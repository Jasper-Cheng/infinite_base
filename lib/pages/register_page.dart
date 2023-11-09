import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';
import 'package:infinite_base/widgets/normal_toolbar_view.dart';

import '../controllers/register_page_controller.dart';

class RegisterPage extends BasePage{
  const RegisterPage({super.key,bundle}) : super(bundle: bundle);

  @override
  State<StatefulWidget> createState() => RegisterPageState();

}
class RegisterPageState extends BasePageState{
  final RegisterPageController _controller=RegisterPageController();

  @override
  Widget buildViews(BuildContext context) {
    return NormalToolbarView(
        body: _buildBodyView()
    );
  }

  Widget _buildBodyView(){
    return Container(
      padding: EdgeInsets.only(top: 30.h,left: 10.w,right: 10.w,bottom: 20.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.w,right: 10.w),
              alignment: Alignment.topLeft,
              child: Text(
                "欢迎注册\nMorningGo账号！！！",
                style: TextStyle(
                    color: const Color(0xFF3295FB),
                    fontWeight: FontWeight.w800,
                    fontSize: 26.sp
                ),
              ),
            ),
            Container(
              height: 90.h,
            ),
            Column(
              children: [
                TextField(
                    controller: _controller.usernameTextEditingController,
                    style: TextStyle(fontSize: 16.sp,),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.w)),
                      ),
                      hintStyle: TextStyle(
                        color: const Color(0x4C1C1F23),
                        fontSize: 14.sp,),
                      hintText: "请输入手机号/邮箱",
                      prefixIcon: Icon(Icons.person_outline,size: 20.w),
                    ),
                    onChanged: _controller.updateUserName
                ),
                Container(
                  height: 12.h,
                ),
                TextField(
                  controller: _controller.verifyCodeTextEditingController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 16.sp,),
                  obscureText: !_controller.eyeOpen,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.w)),
                      ),
                      hintStyle: TextStyle(
                        color: const Color(0x4C1C1F23),
                        fontSize: 14.sp,),
                      hintText: "请输入验证码",
                      prefixIcon: Icon(Icons.message_outlined,size: 20.w),
                      suffixIcon: GestureDetector(
                          onTap: _controller.startTimerCount,
                          child: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Text(_controller.countTip,style: TextStyle(color: _controller.canSend?const Color(0xFF98CDFD):const Color(0xFF3295FB),fontSize: 14.sp,),),
                          )
                      )
                  ),
                  onChanged: _controller.updateVerifyCode,
                ),
                Container(
                  height: 12.h,
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
              ],
            ),
            Container(
              height: 30.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  Row(
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
                          onPressed: _controller.username.isNotEmpty&&_controller.password.isNotEmpty&&_controller.verifyCode.isNotEmpty?_controller.doSignUp:null,
                          child: Text("注册",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w600),),
                        ),
                      )
                    ],
                  ),
                  Container(height: 10.h,),
                  GestureDetector(
                    onTap: _controller.popToLoginPage,
                    child: Text("有账号？去登录",style: TextStyle(color: const Color(0xFF0077FA),fontSize: 12.sp,fontWeight: FontWeight.w500),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  BaseController initController() {
    return _controller;
  }

}