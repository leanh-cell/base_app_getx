import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/general_setting.dart';

GeneralSettingsRes generalSettingsResFromJson(String str) => GeneralSettingsRes.fromJson(json.decode(str));

String generalSettingsResToJson(GeneralSettingsRes data) => json.encode(data.toJson());

class GeneralSettingsRes {
  GeneralSettingsRes({
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
  GeneralSetting? data;

  factory GeneralSettingsRes.fromJson(Map<String, dynamic> json) => GeneralSettingsRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : GeneralSetting.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data!.toJson(),
  };
}


