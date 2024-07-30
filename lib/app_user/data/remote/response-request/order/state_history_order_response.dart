import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/state_order.dart';

StateHistoryOrderResponse stateHistoryOrderResponseFromJson(String str) =>
    StateHistoryOrderResponse.fromJson(json.decode(str));

String stateHistoryOrderResponseToJson(StateHistoryOrderResponse data) =>
    json.encode(data.toJson());

class StateHistoryOrderResponse {
  StateHistoryOrderResponse({
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

  factory StateHistoryOrderResponse.fromJson(Map<String, dynamic> json) =>
      StateHistoryOrderResponse(
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
