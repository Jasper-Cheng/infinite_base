import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/configs/key_config.dart';
import 'package:infinite_base/controllers/extra/application_controller.dart';

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
    hadGuide=ApplicationController().sharedPreferences?.getBool(KeyConfig.guide_page_key)??false;
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

  Future<void> jumpToLoginWidget() async {
    // context.go(RoutePath.login);
    context.go(RoutePath.main);
    ApplicationController().sharedPreferences?.setBool(KeyConfig.guide_page_key, true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    countDownTimer?.cancel();
    super.dispose();
  }

}