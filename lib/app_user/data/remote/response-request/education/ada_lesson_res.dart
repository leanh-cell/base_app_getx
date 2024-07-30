import 'package:com.ikitech.store/app_user/model/lesson.dart';

class AddLessonRes {
  AddLessonRes({
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
  Lesson? data;

  factory AddLessonRes.fromJson(Map<String, dynamic> json) => AddLessonRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Lesson.fromJson(json["data"]),
      );
}
