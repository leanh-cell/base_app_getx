import 'dart:convert';

import '../../../../../model/bonus_product.dart';

AllBonusProductRes allBonusProductResFromJson(String str) => AllBonusProductRes.fromJson(json.decode(str));

String allBonusProductResToJson(AllBonusProductRes data) => json.encode(data.toJson());

class AllBonusProductRes {
  AllBonusProductRes({
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
  List<BonusProduct>? data;

  factory AllBonusProductRes.fromJson(Map<String, dynamic> json) => AllBonusProductRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<BonusProduct>.from(json["data"].map((x) => BonusProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

