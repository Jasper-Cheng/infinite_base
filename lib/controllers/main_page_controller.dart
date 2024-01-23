import 'package:flutter/material.dart';
import 'package:infinite_base/bases/bundle.dart';
import '../utils/toast_util.dart';
import '../bases/base_controller.dart';

class MainPageController extends BaseController{
  int last = 0;

  @override
  void initController(State<StatefulWidget> state,Bundle? bundle) {
    postFrameCallback((duration) {

    });
  }

  void switchCurrentIndex(int index){
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