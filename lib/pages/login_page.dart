import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';

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
        body: GestureDetector(
          child: Center(
            child: Text("LoginPage"),
          ),
          onTap: (){
            _controller.jumpToMainWidget();
          },
        ),
      ),
      value: SystemUiOverlayStyle.dark,
    );
  }

  @override
  BaseController initController() {
    return _controller;
  }
}
