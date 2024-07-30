
import 'package:com.ikitech.store/app_user/model/collaborator_configs.dart';

class CollaboratorConfigsResponse {
  CollaboratorConfigsResponse({
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
  CollaboratorConfig? data;

  factory CollaboratorConfigsResponse.fromJson(Map<String, dynamic> json) => CollaboratorConfigsResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : CollaboratorConfig.fromJson(json["data"]),
  );
}

