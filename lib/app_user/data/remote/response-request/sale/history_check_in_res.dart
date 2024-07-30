

import 'package:com.ikitech.store/app_user/model/history_check_in.dart';

class HistoryCheckInRes {
    int? code;
    bool? success;
    HistoryCheckIn? data;
    String? msgCode;
    String? msg;

    HistoryCheckInRes({
        this.code,
        this.success,
        this.data,
        this.msgCode,
        this.msg,
    });

    factory HistoryCheckInRes.fromJson(Map<String, dynamic> json) => HistoryCheckInRes(
        code: json["code"],
        success: json["success"],
        data: json["data"] == null ? null : HistoryCheckIn.fromJson(json["data"]),
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


