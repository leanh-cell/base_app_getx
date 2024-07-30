import '../../../../model/product_commerce.dart';

class AllProductCommerceRes {
  AllProductCommerceRes({
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
  Data? data;

  factory AllProductCommerceRes.fromJson(Map<String, dynamic> json) =>
      AllProductCommerceRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<ProductCommerces>? data;

  String? nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<ProductCommerces>.from(
                json["data"]!.map((x) => ProductCommerces.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class ProductCommerces {
  ProductCommerces({
    this.name,
    this.nameStrFilter,
    this.mainImage,
    this.parentSkuInEcommerce,
    this.parentProductIdInEcommerce,
    this.minPrice,
    this.productIdInEcommerce,
    this.skuInEcommerce,
    this.children,
  });

  String? name;
  String? nameStrFilter;
  String? mainImage;
  String? parentSkuInEcommerce;
  String? parentProductIdInEcommerce;
  double? minPrice;
  String? productIdInEcommerce;
  String? skuInEcommerce;
  List<ProductCommerce>? children;

  factory ProductCommerces.fromJson(Map<String, dynamic> json) =>
      ProductCommerces(
        name: json["name"],
        nameStrFilter: json["name_str_filter"],
        mainImage: json["main_image"],
        parentSkuInEcommerce: json["parent_sku_in_ecommerce"],
        parentProductIdInEcommerce: json["parent_product_id_in_ecommerce"],
        minPrice:
            json["min_price"] == null ? null : json["min_price"].toDouble(),
        productIdInEcommerce: json["product_id_in_ecommerce"],
        skuInEcommerce: json["sku_in_ecommerce"],
        children: json["children"] == null
            ? []
            : List<ProductCommerce>.from(
                json["children"]!.map((x) => ProductCommerce.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "name_str_filter": nameStrFilter,
        "parent_sku_in_ecommerce": parentSkuInEcommerce,
        "parent_product_id_in_ecommerce": parentProductIdInEcommerce,
        "min_price": minPrice,
        "product_id_in_ecommerce": productIdInEcommerce,
        "sku_in_ecommerce": skuInEcommerce,
        "children": children == null
            ? []
            : List<dynamic>.from(children!.map((x) => x.toJson())),
      };
}
