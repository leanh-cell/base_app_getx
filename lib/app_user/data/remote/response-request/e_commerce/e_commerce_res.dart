import '../../../../model/e_commerce.dart';

class AllECommerceRes {
  AllECommerceRes({
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
  List<ECommerce>? data;

  factory AllECommerceRes.fromJson(Map<String, dynamic> json) =>
      AllECommerceRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<ECommerce>.from(
                json["data"]!.map((x) => ECommerce.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
