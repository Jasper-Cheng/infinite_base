// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ws_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WsResponseModel _$WsResponseModelFromJson(Map<String, dynamic> json) =>
    WsResponseModel()
      ..code = json['code'] as int?
      ..result = json['result'] as String?
      ..msg = json['msg'] as String?;

Map<String, dynamic> _$WsResponseModelToJson(WsResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'result': instance.result,
      'msg': instance.msg,
    };
