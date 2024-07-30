import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/product.dart';

TallySheetRequest tallySheetRequestFromJson(String str) =>
    TallySheetRequest.fromJson(json.decode(str));

String tallySheetRequestToJson(TallySheetRequest data) =>
    json.encode(data.toJson());

class TallySheetRequest {
  TallySheetRequest({
    this.note,
    this.tallySheetItems,
  });

  String? note;
  List<TallySheetItem>? tallySheetItems;

  factory TallySheetRequest.fromJson(Map<String, dynamic> json) =>
      TallySheetRequest(
        note: json["note"] == null ? null : json["note"],
        tallySheetItems: json["tally_sheet_items"] == null
            ? null
            : List<TallySheetItem>.from(json["tally_sheet_items"]
                .map((x) => TallySheetItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "note": note == null ? null : note,
        "tally_sheet_items": tallySheetItems == null
            ? null
            : List<dynamic>.from(tallySheetItems!.map((x) => x.toJson())),
      };
}

class TallySheetItem {
  TallySheetItem({
    this.realityExist,
    this.stockOnline,
    this.imageProductUrl,
    this.nameProduct,
    this.productId,
    this.distributeName,
    this.elementDistributeName,
    this.subElementDistributeName,
    this.existingBranch,
    this.deviant,
    this.product,
  });

  int? realityExist;
  int? stockOnline;
  int? productId;
  String? imageProductUrl;
  String? nameProduct;
  String? distributeName;
  String? elementDistributeName;
  String? subElementDistributeName;
  int? existingBranch;
  int? deviant;
  Product? product;

  factory TallySheetItem.fromJson(Map<String, dynamic> json) => TallySheetItem(
        realityExist:
            json["reality_exist"] == null ? null : json["reality_exist"],
        productId: json["product_id"] == null ? null : json["product_id"],
        distributeName:
            json["distribute_name"] == null ? null : json["distribute_name"],
        elementDistributeName: json["element_distribute_name"] == null
            ? null
            : json["element_distribute_name"],
        subElementDistributeName: json["sub_element_distribute_name"] == null
            ? null
            : json["sub_element_distribute_name"],
        existingBranch:
            json["existing_branch"] == null ? null : json["existing_branch"],
        deviant: json["deviant"] == null ? null : json["deviant"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "reality_exist": realityExist == null ? 0 : realityExist,
        "product_id": productId == null ? null : productId,
        "distribute_name": distributeName == null ? null : distributeName,
        "element_distribute_name":
            elementDistributeName == null ? null : elementDistributeName,
        "sub_element_distribute_name":
            subElementDistributeName == null ? null : subElementDistributeName,
      };
}
