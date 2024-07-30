import '../../../../model/branch.dart';
import '../../../../model/transfer_stock.dart';
import '../../../../model/transfer_stock_item.dart';

class TransferStocksRes {
  TransferStocksRes({
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
  TransferStock? data;

  factory TransferStocksRes.fromJson(Map<String, dynamic> json) =>
      TransferStocksRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : TransferStock.fromJson(json["data"]),
      );
}




