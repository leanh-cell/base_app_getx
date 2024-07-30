
import 'package:com.ikitech.store/app_user/model/agency.dart';

class UpdateAgencyResponse {
  UpdateAgencyResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.agency,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  Agency? agency;

  factory UpdateAgencyResponse.fromJson(Map<String, dynamic> json) =>
      UpdateAgencyResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        agency: json["data"] == null ? null : Agency.fromJson(json["data"]),
      );
}
