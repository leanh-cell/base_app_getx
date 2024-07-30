// To parse this JSON data, do
//
//     final revenueExpenditureRequest = revenueExpenditureRequestFromJson(jsonString);

import 'dart:convert';

RevenueExpenditureRequest revenueExpenditureRequestFromJson(String str) =>
    RevenueExpenditureRequest.fromJson(json.decode(str));

String revenueExpenditureRequestToJson(RevenueExpenditureRequest data) =>
    json.encode(data.toJson());

class RevenueExpenditureRequest {
  RevenueExpenditureRequest({
    this.recipientGroup,
    this.recipientReferencesId,
    this.changeMoney,
    this.paymentMethod,
    this.type,
    this.referenceName,
    this.description,
    this.allowAccounting,
    this.isRevenue,
  });

  int? recipientGroup;
  int? recipientReferencesId;
  double? changeMoney;
  int? paymentMethod;
  int? type;
  String? referenceName;
  String? description;
  bool? allowAccounting;
  bool? isRevenue;

  factory RevenueExpenditureRequest.fromJson(Map<String, dynamic> json) =>
      RevenueExpenditureRequest(
        recipientGroup:
            json["recipient_group"] == null ? null : json["recipient_group"],
        recipientReferencesId: json["recipient_references_id"] == null
            ? null
            : json["recipient_references_id"],
        changeMoney: json["change_money"] == null
            ? null
            : json["change_money"].toDouble(),

        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        referenceName:
            json["reference_name"] == null ? null : json["reference_name"],
        description: json["description"] == null ? null : json["description"],
        allowAccounting:
            json["allow_accounting"] == null ? null : json["allow_accounting"],
        isRevenue: json["is_revenue"] == null ? null : json["is_revenue"],
      );

  Map<String, dynamic> toJson() => {
        "recipient_group": recipientGroup == null ? null : recipientGroup,
        "recipient_references_id":
            recipientReferencesId == null ? null : recipientReferencesId,
        "change_money": changeMoney == null ? null : changeMoney,
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "type": type == null ? null : type,
        "reference_name": referenceName == null ? null : referenceName,
        "description": description == null ? null : description,
        "allow_accounting": allowAccounting == null ? null : allowAccounting,
        "is_revenue": isRevenue == null ? null : isRevenue,
      };
}
