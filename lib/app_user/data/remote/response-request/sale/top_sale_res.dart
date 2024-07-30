import 'package:com.ikitech.store/app_user/model/staff.dart';

class TopSaleRes {
  TopSaleRes({
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

  factory TopSaleRes.fromJson(Map<String, dynamic> json) => TopSaleRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<Staff>? data;
  String? nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Staff>.from(json["data"]!.map((x) => Staff.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );
}
