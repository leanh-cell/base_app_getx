// To parse this JSON data, do
//
//     final historyShipperResponse = historyShipperResponseFromJson(jsonString);

import 'dart:convert';

HistoryShipperResponse historyShipperResponseFromJson(String str) => HistoryShipperResponse.fromJson(json.decode(str));

String historyShipperResponseToJson(HistoryShipperResponse data) => json.encode(data.toJson());

class HistoryShipperResponse {
  HistoryShipperResponse({
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
  List<HistoryShipper>? data;

  factory HistoryShipperResponse.fromJson(Map<String, dynamic> json) => HistoryShipperResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<HistoryShipper>.from(json["data"].map((x) => HistoryShipper.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class HistoryShipper {
  HistoryShipper({
    this.time,
    this.statusText,
  });

  DateTime? time;
  String? statusText;

  factory HistoryShipper.fromJson(Map<String, dynamic> json) => HistoryShipper(
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    statusText: json["status_text"] == null ? null : json["status_text"],
  );

  Map<String, dynamic> toJson() => {
    "time": time == null ? null : time!.toIso8601String(),
    "status_text": statusText == null ? null : statusText,
  };
}
