import 'package:com.ikitech.store/app_user/model/ctv.dart';

class UpdateCtvResponse {
  UpdateCtvResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.ctv,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  Ctv? ctv;

  factory UpdateCtvResponse.fromJson(Map<String, dynamic> json) => UpdateCtvResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    ctv: json["data"] == null ? null : Ctv.fromJson(json["data"]),
  );

}
