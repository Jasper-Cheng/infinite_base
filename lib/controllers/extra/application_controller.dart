import 'package:infinite_base/configs/url_config.dart';
import 'package:infinite_base/utils/toast_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../observers/my_ws_listener.dart';
import '../../utils/log_util.dart';
import '../../utils/network_util.dart';
import '../../utils/shared_preferences_util.dart';
import '../../utils/web_socket_util.dart';

class ApplicationController{

  late PackageInfo packageInfo;

  ApplicationController._internal();
  factory ApplicationController() => instance;
  static final ApplicationController instance = ApplicationController._internal();

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();
    WebSocketUtil.instance.init(UrlConfig.ws_url, MyWsListener());
    NetWorkUtil.instance.initDio();
    SharedPreferencesUtil.instance.init();
    checkBasePermission();
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
}