// To parse this JSON data, do
//
//     final allWarehousesRes = allWarehousesResFromJson(jsonString);

import 'dart:convert';

AllWarehousesRes allWarehousesResFromJson(String str) => AllWarehousesRes.fromJson(json.decode(str));

String allWarehousesResToJson(AllWarehousesRes data) => json.encode(data.toJson());

class AllWarehousesRes {
  AllWarehousesRes({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  List<Warehouses>? data;

  factory AllWarehousesRes.fromJson(Map<String, dynamic> json) => AllWarehousesRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
    data: json["data"] == null ? [] : List<Warehouses>.from(json["data"]!.map((x) => Warehouses.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "msg_code": msgCode,
    "msg": msg,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Warehouses {
  Warehouses({
    this.id,
    this.storeId,
    this.shopId,
    this.name,
    this.code,
    this.address,
    this.allowSync,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  String? shopId;
  String? name;
  String? code;
  String? address;
  bool? allowSync;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Warehouses.fromJson(Map<String, dynamic> json) => Warehouses(
    id: json["id"],
    storeId: json["store_id"],
    shopId: json["shop_id"],
    name: json["name"],
    code: json["code"],
    address: json["address"],
    allowSync: json["allow_sync"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "shop_id": shopId,
    "name": name,
    "code": code,
    "address": address,
    "allow_sync": allowSync,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
