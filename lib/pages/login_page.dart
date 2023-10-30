import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';
import 'package:infinite_base/controllers/extra/application_controller.dart';

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
    return AnnotatedRegion(
      child: Scaffold(
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child:Text(_controller.centerText),
              onTap: (){
                _controller.jumpToMainWidget();
              },
            ),
            Container(
              height: 50.h,
            ),
            Column(
              children: _buildThemeWidget(),
            )

          ],
        )
      ),
      value: SystemUiOverlayStyle.dark,
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
