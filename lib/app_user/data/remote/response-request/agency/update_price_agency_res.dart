
import 'package:sahashop_customer/app_customer/model/product.dart';

class UpdatePriceAgencyRes {
  UpdatePriceAgencyRes({
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
  Data? data;

  factory UpdatePriceAgencyRes.fromJson(Map<String, dynamic> json) => UpdatePriceAgencyRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  Data({
    this.mainPrice,
    this.distributes,
  });

  int? mainPrice;
  List<Distributes>? distributes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mainPrice: json["main_price"] == null ? null : json["main_price"],
    distributes: json["distributes"] == null ? null : List<Distributes>.from(json["distributes"].map((x) => Distributes.fromJson(x))),
  );

}
