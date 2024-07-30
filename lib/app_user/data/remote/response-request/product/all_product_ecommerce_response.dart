import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_request.dart';

class AllProductEcommerceRes {
  AllProductEcommerceRes({
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

  factory AllProductEcommerceRes.fromJson(Map<String, dynamic> json) =>
      AllProductEcommerceRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.totalCount,
    this.page,
    this.perPage,
    this.listProduct,
  });

  int? totalCount;
  int? page;
  int? perPage;
  List<ProductRequest>? listProduct;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCount: json["total_count"] == null ? null : json["total_count"],
        page: json["page"] == null ? null : json["page"],
        perPage: json["per_page"] == null ? null : json["per_page"],
        listProduct: json["list"] == null
            ? null
            : List<ProductRequest>.from(
                json["list"].map((x) => ProductRequest.fromJson(x))),
      );
}
