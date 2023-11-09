import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/bundle.dart';
import 'package:infinite_base/utils/toast_util.dart';

class VerificationCodePageController extends BaseController{
  String verificationCode="";

  int countDown=60;
  Timer? countDownTimer;
  bool canSend=true;
  String countTip="获取验证码";

  @override
  void initController(State<StatefulWidget> state, Bundle? bundle) {
    postFrameCallback((duration) {
      startTimerCount();
    });
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
    countTip="未收到验证码？ $countDown秒后重新发送";
    if(countDown==0){
      countDown=60;
      canSend=true;
      countTip="未收到验证码？ 重新发送";
      countDownTimer?.cancel();
    }
    notifyListeners();
  }


  void updateVerificationCode(String code){
    verificationCode=code;
    notifyListeners();
  }

  void doVerificationStep(){
    EasyLoading.show(status: "正在验证");
    Future.delayed(const Duration(milliseconds: 500),(){
      EasyLoading.dismiss();
      ToastUtil.showToast("验证成功!");
      // context.push(RoutePath.verificationCode);
    });
  }

  @override
  void dispose() {
    countDownTimer?.cancel();
    super.dispose();
  }


}