import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/utils/toast_util.dart';

import '../configs/key_config.dart';
import '../configs/route_config.dart';
import '../bases/bundle.dart';

class LoginPageController extends BaseController{
  String centerText="loginPage";

  @override
  void initController(State<StatefulWidget> state,Bundle? bundle) {
    postFrameCallback((callback) {

    });
  }

  Future<void> jumpToMainWidget() async {
    Bundle bundle = Bundle();
    bundle.putString(KeyConfig.map_common_key, "I'm login,nice to meet you!");
    Object? object=await context.push(RoutePath.main,extra: bundle);
    ToastUtil.showToast("object=${object.toString()}");
  }

  void updateText(String text){
    centerText=text;
    notifyListeners();
  }

}