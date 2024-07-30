// To parse this JSON data, do
//
//     final addTokenShipmentResponse = addTokenShipmentResponseFromJson(jsonString);

import 'dart:convert';

AddTokenShipmentResponse addTokenShipmentResponseFromJson(String str) =>
    AddTokenShipmentResponse.fromJson(json.decode(str));

String addTokenShipmentResponseToJson(AddTokenShipmentResponse data) =>
    json.encode(data.toJson());

class AddTokenShipmentResponse {
  AddTokenShipmentResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;

  factory AddTokenShipmentResponse.fromJson(Map<String, dynamic> json) =>
      AddTokenShipmentResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
      };
}
