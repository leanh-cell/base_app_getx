import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/checkin_location.dart';

CheckInLocationRes checkInLocationResFromJson(String str) =>
    CheckInLocationRes.fromJson(json.decode(str));

String checkInLocationResToJson(CheckInLocationRes data) =>
    json.encode(data.toJson());

class CheckInLocationRes {
  CheckInLocationRes({
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
  CheckInLocation? data;

  factory CheckInLocationRes.fromJson(Map<String, dynamic> json) =>
      CheckInLocationRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : CheckInLocation.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data!.toJson(),
      };
}
