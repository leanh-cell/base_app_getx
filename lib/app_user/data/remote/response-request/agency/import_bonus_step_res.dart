// To parse this JSON data, do
//
//     final importBonusStepsRes = importBonusStepsResFromJson(jsonString);

import 'dart:convert';

import '../../../../model/bonus_level.dart';

ImportBonusStepsRes importBonusStepsResFromJson(String str) => ImportBonusStepsRes.fromJson(json.decode(str));

String importBonusStepsResToJson(ImportBonusStepsRes data) => json.encode(data.toJson());

class ImportBonusStepsRes {
  ImportBonusStepsRes({
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
  List<BonusLevel>? data;

  factory ImportBonusStepsRes.fromJson(Map<String, dynamic> json) => ImportBonusStepsRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? [] : List<BonusLevel>.from(json["data"]!.map((x) => BonusLevel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
