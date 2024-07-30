import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/review.dart';

AllReviewResponse allReviewResponseFromJson(String str) =>
    AllReviewResponse.fromJson(json.decode(str));

String allReviewResponseToJson(AllReviewResponse data) =>
    json.encode(data.toJson());

class AllReviewResponse {
  AllReviewResponse({
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

  factory AllReviewResponse.fromJson(Map<String, dynamic> json) =>
      AllReviewResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.averagedStars,
    this.totalReviews,
    this.totalPendingApproval,
    this.totalCancel,
    this.total1Stars,
    this.total2Stars,
    this.total3Stars,
    this.total4Stars,
    this.total5Stars,
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  double? averagedStars;
  int? totalReviews;
  int? totalPendingApproval;
  int? totalCancel;
  int? total1Stars;
  int? total2Stars;
  int? total3Stars;
  int? total4Stars;
  int? total5Stars;
  int? currentPage;
  List<Review>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        averagedStars: json["averaged_stars"] == null
            ? null
            : json["averaged_stars"].toDouble(),
        totalReviews:
            json["total_reviews"] == null ? null : json["total_reviews"],
        totalPendingApproval: json["total_pending_approval"] == null
            ? null
            : json["total_pending_approval"],
        totalCancel: json["total_cancel"] == null ? null : json["total_cancel"],
        total1Stars:
            json["total_1_stars"] == null ? null : json["total_1_stars"],
        total2Stars:
            json["total_2_stars"] == null ? null : json["total_2_stars"],
        total3Stars:
            json["total_3_stars"] == null ? null : json["total_3_stars"],
        total4Stars:
            json["total_4_stars"] == null ? null : json["total_4_stars"],
        total5Stars:
            json["total_5_stars"] == null ? null : json["total_5_stars"],
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<Review>.from(json["data"].map((x) => Review.fromJson(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "averaged_stars": averagedStars == null ? null : averagedStars,
        "total_reviews": totalReviews == null ? null : totalReviews,
        "total_pending_approval":
            totalPendingApproval == null ? null : totalPendingApproval,
        "total_cancel": totalCancel == null ? null : totalCancel,
        "total_1_stars": total1Stars == null ? null : total1Stars,
        "total_2_stars": total2Stars == null ? null : total2Stars,
        "total_3_stars": total3Stars == null ? null : total3Stars,
        "total_4_stars": total4Stars == null ? null : total4Stars,
        "total_5_stars": total5Stars == null ? null : total5Stars,
        "current_page": currentPage == null ? null : currentPage,
        "data": data == null
            ? null
            : List<Review>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl == null ? null : firstPageUrl,
        "from": from == null ? null : from,
        "last_page": lastPage == null ? null : lastPage,
        "last_page_url": lastPageUrl == null ? null : lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path == null ? null : path,
        "per_page": perPage == null ? null : perPage,
        "prev_page_url": prevPageUrl,
        "to": to == null ? null : to,
        "total": total == null ? null : total,
      };
}
