
import '../../../../model/transfer_stock.dart';

class AllTransferStocksRes {
  AllTransferStocksRes({
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
  Data? data;

  factory AllTransferStocksRes.fromJson(Map<String, dynamic> json) =>
      AllTransferStocksRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.totalTransfered,
    this.totalWait,
    this.totalCancel,
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? totalTransfered;
  int? totalWait;
  int? totalCancel;
  int? currentPage;
  List<TransferStock>? data;
  String? nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalTransfered:
            json["total_transfered"] == null ? null : json["total_transfered"],
        totalWait: json["total_wait"] == null ? null : json["total_wait"],
        totalCancel: json["total_cancel"] == null ? null : json["total_cancel"],
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<TransferStock>.from(
                json["data"].map((x) => TransferStock.fromJson(x))),
        nextPageUrl:
            json["next_page_url"] == null ? null : json["next_page_url"],
      );

}

