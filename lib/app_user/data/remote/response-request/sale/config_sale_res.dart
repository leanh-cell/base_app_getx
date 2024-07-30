// To parse this JSON data, do
//
//     final configSaleRes = configSaleResFromJson(jsonString);

import 'dart:convert';

import '../../../../model/config_sale.dart';

ConfigSaleRes configSaleResFromJson(String str) => ConfigSaleRes.fromJson(json.decode(str));

String configSaleResToJson(ConfigSaleRes data) => json.encode(data.toJson());

class ConfigSaleRes {
  ConfigSaleRes({
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
  ConfigSale? data;

  factory ConfigSaleRes.fromJson(Map<String, dynamic> json) => ConfigSaleRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : ConfigSale.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
    "data": data?.toJson(),
  };
}


