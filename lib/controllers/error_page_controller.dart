import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/configs/key_config.dart';
import 'package:infinite_base/utils/log_util.dart';
import 'package:infinite_base/bases/bundle.dart';

class ErrorPageController extends BaseController{
  GoException? goException;
  @override
  void initController(State<StatefulWidget> state,Bundle? bundle) {
    goException=bundle?.getObject(KeyConfig.route_error_key);
    LogUtil.e("ErrorPage-GoException.message=${goException?.message}");
    postFrameCallback((callback) {

    });
  }

}