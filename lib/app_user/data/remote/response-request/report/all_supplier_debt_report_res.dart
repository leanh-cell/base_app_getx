import 'package:com.ikitech.store/app_user/model/supplier.dart';

class AllSupplierDebtReportRes {
  AllSupplierDebtReportRes({
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
  AllSupplierDebtReport? data;

  factory AllSupplierDebtReportRes.fromJson(Map<String, dynamic> json) =>
      AllSupplierDebtReportRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : AllSupplierDebtReport.fromJson(json["data"]),
      );
}

class AllSupplierDebtReport {
  AllSupplierDebtReport({
    this.debt,
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  double? debt;
  int? currentPage;
  List<Supplier>? data;
  String? nextPageUrl;

  factory AllSupplierDebtReport.fromJson(Map<String, dynamic> json) => AllSupplierDebtReport(
        debt: json["debt"] == null ? null : json["debt"].toDouble(),
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<Supplier>.from(
                json["data"].map((x) => Supplier.fromJson(x))),
        nextPageUrl:
            json["next_page_url"] == null ? null : json["next_page_url"],
      );
}
