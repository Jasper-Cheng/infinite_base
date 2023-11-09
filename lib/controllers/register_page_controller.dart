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

  ///手机号验证
  static bool isChinaPhoneLegal(String str) {
    return RegExp(
        r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$")
        .hasMatch(str);
  }

  ///邮箱验证
  static bool isEmail(String str) {
    return RegExp(
        r"^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$")
        .hasMatch(str);
  }

  void startTimerCount(){
    if(isChinaPhoneLegal(username)||isEmail(username)){
      if(canSend){
        canSend=false;
        updateTimerTip();
        countDownTimer=Timer.periodic(const Duration(seconds: 1), (timer) {
          updateTimerTip();
        });
        notifyListeners();
      }
    }else{
      ToastUtil.showToast("手机号或邮箱不符合规范哦");
      return;
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