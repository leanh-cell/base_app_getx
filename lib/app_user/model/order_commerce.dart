import 'dart:convert';

class OrderCommerce {
  OrderCommerce(
      {this.id,
      this.storeId,
      this.phoneNumber,
      this.orderIdInEcommerce,
      this.orderCode,
      this.orderStatus,
      this.paymentStatus,
      this.shipDiscountAmount,
      this.totalShippingFee,
      this.totalBeforeDiscount,
      this.totalAfterDiscount,
      this.discount,
      this.totalFinal,
      this.totalCostOfCapital,
      this.remainingAmount,
      this.branchId,
      this.customerProvinceName,
      this.customerDistrictName,
      this.customerWardsName,
      this.customerName,
      this.customerCountry,
      this.customerProvince,
      this.customerDistrict,
      this.customerWards,
      this.customerVillage,
      this.customerPostcode,
      this.customerEmail,
      this.customerPhone,
      this.customerAddressDetail,
      this.customerNote,
      this.createdByUserId,
      this.createdByStaffId,
      this.orderCodeRefund,
      this.orderFrom,
      this.lastTimeChangeOrderStatus,
      this.packageWeight,
      this.packageLength,
      this.packageWidth,
      this.packageHeight,
      this.fromPlatform,
      this.shopId,
      this.shopName,
      this.code,
      this.createdAt,
      this.updatedAt,
      this.lineItemsInTime,
      this.lineTimes});

  int? id;
  int? storeId;
  String? phoneNumber;
  String? orderIdInEcommerce;
  String? orderCode;
  String? orderStatus;
  String? paymentStatus;
  double? shipDiscountAmount;
  double? totalShippingFee;
  double? totalBeforeDiscount;
  double? totalAfterDiscount;
  double? discount;
  double? totalFinal;
  double? totalCostOfCapital;
  double? remainingAmount;
  dynamic branchId;

  String? customerProvinceName;
  String? customerDistrictName;
  String? customerWardsName;
  String? customerName;
  dynamic customerCountry;
  dynamic customerProvince;
  dynamic customerDistrict;
  dynamic customerWards;
  dynamic customerVillage;
  dynamic customerPostcode;
  dynamic customerEmail;
  dynamic customerPhone;
  dynamic customerAddressDetail;
  dynamic customerNote;
  dynamic createdByUserId;
  dynamic createdByStaffId;
  dynamic orderCodeRefund;
  dynamic orderFrom;
  dynamic lastTimeChangeOrderStatus;
  double? packageWeight;
  double? packageLength;
  double? packageWidth;
  double? packageHeight;
  String? fromPlatform;
  String? shopId;
  String? shopName;
  dynamic code;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<LineItemsInTime>? lineItemsInTime;
  List<LineTime>? lineTimes;

  factory OrderCommerce.fromJson(Map<String, dynamic> json) => OrderCommerce(
        id: json["id"],
        storeId: json["store_id"],
        phoneNumber: json["phone_number"],
        orderIdInEcommerce: json["order_id_in_ecommerce"],
        orderCode: json["order_code"],
        orderStatus: json["order_status"],
        paymentStatus: json["payment_status"],
        shipDiscountAmount: json["ship_discount_amount"] == null
            ? null
            : json["ship_discount_amount"].toDouble(),
        totalShippingFee: json["total_shipping_fee"] == null
            ? null
            : json["total_shipping_fee"].toDouble(),
        totalBeforeDiscount: json["total_before_discount"] == null
            ? null
            : json["total_before_discount"].toDouble(),
        totalAfterDiscount: json["total_after_discount"] == null
            ? null
            : json["total_after_discount"].toDouble(),
        discount: json["discount"] == null ? null : json["discount"].toDouble(),
        totalFinal:
            json["total_final"] == null ? null : json["total_final"].toDouble(),
        totalCostOfCapital: json["total_cost_of_capital"] == null
            ? null
            : json["total_cost_of_capital"].toDouble(),
        remainingAmount: json["remaining_amount"] == null
            ? null
            : json["remaining_amount"].toDouble(),
        branchId: json["branch_id"],
        customerProvinceName: json["customer_province_name"],
        customerDistrictName: json["customer_district_name"],
        customerWardsName: json["customer_wards_name"],
        customerName: json["customer_name"],
        customerCountry: json["customer_country"],
        customerProvince: json["customer_province"],
        customerDistrict: json["customer_district"],
        customerWards: json["customer_wards"],
        customerVillage: json["customer_village"],
        customerPostcode: json["customer_postcode"],
        customerEmail: json["customer_email"],
        customerPhone: json["customer_phone"],
        customerAddressDetail: json["customer_address_detail"],
        customerNote: json["customer_note"],
        createdByUserId: json["created_by_user_id"],
        createdByStaffId: json["created_by_staff_id"],
        orderCodeRefund: json["order_code_refund"],
        orderFrom: json["order_from"],
        lastTimeChangeOrderStatus: json["last_time_change_order_status"],
        packageWeight: json["package_weight"] == null
            ? null
            : json["package_weight"].toDouble(),
        packageLength: json["package_length"] == null
            ? null
            : json["package_length"].toDouble(),
        packageWidth: json["package_width"] == null
            ? null
            : json["package_width"].toDouble(),
        packageHeight: json["package_height"] == null
            ? null
            : json["package_height"].toDouble(),
        fromPlatform: json["from_platform"],
        shopId: json["shop_id"],
        shopName: json["shop_name"],
        code: json["code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        lineItemsInTime: json["line_items_in_time"] == null
            ? []
            : List<LineItemsInTime>.from(json["line_items_in_time"].map((x) => LineItemsInTime.fromJson(x))),
        lineTimes: json["line_times"] == null
            ? []
            : List<LineTime>.from(
                json["line_times"]!.map((x) => LineTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "phone_number": phoneNumber,
        "order_id_in_ecommerce": orderIdInEcommerce,
        "order_code": orderCode,
        "order_status": orderStatus,
        "payment_status": paymentStatus,
        "ship_discount_amount": shipDiscountAmount,
        "total_shipping_fee": totalShippingFee,
        "total_before_discount": totalBeforeDiscount,
        "total_after_discount": totalAfterDiscount,
        "discount": discount,
        "total_final": totalFinal,
        "total_cost_of_capital": totalCostOfCapital,
        "remaining_amount": remainingAmount,
        "branch_id": branchId,
        "customer_province_name": customerProvinceName,
        "customer_district_name": customerDistrictName,
        "customer_wards_name": customerWardsName,
        "customer_name": customerName,
        "customer_country": customerCountry,
        "customer_province": customerProvince,
        "customer_district": customerDistrict,
        "customer_wards": customerWards,
        "customer_village": customerVillage,
        "customer_postcode": customerPostcode,
        "customer_email": customerEmail,
        "customer_phone": customerPhone,
        "customer_address_detail": customerAddressDetail,
        "customer_note": customerNote,
        "created_by_user_id": createdByUserId,
        "created_by_staff_id": createdByStaffId,
        "order_code_refund": orderCodeRefund,
        "order_from": orderFrom,
        "last_time_change_order_status": lastTimeChangeOrderStatus,
        "package_weight": packageWeight,
        "package_length": packageLength,
        "package_width": packageWidth,
        "package_height": packageHeight,
        "from_platform": fromPlatform,
        "shop_id": shopId,
        "shop_name": shopName,
        "code": code,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "line_items_in_time": lineItemsInTime == null
            ? []
            : List<dynamic>.from(lineItemsInTime!.map((x) => x.toJson())),
        "line_times": lineTimes == null
            ? []
            : List<dynamic>.from(lineTimes!.map((x) => x.toJson())),
      };
}

class LineItemsInTime {
  LineItemsInTime({
    this.id,
    this.product,
    this.seller,
    this.confirmation,
    this.parentItemId,
    this.price,
    this.qty,
    this.fulfilledAt,
    this.isVirtual,
    this.isEbook,
    this.isBookcare,
    this.isFreeGift,
    this.isFulfilled,
    this.backendId,
    this.appliedRuleIds,
    this.invoice,
    this.inventoryRequisition,
    this.inventoryWithdrawals,
    this.sellerInventoryId,
    this.sellerInventoryName,
    this.sellerIncomeDetail,
  });

  int? id;
  Product? product;
  Seller? seller;
  Confirmation? confirmation;
  int? parentItemId;
  double? price;
  int? qty;
  dynamic fulfilledAt;
  bool? isVirtual;
  bool? isEbook;
  bool? isBookcare;
  bool? isFreeGift;
  bool? isFulfilled;
  int? backendId;
  List<String>? appliedRuleIds;
  Invoice? invoice;
  dynamic inventoryRequisition;
  List<dynamic>? inventoryWithdrawals;
  int? sellerInventoryId;
  String? sellerInventoryName;
  SellerIncomeDetail? sellerIncomeDetail;

  factory LineItemsInTime.fromJson(Map<String, dynamic> json) =>
      LineItemsInTime(
        id: json["id"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
        confirmation: json["confirmation"] == null
            ? null
            : Confirmation.fromJson(json["confirmation"]),
        parentItemId: json["parent_item_id"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        qty: json["qty"],
        fulfilledAt: json["fulfilled_at"],
        isVirtual: json["is_virtual"],
        isEbook: json["is_ebook"],
        isBookcare: json["is_bookcare"],
        isFreeGift: json["is_free_gift"],
        isFulfilled: json["is_fulfilled"],
        backendId: json["backend_id"],
        appliedRuleIds: json["applied_rule_ids"] == null
            ? []
            : List<String>.from(json["applied_rule_ids"]!.map((x) => x)),
        invoice:
            json["invoice"] == null ? null : Invoice.fromJson(json["invoice"]),
        inventoryRequisition: json["inventory_requisition"],
        inventoryWithdrawals: json["inventory_withdrawals"] == null
            ? []
            : List<dynamic>.from(json["inventory_withdrawals"]!.map((x) => x)),
        sellerInventoryId: json["seller_inventory_id"],
        sellerInventoryName: json["seller_inventory_name"],
        sellerIncomeDetail: json["seller_income_detail"] == null
            ? null
            : SellerIncomeDetail.fromJson(json["seller_income_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product?.toJson(),
        "seller": seller?.toJson(),
        "confirmation": confirmation?.toJson(),
        "parent_item_id": parentItemId,
        "price": price,
        "qty": qty,
        "fulfilled_at": fulfilledAt,
        "is_virtual": isVirtual,
        "is_ebook": isEbook,
        "is_bookcare": isBookcare,
        "is_free_gift": isFreeGift,
        "is_fulfilled": isFulfilled,
        "backend_id": backendId,
        "applied_rule_ids": appliedRuleIds == null
            ? []
            : List<dynamic>.from(appliedRuleIds!.map((x) => x)),
        "invoice": invoice?.toJson(),
        "inventory_requisition": inventoryRequisition,
        "inventory_withdrawals": inventoryWithdrawals == null
            ? []
            : List<dynamic>.from(inventoryWithdrawals!.map((x) => x)),
        "seller_inventory_id": sellerInventoryId,
        "seller_inventory_name": sellerInventoryName,
        "seller_income_detail": sellerIncomeDetail?.toJson(),
      };
}

class Confirmation {
  Confirmation({
    this.status,
    this.confirmedAt,
    this.availableConfirmSla,
    this.pickupConfirmSla,
    this.histories,
  });

  String? status;
  dynamic confirmedAt;
  DateTime? availableConfirmSla;
  dynamic pickupConfirmSla;
  List<dynamic>? histories;

  factory Confirmation.fromJson(Map<String, dynamic> json) => Confirmation(
        status: json["status"],
        confirmedAt: json["confirmed_at"],
        availableConfirmSla: json["available_confirm_sla"] == null
            ? null
            : DateTime.parse(json["available_confirm_sla"]),
        pickupConfirmSla: json["pickup_confirm_sla"],
        histories: json["histories"] == null
            ? []
            : List<dynamic>.from(json["histories"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "confirmed_at": confirmedAt,
        "available_confirm_sla": availableConfirmSla?.toIso8601String(),
        "pickup_confirm_sla": pickupConfirmSla,
        "histories": histories == null
            ? []
            : List<dynamic>.from(histories!.map((x) => x)),
      };
}

class Invoice {
  Invoice({
    this.price,
    this.quantity,
    this.subtotal,
    this.rowTotal,
    this.discountAmount,
    this.discountTikixu,
    this.discountPromotion,
    this.discountPercent,
    this.discountCoupon,
    this.discountOther,
    this.discountTikier,
    this.discountTikiFirst,
    this.discountData,
    this.isSellerDiscountCoupon,
    this.isTaxable,
    this.fobPrice,
    this.sellerFee,
    this.sellerIncome,
    this.fees,
  });

  double? price;
  int? quantity;
  int? subtotal;
  int? rowTotal;
  double? discountAmount;
  double? discountTikixu;
  double? discountPromotion;
  double? discountPercent;
  double? discountCoupon;
  double? discountOther;
  double? discountTikier;
  double? discountTikiFirst;
  DiscountData? discountData;
  bool? isSellerDiscountCoupon;
  bool? isTaxable;
  double? fobPrice;
  double? sellerFee;
  double? sellerIncome;
  List<dynamic>? fees;

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        price: json["price"] == null ? null : json["price"].toDouble(),
        quantity: json["quantity"],
        subtotal: json["subtotal"],
        rowTotal: json["row_total"],
        discountAmount: json["discount_amount"] == null
            ? null
            : json["discount_amount"].toDouble(),
        discountTikixu: json["discount_tikixu"] == null
            ? null
            : json["discount_tikixu"].toDouble(),
        discountPromotion: json["discount_promotion"] == null
            ? null
            : json["discount_promotion"].toDouble(),
        discountPercent: json["discount_percent"] == null
            ? null
            : json["discount_percent"].toDouble(),
        discountCoupon: json["discount_coupon"] == null
            ? null
            : json["discount_coupon"].toDouble(),
        discountOther: json["discount_other"] == null
            ? null
            : json["discount_other"].toDouble(),
        discountTikier: json["discount_tikier"] == null
            ? null
            : json["discount_tikier"].toDouble(),
        discountTikiFirst: json["discount_tiki_first"] == null
            ? null
            : json["discount_tiki_first"].toDouble(),
        discountData: json["discount_data"] == null
            ? null
            : DiscountData.fromJson(json["discount_data"]),
        isSellerDiscountCoupon: json["is_seller_discount_coupon"],
        isTaxable: json["is_taxable"],
        fobPrice:
            json["fob_price"] == null ? null : json["fob_price"].toDouble(),
        sellerFee:
            json["seller_fee"] == null ? null : json["seller_fee"].toDouble(),
        sellerIncome: json["seller_income"] == null
            ? null
            : json["seller_income"].toDouble(),
        fees: json["fees"] == null
            ? []
            : List<dynamic>.from(json["fees"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "quantity": quantity,
        "subtotal": subtotal,
        "row_total": rowTotal,
        "discount_amount": discountAmount,
        "discount_tikixu": discountTikixu,
        "discount_promotion": discountPromotion,
        "discount_percent": discountPercent,
        "discount_coupon": discountCoupon,
        "discount_other": discountOther,
        "discount_tikier": discountTikier,
        "discount_tiki_first": discountTikiFirst,
        "discount_data": discountData?.toJson(),
        "is_seller_discount_coupon": isSellerDiscountCoupon,
        "is_taxable": isTaxable,
        "fob_price": fobPrice,
        "seller_fee": sellerFee,
        "seller_income": sellerIncome,
        "fees": fees == null ? [] : List<dynamic>.from(fees!.map((x) => x)),
      };
}

class DiscountData {
  DiscountData();

  factory DiscountData.fromJson(Map<String, dynamic> json) => DiscountData();

  Map<String, dynamic> toJson() => {};
}

class Product {
  Product({
    this.id,
    this.type,
    this.superId,
    this.masterId,
    this.sku,
    this.name,
    this.catalogGroupName,
    this.inventoryType,
    this.imeis,
    this.serialNumbers,
    this.thumbnail,
    this.sellerProductCode,
    this.sellerSupplyMethod,
  });

  int? id;
  String? type;
  int? superId;
  int? masterId;
  String? sku;
  String? name;
  String? catalogGroupName;
  String? inventoryType;
  List<dynamic>? imeis;
  List<dynamic>? serialNumbers;
  String? thumbnail;
  String? sellerProductCode;
  dynamic sellerSupplyMethod;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        type: json["type"],
        superId: json["super_id"],
        masterId: json["master_id"],
        sku: json["sku"],
        name: json["name"],
        catalogGroupName: json["catalog_group_name"],
        inventoryType: json["inventory_type"],
        imeis: json["imeis"] == null
            ? []
            : List<dynamic>.from(json["imeis"]!.map((x) => x)),
        serialNumbers: json["serial_numbers"] == null
            ? []
            : List<dynamic>.from(json["serial_numbers"]!.map((x) => x)),
        thumbnail: json["thumbnail"],
        sellerProductCode: json["seller_product_code"],
        sellerSupplyMethod: json["seller_supply_method"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "super_id": superId,
        "master_id": masterId,
        "sku": sku,
        "name": name,
        "catalog_group_name": catalogGroupName,
        "inventory_type": inventoryType,
        "imeis": imeis == null ? [] : List<dynamic>.from(imeis!.map((x) => x)),
        "serial_numbers": serialNumbers == null
            ? []
            : List<dynamic>.from(serialNumbers!.map((x) => x)),
        "thumbnail": thumbnail,
        "seller_product_code": sellerProductCode,
        "seller_supply_method": sellerSupplyMethod,
      };
}

class Seller {
  Seller({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class SellerIncomeDetail {
  SellerIncomeDetail({
    this.itemPrice,
    this.itemQty,
    this.shippingFee,
    this.sellerFees,
    this.subTotal,
    this.sellerIncome,
    this.discount,
  });

  double? itemPrice;
  int? itemQty;
  double? shippingFee;
  List<dynamic>? sellerFees;
  int? subTotal;
  int? sellerIncome;
  Discount? discount;

  factory SellerIncomeDetail.fromJson(Map<String, dynamic> json) =>
      SellerIncomeDetail(
        itemPrice:
            json["item_price"] == null ? null : json["item_price"].toDouble(),
        itemQty: json["item_qty"],
        shippingFee:
            json["shipping_fee"] == null ? null : json["item_price"].toDouble(),
        sellerFees: json["seller_fees"] == null
            ? []
            : List<dynamic>.from(json["seller_fees"]!.map((x) => x)),
        subTotal: json["sub_total"],
        sellerIncome: json["seller_income"],
        discount: json["discount"] == null
            ? null
            : Discount.fromJson(json["discount"]),
      );

  Map<String, dynamic> toJson() => {
        "item_price": itemPrice,
        "item_qty": itemQty,
        "shipping_fee": shippingFee,
        "seller_fees": sellerFees == null
            ? []
            : List<dynamic>.from(sellerFees!.map((x) => x)),
        "sub_total": subTotal,
        "seller_income": sellerIncome,
        "discount": discount?.toJson(),
      };
}

class Discount {
  Discount({
    this.discountShippingFee,
    this.discountCoupon,
    this.discountTikixu,
  });

  DiscountShippingFee? discountShippingFee;
  DiscountCoupon? discountCoupon;
  DiscountTikixu? discountTikixu;

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        discountShippingFee: json["discount_shipping_fee"] == null
            ? null
            : DiscountShippingFee.fromJson(json["discount_shipping_fee"]),
        discountCoupon: json["discount_coupon"] == null
            ? null
            : DiscountCoupon.fromJson(json["discount_coupon"]),
        discountTikixu: json["discount_tikixu"] == null
            ? null
            : DiscountTikixu.fromJson(json["discount_tikixu"]),
      );

  Map<String, dynamic> toJson() => {
        "discount_shipping_fee": discountShippingFee?.toJson(),
        "discount_coupon": discountCoupon?.toJson(),
        "discount_tikixu": discountTikixu?.toJson(),
      };
}

class DiscountCoupon {
  DiscountCoupon({
    this.sellerDiscount,
    this.platformDiscount,
    this.totalDiscount,
  });

  double? sellerDiscount;
  double? platformDiscount;
  double? totalDiscount;

  factory DiscountCoupon.fromJson(Map<String, dynamic> json) => DiscountCoupon(
        sellerDiscount: json["seller_discount"] == null
            ? null
            : json["seller_discount"].toDouble(),
        platformDiscount: json["platform_discount"] == null
            ? null
            : json["platform_discount"].toDouble(),
        totalDiscount: json["total_discount"] == null
            ? null
            : json["total_discount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "seller_discount": sellerDiscount,
        "platform_discount": platformDiscount,
        "total_discount": totalDiscount,
      };
}

class DiscountShippingFee {
  DiscountShippingFee({
    this.sellerDiscount,
    this.feeAmount,
    this.qty,
    this.applyDiscount,
    this.sellerSubsidy,
    this.tikiSubsidy,
  });

  double? sellerDiscount;
  double? feeAmount;
  int? qty;
  List<ApplyDiscount>? applyDiscount;
  int? sellerSubsidy;
  int? tikiSubsidy;

  factory DiscountShippingFee.fromJson(Map<String, dynamic> json) =>
      DiscountShippingFee(
        sellerDiscount: json["sellerDiscount"] == null
            ? null
            : json["sellerDiscount"].toDouble(),
        feeAmount:
            json["fee_amount"] == null ? null : json["fee_amount"].toDouble(),
        qty: json["qty"],
        applyDiscount: json["apply_discount"] == null
            ? []
            : List<ApplyDiscount>.from(
                json["apply_discount"]!.map((x) => ApplyDiscount.fromJson(x))),
        sellerSubsidy: json["seller_subsidy"],
        tikiSubsidy: json["tiki_subsidy"],
      );

  Map<String, dynamic> toJson() => {
        "sellerDiscount": sellerDiscount,
        "fee_amount": feeAmount,
        "qty": qty,
        "apply_discount": applyDiscount == null
            ? []
            : List<dynamic>.from(applyDiscount!.map((x) => x.toJson())),
        "seller_subsidy": sellerSubsidy,
        "tiki_subsidy": tikiSubsidy,
      };
}

class ApplyDiscount {
  ApplyDiscount({
    this.ruleId,
    this.type,
    this.amount,
    this.sellerSponsor,
    this.tikiSponsor,
  });

  String? ruleId;
  String? type;
  int? amount;
  dynamic sellerSponsor;
  dynamic tikiSponsor;

  factory ApplyDiscount.fromJson(Map<String, dynamic> json) => ApplyDiscount(
        ruleId: json["rule_id"],
        type: json["type"],
        amount: json["amount"],
        sellerSponsor: json["seller_sponsor"],
        tikiSponsor: json["tiki_sponsor"],
      );

  Map<String, dynamic> toJson() => {
        "rule_id": ruleId,
        "type": type,
        "amount": amount,
        "seller_sponsor": sellerSponsor,
        "tiki_sponsor": tikiSponsor,
      };
}

class DiscountTikixu {
  DiscountTikixu({
    this.amount,
  });

  int? amount;

  factory DiscountTikixu.fromJson(Map<String, dynamic> json) => DiscountTikixu(
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
      };
}

class LineTime {
  LineTime(
      {this.id,
      this.orderItemIdInEcommerce,
      this.storeId,
      this.shopId,
      this.orderId,
      this.productIdInEcommerce,
      this.orderIdInEcommerce,
      this.sku,
      this.customerId,
      this.name,
      this.nameDistribute,
      this.phoneNumber,
      this.deviceId,
      this.productId,
      this.totalRefund,
      this.beforeDiscountPrice,
      this.itemPrice,
      this.costOfCapital,
      this.quantity,
      this.isRefund,
      this.branchId,
      this.isBonus,
      this.hasEditItemPrice,
      this.bonusProductName,
      this.createdAt,
      this.updatedAt,
      this.thumbnail});

  int? id;
  String? orderItemIdInEcommerce;
  int? storeId;
  String? shopId;
  String? orderId;
  String? productIdInEcommerce;
  String? orderIdInEcommerce;
  String? sku;
  int? customerId;
  String? name;
  dynamic nameDistribute;
  String? phoneNumber;
  String? deviceId;
  int? productId;
  double? totalRefund;
  double? beforeDiscountPrice;
  double? itemPrice;
  int? costOfCapital;
  int? quantity;
  dynamic isRefund;
  dynamic branchId;
  dynamic isBonus;
  dynamic hasEditItemPrice;
  dynamic bonusProductName;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? thumbnail;

  factory LineTime.fromJson(Map<String, dynamic> json) => LineTime(
      id: json["id"],
      orderItemIdInEcommerce: json["order_item_id_in_ecommerce"],
      storeId: json["store_id"],
      shopId: json["shop_id"],
      orderId: json["order_id"],
      productIdInEcommerce: json["product_id_in_ecommerce"],
      orderIdInEcommerce: json["order_id_in_ecommerce"],
      sku: json["sku"],
      customerId: json["customer_id"],
      name: json["name"],
      nameDistribute: json["name_distribute"],
      phoneNumber: json["phone_number"],
      deviceId: json["device_id"],
      productId: json["product_id"],
      totalRefund:
          json["total_refund"] == null ? null : json["total_refund"].toDouble(),
      beforeDiscountPrice: json["before_discount_price"] == null
          ? null
          : json["before_discount_price"].toDouble(),
      itemPrice:
          json["item_price"] == null ? null : json["item_price"].toDouble(),
      costOfCapital: json["cost_of_capital"],
      quantity: json["quantity"],
      isRefund: json["is_refund"],
      branchId: json["branch_id"],
      isBonus: json["is_bonus"],
      hasEditItemPrice: json["has_edit_item_price"],
      bonusProductName: json["bonus_product_name"],
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      thumbnail: json['thumbnail']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_item_id_in_ecommerce": orderItemIdInEcommerce,
        "store_id": storeId,
        "shop_id": shopId,
        "order_id": orderId,
        "product_id_in_ecommerce": productIdInEcommerce,
        "order_id_in_ecommerce": orderIdInEcommerce,
        "sku": sku,
        "customer_id": customerId,
        "name": name,
        "name_distribute": nameDistribute,
        "phone_number": phoneNumber,
        "device_id": deviceId,
        "product_id": productId,
        "total_refund": totalRefund,
        "before_discount_price": beforeDiscountPrice,
        "item_price": itemPrice,
        "cost_of_capital": costOfCapital,
        "quantity": quantity,
        "is_refund": isRefund,
        "branch_id": branchId,
        "is_bonus": isBonus,
        "has_edit_item_price": hasEditItemPrice,
        "bonus_product_name": bonusProductName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        'thumbnail': thumbnail
      };
}
