import 'package:com.ikitech.store/app_user/model/shifts.dart';

class ShiftsRes {
  ShiftsRes({
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
  Shifts? data;

  factory ShiftsRes.fromJson(Map<String, dynamic> json) => ShiftsRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : Shifts.fromJson(json["data"]),
  );
}
