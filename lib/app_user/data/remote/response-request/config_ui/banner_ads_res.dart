// To parse this JSON data, do
//
//     final bannerAdsRes = bannerAdsResFromJson(jsonString);

import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/banner_ads.dart';

BannerAdsRes bannerAdsResFromJson(String str) => BannerAdsRes.fromJson(json.decode(str));

String bannerAdsResToJson(BannerAdsRes data) => json.encode(data.toJson());

class BannerAdsRes {
  BannerAdsRes({
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
  BannerAds? data;

  factory BannerAdsRes.fromJson(Map<String, dynamic> json) => BannerAdsRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : BannerAds.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : data!.toJson(),
  };
}