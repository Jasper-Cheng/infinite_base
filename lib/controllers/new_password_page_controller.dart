import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/bundle.dart';
import 'package:infinite_base/configs/route_config.dart';

import '../configs/assets_config.dart';
import '../utils/toast_util.dart';

class NewPasswordPageController extends BaseController{

  TextEditingController? passwordTextEditingController;
  bool eyeOpen=false;
  String password="";

  TextEditingController? passwordConfirmTextEditingController;
  bool eyeOpenConfirm=false;
  String passwordConfirm="";

  @override
  void initController(State<StatefulWidget> state, Bundle? bundle) {
    postFrameCallback((duration) {
      passwordTextEditingController=TextEditingController(text: password);
      passwordConfirmTextEditingController=TextEditingController(text: passwordConfirm);
    });
  }

  void updateEyeConfirm(){
    eyeOpenConfirm=!eyeOpenConfirm;
    notifyListeners();
  }

  void updatePassword(String value){
    password=value;
    notifyListeners();
  }

  void updatePasswordConfirm(String value){
    passwordConfirm=value;
    notifyListeners();
  }

  void updateEye(){
    eyeOpen=!eyeOpen;
    notifyListeners();
  }


  void doFinishedPassword(){
    if(password.length<6||password.length>12||!password.contains(RegExp("[a-z,A-Z]"))||!password.contains(RegExp("[0-9]"))){
      ToastUtil.showToast("密码需要6-12位字母数字组合哦！");
      return ;
    }
    if(password!=passwordConfirm){
      ToastUtil.showToast("两次密码不一致哦！");
      return ;
    }
    EasyLoading.show(status: "正在修改");
    Future.delayed(const Duration(seconds: 1),(){
      EasyLoading.dismiss();
      ToastUtil.showToast("修改成功!");
      showSuccessfulDialog();
      Future.delayed(const Duration(seconds: 1),(){
        context.go(RoutePath.login);
      });
    });
  }

  void showSuccessfulDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.w))
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
            width: 200.w,
            height: 300.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:  BorderRadius.all(Radius.circular(20.w))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AssetImageConfig.new_password_dialog_header,
                  fit: BoxFit.fill,
                ),
                Container(height: 20.h,),
                Text(
                  "恭喜，密码修改成功！",
                  style: TextStyle(
                      color: const Color(0xFF0077FA),
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp
                  ),
                ),
                Container(height: 20.h,),
                Text(
                  "您的帐户密码修改成功，可正常使用。正在为您跳转到登录页面...",
                  style: TextStyle(
                      color: const Color(0xCC1C1F23),
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}