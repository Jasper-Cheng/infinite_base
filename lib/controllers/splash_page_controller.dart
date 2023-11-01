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
  bool hadGuide=true;
  int advertisementCount=3;
  Timer? countDownTimer;

  @override
  void initController(State<StatefulWidget> state,Bundle? bundle) {
    pageController=PageController();
    postFrameCallback((callback){
      hadGuide=ApplicationController().sharedPreferences?.getBool(KeyConfig.guide_page_key)??false;
      notifyListeners();
    });
    countDownTimer=Timer.periodic(const Duration(seconds: 1), (timer) {
      if(advertisementCount==0){
        jumpToLoginWidget();
        timer.cancel();
      }
      notifyListeners();
    });
  }

  void jumpToLoginWidget(){
    ApplicationController().sharedPreferences?.setBool(KeyConfig.guide_page_key, hadGuide);
    context.go(RoutePath.login);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    countDownTimer?.cancel();
    super.dispose();
  }

}