import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/home_data.dart';


LayoutSortResponse layoutSortResponseFromJson(String str) => LayoutSortResponse.fromJson(json.decode(str));

String layoutSortResponseToJson(LayoutSortResponse data) => json.encode(data.toJson());

class LayoutSortResponse {
  LayoutSortResponse({
    this.code,
    this.success,
    this.msgCode,
    this.buttons,
  });

  int? code;
  bool? success;
  String? msgCode;
  List<LayoutHome>? buttons;

  factory LayoutSortResponse.fromJson(Map<String, dynamic> json) => LayoutSortResponse(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    buttons: List<LayoutHome>.from(json["data"]['layouts'].map((x) => LayoutHome.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    // "buttons": buttons!.toJson(),
  };
}


