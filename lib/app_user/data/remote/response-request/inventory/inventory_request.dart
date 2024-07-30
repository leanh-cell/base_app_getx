// To parse this JSON data, do
//
//     final inventoryRequest = inventoryRequestFromJson(jsonString);

import 'dart:convert';

InventoryRequest inventoryRequestFromJson(String str) => InventoryRequest.fromJson(json.decode(str));

String inventoryRequestToJson(InventoryRequest data) => json.encode(data.toJson());

class InventoryRequest {
  InventoryRequest({
    this.productId,
    this.distributeName,
    this.elementDistributeName,
    this.subElementDistributeName,
    this.stock,
    this.costOfCapital,
  });

  int? productId;
  String? distributeName;
  String? elementDistributeName;
  String? subElementDistributeName;
  int? stock;
  double? costOfCapital;

  factory InventoryRequest.fromJson(Map<String, dynamic> json) => InventoryRequest(
    productId: json["product_id"] == null ? null : json["product_id"],
    distributeName: json["distribute_name"] == null ? null : json["distribute_name"],
    elementDistributeName: json["element_distribute_name"] == null ? null : json["element_distribute_name"],
    subElementDistributeName: json["sub_element_distribute_name"] == null ? null : json["sub_element_distribute_name"],
    stock: json["stock"] == null ? null : json["stock"],
    costOfCapital: json["cost_of_capital"] == null ? null : json["cost_of_capital"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId == null ? null : productId,
    "distribute_name": distributeName == null ? null : distributeName,
    "element_distribute_name": elementDistributeName == null ? null : elementDistributeName,
    "sub_element_distribute_name": subElementDistributeName == null ? null : subElementDistributeName,
    "stock": stock == null ? null : stock,
    "cost_of_capital": costOfCapital == null ? null : costOfCapital,
  };
}
