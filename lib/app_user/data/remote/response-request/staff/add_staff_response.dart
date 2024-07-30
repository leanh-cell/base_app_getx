import 'package:com.ikitech.store/app_user/model/staff.dart';

class AddStaffResponse {
  AddStaffResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.staff,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  Staff? staff;

  factory AddStaffResponse.fromJson(Map<String, dynamic> json) => AddStaffResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    staff: json["data"] == null ? null : Staff.fromJson(json["data"]),
  );
}
