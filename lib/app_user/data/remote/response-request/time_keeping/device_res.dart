import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/device.dart';

DeviceRes deviceResFromJson(String str) => DeviceRes.fromJson(json.decode(str));

String deviceResToJson(DeviceRes data) => json.encode(data.toJson());

class DeviceRes {
  DeviceRes({
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
  Device? data;

  factory DeviceRes.fromJson(Map<String, dynamic> json) => DeviceRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : Device.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data!.toJson(),
  };
}
