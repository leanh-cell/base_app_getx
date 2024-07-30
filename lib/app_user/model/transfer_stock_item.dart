import 'package:sahashop_customer/app_customer/model/product.dart';

class TransferStockItem {
  TransferStockItem({
    this.id,
    this.storeId,
    this.fromBranchId,
    this.imageProductUrl,
    this.toBranchId,
    this.productId,
    this.transferStockId,
    this.product,
    this.elementDistributeId,
    this.subElementDistributeId,
    this.quantity,
    this.quantityMax,
    this.distributeName,
    this.elementDistributeName,
    this.subElementDistributeName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  int? fromBranchId;
  int? toBranchId;
  int? productId;
  String? imageProductUrl;
  int? transferStockId;
  int? elementDistributeId;
  int? subElementDistributeId;
  int? quantity;
  int? quantityMax;
  Product? product;
  String? distributeName;
  String? elementDistributeName;
  String? subElementDistributeName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory TransferStockItem.fromJson(Map<String, dynamic> json) =>
      TransferStockItem(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        fromBranchId:
            json["from_branch_id"] == null ? null : json["from_branch_id"],
        toBranchId: json["to_branch_id"] == null ? null : json["to_branch_id"],
        transferStockId: json["transfer_stock_id"] == null
            ? null
            : json["transfer_stock_id"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        productId: json["product_id"] == null ? null : json["product_id"],
        elementDistributeId: json["element_distribute_id"] == null
            ? null
            : json["element_distribute_id"],
        subElementDistributeId: json["sub_element_distribute_id"] == null
            ? null
            : json["sub_element_distribute_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        distributeName:
            json["distribute_name"] == null ? null : json["distribute_name"],
        elementDistributeName: json["element_distribute_name"] == null
            ? null
            : json["element_distribute_name"],
        subElementDistributeName: json["sub_element_distribute_name"] == null
            ? null
            : json["sub_element_distribute_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "from_branch_id": fromBranchId == null ? null : fromBranchId,
        "to_branch_id": toBranchId == null ? null : toBranchId,
        "transfer_stock_id": transferStockId == null ? null : transferStockId,
        "product_id": productId == null ? null : productId,
        "element_distribute_id": elementDistributeId,
        "sub_element_distribute_id": subElementDistributeId,
        "quantity": quantity == null ? null : quantity,
        "distribute_name": distributeName,
        "element_distribute_name": elementDistributeName,
        "sub_element_distribute_name": subElementDistributeName,
      };
}
