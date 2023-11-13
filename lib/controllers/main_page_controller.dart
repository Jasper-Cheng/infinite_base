import 'package:flutter/material.dart';
import 'package:infinite_base/configs/key_config.dart';
import 'package:infinite_base/bases/bundle.dart';
import '../pages/views/home_page.dart';
import '../pages/views/my_page.dart';
import '../utils/toast_util.dart';
import '../bases/base_controller.dart';

class MainPageController extends BaseController{
  String? who;
  final List<Widget> childWidgets = [const HomePage(), const MyPage()];
  int currentIndex = 0;
  int last = 0;
  Bundle? bundle;

  @override
  void initController(State<StatefulWidget> state,Bundle? bundle) {
    who=bundle?.getString(KeyConfig.app_common_key);
    postFrameCallback((duration) {

    });
  }

  void switchCurrentIndex(int index){
    currentIndex=index;
    notifyListeners();
  }

  Future<bool> exitApp() async {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - last > 2000) {
      last = now;
      ToastUtil.showShortToast("再次点击退出");
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

}