class Supplier {
  Supplier({
    this.id,
    this.storeId,
    this.name,
    this.debt,
    this.addressDetail,
    this.province,
    this.district,
    this.wards,
    this.provinceName,
    this.districtName,
    this.wardsName,
    this.email,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  String? name;
  String? addressDetail;
  int? province;
  int? district;
  int? wards;
  double? debt;
  String? provinceName;
  String? districtName;
  String? wardsName;
  String? email;
  String? phone;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        name: json["name"] == null ? null : json["name"],
        addressDetail:
            json["address_detail"] == null ? null : json["address_detail"],
        debt: json["debt"] == null ? null : json["debt"].toDouble(),
        province: json["province"] == null ? null : json["province"],
        district: json["district"] == null ? null : json["district"],
        wards: json["wards"] == null ? null : json["wards"],
        provinceName:
            json["province_name"] == null ? null : json["province_name"],
        districtName:
            json["district_name"] == null ? null : json["district_name"],
        wardsName: json["wards_name"] == null ? null : json["wards_name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "name": name == null ? null : name,
        "address_detail": addressDetail == null ? null : addressDetail,
        "province": province == null ? null : province,
        "district": district == null ? null : district,
        "wards": wards == null ? null : wards,
        "province_name": provinceName == null ? null : provinceName,
        "district_name": districtName == null ? null : districtName,
        "wards_name": wardsName == null ? null : wardsName,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
      };
}
