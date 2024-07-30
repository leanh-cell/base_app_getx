// To parse this JSON data, do
//
//     final allDeviceRes = allDeviceResFromJson(jsonString);

import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/device.dart';

AllDeviceRes allDeviceResFromJson(String str) => AllDeviceRes.fromJson(json.decode(str));

String allDeviceResToJson(AllDeviceRes data) => json.encode(data.toJson());

class AllDeviceRes {
  AllDeviceRes({
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
  List<Device>? data;

  factory AllDeviceRes.fromJson(Map<String, dynamic> json) => AllDeviceRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<Device>.from(json["data"].map((x) => Device.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}


