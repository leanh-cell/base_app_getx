import 'package:com.ikitech.store/app_user/model/revenue_expenditure.dart';

class AllRevenueExpenditureReportRes {
  AllRevenueExpenditureReportRes({
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
  AllRevenueExpenditureReport? data;

  factory AllRevenueExpenditureReportRes.fromJson(Map<String, dynamic> json) =>
      AllRevenueExpenditureReportRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : AllRevenueExpenditureReport.fromJson(json["data"]),
      );
}

class AllRevenueExpenditureReport {
  AllRevenueExpenditureReport({
    this.renvenure,
    this.expenditure,
    this.reserve,
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  double? renvenure;
  double? expenditure;
  double? reserve;
  int? currentPage;
  List<RevenueExpenditure>? data;
  String? nextPageUrl;

  factory AllRevenueExpenditureReport.fromJson(Map<String, dynamic> json) =>
      AllRevenueExpenditureReport(
        renvenure:
            json["renvenure"] == null ? null : json["renvenure"].toDouble(),
        expenditure:
            json["expenditure"] == null ? null : json["expenditure"].toDouble(),
        reserve: json["reserve"] == null ? null : json["reserve"].toDouble(),
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<RevenueExpenditure>.from(
                json["data"].map((x) => RevenueExpenditure.fromJson(x))),
        nextPageUrl:
            json["next_page_url"] == null ? null : json["next_page_url"],
      );
}
