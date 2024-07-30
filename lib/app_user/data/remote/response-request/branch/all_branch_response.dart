import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/branch.dart';


AllBranchResponse allStoreResponseFromJson(String str) =>
    AllBranchResponse.fromJson(json.decode(str));

String allStoreResponseToJson(AllBranchResponse data) =>
    json.encode(data.toJson());

class AllBranchResponse {
  AllBranchResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  List<Branch>? data;

  factory AllBranchResponse.fromJson(Map<String, dynamic> json) =>
      AllBranchResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: List<Branch>.from(json["data"].map((x) => Branch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}