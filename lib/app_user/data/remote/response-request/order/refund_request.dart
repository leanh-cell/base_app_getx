// To parse this JSON data, do
//
//     final refundRequest = refundRequestFromJson(jsonString);

import 'dart:convert';

RefundRequest refundRequestFromJson(String str) =>
    RefundRequest.fromJson(json.decode(str));

String refundRequestToJson(RefundRequest data) => json.encode(data.toJson());

class RefundRequest {
  RefundRequest({
    this.orderCode,
    this.newLineItems,
    this.refundMoneyPaid,
  });

  String? orderCode;
  RefundMoneyPaid? refundMoneyPaid;
  List<NewLineItem>? newLineItems;

  factory RefundRequest.fromJson(Map<String, dynamic> json) => RefundRequest(
        orderCode: json["order_code"] == null ? null : json["order_code"],
        refundMoneyPaid: json["refund_money_paid"] == null
            ? null
            : RefundMoneyPaid.fromJson(json["refund_money_paid"]),
        newLineItems: json["new_line_items"] == null
            ? null
            : List<NewLineItem>.from(
                json["new_line_items"].map((x) => NewLineItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_code": orderCode == null ? null : orderCode,
        "refund_money_paid":
            refundMoneyPaid == null ? null : refundMoneyPaid!.toJson(),
        "refund_line_items": newLineItems == null
            ? null
            : List<dynamic>.from(newLineItems!.map((x) => x.toJson())),
      };
}

class RefundMoneyPaid {
  RefundMoneyPaid({
    this.amountMoney,
    this.paymentMethod,
  });

  double? amountMoney;
  int? paymentMethod;

  factory RefundMoneyPaid.fromJson(Map<String, dynamic> json) =>
      RefundMoneyPaid(
        amountMoney: json["amount_money"] == null
            ? null
            : json["amount_money"].toDouble(),
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
      );

  Map<String, dynamic> toJson() => {
        "amount_money": amountMoney == null ? null : amountMoney,
        "payment_method": paymentMethod == null ? null : paymentMethod,
      };
}

class NewLineItem {
  NewLineItem({
    this.lineItemId,
    this.quantity,
    this.price,
  });

  int? lineItemId;
  int? quantity;
  double? price;

  factory NewLineItem.fromJson(Map<String, dynamic> json) => NewLineItem(
        lineItemId: json["line_item_id"] == null ? null : json["line_item_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "line_item_id": lineItemId == null ? null : lineItemId,
        "quantity": quantity == null ? null : quantity,
      };
}
