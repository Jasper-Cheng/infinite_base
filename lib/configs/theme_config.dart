import 'package:flutter/material.dart';

class ThemeConfig{
  static String defaultFontStyle="SourceHanSerifCN";
  static Map<String,ThemeData> map={
    "LIGHT":ThemeData(
      brightness: Brightness.light,
      fontFamily: defaultFontStyle,
    ),
    "DARK":ThemeData(
      brightness: Brightness.dark,
      fontFamily: defaultFontStyle,
    )
  };
}