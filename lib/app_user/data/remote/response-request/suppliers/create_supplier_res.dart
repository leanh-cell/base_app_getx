import 'package:com.ikitech.store/app_user/model/supplier.dart';

class CreateSuppliersRes {
  CreateSuppliersRes({
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
  Supplier? data;

  factory CreateSuppliersRes.fromJson(Map<String, dynamic> json) =>
      CreateSuppliersRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Supplier.fromJson(json["data"]),
      );
}
