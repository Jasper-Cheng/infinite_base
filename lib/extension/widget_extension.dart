import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget addBackIntercept(Future<bool> Function() function) {
    return WillPopScope(
      onWillPop: function,
      child: this,
    );
  }

  Widget addClick(Function() function) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: function,
      child: this,
    );
  }
}
