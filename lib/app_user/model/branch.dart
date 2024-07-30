import 'package:hive/hive.dart';

part 'branch.g.dart';

@HiveType(typeId: 3)
class Branch {
  Branch({
    this.id,
    this.storeId,
    this.name,
    this.addressDetail,
    this.province,
    this.district,
    this.wards,
    this.provinceName,
    this.districtName,
    this.wardsName,
    this.branchCode,
    this.postcode,
    this.email,
    this.phone,
    this.isDefault,
    this.isDefaultOrderOnline,
    this.createdAt,
    this.updatedAt,
  });
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? storeId;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? addressDetail;
  @HiveField(4)
  int? province;
  @HiveField(5)
  int? district;
  @HiveField(6)
  int? wards;
  @HiveField(7)
  String? provinceName;
  @HiveField(8)
  String? districtName;
  @HiveField(9)
  String? wardsName;
  @HiveField(10)
  String? branchCode;
  @HiveField(11)
  String? postcode;
  @HiveField(12)
  String? email;
  @HiveField(13)
  String? phone;
  @HiveField(14)
  bool? isDefault;
  @HiveField(15)
  DateTime? createdAt;
  @HiveField(16)
  DateTime? updatedAt;
  @HiveField(17)
  bool? isDefaultOrderOnline;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        name: json["name"] == null ? null : json["name"],
        addressDetail:
            json["address_detail"] == null ? null : json["address_detail"],
        province: json["province"] == null ? null : json["province"],
        district: json["district"] == null ? null : json["district"],
        wards: json["wards"] == null ? null : json["wards"],
        provinceName:
            json["province_name"] == null ? null : json["province_name"],
        districtName:
            json["district_name"] == null ? null : json["district_name"],
        wardsName: json["wards_name"] == null ? null : json["wards_name"],
        branchCode: json["branch_code"] == null ? null : json["branch_code"],
        postcode: json["postcode"] == null ? null : json["postcode"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        isDefault: json["is_default"] == null ? null : json["is_default"],
        isDefaultOrderOnline: json["is_default_order_online"] == null
            ? null
            : json["is_default_order_online"],
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
        "branch_code": branchCode == null ? null : branchCode,
        "postcode": postcode == null ? null : postcode,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "is_default": isDefault == null ? null : isDefault,
        "is_default_order_online": isDefaultOrderOnline == null ? null : isDefaultOrderOnline,
      };
}
