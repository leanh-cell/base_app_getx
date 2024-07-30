import 'dart:convert';

InfoAddressCustomer infoAddressCustomerFromJson(String str) =>
    InfoAddressCustomer.fromJson(json.decode(str));

String infoAddressCustomerToJson(InfoAddressCustomer data) =>
    json.encode(data.toJson());

class InfoAddressCustomer {
  InfoAddressCustomer({
    this.id,
    this.storeId,
    this.customerId,
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
    this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.provinceName,
    this.districtName,
    this.wardsName,
  });

  int? id;
  int? storeId;
  int? customerId;
  String? name;
  String? addressDetail;
  int? country;
  int? province;
  int? district;
  int? wards;
  dynamic village;
  dynamic postcode;
  String? email;
  String? phone;
  bool? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? provinceName;
  String? districtName;
  String? wardsName;

  factory InfoAddressCustomer.fromJson(Map<String, dynamic> json) =>
      InfoAddressCustomer(
        id: json["id"],
        storeId: json["store_id"],
        customerId: json["customer_id"],
        name: json["name"],
        addressDetail: json["address_detail"],
        country: json["country"],
        province: json["province"],
        district: json["district"],
        wards: json["wards"],
        village: json["village"],
        postcode: json["postcode"],
        email: json["email"],
        phone: json["phone"],
        isDefault: json["is_default"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        provinceName: json["province_name"],
        districtName: json["district_name"],
        wardsName: json["wards_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "customer_id": customerId,
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
        "is_default": isDefault,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "province_name": provinceName,
        "district_name": districtName,
        "wards_name": wardsName,
      };
}
