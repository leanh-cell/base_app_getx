// To parse this JSON data, do
//
//     final listIdCustomerStaffSaleTopRes = listIdCustomerStaffSaleTopResFromJson(jsonString);

import 'dart:convert';

ListIdCustomerStaffSaleTopRes listIdCustomerStaffSaleTopResFromJson(String str) => ListIdCustomerStaffSaleTopRes.fromJson(json.decode(str));

String listIdCustomerStaffSaleTopResToJson(ListIdCustomerStaffSaleTopRes data) => json.encode(data.toJson());

class ListIdCustomerStaffSaleTopRes {
  ListIdCustomerStaffSaleTopRes({
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
  List<int>? data;

  factory ListIdCustomerStaffSaleTopRes.fromJson(Map<String, dynamic> json) => ListIdCustomerStaffSaleTopRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? [] : List<int>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
