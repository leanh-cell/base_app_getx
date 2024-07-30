import 'dart:convert';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

ProductScanResponse productScanResponseFromJson(String str) =>
    ProductScanResponse.fromJson(json.decode(str));

String productScanResponseToJson(ProductScanResponse data) =>
    json.encode(data.toJson());

class ProductScanResponse {
  ProductScanResponse({
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

  factory ProductScanResponse.fromJson(Map<String, dynamic> json) =>
      ProductScanResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.distributes,
    this.product,
    this.quantity,
  });

  List<DistributesSelected>? distributes;
  Product? product;
  int? quantity;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        distributes: json["distributes"] == null
            ? null
            : List<DistributesSelected>.from(json["distributes"]
                .map((x) => DistributesSelected.fromJson(x))),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        quantity: json["quantity_in_stock"] == null ? null : json["quantity_in_stock"],
      );

  Map<String, dynamic> toJson() => {
        "distributes": distributes == null
            ? null
            : List<Distributes>.from(distributes!.map((x) => x)),
        "product": product == null ? null : product!.toJson(),
      };
}
