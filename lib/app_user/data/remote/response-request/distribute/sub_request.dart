// To parse this JSON data, do
//
//     final subRequest = subRequestFromJson(jsonString);

import 'dart:convert';

SubRequest subRequestFromJson(String str) =>
    SubRequest.fromJson(json.decode(str));

String subRequestToJson(SubRequest data) => json.encode(data.toJson());

class SubRequest {
  SubRequest({
    this.subElementDistributeId,
    this.subElementDistributeName,
    this.name,
    this.imageUrl,
    this.price,
    this.importPrice,
    this.defaultPrice,
    this.barcode,
    this.quantityInStock,
  });

  int? subElementDistributeId;
  String? subElementDistributeName;
  String? name;
  String? imageUrl;
  double? price;
  double? importPrice;
  double? defaultPrice;
  String? barcode;
  int? quantityInStock;

  factory SubRequest.fromJson(Map<String, dynamic> json) => SubRequest(
        subElementDistributeId: json["sub_element_distribute_id"] == null
            ? null
            : json["sub_element_distribute_id"],
        name: json["name"] == null ? null : json["name"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        importPrice: json["import_price"] == null
            ? null
            : json["import_price"].toDouble(),
        defaultPrice: json["default_price"] == null
            ? null
            : json["default_price"].toDouble(),
        barcode: json["barcode"] == null ? null : json["barcode"],
        quantityInStock: json["quantity_in_stock"] == null
            ? null
            : json["quantity_in_stock"],
      );

  Map<String, dynamic> toJson() => {
        "sub_element_distribute_id":
            subElementDistributeId == null ? null : subElementDistributeId,
        "sub_element_distribute_name":
            subElementDistributeName == null ? null : subElementDistributeName,
        "name": name == null ? null : name,
        "image_url": imageUrl == null ? null : imageUrl,
        "price": price == null ? null : price,
        "import_price": importPrice == null ? null : importPrice,
        "default_price": defaultPrice == null ? null : defaultPrice,
        "barcode": barcode == null ? null : barcode,
        "quantity_in_stock": quantityInStock == null ? null : quantityInStock,
      };
}
