// To parse this JSON data, do
//
//     final profitAndLossRes = profitAndLossResFromJson(jsonString);

import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/profit_and_loss.dart';

ProfitAndLossRes profitAndLossResFromJson(String str) => ProfitAndLossRes.fromJson(json.decode(str));

String profitAndLossResToJson(ProfitAndLossRes data) => json.encode(data.toJson());

class ProfitAndLossRes {
  ProfitAndLossRes({
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
  ProfitAndLoss? data;

  factory ProfitAndLossRes.fromJson(Map<String, dynamic> json) => ProfitAndLossRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : ProfitAndLoss.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data!.toJson(),
  };
}


