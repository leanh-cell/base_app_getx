import 'package:sahashop_customer/app_customer/model/order.dart';

import 'cart.dart';
import 'step_bonus_agency.dart';

class CartModel {
  CartModel({
    this.totalBeforeDiscount = 0,
    this.totalFinal = 0,
    this.discount = 0,
    this.balanceCollaboratorCanUse = 0,
    this.balanceCollaboratorUsed = 0,
    this.bonusPointsAmountCanUse = 0,
    this.bonusPointsAmountUsed = 0,
    this.totalPointsCanUse = 0,
    this.shipDiscountAmount = 0,
    this.isUsePoints = false,
    this.productDiscountAmount = 0,
    this.usedDiscount,
    this.comboDiscountAmount = 0,
    this.usedCombos,
    this.voucherDiscountAmount = 0,
    this.usedVoucher,
    this.totalAfterDiscount = 0,
    this.lineItems,
    this.stepBonusAgency,
    this.vat
  });

  double? totalBeforeDiscount;
  double? totalFinal;
  double? discount;
  double? balanceCollaboratorCanUse;
  double? balanceCollaboratorUsed;
  double? bonusPointsAmountCanUse;
  double? totalPointsCanUse;
  double? bonusPointsAmountUsed;
  double? shipDiscountAmount;
  bool? isUsePoints;
  double? productDiscountAmount;
  List<UsedDiscount>? usedDiscount;
  double? comboDiscountAmount;
  List<UsedCombo>? usedCombos;
  double? voucherDiscountAmount;
  UsedVoucher? usedVoucher;
  double? totalAfterDiscount;
  List<LineItem>? lineItems;
  DataConfigBonus? stepBonusAgency;
  double? vat;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        totalBeforeDiscount: json["total_before_discount"].toDouble(),
        totalFinal: json["total_final"].toDouble(),
        discount: json["discount"].toDouble(),
        balanceCollaboratorCanUse: json["balance_collaborator_can_use"] == null
            ? null
            : json["balance_collaborator_can_use"].toDouble(),
        balanceCollaboratorUsed: json["balance_collaborator_used"] == null
            ? null
            : json["balance_collaborator_used"].toDouble(),
        bonusPointsAmountCanUse: json["bonus_points_amount_can_use"] == null
            ? null
            : json["bonus_points_amount_can_use"].toDouble(),
        shipDiscountAmount: json["ship_discount_amount"] == null
            ? null
            : json["ship_discount_amount"].toDouble(),
        totalPointsCanUse: json["total_points_can_use"] == null
            ? null
            : json["total_points_can_use"].toDouble(),
        bonusPointsAmountUsed: json["bonus_points_amount_used"] == null
            ? null
            : json["bonus_points_amount_used"].toDouble(),
        productDiscountAmount: json["product_discount_amount"].toDouble(),
        usedDiscount: List<UsedDiscount>.from(
            json["used_discount"].map((x) => UsedDiscount.fromJson(x))),
        comboDiscountAmount: json["combo_discount_amount"].toDouble(),
        usedCombos: List<UsedCombo>.from(
            json["used_combos"].map((x) => UsedCombo.fromJson(x))),
        voucherDiscountAmount: json["voucher_discount_amount"] == null
            ? 0
            : json["voucher_discount_amount"].toDouble(),
        usedVoucher: json["used_voucher"] == null
            ? null
            : UsedVoucher.fromJson(json["used_voucher"]),
        totalAfterDiscount: json["total_after_discount"].toDouble(),
        isUsePoints: json["is_use_points"],
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
        stepBonusAgency: json["bonus_agency"] == null
            ? null
            : DataConfigBonus.fromJson(json["bonus_agency"]),
        vat : json["vat"] == null ? null : json["vat"].toDouble()
      );
}

class DataConfigBonus {
  DataConfigBonus({
    this.config,
    this.stepBonus,
  });

  Config? config;
  List<StepBonusAgency>? stepBonus = [];

  factory DataConfigBonus.fromJson(Map<String, dynamic> json) =>
      DataConfigBonus(
        config: json["config"] == null ? null : Config.fromJson(json["config"]),
        stepBonus: json["step_bonus"] == null
            ? []
            : List<StepBonusAgency>.from(
                json["step_bonus"].map((x) => StepBonusAgency.fromJson(x))),
      );
}

class Config {
  Config({
    this.isEnd,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });

  bool? isEnd;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        isEnd: json["is_end"] == null ? null : json["is_end"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "is_end": isEnd == null ? null : isEnd,
        "start_time": startTime == null ? null : startTime!.toIso8601String(),
        "end_time": endTime == null ? null : endTime!.toIso8601String(),
      };
}
