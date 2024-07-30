import 'dart:convert';
import 'package:com.ikitech.store/app_user/model/combo.dart';

MyComboResponse myComboResponseFromJson(String str) =>
    MyComboResponse.fromJson(json.decode(str));

String myComboResponseToJson(MyComboResponse data) =>
    json.encode(data.toJson());

class MyComboResponse {
  MyComboResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  List<Combo>? data;

  factory MyComboResponse.fromJson(Map<String, dynamic> json) =>
      MyComboResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: List<Combo>.from(json["data"].map((x) => Combo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
