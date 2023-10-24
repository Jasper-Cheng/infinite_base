import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil{

  SharedPreferencesUtil._internal();
  factory SharedPreferencesUtil() => instance;
  static final SharedPreferencesUtil instance = SharedPreferencesUtil._internal();

  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> put(String key, Object value) {
    if (value is int) {
      return putInt(key, value);
    } else if (value is String) {
      return putString(key, value);
    } else if (value is bool) {
      return putBool(key, value);
    } else if (value is double) {
      return putDouble(key, value);
    } else if (value is List<String>) {
      return putStringList(key, value);
    }
    throw Exception("Type not supported");
  }


  String? getString(String key, {String? defValue}) {
    return _sharedPreferences.getString(key) ?? defValue;
  }

  Future<bool> putString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  bool getBool(String key, {bool defValue = false}) {
    return _sharedPreferences.getBool(key) ?? defValue;
  }

  Future<bool> putBool(String key, bool value) {
    return _sharedPreferences.setBool(key, value);
  }

  int getInt(String key, {int defValue = 0}) {
    return _sharedPreferences.getInt(key) ?? defValue;
  }

  Future<bool> putInt(String key, int value) {
    return _sharedPreferences.setInt(key, value);
  }

  double getDouble(String key, {double defValue = 0.0}) {
    return _sharedPreferences.getDouble(key) ?? defValue;
  }

  Future<bool> putDouble(String key, double value) {
    return _sharedPreferences.setDouble(key, value);
  }

  List<String> getStringList(String key) {
    return _sharedPreferences.getStringList(key) ?? [];
  }

  Future<bool> putStringList(String key, List<String> value) {
    return _sharedPreferences.setStringList(key, value);
  }

  dynamic getDynamic(String key, {Object? defValue}) {
    return _sharedPreferences.get(key) ?? defValue;
  }

  bool haveKey(String key) {
    return _sharedPreferences.getKeys().contains(key);
  }

  Set<String> getKeys() {
    return _sharedPreferences.getKeys();
  }

  Future<bool> remove(String key) {
    return _sharedPreferences.remove(key);
  }

  Future<bool> clear() {
    return _sharedPreferences.clear();
  }

  Future<bool> putObject(String key, Object? value) {
    return _sharedPreferences.setString(
        "object_$key", value == null ? "" : json.encode(value));
  }

  T? getTarget<T>(String key, T Function(Map v) f, {T? defValue}) {
    Map? map = getObject(key);
    return map == null ? defValue : f(map);
  }

  Map? getObject(String key) {
    String? data = _sharedPreferences.getString("object_$key");
    return (data == null || data.isEmpty) ? null : json.decode(data);
  }

  Future<bool> putObjectList(String key, List<Object> list) {
    List<String> dataList = list.map((value) {
      return json.encode(value);
    }).toList();
    return _sharedPreferences.setStringList(key, dataList);
  }

  List<T> getTargetList<T>(String key, T Function(Map v) f,
      {List<T> defValue = const []}) {
    List<Map>? dataList = getObjectList(key);
    if (dataList == null) {
      return defValue;
    }
    List<T>? list = dataList.map((value) {
      return f(value);
    }).toList();
    return list;
  }

  List<Map>? getObjectList(String key) {
    List<String>? dataList = _sharedPreferences.getStringList(key);
    return dataList?.map((value) {
      Map dataMap = json.decode(value);
      return dataMap;
    }).toList();
  }

  Future<bool> putMapList<T>(String key, Map<String, List<T>> mapList) {
    Map<String, List<T>> mapStringList = {};
    mapList.forEach((k, v) {
      List<T> dataList = v
          .map((value) {
            return json.encode(value);
          })
          .cast<T>()
          .toList();
      mapStringList[k] = dataList;
    });
    return putObject(key, mapStringList);
  }

  Map<String, List<T>> getMapList<T>(String key, T Function(Map v) f) {
    Map mapStringList = getObject(key) ?? {};
    Map<String, List<T>> mapList = {};
    mapStringList.forEach((k, v) {
      List<String> newValue = [];
      v.map((value) {
        return newValue.add(value as String);
      })?.toList();
      List<T> list = newValue.map((value) {
        return f(json.decode(value));
      }).toList();
      mapList[k] = list;
    });
    return mapList;
  }
}
