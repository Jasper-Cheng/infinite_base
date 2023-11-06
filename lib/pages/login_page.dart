import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';
import 'package:infinite_base/configs/assets_config.dart';
import 'package:infinite_base/controllers/extra/application_controller.dart';
import 'package:infinite_base/widgets/normal_toolbar_view.dart';

import '../configs/theme_config.dart';
import '../controllers/login_page_controller.dart';

class LoginPage extends BasePage {
  const LoginPage({super.key,bundle}) : super(bundle: bundle);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends BasePageState<LoginPage> {
  final LoginPageController _controller=LoginPageController();
  @override
  Widget buildViews(BuildContext context) {
    return NormalToolbarView(
      showLeadingView: false,
      body: _buildBodyView()
    );
  }

  Widget _buildBodyView(){
    return Container(
      padding: EdgeInsets.only(top: 80.h,left: 10.w,right: 10.w,bottom: 20.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              AssetImageConfig.login_top_paint,
              width: 200.w,
              fit: BoxFit.fill,
            ),
            Container(
              height: 30.h,
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
                        hintText: "请输入用户号/手机号",
                        prefixIcon: Icon(Icons.person_outline,size: 20.w),
                    ),
                  onChanged: _controller.updateUserName
                ),
                Container(
                  height: 12.h,
                ),
                TextField(
                  controller: _controller.passwordTextEditingController,
                    style: TextStyle(fontSize: 16.sp,),
                    obscureText: !_controller.eyeOpen,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.w)),
                        ),
                        hintStyle: TextStyle(
                          color: const Color(0x4C1C1F23),
                          fontSize: 14.sp,),
                        hintText: "请输入密码",
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
                          onPressed: _controller.username.isNotEmpty&&_controller.password.isNotEmpty?_controller.doLogin:null,
                          child: Text("登录",style: TextStyle(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w600),),
                        ),
                      )
                    ],
                  ),
                  Container(height: 10.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: _controller.jumpToRegisterPage,
                            child: Text("  注册",style: TextStyle(color: const Color(0xFF3295FB),fontSize: 12.sp),),
                          ),
                        ),
                        Expanded(
                          child: Text("忘记密码?",textAlign: TextAlign.end,style: TextStyle(color: const Color(0xA51C1F23),fontSize: 12.sp)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 30.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text("其他登录方式",style: TextStyle(color: const Color(0xFF888D92),fontSize: 12.sp),),
                  Container(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AssetImageConfig.Wechat,
                        width: 30.w,
                        height: 30.w,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        width: 30.w,
                      ),
                      Image.asset(
                        AssetImageConfig.Weibo,
                        width: 30.w,
                        height: 30.w,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        width: 30.w,
                      ),
                      Image.asset(
                        AssetImageConfig.QQ,
                        width: 30.w,
                        height: 30.w,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        width: 30.w,
                      ),
                      Image.asset(
                        AssetImageConfig.Apple,
                        width: 30.w,
                        height: 30.w,
                        fit: BoxFit.fill,
                      )
                    ],
                  ),
                  Container(
                    height: 16.h,
                  ),
                  Text(
                    "登录即代表同意《中国移动认证服务条款》和《服务与隐私协议》，并使用本机号码登录",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black,fontSize: 12.sp,fontWeight: FontWeight.w500),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildThemeWidget(){
    List<Widget> list=[];
    ThemeConfig.map.forEach((key, value) {
      list.add(Container(height: 30.h,));
      list.add(
          GestureDetector(
            child:Text(key),
            onTap: (){
              ApplicationController().setCurrentTheme(key);
            },
          )
      );
    });
    return list;
  }

  @override
  BaseController initController() {
    return _controller;
  }
}
