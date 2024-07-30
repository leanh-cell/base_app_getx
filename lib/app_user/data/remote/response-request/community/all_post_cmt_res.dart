import 'package:sahashop_customer/app_customer/model/community_post.dart';

class AllPostCmtRes {
  AllPostCmtRes({
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
  Data? data;

  factory AllPostCmtRes.fromJson(Map<String, dynamic> json) => AllPostCmtRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<CommunityPost>? data;
  String? nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<CommunityPost>.from(json["data"].map((x) => CommunityPost.fromJson(x))),
    nextPageUrl:json["next_page_url"] == null ? null :  json["next_page_url"],
  );
}


