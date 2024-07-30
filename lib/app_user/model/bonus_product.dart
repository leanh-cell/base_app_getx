import 'package:sahashop_customer/app_customer/model/product.dart';

import '../data/remote/response-request/customer/all_group_customer_res.dart';
import 'agency_type.dart';

class BonusProduct {
  BonusProduct(
      {this.id,
      this.storeId,
      this.multiplyByNumber,
      this.isEnd,
      this.name,
      this.description,
      this.imageUrl,
      this.startTime,
      this.endTime,
      this.setLimitAmount,
      this.ladderReward,
      this.amount,
      this.used,
      this.createdAt,
      this.updatedAt,
      this.selectProducts,
      this.bonusProducts,
      this.dataLadder,
      this.bonusProductsLadder,
      this.group,
      this.agencyTypes,
      this.groupTypes,
      this.groupProducts,this.groupProduct});

  int? id;
  int? storeId;
  bool? multiplyByNumber;
  bool? isEnd;
  String? name;
  String? description;
  String? imageUrl;
  DateTime? startTime;
  DateTime? endTime;
  bool? setLimitAmount;
  bool? ladderReward;
  int? amount;
  int? used;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<BonusProductSelected>? selectProducts;
  List<BonusProductSelected>? bonusProducts;
  DataLadder? dataLadder;
  List<BonusProductsLadder>? bonusProductsLadder;
  List<int>? group;
  List<AgencyType>? agencyTypes;
  List<GroupCustomer>? groupTypes;
  List<int>? groupProducts;
  int?  groupProduct;
  

  factory BonusProduct.fromJson(Map<String, dynamic> json) => BonusProduct(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        multiplyByNumber: json["multiply_by_number"] == null
            ? null
            : json["multiply_by_number"],
        isEnd: json["is_end"] == null ? null : json["is_end"],
        ladderReward:
            json["ladder_reward"] == null ? null : json["ladder_reward"],
        dataLadder: json["data_ladder"] == null
            ? null
            : DataLadder.fromJson(json["data_ladder"]),
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
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
        selectProducts: json["select_products"] == null
            ? null
            : List<BonusProductSelected>.from(json["select_products"]
                .map((x) => BonusProductSelected.fromJson(x))),
        bonusProducts: json["bonus_products"] == null
            ? null
            : List<BonusProductSelected>.from(json["bonus_products"]
                .map((x) => BonusProductSelected.fromJson(x))),
        bonusProductsLadder: json["bonus_products_ladder"] == null
            ? null
            : List<BonusProductsLadder>.from(json["bonus_products_ladder"]
                .map((x) => BonusProductsLadder.fromJson(x))),
        group: json["group_customers"] == null
            ? []
            : List<int>.from(json["group_customers"].map((x) => x)),
        agencyTypes: json["agency_types"] == null
            ? []
            : List<AgencyType>.from(
                json["agency_types"]!.map((x) => AgencyType.fromJson(x))),
        groupTypes: json["group_types"] == null
            ? []
            : List<GroupCustomer>.from(
                json["group_types"]!.map((x) => GroupCustomer.fromJson(x))),
        groupProducts: json["group_products"] == null
            ? []
            : List<int>.from(json["group_products"].map((x) => x)),
        groupProduct: json["group_product_current"],
       
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "multiply_by_number": multiplyByNumber,
        "is_end": isEnd == null ? null : isEnd,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "image_url": imageUrl,
        "start_time": startTime == null ? null : startTime!.toIso8601String(),
        "end_time": endTime == null ? null : endTime!.toIso8601String(),
        "ladder_reward": ladderReward == null ? null : ladderReward,
        "data_ladder": dataLadder == null ? null : dataLadder!.toJson(),
        "set_limit_amount": setLimitAmount == null ? null : setLimitAmount,
        "select_products": selectProducts == null
            ? null
            : List<dynamic>.from(selectProducts!.map((x) => x.toJson())),
        "bonus_products": bonusProducts == null
            ? null
            : List<dynamic>.from(bonusProducts!.map((x) => x.toJson())),
        "amount": amount,
        "used": used == null ? null : used,
        "agency_types": agencyTypes == null
            ? []
            : List<dynamic>.from(agencyTypes!.map((x) => x.toJson())),
        "group_types": groupTypes == null
            ? []
            : List<dynamic>.from(groupTypes!.map((x) => x.toJson())),
        "group_customers": group,
        "group_products" : groupProducts,
        "group_product" : groupProduct
      };
}

class BonusProductsLadder {
  BonusProductsLadder({
    this.id,
    this.storeId,
    this.bonusProductId,
    this.productId,
    this.elementDistributeId,
    this.subElementDistributeId,
    this.fromQuantity,
    this.distributeName,
    this.elementDistributeName,
    this.subElementDistributeName,
    this.boProductId,
    this.boElementDistributeId,
    this.boSubElementDistributeId,
    this.boQuantity,
    this.boDistributeName,
    this.boElementDistributeName,
    this.boSubElementDistributeName,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.boProduct,
  });

  int? id;
  int? storeId;
  int? bonusProductId;
  int? productId;
  int? elementDistributeId;
  int? subElementDistributeId;
  int? fromQuantity;
  String? distributeName;
  String? elementDistributeName;
  String? subElementDistributeName;
  int? boProductId;
  int? boElementDistributeId;
  int? boSubElementDistributeId;
  int? boQuantity;
  String? boDistributeName;
  String? boElementDistributeName;
  String? boSubElementDistributeName;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;
  Product? boProduct;

  factory BonusProductsLadder.fromJson(Map<String, dynamic> json) =>
      BonusProductsLadder(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        bonusProductId:
            json["bonus_product_id"] == null ? null : json["bonus_product_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        elementDistributeId: json["element_distribute_id"] == null
            ? null
            : json["element_distribute_id"],
        subElementDistributeId: json["sub_element_distribute_id"],
        fromQuantity:
            json["from_quantity"] == null ? null : json["from_quantity"],
        distributeName:
            json["distribute_name"] == null ? null : json["distribute_name"],
        elementDistributeName: json["element_distribute_name"] == null
            ? null
            : json["element_distribute_name"],
        subElementDistributeName: json["sub_element_distribute_name"],
        boProductId:
            json["bo_product_id"] == null ? null : json["bo_product_id"],
        boElementDistributeId: json["bo_element_distribute_id"],
        boSubElementDistributeId: json["bo_sub_element_distribute_id"],
        boQuantity: json["bo_quantity"] == null ? null : json["bo_quantity"],
        boDistributeName: json["bo_distribute_name"] == null
            ? null
            : json["bo_distribute_name"],
        boElementDistributeName: json["bo_element_distribute_name"] == null
            ? null
            : json["bo_element_distribute_name"],
        boSubElementDistributeName:
            json["bo_sub_element_distribute_name"] == null
                ? null
                : json["bo_sub_element_distribute_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        boProduct: json["bo_product"] == null
            ? null
            : Product.fromJson(json["bo_product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "bonus_product_id": bonusProductId == null ? null : bonusProductId,
        "product_id": productId == null ? null : productId,
        "element_distribute_id":
            elementDistributeId == null ? null : elementDistributeId,
        "sub_element_distribute_id": subElementDistributeId,
        "from_quantity": fromQuantity == null ? null : fromQuantity,
        "distribute_name": distributeName == null ? null : distributeName,
        "element_distribute_name":
            elementDistributeName == null ? null : elementDistributeName,
        "sub_element_distribute_name": subElementDistributeName,
        "bo_product_id": boProductId == null ? null : boProductId,
        "bo_element_distribute_id": boElementDistributeId,
        "bo_sub_element_distribute_id": boSubElementDistributeId,
        "bo_quantity": boQuantity == null ? null : boQuantity,
        "bo_distribute_name":
            boDistributeName == null ? null : boDistributeName,
        "bo_element_distribute_name":
            boElementDistributeName == null ? null : boElementDistributeName,
        "bo_sub_element_distribute_name": boSubElementDistributeName == null
            ? null
            : boSubElementDistributeName,
      };
}

class BonusProductSelected {
  BonusProductSelected({
    this.id,
    this.storeId,
    this.bonusProductId,
    this.productId,
    this.elementDistributeId,
    this.subElementDistributeId,
    this.isSelectProduct,
    this.quantity,
    this.allowsChooseDistribute,
    this.allowsAllDistribute,
    this.distributeName,
    this.elementDistributeName,
    this.subElementDistributeName,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  int? id;
  int? storeId;
  int? bonusProductId;
  int? productId;
  int? elementDistributeId;
  int? subElementDistributeId;
  int? isSelectProduct;
  int? quantity;
  bool? allowsChooseDistribute;
  bool? allowsAllDistribute;
  String? imageUrl;
  String? distributeName;
  String? elementDistributeName;
  String? subElementDistributeName;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;

  factory BonusProductSelected.fromJson(Map<String, dynamic> json) =>
      BonusProductSelected(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        bonusProductId:
            json["bonus_product_id"] == null ? null : json["bonus_product_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        allowsChooseDistribute: json["allows_choose_distribute"] == null
            ? null
            : json["allows_choose_distribute"],
        allowsAllDistribute: json["allows_all_distribute"] == null
            ? null
            : json["allows_all_distribute"],
        elementDistributeId: json["element_distribute_id"] == null
            ? null
            : json["element_distribute_id"],
        subElementDistributeId: json["sub_element_distribute_id"] == null
            ? null
            : json["sub_element_distribute_id"],
        isSelectProduct: json["is_select_product"] == null
            ? null
            : json["is_select_product"],
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
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "bonus_product_id": bonusProductId == null ? null : bonusProductId,
        "product_id": productId == null ? null : productId,
        "element_distribute_id":
            elementDistributeId == null ? null : elementDistributeId,
        "sub_element_distribute_id":
            subElementDistributeId == null ? null : subElementDistributeId,
        "quantity": quantity == null ? null : quantity,
        "allows_choose_distribute":
            allowsChooseDistribute == null ? null : allowsChooseDistribute,
        "allows_all_distribute":
            allowsAllDistribute == null ? null : allowsAllDistribute,
        "distribute_name": distributeName == null ? null : distributeName,
        "element_distribute_name":
            elementDistributeName == null ? null : elementDistributeName,
        "sub_element_distribute_name":
            subElementDistributeName == null ? null : subElementDistributeName,
      };
}

class DataLadder {
  DataLadder({
    this.productId,
    this.distributeName,
    this.elementDistributeName,
    this.subElementDistributeName,
    this.list,
  });

  int? productId;
  String? distributeName;
  String? elementDistributeName;
  String? subElementDistributeName;
  List<ListOffer>? list = [];

  factory DataLadder.fromJson(Map<String, dynamic> json) => DataLadder(
        productId: json["product_id"] == null ? null : json["product_id"],
        distributeName:
            json["distribute_name"] == null ? null : json["distribute_name"],
        elementDistributeName: json["element_distribute_name"] == null
            ? null
            : json["element_distribute_name"],
        subElementDistributeName: json["sub_element_distribute_name"] == null
            ? null
            : json["sub_element_distribute_name"],
        list: json["list"] == null
            ? null
            : List<ListOffer>.from(
                json["list"].map((x) => ListOffer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId == null ? null : productId,
        "distribute_name": distributeName == null ? null : distributeName,
        "element_distribute_name":
            elementDistributeName == null ? null : elementDistributeName,
        "sub_element_distribute_name":
            subElementDistributeName == null ? null : subElementDistributeName,
        "list": list == null
            ? null
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class ListOffer {
  ListOffer({
    this.fromQuantity,
    this.bonusQuantity,
    this.boProductId,
    this.productName,
    this.boDistributeName,
    this.boElementDistributeName,
    this.boSubElementDistributeName,
  });

  int? fromQuantity;
  int? bonusQuantity;
  int? boProductId;
  String? productName;
  String? boElementDistributeName;
  String? boDistributeName;
  String? boSubElementDistributeName;

  factory ListOffer.fromJson(Map<String, dynamic> json) => ListOffer(
        fromQuantity:
            json["from_quantity"] == null ? null : json["from_quantity"],
        bonusQuantity:
            json["bonus_quantity"] == null ? null : json["bonus_quantity"],
        boProductId:
            json["bo_product_id"] == null ? null : json["bo_product_id"],
        boDistributeName: json["bo_distribute_name"] == null
            ? null
            : json["bo_distribute_name"],
        boElementDistributeName: json["bo_element_distribute_name"] == null
            ? null
            : json["bo_element_distribute_name"],
        boSubElementDistributeName:
            json["bo_sub_element_distribute_name"] == null
                ? null
                : json["bo_sub_element_distribute_name"],
      );

  Map<String, dynamic> toJson() => {
        "from_quantity": fromQuantity == null ? null : fromQuantity,
        "bonus_quantity": bonusQuantity == null ? null : bonusQuantity,
        "bo_product_id": boProductId == null ? null : boProductId,
        "bo_distribute_name":
            boDistributeName == null ? null : boDistributeName,
        "bo_element_distribute_name":
            boElementDistributeName == null ? null : boElementDistributeName,
        "bo_sub_element_distribute_name": boSubElementDistributeName == null
            ? null
            : boSubElementDistributeName,
      };
}
