import 'package:flutter/material.dart';
import 'app_config.dart';

class ThemeConfig{
  static Map<String,ThemeData> map={
    "LIGHT":ThemeData(
      brightness: Brightness.light,
      fontFamily: AppConfig.defaultFontStyle,
    ),
    "DARK":ThemeData(
      brightness: Brightness.dark,
      fontFamily: AppConfig.defaultFontStyle,
    )
  };
}