class GeneralSetting {
  GeneralSetting({
    this.storeId,
    this.notiNearOutStock,
    this.notiStockCountNear,
    this.allowSemiNegative,this.enableVat,this.percentVat,this.allowBranchPaymentOrder,this.autoChooseDefaultBranchPaymentOrder
  });

  int? storeId;
  bool? notiNearOutStock;
  int? notiStockCountNear;
  bool? allowSemiNegative;
  bool? enableVat;
  double? percentVat;
  bool? allowBranchPaymentOrder;
  bool? autoChooseDefaultBranchPaymentOrder;

  factory GeneralSetting.fromJson(Map<String, dynamic> json) => GeneralSetting(
        storeId: json["store_id"] == null ? null : json["store_id"],
        notiNearOutStock: json["noti_near_out_stock"] == null
            ? null
            : json["noti_near_out_stock"],
        allowSemiNegative: json["allow_semi_negative"] == null
            ? null
            : json["allow_semi_negative"],
        notiStockCountNear: json["noti_stock_count_near"] == null
            ? null
            : json["noti_stock_count_near"],
        enableVat : json["enable_vat"],
        percentVat: json["percent_vat"] == null ? null : json["percent_vat"].toDouble(),
        allowBranchPaymentOrder: json["allow_branch_payment_order"],
        autoChooseDefaultBranchPaymentOrder: json["auto_choose_default_branch_payment_order"]
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId == null ? null : storeId,
        "noti_near_out_stock":
            notiNearOutStock == null ? null : notiNearOutStock,
        "allow_semi_negative":
            allowSemiNegative == null ? null : allowSemiNegative,
        "noti_stock_count_near":
            notiStockCountNear == null ? null : notiStockCountNear,
        "enable_vat": enableVat,
        "percent_vat":percentVat,
        "auto_choose_default_branch_payment_order": autoChooseDefaultBranchPaymentOrder,
        "allow_branch_payment_order" : allowBranchPaymentOrder
      };
}
