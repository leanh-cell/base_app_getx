import 'package:sahashop_customer/app_customer/model/info_customer.dart';

class AllCustomerDebtReportRes {
  AllCustomerDebtReportRes({
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
  AllCustomerDebtReport? data;

  factory AllCustomerDebtReportRes.fromJson(Map<String, dynamic> json) =>
      AllCustomerDebtReportRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : AllCustomerDebtReport.fromJson(json["data"]),
      );
}

class AllCustomerDebtReport {
  AllCustomerDebtReport({
    this.debt,
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  double? debt;
  int? currentPage;
  List<InfoCustomer>? data;
  String? nextPageUrl;

  factory AllCustomerDebtReport.fromJson(Map<String, dynamic> json) => AllCustomerDebtReport(
        debt: json["debt"] == null ? null : json["debt"].toDouble(),
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<InfoCustomer>.from(
                json["data"].map((x) => InfoCustomer.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );
}
