import 'package:sahashop_customer/app_customer/model/button_home.dart';
import 'dart:convert';

ButtonHomeResponse buttonHomeResponseFromJson(String str) => ButtonHomeResponse.fromJson(json.decode(str));

String buttonHomeResponseToJson(ButtonHomeResponse data) => json.encode(data.toJson());

class ButtonHomeResponse {
  ButtonHomeResponse({
    this.code,
    this.success,
    this.msgCode,
    this.buttons,
  });

  int? code;
  bool? success;
  String? msgCode;
  List<HomeButton>? buttons;

  factory ButtonHomeResponse.fromJson(Map<String, dynamic> json) => ButtonHomeResponse(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    buttons: List<HomeButton>.from(json["data"]['buttons'].map((x) => HomeButton.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    // "buttons": buttons!.toJson(),
  };
}


