import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/history_checkin_checkout.dart';
import 'package:com.ikitech.store/app_user/model/shifts.dart';

TimeKeepingToDayRes timeKeepingToDayResFromJson(String str) =>
    TimeKeepingToDayRes.fromJson(json.decode(str));

String timeKeepingToDayResToJson(TimeKeepingToDayRes data) =>
    json.encode(data.toJson());

class TimeKeepingToDayRes {
  TimeKeepingToDayRes({
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
  Data? data;

  factory TimeKeepingToDayRes.fromJson(Map<String, dynamic> json) =>
      TimeKeepingToDayRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.shiftWorking,
    this.historyCheckinCheckout,
  });

  List<Shifts>? shiftWorking;
  List<HistoryCheckInCheckout>? historyCheckinCheckout;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        shiftWorking: json["shift_working"] == null
            ? null
            : List<Shifts>.from(
                json["shift_working"].map((x) => Shifts.fromJson(x))),
        historyCheckinCheckout: json["history_checkin_checkout"] == null
            ? null
            : List<HistoryCheckInCheckout>.from(json["history_checkin_checkout"]
                .map((x) => HistoryCheckInCheckout.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "shift_working": shiftWorking == null
            ? null
            : List<dynamic>.from(shiftWorking!.map((x) => x.toJson())),
        "history_checkin_checkout": historyCheckinCheckout == null
            ? null
            : List<dynamic>.from(
                historyCheckinCheckout!.map((x) => x.toJson())),
      };
}
