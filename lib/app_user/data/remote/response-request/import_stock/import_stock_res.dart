import 'package:com.ikitech.store/app_user/model/import_stock.dart';

class ImportStocksRes {
  ImportStocksRes({
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
  ImportStock? data;

  factory ImportStocksRes.fromJson(Map<String, dynamic> json) => ImportStocksRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : ImportStock.fromJson(json["data"]),
  );
}


