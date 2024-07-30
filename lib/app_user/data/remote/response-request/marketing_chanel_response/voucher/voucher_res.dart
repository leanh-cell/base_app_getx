
import 'package:com.ikitech.store/app_user/model/voucher.dart';

class VoucherRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    Voucher? data;

    VoucherRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory VoucherRes.fromJson(Map<String, dynamic> json) => VoucherRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Voucher.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}

