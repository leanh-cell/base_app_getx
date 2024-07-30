
import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/post.dart';

PostRes postResFromJson(String str) => PostRes.fromJson(json.decode(str));

String postResToJson(PostRes data) => json.encode(data.toJson());

class PostRes {
  PostRes({
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
  Post? data;

  factory PostRes.fromJson(Map<String, dynamic> json) => PostRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : Post.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data!.toJson(),
  };
}
