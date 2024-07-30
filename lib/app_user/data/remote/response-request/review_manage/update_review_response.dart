import 'dart:convert';
import 'package:com.ikitech.store/app_user/model/review.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';


UpdateReviewResponse updateReviewResponseFromJson(String str) =>
    UpdateReviewResponse.fromJson(json.decode(str));

String updateReviewResponseToJson(UpdateReviewResponse data) =>
    json.encode(data.toJson());

class UpdateReviewResponse {
  UpdateReviewResponse({
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

  factory UpdateReviewResponse.fromJson(Map<String, dynamic> json) =>
      UpdateReviewResponse(
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
    this.id,
    this.stars,
    this.content,
    this.images,
    this.status,
    this.createdAt,
    this.customer,
    this.product,
  });

  int? id;
  int? stars;
  String? content;
  String? images;
  int? status;
  DateTime? createdAt;
  Customer? customer;
  Product? product;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        stars: json["stars"] == null ? null : json["stars"],
        content: json["content"] == null ? null : json["content"],
        images: json["images"] == null ? null : json["images"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "stars": stars == null ? null : stars,
        "content": content == null ? null : content,
        "images": images == null ? null : images,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "customer": customer == null ? null : customer!.toJson(),
        "product": product == null ? null : product!.toJson(),
      };
}
