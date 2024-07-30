import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/community_post.dart';

PostCmtRes postCmtResFromJson(String str) =>
    PostCmtRes.fromJson(json.decode(str));

String postCmtResToJson(PostCmtRes data) => json.encode(data.toJson());

class PostCmtRes {
  PostCmtRes({
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
  CommunityPost? data;

  factory PostCmtRes.fromJson(Map<String, dynamic> json) => PostCmtRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data:
            json["data"] == null ? null : CommunityPost.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data!.toJson(),
      };
}
