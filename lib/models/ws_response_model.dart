import 'package:json_annotation/json_annotation.dart';

part 'ws_response_model.g.dart';

@JsonSerializable()
class WsResponseModel {
  int? code;
  String? result;
  String? msg;

  WsResponseModel();

  factory WsResponseModel.fromJson(Map<String, dynamic> json) => _$WsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WsResponseModelToJson(this);
}