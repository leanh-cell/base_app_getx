import 'dart:convert';

ChangeOrderStatusResponse changeOrderStatusResponseFromJson(String str) =>
    ChangeOrderStatusResponse.fromJson(json.decode(str));

String changeOrderStatusResponseToJson(ChangeOrderStatusResponse data) =>
    json.encode(data.toJson());

class ChangeOrderStatusResponse {
  ChangeOrderStatusResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;

  factory ChangeOrderStatusResponse.fromJson(Map<String, dynamic> json) =>
      ChangeOrderStatusResponse(
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
