import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/ship_config.dart';

ConfigShipRes configShipResFromJson(String str) => ConfigShipRes.fromJson(json.decode(str));

String configShipResToJson(ConfigShipRes data) => json.encode(data.toJson());

class ConfigShipRes {
  ConfigShipRes({
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
  ShipConfig? data;

  factory ConfigShipRes.fromJson(Map<String, dynamic> json) => ConfigShipRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : ShipConfig.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data!.toJson(),
  };
}


