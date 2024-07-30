
import 'package:com.ikitech.store/app_user/model/schedule_noti.dart';

class ScheduleNotiResponse {
  ScheduleNotiResponse({
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
  ScheduleNoti? data;

  factory ScheduleNotiResponse.fromJson(Map<String, dynamic> json) => ScheduleNotiResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : ScheduleNoti.fromJson(json["data"]),
  );
}
