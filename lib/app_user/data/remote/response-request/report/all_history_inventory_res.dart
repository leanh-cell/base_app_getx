import 'package:com.ikitech.store/app_user/model/history_inventory.dart';

class AllHistoryInventoryRes {
  AllHistoryInventoryRes({
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
  AllHistoryInventory? data;

  factory AllHistoryInventoryRes.fromJson(Map<String, dynamic> json) =>
      AllHistoryInventoryRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : AllHistoryInventory.fromJson(json["data"]),
      );
}

class AllHistoryInventory {
  AllHistoryInventory({
    this.countImport,
    this.countExport,
    this.importValue,
    this.exportValue,
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? countImport;
  int? countExport;
  double? importValue;
  double? exportValue;
  int? currentPage;
  List<HistoryInventory>? data;
  String? nextPageUrl;

  factory AllHistoryInventory.fromJson(Map<String, dynamic> json) =>
      AllHistoryInventory(
        countImport: json["count_import"] == null ? null : json["count_import"],
        countExport: json["count_export"] == null ? null : json["count_export"],
        importValue: json["import_value"] == null
            ? null
            : json["import_value"].toDouble(),
        exportValue: json["export_value"] == null
            ? null
            : json["export_value"].toDouble(),
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<HistoryInventory>.from(
                json["data"].map((x) => HistoryInventory.fromJson(x))),
        nextPageUrl:
            json["next_page_url"] == null ? null : json["next_page_url"],
      );
}
