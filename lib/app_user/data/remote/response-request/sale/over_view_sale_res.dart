import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/step_bonus.dart';

OverViewSaleRes overViewSaleResFromJson(String str) =>
    OverViewSaleRes.fromJson(json.decode(str));

String overViewSaleResToJson(OverViewSaleRes data) =>
    json.encode(data.toJson());

class OverViewSaleRes {
  OverViewSaleRes({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  OverViewSale? data;
  String? msgCode;
  String? msg;

  factory OverViewSaleRes.fromJson(Map<String, dynamic> json) =>
      OverViewSaleRes(
        code: json["code"],
        success: json["success"],
        data: json["data"] == null ? null : OverViewSale.fromJson(json["data"]),
        msgCode: json["msg_code"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "data": data?.toJson(),
        "msg_code": msgCode,
        "msg": msg,
      };
}

class OverViewSale {
  OverViewSale({
    this.totalOrder,
    this.totalFinal,
    this.countInDay,
    this.totalFinalInDay,
    this.countInMonth,
    this.totalFinalInMonth,
    this.countInYear,
    this.totalFinalInYear,
    this.countInQuarter,
    this.totalFinalInQuarter,
    this.stepsBonus,
    this.saleConfig,
    this.totalFinalInWeek,
    this.countInWeek,
  });

  int? totalOrder;
  double? totalFinal;
  int? countInDay;
  double? totalFinalInDay;
  int? countInMonth;
  double? totalFinalInMonth;
  int? countInYear;
  double? totalFinalInWeek;
  int? countInWeek;
  double? totalFinalInYear;
  int? countInQuarter;
  double? totalFinalInQuarter;
  List<StepsBonus>? stepsBonus;
  SaleConfig? saleConfig;

  factory OverViewSale.fromJson(Map<String, dynamic> json) => OverViewSale(
        totalOrder: json["total_order"],
        totalFinal:
            json["total_final"] == null ? null : json["total_final"].toDouble(),
        countInDay: json["count_in_day"],
        totalFinalInDay: json["total_final_in_day"] == null
            ? null
            : json["total_final_in_day"].toDouble(),
        countInWeek: json["count_in_week"],
        totalFinalInWeek: json["total_final_in_week"] == null
            ? null
            : json["total_final_in_week"].toDouble(),
        countInMonth: json["count_in_month"],
        totalFinalInMonth: json["total_final_in_month"] == null
            ? null
            : json["total_final_in_month"].toDouble(),
        countInYear: json["count_in_year"],
        totalFinalInYear: json["total_final_in_year"] == null
            ? null
            : json["total_final_in_year"].toDouble(),
        countInQuarter: json["count_in_quarter"],
        totalFinalInQuarter: json["total_final_in_quarter"] == null
            ? null
            : json["total_final_in_quarter"].toDouble(),
        stepsBonus: json["steps_bonus"] == null
            ? []
            : List<StepsBonus>.from(
                json["steps_bonus"]!.map((x) => StepsBonus.fromJson(x))),
        saleConfig: json["sale_config"] == null
            ? null
            : SaleConfig.fromJson(json["sale_config"]),
      );

  Map<String, dynamic> toJson() => {
        "total_order": totalOrder,
        "total_final": totalFinal,
        "count_in_day": countInDay,
        "total_final_in_day": totalFinalInDay,
        "count_in_month": countInMonth,
        "total_final_in_month": totalFinalInMonth,
        "count_in_year": countInYear,
        "total_final_in_year": totalFinalInYear,
        "count_in_quarter": countInQuarter,
        "total_final_in_quarter": totalFinalInQuarter,
        "sale_config": saleConfig?.toJson(),
      };
}

class SaleConfig {
  SaleConfig({
    this.id,
    this.storeId,
    this.allowSale,
    this.typeBonusPeriod,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  bool? allowSale;
  int? typeBonusPeriod;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SaleConfig.fromJson(Map<String, dynamic> json) => SaleConfig(
        id: json["id"],
        storeId: json["store_id"],
        allowSale: json["allow_sale"],
        typeBonusPeriod: json["type_bonus_period"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "allow_sale": allowSale,
        "type_bonus_period": typeBonusPeriod,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
