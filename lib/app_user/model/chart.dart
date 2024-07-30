class Chart {
  Chart({
    this.time,
    this.totalOrderCount,
    this.totalShippingFee,
    this.totalBeforeDiscount,
    this.comboDiscountAmount,
    this.voucherDiscountAmount,
    this.totalAfterDiscount,
    this.totalFinal,
    this.totalCollaboratorRegCount,
    this.totalReferralOfCustomerCount,
    this.name,
  });

  DateTime? time;
  double? totalOrderCount;
  double? totalShippingFee;
  double? totalBeforeDiscount;
  double? comboDiscountAmount;
  double? voucherDiscountAmount;
  double? totalAfterDiscount;
  double? totalFinal;
  int? totalCollaboratorRegCount;
  int? totalReferralOfCustomerCount;
  String? name;

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
        time: json["time"] == null
            ? null
            : json["time"].toString().length == 7
                ? null
                : DateTime.parse(json["time"].toString()),
        totalOrderCount: json["total_order_count"].toDouble(),
        totalShippingFee: json["total_shipping_fee"].toDouble(),
        totalBeforeDiscount: json["total_before_discount"].toDouble(),
        comboDiscountAmount: json["combo_discount_amount"].toDouble(),
        voucherDiscountAmount: json["voucher_discount_amount"].toDouble(),
        totalAfterDiscount: json["total_after_discount"].toDouble(),
        totalFinal: json["total_final"].toDouble(),
        totalCollaboratorRegCount: json["total_collaborator_reg_count"],
        totalReferralOfCustomerCount: json["total_referral_of_customer_count"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "total_order_count": totalOrderCount,
        "total_shipping_fee": totalShippingFee,
        "total_before_discount": totalBeforeDiscount,
        "combo_discount_amount": comboDiscountAmount,
        "voucher_discount_amount": voucherDiscountAmount,
        "total_after_discount": totalAfterDiscount,
        "total_final": totalFinal,
        "name": name == null ? null : name,
      };
}
