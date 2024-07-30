// To parse this JSON data, do
//
//     final allBannerAdsRes = allBannerAdsResFromJson(jsonString);

import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/banner_ads.dart';


AllBannerAdsRes allBannerAdsResFromJson(String str) => AllBannerAdsRes.fromJson(json.decode(str));

String allBannerAdsResToJson(AllBannerAdsRes data) => json.encode(data.toJson());

class AllBannerAdsRes {
  AllBannerAdsRes({
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
  List<BannerAds>? data;

  factory AllBannerAdsRes.fromJson(Map<String, dynamic> json) => AllBannerAdsRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<BannerAds>.from(json["data"].map((x) => BannerAds.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

