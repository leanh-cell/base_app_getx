import 'package:com.ikitech.store/app_user/model/branch.dart';

class CreateBranchResponse {
  CreateBranchResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  Branch? data;

  factory CreateBranchResponse.fromJson(Map<String, dynamic> json) =>
      CreateBranchResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: json["data"] == null ? null : Branch.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": data!.toJson(),
      };
}
