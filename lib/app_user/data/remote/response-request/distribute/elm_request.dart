// To parse this JSON data, do
//
//     final elmRequest = elmRequestFromJson(jsonString);

import 'dart:convert';

ElmRequest elmRequestFromJson(String str) => ElmRequest.fromJson(json.decode(str));

String elmRequestToJson(ElmRequest data) => json.encode(data.toJson());

class ElmRequest {
  ElmRequest({
    this.distributeName,
    this.elementDistributeId,
    this.imageUrl,
    this.price,
    this.importPrice,
    this.defaultPrice,
    this.barcode,
    this.quantityInStock,
  });

  String? distributeName;
  int? elementDistributeId;
  String? imageUrl;
  double? price;
  double? importPrice;
  double? defaultPrice;
  String? barcode;
  int? quantityInStock;

  factory ElmRequest.fromJson(Map<String, dynamic> json) => ElmRequest(
    distributeName: json["distribute_name"] == null ? null : json["distribute_name"],
    elementDistributeId: json["element_distribute_id"] == null ? null : json["element_distribute_id"],
    imageUrl: json["image_url"] == null ? null : json["image_url"],
    price: json["price"] == null ? null : json["price"].toDouble(),
    importPrice: json["import_price"] == null ? null : json["import_price"].toDouble(),
    defaultPrice: json["default_price"] == null ? null : json["default_price"].toDouble(),
    barcode: json["barcode"] == null ? null : json["barcode"],
    quantityInStock: json["quantity_in_stock"] == null ? null : json["quantity_in_stock"],
  );

  Map<String, dynamic> toJson() => {
    "distribute_name": distributeName == null ? null : distributeName,
    "element_distribute_id": elementDistributeId == null ? null : elementDistributeId,
    "image_url": imageUrl == null ? null : imageUrl,
    "price": price == null ? null : price,
    "import_price": importPrice == null ? null : importPrice,
    "default_price": defaultPrice == null ? null : defaultPrice,
    "barcode": barcode == null ? null : barcode,
    "quantity_in_stock": quantityInStock == null ? null : quantityInStock,
  };
}
