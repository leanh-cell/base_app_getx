import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/info_address.dart';

CreateAddressStoreResponse createAddressStoreResponseFromJson(String str) =>
    CreateAddressStoreResponse.fromJson(json.decode(str));

String createAddressStoreResponseToJson(CreateAddressStoreResponse data) =>
    json.encode(data.toJson());

class CreateAddressStoreResponse {
  CreateAddressStoreResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  InfoAddress? data;

  factory CreateAddressStoreResponse.fromJson(Map<String, dynamic> json) =>
      CreateAddressStoreResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: InfoAddress.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": data!.toJson(),
      };
}
