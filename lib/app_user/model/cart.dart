import 'package:sahashop_customer/app_customer/model/product.dart';

import 'cart_model.dart';
import 'combo.dart';

class Cart {
  Cart({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  CartModel? data;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: CartModel.fromJson(json["data"]),
      );
}



class UsedCombo {
  UsedCombo({
    this.combo,
    this.quantity,
  });

  Combo? combo;
  int? quantity;

  factory UsedCombo.fromJson(Map<String, dynamic> json) => UsedCombo(
        combo: Combo.fromJson(json["combo"]),
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "combo": combo!.toJson(),
        "quantity": quantity,
      };
}

class UsedDiscount {
  UsedDiscount({
    this.name,
    this.beforePrice,
    this.afterDiscount,
  });

  String? name;
  double? beforePrice;
  double? afterDiscount;

  factory UsedDiscount.fromJson(Map<String, dynamic> json) => UsedDiscount(
        name:json["name"] == null ? null : json["name"],
        beforePrice:json["before_price"] == null ? null :  json["before_price"].toDouble(),
        afterDiscount:json["after_discount"] == null ? null : json["after_discount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "before_price": beforePrice,
        "after_discount": afterDiscount,
      };
}

class UsedVoucher {
  UsedVoucher({
    this.id,
    this.storeId,
    this.isEnd,
    this.voucherType,
    this.name,
    this.code,
    this.description,
    this.imageUrl,
    this.startTime,
    this.endTime,
    this.discountType,
    this.valueDiscount,
    this.setLimitValueDiscount,
    this.maxValueDiscount,
    this.setLimitTotal,
    this.valueLimitTotal,
    this.isShowVoucher,
    this.setLimitAmount,
    this.amount,
    this.used,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  int? id;
  int? storeId;
  bool? isEnd;
  int? voucherType;
  String? name;
  String? code;
  dynamic description;
  dynamic imageUrl;
  DateTime? startTime;
  DateTime? endTime;
  int? discountType;
  double? valueDiscount;
  bool? setLimitValueDiscount;
  double? maxValueDiscount;
  bool? setLimitTotal;
  double? valueLimitTotal;
  bool? isShowVoucher;
  bool? setLimitAmount;
  int? amount;
  int? used;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Product>? products;

  factory UsedVoucher.fromJson(Map<String, dynamic> json) => UsedVoucher(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        isEnd: json["is_end"] == null ? null : json["is_end"],
        voucherType: json["voucher_type"] == null ? null : json["voucher_type"],
        name: json["name"] == null ? null : json["name"],
        code: json["code"] == null ? null : json["code"],
        description: json["description"],
        imageUrl: json["image_url"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        discountType:
            json["discount_type"] == null ? null : json["discount_type"],
        valueDiscount: json["value_discount"] == null
            ? null
            : json["value_discount"].toDouble(),
        setLimitValueDiscount: json["set_limit_value_discount"] == null
            ? null
            : json["set_limit_value_discount"],
        maxValueDiscount: json["max_value_discount"] == null
            ? null
            : json["max_value_discount"].toDouble(),
        setLimitTotal:
            json["set_limit_total"] == null ? null : json["set_limit_total"],
        valueLimitTotal: json["value_limit_total"] == null
            ? null
            : json["value_limit_total"].toDouble(),
        isShowVoucher:
            json["is_show_voucher"] == null ? null : json["is_show_voucher"],
        setLimitAmount:
            json["set_limit_amount"] == null ? null : json["set_limit_amount"],
        amount: json["amount"] == null ? null : json["amount"],
        used: json["used"] == null ? null : json["used"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );
}
