import 'package:com.ikitech.store/app_user/model/gift.dart';

class MiniGame {
  MiniGame(
      {this.id,
      this.storeId,
      this.userId,
      this.name,
      this.images,
      this.turnInDay,
      this.timeStart,
      this.timeEnd,
      this.status,
      this.groupCustomerId,
      this.applyFor,
      this.note,
      this.createdAt,
      this.updatedAt,
      this.listGift,
      this.description,
      this.isShake,
      this.agencyId,
      this.backgroundImageUrl,
      this.typeBackgroundImage});

  int? id;
  int? storeId;
  int? userId;
  String? name;
  List<String>? images;
  int? turnInDay;
  DateTime? timeStart;
  DateTime? timeEnd;
  String? description;
  int? status;
  int? groupCustomerId;
  int? applyFor;
  dynamic note;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Gift>? listGift;
  bool? isShake;
  int? agencyId;
  int? typeBackgroundImage;
  String? backgroundImageUrl;

  factory MiniGame.fromJson(Map<String, dynamic> json) => MiniGame(
      id: json["id"],
      storeId: json["store_id"],
      userId: json["user_id"],
      name: json["name"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      turnInDay: json["turn_in_day"],
      timeStart: json["time_start"] == null
          ? null
          : DateTime.parse(json["time_start"]),
      timeEnd:
          json["time_end"] == null ? null : DateTime.parse(json["time_end"]),
      status: json["status"],
      groupCustomerId: json["group_customer_id"],
      applyFor: json["apply_for"],
      note: json["note"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      listGift: json['list_gift'] == null
          ? []
          : List<Gift>.from(json["list_gift"]!.map((x) => Gift.fromJson(x))),
      description: json['description'],
      isShake: json['is_shake'],
      agencyId: json["agency_type_id"],
      backgroundImageUrl: json['background_image_url'],
      typeBackgroundImage: json['type_background_image']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "user_id": userId,
        "name": name,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "turn_in_day": turnInDay,
        "time_start": timeStart?.toIso8601String(),
        "time_end": timeEnd?.toIso8601String(),
        "status": status,
        "group_customer_id": groupCustomerId,
        "apply_for": applyFor,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "description": description,
        "is_shake": isShake,
        "agency_type_id": agencyId,
        "type_background_image": typeBackgroundImage,
        "background_image_url": backgroundImageUrl
      };
}
