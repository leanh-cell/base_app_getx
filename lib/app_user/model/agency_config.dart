class AgencyConfig {
  AgencyConfig({
    this.id,
    this.storeId,
    this.typeRose,
    this.allowPaymentRequest,
    this.allowRoseReferralCustomer,
    this.payment1OfMonth,
    this.payment16OfMonth,
    this.paymentLimit,
    this.bonusTypeForCtvT2,
    this.percentAgencyT1,
    this.typeBonusPeriodImport,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? typeRose;
  int? storeId;
  bool? allowPaymentRequest;
  bool? allowRoseReferralCustomer;
  bool? payment1OfMonth;
  bool? payment16OfMonth;
  double? paymentLimit;
  int? bonusTypeForCtvT2;
  int? typeBonusPeriodImport;
  double? percentAgencyT1;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AgencyConfig.fromJson(Map<String, dynamic> json) => AgencyConfig(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        typeRose: json["type_rose"] == null ? null : json["type_rose"],
        allowPaymentRequest: json["allow_payment_request"] == null
            ? null
            : json["allow_payment_request"],
        allowRoseReferralCustomer: json["allow_rose_referral_customer"] == null
            ? null
            : json["allow_rose_referral_customer"],
        payment1OfMonth: json["payment_1_of_month"] == null
            ? null
            : json["payment_1_of_month"],
        payment16OfMonth: json["payment_16_of_month"] == null
            ? null
            : json["payment_16_of_month"],
        bonusTypeForCtvT2: json["bonus_type_for_ctv_t2"] == null
            ? null
            : json["bonus_type_for_ctv_t2"],
        percentAgencyT1: json["percent_agency_t1"] == null
            ? null
            : json["percent_agency_t1"].toDouble(),
        typeBonusPeriodImport: json["type_bonus_period_import"] == null
            ? null
            : json["type_bonus_period_import"],
        paymentLimit: json["payment_limit"] == null
            ? null
            : json["payment_limit"].toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "bonus_type_for_ctv_t2":
            bonusTypeForCtvT2 == null ? null : bonusTypeForCtvT2,
        "percent_agency_t1": percentAgencyT1 == null ? null : percentAgencyT1,
        "type_bonus_period_import":
            typeBonusPeriodImport == null ? null : typeBonusPeriodImport,
        "type_rose": typeRose == null ? null : typeRose,
        "allow_payment_request":
            allowPaymentRequest == null ? null : allowPaymentRequest,
        "payment_1_of_month": payment1OfMonth == null ? null : payment1OfMonth,
        "payment_16_of_month":
            payment16OfMonth == null ? null : payment16OfMonth,
        "payment_limit": paymentLimit == null ? null : paymentLimit,
        "allow_rose_referral_customer": allowRoseReferralCustomer == null
            ? null
            : allowRoseReferralCustomer,
      };
}
