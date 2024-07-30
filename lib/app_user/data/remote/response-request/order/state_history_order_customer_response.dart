

import 'package:com.ikitech.store/app_user/model/state_order.dart';

class StateHistoryOrderCustomerResponse {
  StateHistoryOrderCustomerResponse({
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
  List<StateOrder>? data;

  factory StateHistoryOrderCustomerResponse.fromJson(
          Map<String, dynamic> json) =>
      StateHistoryOrderCustomerResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: List<StateOrder>.from(
            json["data"].map((x) => StateOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
