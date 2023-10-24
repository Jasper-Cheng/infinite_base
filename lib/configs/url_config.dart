import 'package:infinite_base/configs/app_config.dart';

class UrlConfig{
  static const String release_url = "https://api.oioweb.cn";//正式环境base url

  static const String debug_url = "https://api.oioweb.cn";//测试环境base url

  static String getUrl() {
    return AppConfig.deBug ? debug_url : release_url;
  }

  static const String ws_url = "wss://echo.websocket.events";//websocket测试url

  static const String getMyWife = "/api/site/UrlRevert";
}