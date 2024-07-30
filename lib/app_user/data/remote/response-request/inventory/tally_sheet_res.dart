// To parse this JSON data, do
//
//     final tallySheetRes = tallySheetResFromJson(jsonString);

import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/tally_sheet.dart';

TallySheetRes tallySheetResFromJson(String str) => TallySheetRes.fromJson(json.decode(str));

String tallySheetResToJson(TallySheetRes data) => json.encode(data.toJson());

class TallySheetRes {
  TallySheetRes({
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
  TallySheet? data;

  factory TallySheetRes.fromJson(Map<String, dynamic> json) => TallySheetRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : TallySheet.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data!.toJson(),
  };
}

