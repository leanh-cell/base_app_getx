import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/refund_calculate.dart';

RefundCalculateRes refundCalculateResFromJson(String str) => RefundCalculateRes.fromJson(json.decode(str));

String refundCalculateResToJson(RefundCalculateRes data) => json.encode(data.toJson());

class RefundCalculateRes {
    RefundCalculateRes({
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
    RefundCalculate? data;

    factory RefundCalculateRes.fromJson(Map<String, dynamic> json) => RefundCalculateRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : RefundCalculate.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data!.toJson(),
    };
}


