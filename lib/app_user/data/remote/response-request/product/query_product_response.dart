import 'dart:convert';
import 'package:sahashop_customer/app_customer/model/product.dart';

QueryProductResponse queryProductResponseFromJson(String str) =>
    QueryProductResponse.fromJson(json.decode(str));

String queryProductResponseToJson(QueryProductResponse data) =>
    json.encode(data.toJson());

class QueryProductResponse {
  QueryProductResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  DataPageProduct? data;

  factory QueryProductResponse.fromJson(Map<String, dynamic> json) =>
      QueryProductResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: DataPageProduct.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": data!.toJson(),
      };
}



class DataPageProduct {
  DataPageProduct({
    this.totalStoking,
    this.totalOutOfStock,
    this.totalHide,
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
  });

  int? totalStoking;
  int? totalOutOfStock;
  int? totalHide;
  int? currentPage;
  List<Product>? data;
  String? firstPageUrl;
  int? from;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;

  factory DataPageProduct.fromJson(Map<String, dynamic> json) =>
      DataPageProduct(
        totalStoking: json["total_stoking"] ?? 0,
        totalOutOfStock: json["total_out_of_stock"] ?? 0,
        totalHide: json["total_hide"] ?? 0,
        currentPage: json["current_page"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
    "total_stoking": totalStoking,
    "total_out_of_stock": totalOutOfStock,
    "total_hide": totalHide,
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
  };
}
