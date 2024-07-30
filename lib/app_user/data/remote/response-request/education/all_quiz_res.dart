import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/quiz.dart';

AllQuizRes allQuizResFromJson(String str) => AllQuizRes.fromJson(json.decode(str));

String allQuizResToJson(AllQuizRes data) => json.encode(data.toJson());

class AllQuizRes {
  AllQuizRes({
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
  List<Quiz>? data;

  factory AllQuizRes.fromJson(Map<String, dynamic> json) => AllQuizRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<Quiz>.from(json["data"].map((x) => Quiz.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}
