class ProfitAndLoss {
  ProfitAndLoss({
    this.salesRevenue,
    this.realMoneyForSale,
    this.moneyBack,
    this.moneySales,
    this.taxVat,
    this.customerDeliveryFee,
    this.discount,
    this.sellingExpenses,
    this.costOfSales,
    this.payWithPoints,
    this.partnerDeliveryFee,
    this.otherIncome,
    this.revenueAutoCreate,
    this.customerReturn,
    this.otherCosts,
    this.profit,
    this. productDiscount,
    this.voucher,
    this.combo,
    this.totalDiscount,
  });

  double? salesRevenue;
  double? realMoneyForSale;
  double? moneyBack;
  double? moneySales;
  double? taxVat;
  double? customerDeliveryFee;
  double? discount;
  double? productDiscount;
  double? voucher;
  double? combo;
  double? totalDiscount;
  double? sellingExpenses;
  double? costOfSales;
  double? payWithPoints;
  double? partnerDeliveryFee;
  double? otherIncome;
  double? revenueAutoCreate;
  double? customerReturn;
  double? otherCosts;
  double? profit;

  factory ProfitAndLoss.fromJson(Map<String, dynamic> json) => ProfitAndLoss(
    salesRevenue: json["sales_revenue"] == null ? null : json["sales_revenue"].toDouble(),
    realMoneyForSale: json["real_money_for_sale"] == null ? null : json["real_money_for_sale"].toDouble(),
    moneyBack: json["money_back"] == null ? null : json["money_back"].toDouble(),
    moneySales: json["money_sales"] == null ? null : json["money_sales"].toDouble(),
    taxVat: json["tax_vat"] == null ? null : json["tax_vat"].toDouble(),
    customerDeliveryFee: json["customer_delivery_fee"] == null ? null : json["customer_delivery_fee"].toDouble(),

    discount: json["discount"] == null ? null : json["discount"].toDouble(),
    voucher: json["voucher"] == null ? null : json["voucher"].toDouble(),
    combo: json["combo"] == null ? null : json["combo"].toDouble(),
    productDiscount: json["product_discount"] == null ? null : json["product_discount"].toDouble(),
    totalDiscount: json["total_discount"] == null ? null : json["total_discount"].toDouble(),

    sellingExpenses: json["selling_expenses"] == null ? null : json["selling_expenses"].toDouble(),
    costOfSales: json["cost_of_sales"] == null ? null : json["cost_of_sales"].toDouble(),
    payWithPoints: json["pay_with_points"] == null ? null : json["pay_with_points"].toDouble(),
    partnerDeliveryFee: json["partner_delivery_fee"] == null ? null : json["partner_delivery_fee"].toDouble(),
    otherIncome: json["other_income"] == null ? null : json["other_income"].toDouble(),
    revenueAutoCreate: json["revenue_auto_create"] == null ? null : json["revenue_auto_create"].toDouble(),
    customerReturn: json["customer_return"] == null ? null : json["customer_return"].toDouble(),
    otherCosts: json["other_costs"] == null ? null : json["other_costs"].toDouble(),
    profit: json["profit"] == null ? null : json["profit"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "sales_revenue": salesRevenue == null ? null : salesRevenue,
    "real_money_for_sale": realMoneyForSale == null ? null : realMoneyForSale,
    "money_back": moneyBack == null ? null : moneyBack,
    "money_sales": moneySales == null ? null : moneySales,
    "tax_vat": taxVat == null ? null : taxVat,
    "customer_delivery_fee": customerDeliveryFee == null ? null : customerDeliveryFee,
    "discount": discount == null ? null : discount,
    "selling_expenses": sellingExpenses == null ? null : sellingExpenses,
    "cost_of_sales": costOfSales == null ? null : costOfSales,
    "pay_with_points": payWithPoints == null ? null : payWithPoints,
    "partner_delivery_fee": partnerDeliveryFee == null ? null : partnerDeliveryFee,
    "other_income": otherIncome == null ? null : otherIncome,
    "revenue_auto_create": revenueAutoCreate == null ? null : revenueAutoCreate,
    "customer_return": customerReturn == null ? null : customerReturn,
    "other_costs": otherCosts == null ? null : otherCosts,
    "profit": profit == null ? null : profit,
  };
}