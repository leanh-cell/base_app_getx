import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/shipment.dart';

AllShipmentResponse allShipmentResponseFromJson(String str) =>
    AllShipmentResponse.fromJson(json.decode(str));

String allShipmentResponseToJson(AllShipmentResponse data) =>
    json.encode(data.toJson());

class AllShipmentResponse {
  AllShipmentResponse({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  List<Shipment>? data;
  String? msgCode;
  String? msg;

  factory AllShipmentResponse.fromJson(Map<String, dynamic> json) =>
      AllShipmentResponse(
        code: json["code"],
        success: json["success"],
        data:
            List<Shipment>.from(json["data"].map((x) => Shipment.fromJson(x))),
        msgCode: json["msg_code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg_code": msgCode,
        "msg": msg,
      };
}
