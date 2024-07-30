
import 'package:com.ikitech.store/app_user/model/agency_config.dart';
import 'package:com.ikitech.store/app_user/model/collaborator_configs.dart';

class AgencyConfigResponse {
  AgencyConfigResponse({
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
  AgencyConfig? data;

  factory AgencyConfigResponse.fromJson(Map<String, dynamic> json) => AgencyConfigResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : AgencyConfig.fromJson(json["data"]),
  );
}

