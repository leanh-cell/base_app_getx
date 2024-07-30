import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/combo.dart';

CreateComboResponse createComboResponseFromJson(String str) =>
    CreateComboResponse.fromJson(json.decode(str));

String createComboResponseToJson(CreateComboResponse data) =>
    json.encode(data.toJson());

class CreateComboResponse {
  CreateComboResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  Combo? data;

  factory CreateComboResponse.fromJson(Map<String, dynamic> json) =>
      CreateComboResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: Combo.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": data!.toJson(),
      };
}
