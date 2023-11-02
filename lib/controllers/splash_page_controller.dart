import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/configs/key_config.dart';
import 'package:infinite_base/controllers/extra/application_controller.dart';
import 'package:infinite_base/utils/log_util.dart';

import '../configs/route_config.dart';
import '../bases/bundle.dart';

class SplashPageController extends BaseController{
  PageController? pageController;
  bool? hadGuide;
  int countDown=3;
  Timer? countDownTimer;

  @override
  void initController(State<StatefulWidget> state,Bundle? bundle) {
    pageController=PageController();
    postFrameCallback((callback){
      checkGuide();
    });
  }

  void checkGuide() {
    hadGuide=ApplicationController().sharedPreferences?.getBool(KeyConfig.guide_page_key);
    LogUtil.d("hadGuide $hadGuide");
    if(hadGuide==true){
      countDownTimer=Timer.periodic(const Duration(seconds: 1), (timer) {
        countDown--;
        if(countDown==0){
          jumpToLoginWidget();
          timer.cancel();
        }
        notifyListeners();
      });
    }
    notifyListeners();
  }

  void jumpToLoginWidget(){
    ApplicationController().sharedPreferences?.setBool(KeyConfig.guide_page_key, hadGuide??false);
    context.go(RoutePath.login);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    countDownTimer?.cancel();
    super.dispose();
  }

}