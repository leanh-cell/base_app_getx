import '../../../../model/order_commerce.dart';

class OrderCommerceRes {
  OrderCommerceRes({
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
  OrderCommerce? data;

  factory OrderCommerceRes.fromJson(Map<String, dynamic> json) =>
      OrderCommerceRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data:
            json["data"] == null ? null : OrderCommerce.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
      };
}
