


import 'package:sahashop_customer/app_customer/model/info_customer.dart';

class InfoCustomerRes {
  InfoCustomerRes({
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
  InfoCustomer? data;

  factory InfoCustomerRes.fromJson(Map<String, dynamic> json) => InfoCustomerRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : InfoCustomer.fromJson(json["data"]),
  );
}
