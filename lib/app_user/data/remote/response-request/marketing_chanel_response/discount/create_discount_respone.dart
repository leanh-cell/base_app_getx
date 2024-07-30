import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/product.dart';

CreateDiscountResponse createDiscountResponseFromJson(String str) =>
    CreateDiscountResponse.fromJson(json.decode(str));

String createDiscountResponseToJson(CreateDiscountResponse data) =>
    json.encode(data.toJson());

class CreateDiscountResponse {
  CreateDiscountResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  Data? data;

  factory CreateDiscountResponse.fromJson(Map<String, dynamic> json) =>
      CreateDiscountResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.storeId,
    this.isEnd,
    this.name,
    this.description,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.value,
    this.setLimitAmount,
    this.amount,
    this.used,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  int? id;
  int? storeId;
  bool? isEnd;
  String? name;
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        storeId: json["store_id"],
        isEnd: json["is_end"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        value: json["value"].toDouble(),
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
