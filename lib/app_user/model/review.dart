
import 'package:sahashop_customer/app_customer/model/product.dart';

class Review {
  Review({
    this.stars,
    this.content,
    this.images,
    this.status,
    this.createdAt,
    this.id,
    this.customer,
    this.product,
  });

  int? stars;
  String? content;
  String? images;
  int? status;
  DateTime? createdAt;
  int? id;
  Customer? customer;
  Product? product;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        stars: json["stars"] == null ? null : json["stars"],
        content: json["content"] == null ? null : json["content"],
        images: json["images"] == null ? null : json["images"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "stars": stars == null ? null : stars,
        "content": content == null ? null : content,
        "images": images == null ? null : images,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "id": id == null ? null : id,
        "customer": customer == null ? null : customer!.toJson(),
      };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.phoneNumber,
    this.avatarImage,
  });

  int? id;
  String? name;
  String? phoneNumber;
  String? avatarImage;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        avatarImage: json["avatar_image"] == null ? null : json["avatar_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "avatar_image": avatarImage == null ? null : avatarImage,
      };
}
