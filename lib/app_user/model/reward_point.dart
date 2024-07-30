class RewardPoint {
  RewardPoint({
    this.id,
    this.storeId,
    this.pointReview,
    this.pointIntroduceCustomer,
    this.percentRefund,
    this.moneyAPoint,
    this.orderMaxPoint,
    this.isSetOrderMaxPoint,
    this.allowUsePointOrder,
    this.isPercentUseMaxPoint,
    this.percentUseMaxPoint,
    this.createdAt,
    this.updatedAt,
    this.bonusPointBonusProductToAgency,
    this.bonusPointProductToAgency,
  });

  int? id;
  int? storeId;
  double? pointReview;
  double? pointIntroduceCustomer;
  double? percentRefund;
  double? moneyAPoint;
  double? orderMaxPoint;
  bool? isSetOrderMaxPoint;
  bool? allowUsePointOrder;
  bool? bonusPointBonusProductToAgency;
  bool? bonusPointProductToAgency;
  double? percentUseMaxPoint;
  bool? isPercentUseMaxPoint;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory RewardPoint.fromJson(Map<String, dynamic> json) => RewardPoint(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        pointReview:
            json["point_review"] == null ? 0 : json["point_review"].toDouble(),
        pointIntroduceCustomer: json["point_introduce_customer"] == null
            ? 0
            : json["point_introduce_customer"].toDouble(),
        percentRefund: json["percent_refund"] == null
            ? 0
            : json["percent_refund"].toDouble(),
        moneyAPoint: json["money_a_point"] == null
            ? 0
            : json["money_a_point"].toDouble(),
        orderMaxPoint: json["order_max_point"] == null
            ? 0
            : json["order_max_point"].toDouble(),
        isSetOrderMaxPoint: json["is_set_order_max_point"] == null
            ? false
            : json["is_set_order_max_point"],
        allowUsePointOrder: json["allow_use_point_order"] == null
            ? false
            : json["allow_use_point_order"],
        bonusPointProductToAgency: json["bonus_point_product_to_agency"] == null
            ? false
            : json["bonus_point_product_to_agency"],
        bonusPointBonusProductToAgency:
            json["bonus_point_bonus_product_to_agency"] == null
                ? false
                : json["bonus_point_bonus_product_to_agency"],
        percentUseMaxPoint: json["percent_use_max_point"] == null
            ? null
            : json["percent_use_max_point"].toDouble(),
        isPercentUseMaxPoint: json["is_percent_use_max_point"] == null
            ? false
            : json["is_percent_use_max_point"],
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
        "point_review": pointReview == null ? null : pointReview,
        "point_introduce_customer":
            pointIntroduceCustomer == null ? null : pointIntroduceCustomer,
        "percent_use_max_point":
            percentUseMaxPoint == null ? null : percentUseMaxPoint,
        "percent_refund": percentRefund == null ? null : percentRefund,
        "money_a_point": moneyAPoint == null ? null : moneyAPoint,
        "bonus_point_bonus_product_to_agency": bonusPointBonusProductToAgency == null ? null : bonusPointBonusProductToAgency,
        "bonus_point_product_to_agency": bonusPointProductToAgency == null ? null : bonusPointProductToAgency,
        "is_percent_use_max_point":
            isPercentUseMaxPoint == null ? false : isPercentUseMaxPoint,
        "order_max_point": orderMaxPoint == null ? null : orderMaxPoint,
        "is_set_order_max_point":
            isSetOrderMaxPoint == null ? null : isSetOrderMaxPoint,
        "allow_use_point_order":
            allowUsePointOrder == null ? null : allowUsePointOrder,
      };
}
