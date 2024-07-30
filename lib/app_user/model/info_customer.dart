import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/agency_type.dart';

import 'info_address_customer.dart';


class InfoCustomer {
  InfoCustomer(
      {this.id,
      this.storeId,
      this.username,
      this.phoneNumber,
      this.phoneVerifiedAt,
      this.email,
      this.emailVerifiedAt,
      this.name,
      this.dateOfBirth,
      this.avatarImage,
      this.point,
      this.debt,
      this.sex,
      this.createdAt,
      this.updatedAt,
      this.isCollaborator = false,
      this.isAgency = false,
      this.addressDefault,
      this.addressDetail,
      this.country,
      this.province,
      this.referralPhoneNumber,
      this.district,
      this.wards,
      this.provinceName,
      this.totalShareAgency,
      this.districtName,
      this.saleStaff,
      this.wardsName,
      this.totalFinal,
      this.pass,
      this.agencyType,
      this.passwordShow,
      this.countOrders,
      this.status,
      this.totalShareAgencyReferen,
      this.diemSp,
      this.level,
      this.referralCodeShare,this.totalAfterDiscountNoBonus});

  int? id;
  int? storeId;
  dynamic username;
  String? phoneNumber;
  String? pass;
  dynamic phoneVerifiedAt;
  dynamic email;
  dynamic emailVerifiedAt;
  String? name;
  DateTime? dateOfBirth;
  dynamic avatarImage;
  bool? isCollaborator;
  bool? isAgency;
  double? point;
  double? debt;
  double? totalFinal;
  double? totalShareAgency;
  double? totalShareAgencyReferen;
  dynamic sex;
  String? addressDetail;
  int? country;
  int? province;
  int? district;
  int? wards;
  int? countOrders;
  String? provinceName;
  String? districtName;
  String? wardsName;
  InfoAddressCustomer? addressDefault;
  String? referralPhoneNumber;
  StaffCus? saleStaff;
  DateTime? createdAt;
  DateTime? updatedAt;
  AgencyType? agencyType;
  String? passwordShow;
  int? status;
  int? diemSp;
  int? level;
  String? referralCodeShare;
  double? totalAfterDiscountNoBonus;

  factory InfoCustomer.fromJson(Map<String, dynamic> json) => InfoCustomer(
      id: json["id"] == null ? null : json["id"],
      storeId: json["store_id"] == null ? null : json["store_id"],
      username: json["username"] == null ? null : json["username"],
      totalShareAgencyReferen: json["total_share_agency_referen"]?.toDouble(),
      totalFinal: json["total_final"]?.toDouble(),
      totalShareAgency: json["total_share_agency"]?.toDouble(),
      phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
      pass: json["pass_word"] == null ? null : json["pass_word"],
      phoneVerifiedAt:
          json["phone_verified_at"] == null ? null : json["phone_verified_at"],
      email: json["email"] == null ? null : json["email"],
      emailVerifiedAt:
          json["email_verified_at"] == null ? null : json["email_verified_at"],
      name: json["name"] == null ? null : json["name"],
      dateOfBirth: json["date_of_birth"] == null
          ? null
          : DateTime.parse(json["date_of_birth"]),
      avatarImage: json["avatar_image"] == null ? null : json["avatar_image"],
      countOrders: json["count_orders"] == null ? null : json["count_orders"],
      point: json["points"] == null ? null : json["points"].toDouble(),
      debt: json["debt"] == null ? null : json["debt"].toDouble(),
      sex: json["sex"] == null ? null : json["sex"],
      isCollaborator:
          json["is_collaborator"] == null ? false : json["is_collaborator"],
      isAgency: json["is_agency"] == null ? false : json["is_agency"],
      agencyType: json["agency_type"] == null
          ? null
          : AgencyType.fromJson(json["agency_type"]),
      addressDefault: json["default_address"] == null
          ? null
          : InfoAddressCustomer.fromJson(json["default_address"]),
      saleStaff: json["sale_staff"] == null
          ? null
          : StaffCus.fromJson(json["sale_staff"]),
      addressDetail:
          json["address_detail"] == null ? null : json["address_detail"],
      country: json["country"] == null ? null : json["country"],
      province: json["province"] == null ? null : json["province"],
      district: json["district"] == null ? null : json["district"],
      wards: json["wards"] == null ? null : json["wards"],
      provinceName:
          json["province_name"] == null ? null : json["province_name"],
      districtName:
          json["district_name"] == null ? null : json["district_name"],
      wardsName: json["wards_name"] == null ? null : json["wards_name"],
      referralPhoneNumber: json["referral_phone_number"] == null
          ? null
          : json["referral_phone_number"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      passwordShow: json['password_show'],
      status: json["status"],
      diemSp: json['diem_sp'],
      level: json['level'],
      referralCodeShare: json['referral_code_share'],
      totalAfterDiscountNoBonus: json['total_after_discount_no_bonus'] == null ? null : json['total_after_discount_no_bonus'].toDouble());

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "email": email == null ? null : email,
        "name": name == null ? null : name,
        "avatar_image": avatarImage == null ? null : avatarImage,
        "date_of_birth":
            dateOfBirth == null ? null : dateOfBirth!.toIso8601String(),
        "sex": sex == null ? null : sex,
        "province": province == null ? null : province,
        "district": district == null ? null : district,
        "wards": wards == null ? null : wards,
        "address_detail": addressDetail == null ? null : addressDetail,
        "password_show": passwordShow,
        "status": status
      };
}

class StaffCus {
  StaffCus({
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
    this.dateOfBirth,
    this.avatarImage,
    this.salaryOneHour,
    this.idDecentralization,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? branchId;
  String? username;
  String? areaCode;
  String? phoneNumber;
  String? phoneVerifiedAt;
  String? email;
  String? emailVerifiedAt;
  String? name;
  String? password;
  bool? online;
  int? sex = 0;
  int? totalDevice;
  String? address;
  DateTime? dateOfBirth;
  String? avatarImage;
  double? salaryOneHour;
  int? idDecentralization;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory StaffCus.fromJson(Map<String, dynamic> json) => StaffCus(
        id: json["id"] == null ? null : json["id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        username: json["username"] == null ? null : json["username"],
        areaCode: json["area_code"] == null ? null : json["area_code"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        phoneVerifiedAt: json["phone_verified_at"] == null
            ? null
            : json["phone_verified_at"].toString(),
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        name: json["name"] == null ? null : json["name"],
        online: json['online'] == null ? false : json["online"],
        sex: json["sex"] == null ? null : json["sex"],
        totalDevice: json["total_device"] == null ? null : json["total_device"],
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
      );

  Map<String, dynamic> toJson() => {
        "username": username == null ? null : username,
        "branch_id": branchId == null ? null : branchId,
        "area_code": areaCode == null ? null : areaCode,
        "phone_number": phoneNumber == null ? null : phoneNumber,
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
