import 'package:hive/hive.dart';

import 'decentralization.dart';
part 'staff.g.dart';

@HiveType(typeId: 4)
class Staff {
  Staff({
    this.id,
    this.branchId,
    this.username,
    this.areaCode,
    this.phoneNumber,
    this.phoneVerifiedAt,
    this.email,
    this.emailVerifiedAt,
    this.name,
    this.password,
    this.sex = 0,
    this.totalDevice,
    this.online,
    this.address,
    this.isSale,
    this.dateOfBirth,
    this.avatarImage,
    this.salaryOneHour,
    this.idDecentralization,
    this.createdAt,
    this.updatedAt,
    this.decentralization,
    this.totalCustomer,
    this.sumTotalAfterDiscount,
    this.orderCount,
    this.totalCustomerInFiler,
    this.sumTotalAfterDiscountNoUseBonus,
  });
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? branchId;
  @HiveField(2)
  String? username;
  @HiveField(3)
  String? areaCode;
  @HiveField(4)
  String? phoneNumber;
  @HiveField(5)
  String? phoneVerifiedAt;
  @HiveField(6)
  String? email;
  @HiveField(7)
  String? emailVerifiedAt;
  @HiveField(8)
  String? name;
  @HiveField(9)
  String? password;
  @HiveField(10)
  bool? online;
  @HiveField(11)
  bool? isSale;
  @HiveField(12)
  int? sex = 0;
  @HiveField(13)
  int? totalDevice;
  @HiveField(14)
  String? address;
  @HiveField(15)
  DateTime? dateOfBirth;
  @HiveField(16)
  String? avatarImage;
  @HiveField(17)
  double? salaryOneHour;
  @HiveField(18)
  int? idDecentralization;
  @HiveField(19)
  DateTime? createdAt;
  @HiveField(20)
  DateTime? updatedAt;
  @HiveField(21)
  int? totalCustomer;
  Decentralization? decentralization;
  double? sumTotalAfterDiscount;
  double? sumTotalAfterDiscountNoUseBonus;
  int? orderCount;
  int? totalCustomerInFiler;

  factory Staff.fromJson(Map<String, dynamic> json) => Staff(
        id: json["id"] == null ? null : json["id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        orderCount: json["orders_count"] == null ? null : json["orders_count"],
        username: json["username"] == null ? null : json["username"],
        areaCode: json["area_code"] == null ? null : json["area_code"],
    sumTotalAfterDiscountNoUseBonus: json["sum_total_after_discount_no_use_bonus"] == null ? null : json["sum_total_after_discount_no_use_bonus"].toDouble(),
        sumTotalAfterDiscount: json["sum_total_after_discount"] == null
            ? null
            : json["sum_total_after_discount"].toDouble(),
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        totalCustomerInFiler: json["total_customer_in_filer"] == null
            ? null
            : json["total_customer_in_filer"],
        isSale: json["is_sale"] == null ? null : json["is_sale"],
        phoneVerifiedAt: json["phone_verified_at"] == null
            ? null
            : json["phone_verified_at"].toString(),
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        name: json["name"] == null ? null : json["name"],
        online: json['online'] == null ? false : json["online"],
        sex: json["sex"] == null ? null : json["sex"],
        totalDevice: json["total_device"] == null ? null : json["total_device"],
        totalCustomer:
            json["total_customers"] == null ? null : json["total_customers"],
        address: json["address"] == null ? null : json["address"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        avatarImage: json["avatar_image"] == null
            ? null
            : json["avatar_image"].toString(),
        salaryOneHour: json["salary_one_hour"] == null
            ? null
            : json["salary_one_hour"].toDouble(),
        idDecentralization: json["id_decentralization"] == null
            ? null
            : json["id_decentralization"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        decentralization: json["decentralization"] == null
            ? null
            : Decentralization.fromJson(json["decentralization"]),
      );

  Map<String, dynamic> toJson() => {
        "username": username == null ? null : username,
        "branch_id": branchId == null ? null : branchId,
        "sum_total_after_discount_no_use_bonus": sumTotalAfterDiscountNoUseBonus == null ? null : sumTotalAfterDiscountNoUseBonus,
        "area_code": areaCode == null ? null : areaCode,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "is_sale": isSale == null ? null : isSale,
        "email": email == null ? null : email,
        "name": name == null ? null : name,
        "password": password == null ? null : password,
        "sex": sex == null ? null : sex,
        "address": address == null ? null : address,
        "avatar_image": avatarImage,
        "salary_one_hour": salaryOneHour == null ? null : salaryOneHour,
        "id_decentralization":
            idDecentralization == null ? null : idDecentralization,
      };
}
