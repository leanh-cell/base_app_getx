// To parse this JSON data, do
//
//     final allCartRes = allCartResFromJson(jsonString);

import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/cart_info.dart';

AllCartRes allCartResFromJson(String str) =>
    AllCartRes.fromJson(json.decode(str));

String allCartResToJson(AllCartRes data) => json.encode(data.toJson());

class AllCartRes {
  AllCartRes({
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
  List<CartInfo>? data;

  factory AllCartRes.fromJson(Map<String, dynamic> json) => AllCartRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : List<CartInfo>.from(json["data"].map((x) => CartInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}


