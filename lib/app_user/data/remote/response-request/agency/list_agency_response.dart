


import '../../../../model/agency.dart';

class ListAgencyResponse {
  ListAgencyResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
    this.isStaffHaveCheckoutAgency,this.agencyAreCheckin
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  bool? isStaffHaveCheckoutAgency;
  Agency? agencyAreCheckin;
  Data? data;

  factory ListAgencyResponse.fromJson(Map<String, dynamic> json) =>
      ListAgencyResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        isStaffHaveCheckoutAgency : json["is_staff_have_checkout_agency"],
        agencyAreCheckin:json["agency_are_checkin"] == null ? null : Agency.fromJson(json["agency_are_checkin"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Agency>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<Agency>.from(json["data"].map((x) => Agency.fromJson(x))),
        firstPageUrl:
            json["first_page_url"] == null ? null : json["first_page_url"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"] == null ? null : json["last_page"],
        lastPageUrl:
            json["last_page_url"] == null ? null : json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"] == null ? null : json["path"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"] == null ? null : json["to"],
        total: json["total"] == null ? null : json["total"],
      );
}
