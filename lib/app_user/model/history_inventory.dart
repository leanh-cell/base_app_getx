import 'package:sahashop_customer/app_customer/model/product.dart';

import 'branch.dart';

class HistoryInventory {
  HistoryInventory({
    this.id,
    this.storeId,
    this.branchId,
    this.productId,
    this.elementDistributeId,
    this.subElementDistributeId,
    this.type,
    this.stock,
    this.change,
    this.changeMoney,
    this.costOfCapital,
    this.importPrice,
    this.referencesId,
    this.referencesValue,
    this.createdAt,
    this.updatedAt,
    this.branch,
    this.typeName,
    this.elementDistribute,
    this.subElementDistribute,
    this.product,
  });

  int? id;
  int? storeId;
  int? branchId;
  int? productId;
  int? elementDistributeId;
  int? subElementDistributeId;
  int? type;
  int? stock;
  int? change;
  double? changeMoney;
  double? costOfCapital;
  double? importPrice;
  int? referencesId;
  String? referencesValue;
  DateTime? createdAt;
  DateTime? updatedAt;
  Branch? branch;
  String? typeName;
  ElementDistributes? elementDistribute;
  SubElementDistribute? subElementDistribute;
  Product? product;

  factory HistoryInventory.fromJson(Map<String, dynamic> json) =>
      HistoryInventory(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        elementDistributeId: json["element_distribute_id"] == null
            ? null
            : json["element_distribute_id"],
        subElementDistributeId: json["sub_element_distribute_id"] == null
            ? null
            : json["sub_element_distribute_id"],
        type: json["type"] == null ? null : json["type"],
        stock: json["stock"] == null ? null : json["stock"],
        change: json["change"] == null ? null : json["change"],
        changeMoney:
            json["change_money"] == null ? 0 : json["change_money"].toDouble(),
        costOfCapital: json["cost_of_capital"] == null
            ? null
            : json["cost_of_capital"].toDouble(),
        importPrice: json["import_price"] == null
            ? null
            : json["import_price"].toDouble(),
        referencesId:
            json["references_id"] == null ? null : json["references_id"],
        referencesValue:
            json["references_value"] == null ? null : json["references_value"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        typeName: json["type_name"] == null ? null : json["type_name"],
        elementDistribute: json["element_distribute"] == null
            ? null
            : ElementDistributes.fromJson(json["element_distribute"]),
        subElementDistribute: json["sub_element_distribute"] == null
            ? null
            : SubElementDistribute.fromJson(json["sub_element_distribute"]),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );
}
