import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_base/configs/assets_config.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';

import '../controllers/splash_page_controller.dart';

class SplashPage extends BasePage {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends BasePageState<SplashPage> {

  final SplashPageController _controller=SplashPageController();

  @override
  BaseController initController() {
    return _controller;
  }

  @override
  Widget buildViews(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset(
            AssetImageConfig.helloWorld,
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            fit: BoxFit.fill,
          ),
        ],
      )
    );
  }
}
