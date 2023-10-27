import '../utils/log_util.dart';

class MyWsListener implements OnWebSocketListener {
  static const SUCCESS_CODE=200;

  @override
  void onReceiveMessage(String data) async {
    try {
      LogUtil.d("MyWsListener onReceiveMessage:$data");
      // Map<String, dynamic> json = jsonDecode(data);
      // WsResponseModel wsResponseModel = WsResponseModel.fromJson(json);
      // switch (wsResponseModel.code) {
      //   case SUCCESS_CODE:
      //     //1024
      //     break;
      // }
    } catch (e, s) {
      LogUtil.e('MyWsListener exception details:\n $e');
      LogUtil.d('MyWsListener stack trace:\n $s');
    }
  }

  @override
  void onDone() {
    // TODO: implement onDone
  }

  @override
  void onError(error) {
    // TODO: implement onError
  }
}

abstract class OnWebSocketListener {
  void onReceiveMessage(String data);

  void onError(dynamic error);

  void onDone();
}
