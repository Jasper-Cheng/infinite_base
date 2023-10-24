import 'package:flutter/material.dart';

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // LogUtil.d('MyNavigatorObserver did push ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // LogUtil.d('MyNavigatorObserver did pop ${route.settings.name}');
  }
}