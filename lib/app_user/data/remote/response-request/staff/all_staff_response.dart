import 'package:com.ikitech.store/app_user/model/staff.dart';

class AllStaffResponse {
  AllStaffResponse({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  List<Staff>? data;
  String? msgCode;
  String? msg;

  factory AllStaffResponse.fromJson(Map<String, dynamic> json) => AllStaffResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : List<Staff>.from(json["data"].map((x) => Staff.fromJson(x))),
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
  );
}
