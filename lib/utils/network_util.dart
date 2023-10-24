import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:infinite_base/controllers/extra/application_controller.dart';
import '../configs/response_config.dart';
import '../configs/url_config.dart';
import '../network/success_entity.dart';
import '../network/custom_interceptor.dart';
import '../network/error_entity.dart';
import 'log_util.dart';
typedef ProgressCallback = void Function(int count, int total);
typedef ErrorCallback = Future<void> Function(ErrorEntity);
typedef SuccessCallback<T> = Future<void> Function(SuccessEntity);

class NetWorkUtil{
  NetWorkUtil._internal();
  factory NetWorkUtil() => instance;
  static final NetWorkUtil instance = NetWorkUtil._internal();

  //options normal configure
  static const int sendTimeout = 10000;
  static const int connectTimeout = 10000;
  static const int receiveTimeout = 10000;
  static const String contentType="application/json;charset=utf-8";
  //normal error code
  static const int UNKNOWN_ERROR_CODE = -1;
  static const int TIMEOUT_ERROR_CODE = -2;
  static const int CERTIFICATE_ERROR_CODE = -3;
  static const int CONNECTION_ERROR_CODE = -4;
  static const int BAD_STATUS_ERROR_CODE = -5;
  //normal server error code
  static const int SUCCESSFUL_CODE = 200;
  static const int SERVER_EXCEPTION_CODE = 500;
  static const int NOT_FOUND_CODE = 404;
  static const int UNAUTHORIZED_CODE = 401;
  static const int ERROR_NULL_DEFAULT_CODE = 0;

  final Dio _dio=Dio();

  void initDio() {
    Map<String, String> headers = {};
    headers["app-version"] = ApplicationController.instance.packageInfo.version;
    headers["os"] = Platform.operatingSystem;
    final options = BaseOptions(
      baseUrl: UrlConfig.getUrl(),
      connectTimeout: const Duration(milliseconds: connectTimeout),
      receiveTimeout: const Duration(milliseconds: receiveTimeout),
      sendTimeout: const Duration(milliseconds: sendTimeout),
      contentType: contentType,
      headers:headers,
    );
    _dio.options=options;
    _dio.interceptors.add(CustomInterceptor());
  }
  //DioException异常处理
  //指纹加密

  Future<void> request<T>(String method, String url,{Map<String, dynamic>? headers,Map<String, dynamic>? queryData,bool isFormRequest = false,
    FormData? formData, Map<String, dynamic>? data,CancelToken? cancelToken,ProgressCallback? onReceiveProgress,ProgressCallback? onSendProgress,
    ErrorCallback? errorCallback,SuccessCallback<T>? successCallback}) async {
    LogUtil.d("baseUrl:${_dio.options.baseUrl}  requestUrl:$url method:$method");
    LogUtil.d("queryData:${queryData.toString()}   data:${data.toString()}  formData:${formData?.fields.toString()}");
    try{
      Response response = await _dio.request(
          UrlConfig.getUrl()+url,
          queryParameters: queryData,
          data:isFormRequest?formData:jsonEncode(data),
          cancelToken: cancelToken,
          options: Options(method: method, headers: headers),
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress
      );
      // LogUtil.d("response.requestOptions.contentType:${response.requestOptions.contentType}");
      // LogUtil.d("response.headers.map['content-type']:${response.headers.map['content-type']}");
      //处理返回的数据
      int? statusCode = response.statusCode;
      LogUtil.d("responseData:${response.toString()}");
      if(statusCode==SUCCESSFUL_CODE){
        await successCallback?.call(SuccessEntity(code: SUCCESSFUL_CODE,msg: response.statusMessage,data:ResponseConfig.convertResponse<T>(response.data),response: response));
      }else{
        await processErrorStatus(statusCode??ERROR_NULL_DEFAULT_CODE, errorCallback, response);
      }
    }catch(e,s){
      LogUtil.e('request exception details:\n $e');
      LogUtil.d('request stack trace:\n $s');
      if (e is DioException) {
        await handleDioError(e,errorCallback);
      }else{
        await errorCallback?.call(ErrorEntity(code:UNKNOWN_ERROR_CODE,msg:e.toString()));
      }
    }
  }

  Future<void> handleDioError(DioException error, ErrorCallback? errorCallback) async {
    switch (error.type) {
      case DioExceptionType.cancel:
        LogUtil.w("cancel request！");
        break;
      case DioExceptionType.connectionTimeout:
        LogUtil.w("connection time out！");
        await errorCallback?.call(ErrorEntity(code:TIMEOUT_ERROR_CODE,msg:error.message??""));
        break;
      case DioExceptionType.sendTimeout:
        LogUtil.w("url send timeout!");
        await errorCallback?.call(ErrorEntity(code:TIMEOUT_ERROR_CODE,msg:error.message??""));
        break;
      case DioExceptionType.receiveTimeout:
        LogUtil.w("receive time out！");
        await errorCallback?.call(ErrorEntity(code:TIMEOUT_ERROR_CODE,msg:error.message??""));
        break;
      case DioExceptionType.badCertificate:
        LogUtil.w("certificate failed！");
        await errorCallback?.call(ErrorEntity(code:CERTIFICATE_ERROR_CODE,msg:error.message??""));
        break;
      case DioExceptionType.connectionError:
        LogUtil.w("connection failed！");
        await errorCallback?.call(ErrorEntity(code:CONNECTION_ERROR_CODE,msg:error.message??""));
        break;
      case DioExceptionType.badResponse:
        LogUtil.w("incorrect status code bad response！");
        await errorCallback?.call(ErrorEntity(code:BAD_STATUS_ERROR_CODE,msg:error.message??""));
        break;
      default:
        LogUtil.w("UNKNOWN ERROR！");
        handlerDioUnknownError(error,errorCallback);
        break;
    }
  }

  Future<void> handlerDioUnknownError(DioException error, ErrorCallback? errorCallback,) async {
    try {
      int? errorCode = error.response?.statusCode;
      await processErrorStatus(errorCode??ERROR_NULL_DEFAULT_CODE, errorCallback, error.response);
    } catch (e) {
      await errorCallback?.call(ErrorEntity(code:UNKNOWN_ERROR_CODE,msg:error.message??""));
    }
  }

  Future<void> processErrorStatus(int errorCode, ErrorCallback? errorCallback, Response? response) async {
    LogUtil.w("response code $errorCode ！");
    switch (errorCode) {
      case UNAUTHORIZED_CODE:
        await errorCallback?.call(ErrorEntity(code:errorCode,msg:"server unauthorized"));
        // ApplicationController.instance.loginOut();
        break;
      case SERVER_EXCEPTION_CODE:
        await errorCallback?.call(ErrorEntity(code:errorCode,msg:"server exception"));
        break;
      case NOT_FOUND_CODE:
        await errorCallback?.call(ErrorEntity(code:errorCode,msg:"address not found"));
        break;
      default:
        await errorCallback?.call(ErrorEntity(code:errorCode,msg:response?.data.toString()??""));
        break;
    }
  }

}