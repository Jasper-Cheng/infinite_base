import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/controllers/main_page_controller.dart';
import 'package:infinite_base/extension/widget_extension.dart';
import 'package:infinite_base/widgets/normal_toolbar_view.dart';

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
    return NormalToolbarView(
      body: Container(),
    ).addBackIntercept(_controller.exitApp);
  }


  @override
  BaseController initController() {
    return _controller;
  }
}
