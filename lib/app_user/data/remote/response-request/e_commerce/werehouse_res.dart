// To parse this JSON data, do
//
//     final warehousesRes = warehousesResFromJson(jsonString);

import 'dart:convert';

import 'all_werehouses_res.dart';

WarehousesRes warehousesResFromJson(String str) => WarehousesRes.fromJson(json.decode(str));

String warehousesResToJson(WarehousesRes data) => json.encode(data.toJson());

class WarehousesRes {
  WarehousesRes({
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
  Warehouses? data;

  factory WarehousesRes.fromJson(Map<String, dynamic> json) => WarehousesRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? null : Warehouses.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
    "data": data?.toJson(),
  };
}

