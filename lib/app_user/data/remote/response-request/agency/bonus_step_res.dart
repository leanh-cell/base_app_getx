import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/step_bonus.dart';

BonusStepRes bonusStepResFromJson(String str) =>
    BonusStepRes.fromJson(json.decode(str));

String bonusStepResToJson(BonusStepRes data) => json.encode(data.toJson());

class BonusStepRes {
  BonusStepRes({
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
  DataConfigBonus? data;

  factory BonusStepRes.fromJson(Map<String, dynamic> json) => BonusStepRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : DataConfigBonus.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
      };
}

class DataConfigBonus {
  DataConfigBonus({
    this.config,
    this.stepBonus,
  });

  Config? config;
  List<StepBonus>? stepBonus = [];

  factory DataConfigBonus.fromJson(Map<String, dynamic> json) => DataConfigBonus(
        config: json["config"] == null ? null : Config.fromJson(json["config"]),
        stepBonus: json["step_bonus"] == null
            ? []
            : List<StepBonus>.from(
                json["step_bonus"].map((x) => StepBonus.fromJson(x))),
      );
}

class Config {
  Config({
    this.isEnd,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });

  bool? isEnd;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        isEnd: json["is_end"] == null ? null : json["is_end"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "is_end": isEnd == null ? null : isEnd,
        "start_time": startTime == null ? null : startTime!.toIso8601String(),
        "end_time": endTime == null ? null : endTime!.toIso8601String(),
      };
}
