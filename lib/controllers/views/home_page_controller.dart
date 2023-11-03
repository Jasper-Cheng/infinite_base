import 'package:flutter/material.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/bundle.dart';
import 'package:infinite_base/controllers/extra/application_controller.dart';
import 'package:infinite_base/controllers/login_page_controller.dart';

import '../../pages/login_page.dart';

class HomePageController extends BaseController{

  @override
  void initController(State<StatefulWidget> state,Bundle? bundle) {
    postFrameCallback((callback) {
      // (ApplicationController().getTargetPage<LoginPageState>()?.baseController as LoginPageController).updateText("I'm HomePageController,I changed you.");
    });
  }

}