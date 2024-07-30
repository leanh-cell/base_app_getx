import 'package:com.ikitech.store/app_user/model/profile_user.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';

import 'staff.dart';

class Comment {
  Comment({
    this.id,
    this.storeId,
    this.communityPostId,
    this.userId,
    this.staffId,
    this.customerId,
    this.imagesJson,
    this.status,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.staff,
    this.user,
    this.customer,
    this.images,
  });

  int? id;
  int? storeId;
  int? communityPostId;
  int? userId;
  int? staffId;
  int? customerId;
  String? imagesJson;
  int? status;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  Staff? staff;
  ProfileUser? user;
  InfoCustomer? customer;
  List<String>? images;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"] == null ? null : json["id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    communityPostId: json["community_post_id"] == null
        ? null
        : json["community_post_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    staffId: json["staff_id"],
    customerId: json["customer_id"],
    imagesJson: json["images_json"] == null ? null : json["images_json"],
    status: json["status"] == null ? null : json["status"],
    content: json["content"] == null ? null : json["content"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    staff:json["staff"] == null ? null : Staff.fromJson(json["staff"]),
    user: json["user"] == null ? null : ProfileUser.fromJson(json["user"]),
    customer:json["customer"] == null ? null : InfoCustomer.fromJson(json["customer"]),
    images: json["images"] == null
        ? null
        : List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "community_post_id": communityPostId == null ? null : communityPostId,
    "images_json": imagesJson == null ? null : imagesJson,

    "content": content == null ? null : content,
    "images":
    images == null ? null : List<dynamic>.from(images!.map((x) => x)),
  };
}
