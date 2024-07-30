// To parse this JSON data, do
//
//     final cartRes = cartResFromJson(jsonString);

import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/cart_info.dart';

CartRes cartResFromJson(String str) => CartRes.fromJson(json.decode(str));

String cartResToJson(CartRes data) => json.encode(data.toJson());

class CartRes {
  CartRes({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int ?code;
  bool? success;
  String? msgCode;
  String? msg;
  CartInfo? data;

  factory CartRes.fromJson(Map<String, dynamic> json) => CartRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : CartInfo.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data!.toJson(),
  };
}
