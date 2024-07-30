import 'package:com.ikitech.store/app_user/model/revenue_expenditure.dart';

class RevenueExpenditureRes {
  RevenueExpenditureRes({
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
  RevenueExpenditure? data;

  factory RevenueExpenditureRes.fromJson(Map<String, dynamic> json) => RevenueExpenditureRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : RevenueExpenditure.fromJson(json["data"]),
  );
}
