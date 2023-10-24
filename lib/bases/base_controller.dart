import 'dart:ui';
import 'package:flutter/material.dart';

import 'bundle.dart';

abstract class BaseController with ChangeNotifier {

  late BuildContext context;

  BaseController();

  void initController(State state,Bundle? bundle);

  void postFrameCallback(FrameCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback(callback);
  }
}
