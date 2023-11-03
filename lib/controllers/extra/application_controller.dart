import 'package:flutter/material.dart';
import 'package:infinite_base/configs/app_config.dart';
import 'package:infinite_base/configs/theme_config.dart';
import 'package:infinite_base/configs/url_config.dart';
import 'package:infinite_base/utils/notification_util.dart';
import 'package:infinite_base/utils/toast_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bases/base_page.dart';
import '../../configs/key_config.dart';
import '../../listener/my_ws_listener.dart';
import '../../utils/log_util.dart';
import '../../utils/network_util.dart';
import '../../utils/web_socket_util.dart';

class ApplicationController with ChangeNotifier{

  ApplicationController._internal();
  factory ApplicationController() => _instance;
  static final ApplicationController _instance = ApplicationController._internal();

  PackageInfo? packageInfo;
  SharedPreferences? sharedPreferences;
  final List<BasePageState> pageList = [];

  Future<bool> init() async {
    packageInfo = await PackageInfo.fromPlatform();
    sharedPreferences = await SharedPreferences.getInstance();
    await NotificationUtil().initialize();
    AppConfig.isOpenWebSocketLongConnect?WebSocketUtil().init(UrlConfig.ws_url, MyWsListener()):null;
    NetWorkUtil().initDio();
    return true;
    // checkBasePermission();
  }

  //申请基本的静态权限
  Future<void> checkBasePermission() async {
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    } catch (e, s) {
      LogUtil.e('checkBasePermission exception details:\n $e');
      LogUtil.d('checkBasePermission stack trace:\n $s');
      ToastUtil.showToast("权限申请异常");
    }
  }

  ThemeData? getCurrentTheme(){
    return ThemeConfig.map[sharedPreferences?.getString(KeyConfig.theme_model_key)??""];
  }
  void setCurrentTheme(String theme){
    sharedPreferences?.setString(KeyConfig.theme_model_key, theme);
    notifyListeners();
  }

  void addPage(BasePageState basePageState){
    pageList.add(basePageState);
  }
  void removePage(BasePageState basePageState){
    pageList.remove(basePageState);
  }
  T? getTargetPage<T extends BasePageState>() {
    T? targetPage;
    for (var element in pageList) {
      if (element is T) {
        targetPage = element;
      }
    }
    return targetPage;
  }

}