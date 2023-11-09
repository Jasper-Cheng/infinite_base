import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';
import 'package:infinite_base/widgets/normal_toolbar_view.dart';

import '../configs/assets_config.dart';
import '../controllers/new_password_page_controller.dart';

class NewPasswordPage extends BasePage{
  const NewPasswordPage({super.key,bundle}) : super(bundle: bundle);

  @override
  State<StatefulWidget> createState() => NewPasswordPageState();
}

class NewPasswordPageState extends BasePageState{
  final NewPasswordPageController _controller=NewPasswordPageController();
  @override
  Widget buildViews(BuildContext context) {
    return NormalToolbarView(
      leadingLeftWidget: _buildLeadingView(),
      body: _buildBodyView(),
    );
  }

  Widget _buildLeadingView(){
    return Container(
      padding: EdgeInsets.only(left:6.w,bottom: 2.h),
      child: GestureDetector(
        child: Text(
          "新密码",
          style: TextStyle(
            color: const Color(0xFF1C1F23),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: (){
          context.pop();
        },
      ),
    );
  }

  Widget _buildBodyView(){
    return Container(
        padding: EdgeInsets.only(top: 30.h,left: 10.w,right: 10.w,bottom: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                AssetImageConfig.new_password_header,
                width: 200.w,
                fit: BoxFit.fill,
              ),
              Container(
                height: 24.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  " 请输入新密码",
                  style: TextStyle(
                      color: const Color(0xCC1C1F23),
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp
                  ),
                ),
              ),
              Container(
                height: 30.h,
              ),
              TextField(
                controller: _controller.passwordTextEditingController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-z,0-9,A-Z]")),
                ],
                style: TextStyle(fontSize: 16.sp,),
                obscureText: !_controller.eyeOpen,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.w)),
                    ),
                    hintStyle: TextStyle(
                      color: const Color(0x4C1C1F23),
                      fontSize: 14.sp,),
                    hintText: "请输入6-12位字母数字组合",
                    prefixIcon: Icon(Icons.lock_outline,size: 20.w),
                    suffixIcon: GestureDetector(
                        onTap: _controller.updateEye,
                        child: _controller.eyeOpen?Icon(Icons.visibility_outlined,size: 16.w):Icon(Icons.visibility_off_outlined,size: 16.w)
                    )
                ),
                onChanged: _controller.updatePassword,
              ),
              Container(
                height: 10.h,
              ),
              TextField(
                controller: _controller.passwordConfirmTextEditingController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-z,0-9,A-Z]")),
                ],
                style: TextStyle(fontSize: 16.sp,),
                obscureText: !_controller.eyeOpenConfirm,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.w)),
                    ),
                    hintStyle: TextStyle(
                      color: const Color(0x4C1C1F23),
                      fontSize: 14.sp,),
                    hintText: "请再次确认密码",
                    prefixIcon: Icon(Icons.lock_outline,size: 20.w),
                    suffixIcon: GestureDetector(
                        onTap: _controller.updateEyeConfirm,
                        child: _controller.eyeOpenConfirm?Icon(Icons.visibility_outlined,size: 16.w):Icon(Icons.visibility_off_outlined,size: 16.w)
                    )
                ),
                onChanged: _controller.updatePasswordConfirm,
              ),
              Container(
                height: 40.h,
              ),
              Container(
                margin: EdgeInsets.only(left: 10.w),
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        height: 38.h,
                        shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100.r),
                          ),
                        ),
                        disabledElevation: 6,
                        elevation: 6,
                        color: const Color(0xFF0077FA),
                        disabledColor: const Color(0xFF98CDFD),
                        onPressed: _controller.password.isNotEmpty&&_controller.passwordConfirm.isNotEmpty?_controller.doFinishedPassword:null,
                        child: Text("验证",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w600),),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  @override
  BaseController initController(){
    return _controller;
  }

}