import 'package:sahashop_customer/app_customer/model/product.dart';

class DistributeRes {
  DistributeRes({
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
  List<Distributes>? data;

  factory DistributeRes.fromJson(Map<String, dynamic> json) => DistributeRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : List<Distributes>.from(
                json["data"].map((x) => Distributes.fromJson(x))),
      );
}
