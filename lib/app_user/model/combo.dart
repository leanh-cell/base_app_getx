// To parse this JSON data, do
//
//     final combo = comboFromJson(jsonString);

import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/product.dart';

import '../data/remote/response-request/customer/all_group_customer_res.dart';
import 'agency_type.dart';

Combo comboFromJson(String str) => Combo.fromJson(json.decode(str));

String comboToJson(Combo data) => json.encode(data.toJson());

class Combo {
  Combo(
      {this.id,
      this.storeId,
      this.isEnd,
      this.name,
      this.description,
      this.imageUrl,
      this.startTime,
      this.endTime,
      this.discountType,
      this.valueDiscount,
      this.setLimitAmount,
      this.amount,
      this.used,
      this.createdAt,
      this.updatedAt,
      this.productsCombo,
      this.group,
      this.agencyTypes,
      this.groupTypes});

  int? id;
  int? storeId;
  bool? isEnd;
  String? name;
  String? description;
  String? imageUrl;
  DateTime? startTime;
  DateTime? endTime;
  int? discountType;
  double? valueDiscount;
  bool? setLimitAmount;
  dynamic amount;
  int? used;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ProductsCombo>? productsCombo;
  List<int>? group;
  List<AgencyType>? agencyTypes;
  List<GroupCustomer>? groupTypes;

  factory Combo.fromJson(Map<String, dynamic> json) => Combo(
        id: json["id"],
        storeId: json["store_id"],
        isEnd: json["is_end"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        discountType: json["discount_type"],
        valueDiscount: json["value_discount"].toDouble(),
        setLimitAmount: json["set_limit_amount"],
        amount: json["amount"],
        used: json["used"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        productsCombo: List<ProductsCombo>.from(
            json["products_combo"].map((x) => ProductsCombo.fromJson(x))),
        group: json["group_customers"] == null ? [] : List<int>.from(json["group_customers"].map((x) => x)),
        agencyTypes: json["agency_types"] == null
            ? []
            : List<AgencyType>.from(
                json["agency_types"]!.map((x) => AgencyType.fromJson(x))),
        groupTypes: json["group_types"] == null
            ? []
            : List<GroupCustomer>.from(
                json["group_types"]!.map((x) => GroupCustomer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "is_end": isEnd,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "start_time": startTime!.toIso8601String(),
        "end_time": endTime!.toIso8601String(),
        "discount_type": discountType,
        "value_discount": valueDiscount,
        "set_limit_amount": setLimitAmount,
        "amount": amount,
        "used": used,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "products_combo":
            List<dynamic>.from(productsCombo!.map((x) => x.toJson())),
        "agency_types": agencyTypes == null
            ? []
            : List<dynamic>.from(agencyTypes!.map((x) => x.toJson())),
        "group_types": groupTypes == null
            ? []
            : List<dynamic>.from(groupTypes!.map((x) => x.toJson())),
        "group_customers": group,
      };
}

class ProductsCombo {
  ProductsCombo({
    this.id,
    this.quantity,
    this.product,
  });

  int? id;
  int? quantity;
  Product? product;

  factory ProductsCombo.fromJson(Map<String, dynamic> json) => ProductsCombo(
        id: json["id"],
        quantity: json["quantity"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "product": product!.toJson(),
      };
}
