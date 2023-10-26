import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_base/bases/base_controller.dart';

import '../configs/route_config.dart';
import '../bases/bundle.dart';

class SplashPageController extends BaseController{

  @override
  void initController(State<StatefulWidget> state,Bundle? bundle) {
    postFrameCallback((callback) {
      Future.delayed(const Duration(seconds: 2),(){
        jumpToLoginWidget();
      });
    });
  }

  void jumpToLoginWidget(){
    context.go(RoutePath.login);
  }

}