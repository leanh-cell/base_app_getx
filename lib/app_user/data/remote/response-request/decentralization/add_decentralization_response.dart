
import 'package:com.ikitech.store/app_user/model/decentralization.dart';

class AddDecentralizationResponse {
  AddDecentralizationResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  Decentralization? data;

  factory AddDecentralizationResponse.fromJson(Map<String, dynamic> json) => AddDecentralizationResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : Decentralization.fromJson(json["data"]),
  );
}