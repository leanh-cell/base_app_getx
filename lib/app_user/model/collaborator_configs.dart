class CollaboratorConfig {
  CollaboratorConfig({
    this.id,
    this.storeId,
    this.typeRose,
    this.allowPaymentRequest,
    this.payment1OfMonth,
    this.payment16OfMonth,
    this.paymentLimit,
    this.percentCollaboratorT1,
    this.allowRoseReferralCustomer,
    this.createdAt,
    this.updatedAt,
    this.bonusTypeForCtvT2,
  });

  int? id;
  int? storeId;
  int? typeRose;
  bool? allowPaymentRequest;
  bool? payment1OfMonth;
  bool? payment16OfMonth;
  bool? allowRoseReferralCustomer;
  double? paymentLimit;
  double? percentCollaboratorT1;
  int? bonusTypeForCtvT2;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CollaboratorConfig.fromJson(Map<String, dynamic> json) =>
      CollaboratorConfig(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        typeRose: json["type_rose"] == null ? null : json["type_rose"],
        allowPaymentRequest: json["allow_payment_request"] == null
            ? null
            : json["allow_payment_request"],
        payment1OfMonth: json["payment_1_of_month"] == null
            ? null
            : json["payment_1_of_month"],
        payment16OfMonth: json["payment_16_of_month"] == null
            ? null
            : json["payment_16_of_month"],
        allowRoseReferralCustomer: json["allow_rose_referral_customer"] == null
            ? null
            : json["allow_rose_referral_customer"],
        paymentLimit: json["payment_limit"] == null
            ? null
            : json["payment_limit"].toDouble(),
        percentCollaboratorT1: json["percent_collaborator_t1"] == null
            ? null
            : json["percent_collaborator_t1"].toDouble(),
        bonusTypeForCtvT2: json["bonus_type_for_ctv_t2"] == null
            ? null
            : json["bonus_type_for_ctv_t2"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
    "type_rose": typeRose == null ? null : typeRose,
    "allow_payment_request":
    allowPaymentRequest == null ? null : allowPaymentRequest,
    "payment_1_of_month": payment1OfMonth == null ? null : payment1OfMonth,
    "payment_16_of_month":
    payment16OfMonth == null ? null : payment16OfMonth,
    "payment_limit": paymentLimit == null ? null : paymentLimit,
    "bonus_type_for_ctv_t2": bonusTypeForCtvT2 == null ? null : bonusTypeForCtvT2,
    "percent_collaborator_t1":
    percentCollaboratorT1 == null ? null : percentCollaboratorT1,
    "allow_rose_referral_customer": allowRoseReferralCustomer == null
        ? null
        : allowRoseReferralCustomer,
  };
}
