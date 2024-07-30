import 'dart:convert';

UpdatePaymentResponse updatePaymentResponseFromJson(String str) =>
    UpdatePaymentResponse.fromJson(json.decode(str));

String updatePaymentResponseToJson(UpdatePaymentResponse data) =>
    json.encode(data.toJson());

class UpdatePaymentResponse {
  UpdatePaymentResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;

  factory UpdatePaymentResponse.fromJson(Map<String, dynamic> json) =>
      UpdatePaymentResponse(
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
