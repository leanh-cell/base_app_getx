


import '../../../../../model/product.dart';

class BonusProductItemRes {
    int? code;
    bool? success;
    String? msgCode;
    String? msg;
    BonusProductItem? data;

    BonusProductItemRes({
        this.code,
        this.success,
        this.msgCode,
        this.msg,
        this.data,
    });

    factory BonusProductItemRes.fromJson(Map<String, dynamic> json) => BonusProductItemRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : BonusProductItem.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class BonusProductItem {
    int? groupProductCurrent;
    int? groupProductMax;
    List<ProductClass>? selectProducts;
    List<ProductClass>? bonusProducts;

    BonusProductItem({
        this.groupProductCurrent,
        this.groupProductMax,
        this.selectProducts,
        this.bonusProducts,
    });

    factory BonusProductItem.fromJson(Map<String, dynamic> json) => BonusProductItem(
        groupProductCurrent: json["group_product_current"],
        groupProductMax: json["group_product_max"],
        selectProducts: json["select_products"] == null ? [] : List<ProductClass>.from(json["select_products"]!.map((x) => ProductClass.fromJson(x))),
        bonusProducts: json["bonus_products"] == null ? [] : List<ProductClass>.from(json["bonus_products"]!.map((x) => ProductClass.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "group_product_current": groupProductCurrent,
        "group_product_max": groupProductMax,
        "select_products": selectProducts == null ? [] : List<dynamic>.from(selectProducts!.map((x) => x.toJson())),
        "bonus_products": bonusProducts == null ? [] : List<dynamic>.from(bonusProducts!.map((x) => x.toJson())),
    };
}

class ProductClass {
    int? id;
    int? storeId;
    int? bonusProductId;
    int? productId;
    dynamic elementDistributeId;
    dynamic subElementDistributeId;
    int? isSelectProduct;
    int? groupProduct;
    bool? allowsChooseDistribute;
    int? quantity;
    dynamic distributeName;
    dynamic elementDistributeName;
    dynamic subElementDistributeName;
    bool? allowsAllDistribute;
    DateTime? createdAt;
    DateTime? updatedAt;
    Product? product;

    ProductClass({
        this.id,
        this.storeId,
        this.bonusProductId,
        this.productId,
        this.elementDistributeId,
        this.subElementDistributeId,
        this.isSelectProduct,
        this.groupProduct,
        this.allowsChooseDistribute,
        this.quantity,
        this.distributeName,
        this.elementDistributeName,
        this.subElementDistributeName,
        this.allowsAllDistribute,
        this.createdAt,
        this.updatedAt,
        this.product,
    });

    factory ProductClass.fromJson(Map<String, dynamic> json) => ProductClass(
        id: json["id"],
        storeId: json["store_id"],
        bonusProductId: json["bonus_product_id"],
        productId: json["product_id"],
        elementDistributeId: json["element_distribute_id"],
        subElementDistributeId: json["sub_element_distribute_id"],
        isSelectProduct: json["is_select_product"],
        groupProduct: json["group_product"],
        allowsChooseDistribute: json["allows_choose_distribute"],
        quantity: json["quantity"],
        distributeName: json["distribute_name"],
        elementDistributeName: json["element_distribute_name"],
        subElementDistributeName: json["sub_element_distribute_name"],
        allowsAllDistribute: json["allows_all_distribute"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "bonus_product_id": bonusProductId,
        "product_id": productId,
        "element_distribute_id": elementDistributeId,
        "sub_element_distribute_id": subElementDistributeId,
        "is_select_product": isSelectProduct,
        "group_product": groupProduct,
        "allows_choose_distribute": allowsChooseDistribute,
        "quantity": quantity,
        "distribute_name": distributeName,
        "element_distribute_name": elementDistributeName,
        "sub_element_distribute_name": subElementDistributeName,
        "allows_all_distribute": allowsAllDistribute,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
    };
}

