
import 'package:com.ikitech.store/app_user/model/bonus_level.dart';

class UpdateBonusLevelAgencyResponse {
  UpdateBonusLevelAgencyResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  BonusLevel? data;

  factory UpdateBonusLevelAgencyResponse.fromJson(Map<String, dynamic> json) => UpdateBonusLevelAgencyResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : BonusLevel.fromJson(json["data"]),
  );

}