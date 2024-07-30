class PaymentHistory {
  PaymentHistory({
    this.money,
    this.paymentMethod,
    this.remainingAmount,
    this.revenueExpenditureId,
    this.createdAt,
    this.updatedAt,
  });

  double? money;
  int? paymentMethod;
  double? remainingAmount;
  int? revenueExpenditureId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PaymentHistory.fromJson(Map<String, dynamic> json) => PaymentHistory(
    money: json["money"] == null ? null : json["money"].toDouble(),
    paymentMethod: json["payment_method_id"] == null ? null : json["payment_method_id"],
    remainingAmount: json["remaining_amount"] == null ? null : json["remaining_amount"].toDouble(),
    revenueExpenditureId: json["revenue_expenditure_id"] == null ? null : json["revenue_expenditure_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "money": money == null ? null : money,
    "payment_method": paymentMethod == null ? null : paymentMethod,
    "remaining_amount": remainingAmount == null ? null : remainingAmount,
    "revenue_expenditure_id": revenueExpenditureId == null ? null : revenueExpenditureId,
  };
}
