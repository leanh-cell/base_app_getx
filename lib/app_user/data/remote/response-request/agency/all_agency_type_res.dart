

import '../../../../model/agency_type.dart';

class AllAgencyTypeRes {
  AllAgencyTypeRes({
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
  List<AgencyType>? data;

  factory AllAgencyTypeRes.fromJson(Map<String, dynamic> json) => AllAgencyTypeRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<AgencyType>.from(json["data"].map((x) => AgencyType.fromJson(x))),
  );

}