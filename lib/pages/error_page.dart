import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/base_page.dart';

import '../controllers/error_page_controller.dart';

class ErrorPage extends BasePage {
  const ErrorPage(bundle, {super.key}) : super(bundle: bundle);

  @override
  State<ErrorPage> createState() => ErrorPageState();
}

class ErrorPageState extends BasePageState<ErrorPage> {
  final ErrorPageController _controller=ErrorPageController();
  @override
  Widget buildViews(BuildContext context) {
    return AnnotatedRegion(
      child: Scaffold(
        body: Center(
          child: Text("ErrorPage"),
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
