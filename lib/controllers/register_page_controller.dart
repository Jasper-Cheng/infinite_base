import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/bundle.dart';
import 'package:infinite_base/utils/toast_util.dart';


class RegisterPageController extends BaseController{
  bool eyeOpen=false;

  TextEditingController? usernameTextEditingController;
  TextEditingController? verifyCodeTextEditingController;
  TextEditingController? passwordTextEditingController;
  String username="";
  String password="";
  String verifyCode="";

  int countDown=60;
  Timer? countDownTimer;
  String countTip="获取验证码";
  bool canSend=true;

  @override
  void initController(State<StatefulWidget> state, Bundle? bundle) {
    postFrameCallback((callback) {
      usernameTextEditingController=TextEditingController(text: username);
      passwordTextEditingController=TextEditingController(text: password);
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

  void updateVerifyCode(String value){
    verifyCode=value;
    notifyListeners();
  }

  void startTimerCount(){
    if(canSend){
      canSend=false;
      updateTimerTip();
      countDownTimer=Timer.periodic(const Duration(seconds: 1), (timer) {
        updateTimerTip();
      });
      notifyListeners();
    }
  }

  void updateTimerTip(){
    countDown--;
    countTip="重新获取($countDown秒)";
    if(countDown==0){
      countDown=60;
      canSend=true;
      countTip="获取验证码";
      countDownTimer?.cancel();
    }
    notifyListeners();
  }

  void updatePassword(String value){
    password=value;
    notifyListeners();
  }

  void doSignUp(){
    if(verifyCode.length!=6){
      ToastUtil.showToast("验证码是6位的哦!");
      return;
    }
    if(password.length<6||password.length>12||!password.contains(RegExp("[a-z,A-Z]"))||!password.contains(RegExp("[0-9]"))){
      ToastUtil.showToast("密码需要6-12位字母数字组合哦！");
      return;
    }
    EasyLoading.show(status: "正在注册");
    Timer(const Duration(seconds: 1), () {
      EasyLoading.dismiss();
      ToastUtil.showToast("注册成功!");
      context.pop();
    });
  }

  void popToLoginPage() async {
    context.pop();
  }

  @override
  void dispose() {
    countDownTimer?.cancel();
    super.dispose();

  }

}