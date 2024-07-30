// To parse this JSON data, do
//
//     final createShopResponse = createShopResponseFromJson(jsonString);

import 'dart:convert';

import 'all_store_response.dart';

CreateShopResponse createShopResponseFromJson(String str) => CreateShopResponse.fromJson(json.decode(str));

String createShopResponseToJson(CreateShopResponse data) => json.encode(data.toJson());

class CreateShopResponse {
  CreateShopResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  Store? data;

  factory CreateShopResponse.fromJson(Map<String, dynamic> json) => CreateShopResponse(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    data: Store.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "data": data!.toJson(),
  };
}
