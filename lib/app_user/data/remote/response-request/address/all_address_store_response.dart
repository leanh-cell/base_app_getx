import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/info_address.dart';

AllAddressStoreResponse allAddressStoreResponseFromJson(String str) =>
    AllAddressStoreResponse.fromJson(json.decode(str));

String allAddressStoreResponseToJson(AllAddressStoreResponse data) =>
    json.encode(data.toJson());

class AllAddressStoreResponse {
  AllAddressStoreResponse({
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
  List<InfoAddress>? data;

  factory AllAddressStoreResponse.fromJson(Map<String, dynamic> json) =>
      AllAddressStoreResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: List<InfoAddress>.from(
            json["data"].map((x) => InfoAddress.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
