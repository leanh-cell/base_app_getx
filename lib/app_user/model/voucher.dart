import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/product.dart';

import '../data/remote/response-request/customer/all_group_customer_res.dart';
import 'agency_type.dart';

Voucher voucherFromJson(String str) => Voucher.fromJson(json.decode(str));

String voucherToJson(Voucher data) => json.encode(data.toJson());

class Voucher {
  Voucher({
    this.id,
    this.storeId,
    this.isEnd,
    this.voucherType,
    this.name,
    this.code,
    this.description,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.discountType,
    this.isFreeShip,
    this.discountFor,
    this.shipDiscountValue,
    this.valueDiscount,
    this.setLimitValueDiscount,
    this.maxValueDiscount,
    this.setLimitTotal,
    this.valueLimitTotal,
    this.isShowVoucher,
    this.setLimitAmount,
    this.amount,
    this.used,
    this.createdAt,
    this.updatedAt,
    this.products,
    this.group,
    this.agencyTypes,
    this.groupTypes,
    this.isUseOnce,
    this.amountUseOnce,
    this.isUseOnceCodeMultipleTime,
    this.startingCharacter,
    this.voucherLength,this.isPublic
  });

  int? id;
  int? storeId;
  bool? isEnd;
  int? voucherType;
  String? name;
  String? code;
  String? description;
  String? imageUrl;
  DateTime? startTime;
  DateTime? endTime;
  int? discountType;
  int? discountFor;
  bool? isFreeShip;
  double? shipDiscountValue;
  double? valueDiscount;
  bool? setLimitValueDiscount;
  int? maxValueDiscount;
  bool? setLimitTotal;
  int? valueLimitTotal;
  bool? isShowVoucher;
  bool? setLimitAmount;
  dynamic amount;
  int? used;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Product>? products;
  List<int>? group;
  List<AgencyType>? agencyTypes;
  List<GroupCustomer>? groupTypes;
  bool? isUseOnce;
  bool? isUseOnceCodeMultipleTime;
  String? startingCharacter;
  int? voucherLength;
  int? amountUseOnce;
  bool? isPublic;

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        isEnd: json["is_end"] == null ? null : json["is_end"],
        voucherType: json["voucher_type"] == null ? null : json["voucher_type"],
        name: json["name"] == null ? null : json["name"],
        code: json["code"] == null ? null : json["code"],
        description: json["description"] == null ? null : json["description"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        discountType:
            json["discount_type"] == null ? null : json["discount_type"],
        isFreeShip: json["is_free_ship"] == null ? null : json["is_free_ship"],
        discountFor: json["discount_for"] == null ? null : json["discount_for"],
        valueDiscount: json["value_discount"] == null
            ? null
            : json["value_discount"].toDouble(),
        shipDiscountValue: json["ship_discount_value"] == null
            ? null
            : json["ship_discount_value"].toDouble(),
        setLimitValueDiscount: json["set_limit_value_discount"] == null
            ? null
            : json["set_limit_value_discount"],
        maxValueDiscount: json["max_value_discount"] == null
            ? null
            : json["max_value_discount"],
        setLimitTotal:
            json["set_limit_total"] == null ? null : json["set_limit_total"],
        valueLimitTotal: json["value_limit_total"] == null
            ? null
            : json["value_limit_total"],
        isShowVoucher:
            json["is_show_voucher"] == null ? null : json["is_show_voucher"],
        setLimitAmount:
            json["set_limit_amount"] == null ? null : json["set_limit_amount"],
        amount: json["amount"] == null ? null : json["amount"],
        used: json["used"] == null ? null : json["used"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
        group: json["group_customers"] == null
            ? []
            : List<int>.from(json["group_customers"].map((x) => x)),
        agencyTypes: json["agency_types"] == null
            ? []
            : List<AgencyType>.from(
                json["agency_types"]!.map((x) => AgencyType.fromJson(x))),
        groupTypes: json["group_types"] == null
            ? []
            : List<GroupCustomer>.from(
                json["group_types"]!.map((x) => GroupCustomer.fromJson(x))),
        isUseOnce: json["is_use_once"],
        isUseOnceCodeMultipleTime: json["is_use_once_code_multiple_time"],
        voucherLength: json["voucher_length"],
        amountUseOnce: json["amount_use_once"],
        startingCharacter : json["starting_character"],
        isPublic: json["is_public"]


      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "is_end": isEnd,
        "voucher_type": voucherType,
        "name": name,
        "code": code,
        "description": description,
        "image_url": imageUrl,
        "start_time": startTime!.toIso8601String(),
        "end_time": endTime!.toIso8601String(),
        "discount_type": discountType,
        "value_discount": valueDiscount,
        "set_limit_value_discount": setLimitValueDiscount,
        "is_free_ship": isFreeShip,
        "discount_for": discountFor,
        "ship_discount_value": shipDiscountValue,
        "max_value_discount": maxValueDiscount,
        "set_limit_total": setLimitTotal,
        "value_limit_total": valueLimitTotal,
        "is_show_voucher": isShowVoucher,
        "set_limit_amount": setLimitAmount,
        "amount": amount,
        "used": used,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
        "agency_types": agencyTypes == null
            ? []
            : List<dynamic>.from(agencyTypes!.map((x) => x.toJson())),
        "group_types": groupTypes == null
            ? []
            : List<dynamic>.from(groupTypes!.map((x) => x.toJson())),
        "group_customers": group,
        "is_use_once": isUseOnce,
        "is_use_once_code_multiple_time":isUseOnceCodeMultipleTime,
        "voucher_length":voucherLength,
        "amount_use_once":amountUseOnce,
        "starting_character":startingCharacter
      };
}
