import 'package:flutter/material.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/bundle.dart';

class VerificationCodePageController extends BaseController{
  int selectWay=0;
  @override
  void initController(State<StatefulWidget> state, Bundle? bundle) {
    postFrameCallback((duration) {

    });
  }

  void updateSelectWay(int way){
    selectWay=way;
    notifyListeners();
  }

  void doWayNextStep(){

  }


}