import 'package:com.ikitech.store/app_user/model/question.dart';

class QuestionRes {
  QuestionRes({
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
  Question? data;

  factory QuestionRes.fromJson(Map<String, dynamic> json) => QuestionRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : Question.fromJson(json["data"]),
  );
}
