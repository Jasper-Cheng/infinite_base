import '../models/user_model.dart';
import '../models/ws_response_model.dart';

class ResponseConfig {
  static T convertResponse<T>(dynamic json) {
    switch (T.toString()) {
      case "UserModel":
        return UserModel.fromJson(json) as T;
      case "WsResponseModel":
        return WsResponseModel.fromJson(json) as T;
      default:
        return json as T;
    }
  }
}
