// To parse this JSON data, do
//
//     final groupCustomerRes = groupCustomerResFromJson(jsonString);

import 'dart:convert';

import 'all_group_customer_res.dart';

GroupCustomerRes groupCustomerResFromJson(String str) => GroupCustomerRes.fromJson(json.decode(str));

String groupCustomerResToJson(GroupCustomerRes data) => json.encode(data.toJson());

class GroupCustomerRes {
  GroupCustomerRes({
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
  GroupCustomer? data;

  factory GroupCustomerRes.fromJson(Map<String, dynamic> json) => GroupCustomerRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : GroupCustomer.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data!.toJson(),
  };
}

