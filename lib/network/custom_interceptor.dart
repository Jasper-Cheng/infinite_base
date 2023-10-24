import 'package:dio/dio.dart';

import '../configs/key_config.dart';
import '../utils/log_util.dart';
import '../utils/shared_preferences_util.dart';
class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // LogUtil.d('CustomInterceptor-onRequest url:${options.path}');
    String? token = SharedPreferencesUtil().getString(KeyConfig.user_token_key);
    if (token != null) {
      options.headers["token"] = token;
      LogUtil.d('options.headers["token"]=$token}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // LogUtil.d('CustomInterceptor-onResponse');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // LogUtil.e('CustomInterceptor-onError');
    super.onError(err, handler);
  }
}