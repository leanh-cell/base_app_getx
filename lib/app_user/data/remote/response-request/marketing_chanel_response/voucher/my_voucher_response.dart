import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/voucher.dart';


class MyVoucherResponse {
  MyVoucherResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  List<Voucher>? data;

  factory MyVoucherResponse.fromJson(Map<String, dynamic> json) =>
      MyVoucherResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data:json["data"] == null ? []: List<Voucher>.from(json["data"].map((x) => Voucher.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
