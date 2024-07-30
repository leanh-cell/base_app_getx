
class RefundCalculate {
  RefundCalculate({
    this.totalRefundCurrentInTime,
    this.isRefundPart,
    this.voucherDiscountAmount,
    this.discount,
  });

  double? totalRefundCurrentInTime;
  bool? isRefundPart;
  double? voucherDiscountAmount;
  double? discount;

  factory RefundCalculate.fromJson(Map<String, dynamic> json) => RefundCalculate(
    totalRefundCurrentInTime: json["total_refund_current_in_time"] == null ? null : json["total_refund_current_in_time"].toDouble(),
    isRefundPart: json["is_refund_part"] == null ? null : json["is_refund_part"],
    voucherDiscountAmount: json["voucher_discount_amount"] == null ? null : json["voucher_discount_amount"].toDouble(),
    discount: json["discount"] == null ? null : json["discount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "total_refund_current_in_time": totalRefundCurrentInTime == null ? null : totalRefundCurrentInTime,
    "is_refund_part": isRefundPart == null ? null : isRefundPart,
    "voucher_discount_amount": voucherDiscountAmount == null ? null : voucherDiscountAmount,
    "discount": discount == null ? null : discount,
  };
}