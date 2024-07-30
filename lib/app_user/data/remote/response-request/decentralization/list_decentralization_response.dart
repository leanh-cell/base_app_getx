import 'package:com.ikitech.store/app_user/model/decentralization.dart';

class ListDecentralizationResponse {
  ListDecentralizationResponse({
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
  List<Decentralization>? data;

  factory ListDecentralizationResponse.fromJson(Map<String, dynamic> json) => ListDecentralizationResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<Decentralization>.from(json["data"].map((x) => Decentralization.fromJson(x))),
  );

}

