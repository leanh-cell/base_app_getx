

import '../../../../model/sale_check_in.dart';

class SaleCheckInRes {
    int? code;
    bool? success;
    SaleCheckIn? data;
    String? msgCode;
    String? msg;

    SaleCheckInRes({
        this.code,
        this.success,
        this.data,
        this.msgCode,
        this.msg,
    });

    factory SaleCheckInRes.fromJson(Map<String, dynamic> json) => SaleCheckInRes(
        code: json["code"],
        success: json["success"],
        data: json["data"] == null ? null : SaleCheckIn.fromJson(json["data"]),
        msgCode: json["msg_code"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": data?.toJson(),
        "msg_code": msgCode,
        "msg": msg,
    };
}


