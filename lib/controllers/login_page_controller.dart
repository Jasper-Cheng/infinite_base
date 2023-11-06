import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_base/bases/base_controller.dart';

import '../configs/key_config.dart';
import '../configs/route_config.dart';
import '../bases/bundle.dart';

class LoginPageController extends BaseController{
  bool eyeOpen=false;

  TextEditingController? usernameTextEditingController;
  TextEditingController? passwordTextEditingController;
  String username="";
  String password="";

  @override
  void initController(State<StatefulWidget> state,Bundle? bundle) {
    postFrameCallback((callback) {
      usernameTextEditingController=TextEditingController(text: username);
      passwordTextEditingController=TextEditingController(text: password);
    });
  }

  void jumpToMainPage() async {
    Bundle bundle = Bundle();
    bundle.putString(KeyConfig.app_common_key, "I'm login,nice to meet you!");
    context.push(RoutePath.main,extra: bundle);
  }

  void jumpToRegisterPage() async {
    Bundle bundle = Bundle();
    bundle.putString(KeyConfig.app_common_key, "I'm login,nice to meet you!");
    context.push(RoutePath.register,extra: bundle);
  }

  void doLogin(){
    EasyLoading.show(status: "正在登录");
    Timer(const Duration(seconds: 1), () {
      jumpToMainPage();
    });
  }

  void updateEye(){
    eyeOpen=!eyeOpen;
    notifyListeners();
  }

  void updateUserName(String value){
    username=value;
    notifyListeners();
  }

  void updatePassword(String value){
    password=value;
    notifyListeners();
  }
}