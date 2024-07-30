import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/product.dart';

ProductReportResponse productReportResponseFromJson(String str) =>
    ProductReportResponse.fromJson(json.decode(str));

String productReportResponseToJson(ProductReportResponse data) =>
    json.encode(data.toJson());

class ProductReportResponse {
  ProductReportResponse({
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

  factory ProductReportResponse.fromJson(Map<String, dynamic> json) =>
      ProductReportResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.totalItems,
    this.numberOfOrders,
    this.totalPrice,
    this.view,
  });

  List<TotalItem>? totalItems;
  List<NumberOfOrder>? numberOfOrders;
  List<TotalPrice>? totalPrice;
  List<View>? view;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalItems: List<TotalItem>.from(
            json["total_items"].map((x) => TotalItem.fromJson(x))),
        numberOfOrders: List<NumberOfOrder>.from(
            json["number_of_orders"].map((x) => NumberOfOrder.fromJson(x))),
        totalPrice: List<TotalPrice>.from(
            json["total_price"].map((x) => TotalPrice.fromJson(x))),
        view: List<View>.from(json["view"].map((x) => View.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_items": List<dynamic>.from(totalItems!.map((x) => x.toJson())),
        "number_of_orders":
            List<dynamic>.from(numberOfOrders!.map((x) => x.toJson())),
        "total_price": List<dynamic>.from(totalPrice!.map((x) => x.toJson())),
        "view": List<dynamic>.from(view!.map((x) => x.toJson())),
      };
}

class NumberOfOrder {
  NumberOfOrder({
    this.numberOfOrders,
    this.product,
  });

  int? numberOfOrders;
  Product? product;

  factory NumberOfOrder.fromJson(Map<String, dynamic> json) => NumberOfOrder(
        numberOfOrders: json["number_of_orders"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "number_of_orders": numberOfOrders,
        "product": product!.toJson(),
      };
}

class TotalItem {
  TotalItem({
    this.totalItems,
    this.product,
  });

  int? totalItems;
  Product? product;

  factory TotalItem.fromJson(Map<String, dynamic> json) => TotalItem(
        totalItems: json["total_items"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "total_items": totalItems,
        "product": product!.toJson(),
      };
}

class TotalPrice {
  TotalPrice({
    this.totalPrice,
    this.product,
  });

  double? totalPrice;
  Product? product;

  factory TotalPrice.fromJson(Map<String, dynamic> json) => TotalPrice(
        totalPrice:
            json["total_price"] == null ? null : json["total_price"].toDouble(),
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "total_price": totalPrice,
        "product": product!.toJson(),
      };
}

class View {
  View({
    this.view,
    this.product,
  });

  int? view;
  Product? product;

  factory View.fromJson(Map<String, dynamic> json) => View(
        view: json["view"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "view": view,
        "product": product!.toJson(),
      };
}
