
import 'package:com.ikitech.store/app_user/model/schedule_noti.dart';

class AllScheduleNotiResponse {
  AllScheduleNotiResponse({
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
  List<ScheduleNoti>? data;

  factory AllScheduleNotiResponse.fromJson(Map<String, dynamic> json) => AllScheduleNotiResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<ScheduleNoti>.from(json["data"].map((x) => ScheduleNoti.fromJson(x))),
  );
}

