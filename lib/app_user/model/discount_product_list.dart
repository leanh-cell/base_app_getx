import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/product.dart';

import '../data/remote/response-request/customer/all_group_customer_res.dart';
import 'agency_type.dart';

DiscountProductsList discountProductsListFromJson(String str) =>
    DiscountProductsList.fromJson(json.decode(str));

String discountProductsListToJson(DiscountProductsList data) =>
    json.encode(data.toJson());

class DiscountProductsList {
  DiscountProductsList({
    this.id,
    this.storeId,
    this.isEnd,
    this.name,
    this.description,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.group,
 
    this.value,
    this.setLimitAmount,
    this.amount,
    this.used,
    this.createdAt,
    this.updatedAt,
    this.products,
    this.agencyTypes,this.groupTypes
 
  });

  int? id;
  int? storeId;
  bool? isEnd;
  String? name;
  List<int>? group;
  List<AgencyType>? agencyTypes;
  List<GroupCustomer>? groupTypes;
  String? description;
  String? imageUrl;
  DateTime? startTime;
  DateTime? endTime;
  double? value;
  bool? setLimitAmount;
  dynamic amount;
  int? used;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Product>? products;

  factory DiscountProductsList.fromJson(Map<String, dynamic> json) =>
      DiscountProductsList(
        id: json["id"],
        storeId: json["store_id"],
        isEnd: json["is_end"],
        name: json["name"],
        description: json["description"],
        group: json["group_customers"] == null ? [] : List<int>.from(json["group_customers"].map((x) => x)),
        agencyTypes: json["agency_types"] == null ? [] : List<AgencyType>.from(json["agency_types"]!.map((x) => AgencyType.fromJson(x))),
        groupTypes: json["group_types"] == null ? [] : List<GroupCustomer>.from(json["group_types"]!.map((x) => GroupCustomer.fromJson(x))),
        imageUrl: json["image_url"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        value: json["value"] == null ? null : json["value"].toDouble(),
        setLimitAmount: json["set_limit_amount"],
        amount: json["amount"],
      
        used: json["used"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "is_end": isEnd,
        "name": name,
        "description": description,
        "agency_types": agencyTypes == null ? [] : List<dynamic>.from(agencyTypes!.map((x) => x.toJson())),
        "group_types": groupTypes == null ? [] : List<dynamic>.from(groupTypes!.map((x) => x.toJson())),
        "group_customer": group,

        "image_url": imageUrl,
        "start_time": startTime!.toIso8601String(),
        "end_time": endTime!.toIso8601String(),
        "value": value,
        "set_limit_amount": setLimitAmount,
        "amount": amount,
        "used": used,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}
