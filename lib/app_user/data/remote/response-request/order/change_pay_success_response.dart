import 'dart:convert';

ChangePaySuccessResponse changePaySuccessResponseFromJson(String str) =>
    ChangePaySuccessResponse.fromJson(json.decode(str));

String changePaySuccessResponseToJson(ChangePaySuccessResponse data) =>
    json.encode(data.toJson());

class ChangePaySuccessResponse {
  ChangePaySuccessResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;

  factory ChangePaySuccessResponse.fromJson(Map<String, dynamic> json) =>
      ChangePaySuccessResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
      };
}
