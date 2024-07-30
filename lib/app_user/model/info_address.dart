// To parse this JSON data, do
//
//     final infoAddress = infoAddressFromJson(jsonString);

import 'dart:convert';

InfoAddress infoAddressFromJson(String str) =>
    InfoAddress.fromJson(json.decode(str));

String infoAddressToJson(InfoAddress data) => json.encode(data.toJson());

class InfoAddress {
  InfoAddress({
    this.id,
    this.storeId,
    this.name,
    this.addressDetail,
    this.country,
    this.province,
    this.district,
    this.wards,
    this.village,
    this.postcode,
    this.email,
    this.phone,
    this.isDefaultPickup,
    this.isDefaultReturn,
    this.createdAt,
    this.updatedAt,
    this.provinceName,
    this.districtName,
    this.wardsName,
  });

  int? id;
  int? storeId;
  String? name;
  String? addressDetail;
  int? country;
  int? province;
  int? district;
  int? wards;
  int? village;
  int? postcode;
  String? email;
  String? phone;
  bool? isDefaultPickup;
  bool? isDefaultReturn;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? provinceName;
  String? districtName;
  String? wardsName;

  factory InfoAddress.fromJson(Map<String, dynamic> json) => InfoAddress(
        id: json["id"],
        storeId: json["store_id"],
        name: json["name"],
        addressDetail: json["address_detail"],
        country: json["country"] ?? 0,
        province: json["province"] ?? 0,
        district: json["district"] ?? 0,
        wards: json["wards"] ?? 0,
        village: json["village"] == null ? 1 : int.parse(json["village"]),
        postcode: json["postcode"] == null ? 1 : int.parse(json["postcode"]),
        email: json["email"],
        phone: json["phone"],
        isDefaultPickup: json["is_default_pickup"],
        isDefaultReturn: json["is_default_return"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        provinceName: json["province_name"],
        districtName: json["district_name"],
        wardsName: json["wards_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "name": name,
        "address_detail": addressDetail,
        "country": country,
        "province": province,
        "district": district,
        "wards": wards,
        "village": village,
        "postcode": postcode,
        "email": email,
        "phone": phone,
        "is_default_pickup": isDefaultPickup,
        "is_default_return": isDefaultReturn,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "province_name": provinceName,
        "district_name": districtName,
        "wards_name": wardsName,
      };
}
