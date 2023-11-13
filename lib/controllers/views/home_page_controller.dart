import 'package:flutter/material.dart';
import 'package:infinite_base/bases/base_controller.dart';
import 'package:infinite_base/bases/bundle.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePageController extends BaseController{

  final List<Permission> needPermissionList = [
    Permission.location,
    Permission.storage,
    Permission.phone,
  ];

  @override
  void initController(State<StatefulWidget> state,Bundle? bundle) {
    postFrameCallback((callback) {
      _checkPermissions();
    });
  }

  void _checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await needPermissionList.request();
    statuses.forEach((key, value) {
      print('$key premissionStatus is $value');
    });
  }

}