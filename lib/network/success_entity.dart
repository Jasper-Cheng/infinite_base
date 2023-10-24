import 'package:dio/dio.dart';

class SuccessEntity<T> {
  final int code;
  final T? data;
  final String? msg;
  Response? response;

  SuccessEntity({required this.code, this.msg,this.data, this.response});
}
