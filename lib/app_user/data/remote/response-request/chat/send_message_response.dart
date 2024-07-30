import 'dart:convert';

SendMessageResponse sendMessageResponseFromJson(String str) =>
    SendMessageResponse.fromJson(json.decode(str));

String sendMessageResponseToJson(SendMessageResponse data) =>
    json.encode(data.toJson());

class SendMessageResponse {
  SendMessageResponse({
    this.code,
    this.msgCode,
    this.msg,
    this.success,
  });

  int? code;
  String? msgCode;
  String? msg;
  bool? success;

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) =>
      SendMessageResponse(
        code: json["code"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg_code": msgCode,
        "msg": msg,
        "success": success,
      };
}
