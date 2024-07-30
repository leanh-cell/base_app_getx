import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/voucher.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

CreateVoucherResponse createVoucherResponseFromJson(String str) =>
    CreateVoucherResponse.fromJson(json.decode(str));

String createVoucherResponseToJson(CreateVoucherResponse data) =>
    json.encode(data.toJson());

class CreateVoucherResponse {
  CreateVoucherResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  Voucher? data;

  factory CreateVoucherResponse.fromJson(Map<String, dynamic> json) =>
      CreateVoucherResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: Voucher.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": data!.toJson(),
      };
}
