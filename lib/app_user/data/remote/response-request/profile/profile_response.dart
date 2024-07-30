import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/profile_user.dart';

class ProfileResponse {
  ProfileResponse({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  ProfileUser? data;
  String? msgCode;
  String? msg;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : ProfileUser.fromJson(json["data"]),
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "data": data == null ? null : data!.toJson(),
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
      };
}
