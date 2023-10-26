import 'dart:collection';
import 'package:flutter/material.dart';

class ThemeUtil{
  ThemeUtil._internal();
  factory ThemeUtil() => ThemeUtil._internal();

  Map<String,ThemeData> themeDataMap=HashMap();

  void init(Map<String,ThemeData> map){
    themeDataMap=map;
  }

  ThemeData? getCurrentThemeData(String sp){
    return themeDataMap[sp];
  }

  List<String> getThemeList(){
    return themeDataMap.keys.toList();
  }

}