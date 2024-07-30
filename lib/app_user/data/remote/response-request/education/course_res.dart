import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/course_list.dart';

class CourseRes {
  CourseRes({
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
  CourseList? data;

  factory CourseRes.fromJson(Map<String, dynamic> json) => CourseRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : CourseList.fromJson(json["data"]),
      );
}
