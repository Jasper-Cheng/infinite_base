import 'dart:async';
import 'package:web_socket_channel/io.dart';
import '../observers/my_ws_listener.dart';

class WebSocketUtil{
  WebSocketUtil._internal();
  factory WebSocketUtil() => instance;
  static final WebSocketUtil instance = WebSocketUtil._internal();

  String? wsUrl;
  OnWebSocketListener? onWebSocketListener;
  IOWebSocketChannel? ioWebSocketChannel;
  Timer? timer;//定时发送信息确保链接存活
  int heartbeatTimeCircle = 30;
  String heartbeatMessage="alive";


  void init(String wsUrl, OnWebSocketListener onWebSocketListener,{String? heartbeatMessage, int? heartbeatTimeCircle}){
    timer?.cancel();
    this.wsUrl=wsUrl;
    this.onWebSocketListener = onWebSocketListener;
    if(heartbeatMessage!=null)this.heartbeatMessage=heartbeatMessage;
    if(heartbeatTimeCircle!=null)this.heartbeatTimeCircle=heartbeatTimeCircle;
    ioWebSocketChannel = IOWebSocketChannel.connect(wsUrl);
    ioWebSocketChannel?.stream.listen((data) => onWebSocketListener.onReceiveMessage(data),onError: onWebSocketListener.onError,onDone: onWebSocketListener.onDone);
    timer = Timer.periodic(Duration(seconds: this.heartbeatTimeCircle), (timer) {
        sendMessage(this.heartbeatMessage);
      },
    );
  }

  void sendMessage(String data) {
    if (ioWebSocketChannel == null) {
      return;
    }
    ioWebSocketChannel!.sink.add(data);
  }

  Future<void> closeWebSocket() async {
    await ioWebSocketChannel?.sink.close();
    timer?.cancel();
    ioWebSocketChannel = null;
  }

}