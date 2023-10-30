import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';

import '../../controllers/views/my_page_controller.dart';

class MyPage extends BasePage {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => MyPageState();
}

class MyPageState extends BasePageState<MyPage> {
  final MyPageController _controller=MyPageController();
  @override
  Widget buildViews(BuildContext context) {
    return AnnotatedRegion(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 100),
          alignment: Alignment.center,
          child: Column(
            children: [
              GestureDetector(
                child: Text("get my wife"),
                onTap: (){
                  _controller.getMyWife();
                },
              ),
              Text("${_controller.userModel?.result}"),
              Container(height: 20.h,),
              GestureDetector(
                child: Text("notification"),
                onTap: (){
                  _controller.createNotification();
                },
              ),
            ],
          ),
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
