import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/controllers/main_page_controller.dart';
import 'package:infinite_base/extension/widget_extension.dart';

import '../bases/base_page.dart';

class MainPage extends BasePage {
  const MainPage(bundle, {super.key}) : super(bundle: bundle);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends BasePageState<MainPage> {
  final MainPageController _controller= MainPageController();

  @override
  Widget buildViews(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: _controller.childWidgets[_controller.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _controller.currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.supervisor_account),label: "我的")
          ],
          onTap: (index){
            _controller.switchCurrentIndex(index);
          },
        ),
      ).addBackIntercept(_controller.exitApp),
    );
  }

  @override
  BaseController initController() {
    return _controller;
  }
}
