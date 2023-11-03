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
  const LoginPage({Key? key}) : super(key: key);

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
      padding: EdgeInsets.only(top: 80.h,left: 20.w,right: 20.w,bottom: 20.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              AssetImageConfig.login_top_paint,
              width: 200.w,
              fit: BoxFit.fill,
            ),
            TextField(
              controller: _controller.textEditingController,
              style: TextStyle(
                  fontSize: 16.sp,),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                    color: const Color(0xFF1C1F23),
                    fontSize: 16.sp,
                    textBaseline: TextBaseline.alphabetic),
                hintText: "请输入用户号/手机号",
                prefixIcon: Image.asset(
                  AssetImageConfig.login_account_unselect,
                ),
                // prefixIconConstraints: BoxConstraints(
                //   minWidth: 24.w,
                //   minHeight: 24.w,
                //   maxWidth: 24.w,
                //   maxHeight: 24.w
                // ),
              ),
            ),
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
