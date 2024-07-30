import 'package:sahashop_customer/app_customer/model/attribute_search.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';

import 'agency_price.dart';

class Product {
  Product({
    this.id,
    this.name,
    this.shelfPosition,
    this.storeId,
    this.description,
    this.indexImageAvatar,
    this.price,
    this.weight,
    this.priceImport,
    this.priceCapital,
    this.minPrice = 0,
    this.maxPrice,
    this.barcode,
    this.sku,
    this.status,
    this.mainStock,
    this.quantityInStock,
    this.quantityInStockWithDistribute,
    this.view,
    this.sold,
    this.likes,
    this.isNew,
    this.isTopSale,
    this.isFavorite,
    this.checkInventory = false,
    this.createdAt,
    this.updatedAt,
    this.distributes,
    this.attributes,
    this.images,
    this.categories,
    this.categoryChildren,
    this.attributeSearchList,
    this.attributeSearchChildren,
    this.productDiscount,
    this.hasInDiscount,
    this.hasInCombo,
    this.agencyPrice,
    this.percentCollaborator = 0,
    this.contentForCollaborator,
    this.inventory,
    this.distributeStock,
    this.importExport,
    this.hasInBonusProduct,
    this.pointForAgency,
    this.maxPriceBeforeOverride,
    this.minPriceBeforeOverride,
    this.percentAgency = 0,
    this.typeShareCollaboratorNumber,
    this.moneyAmountCollaborator,
    this.level,this.customPoint,this.customStock,this.customView,this.videoUrl,this.isMedicine
  });

  int? id;
  String? name;
  String? shelfPosition;
  int? storeId;
  String? description;
  int? indexImageAvatar;
  double? price;
  double? weight;
  double? priceCapital;
  double? priceImport;
  double? minPrice;
  double? maxPrice;
  double? maxPriceBeforeOverride;
  double? minPriceBeforeOverride;
  String? barcode;
  String? sku;
  int? mainStock;
  int? quantityInStock;
  int? quantityInStockWithDistribute;
  List<DistributeStock>? distributeStock;
  int? sold;
  int? view;
  int? likes;
  int? status;
  bool? isNew;
  bool? isTopSale;
  bool? isFavorite;
  bool? checkInventory = false;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Distributes>? distributes;
  List<Attributes>? attributes;
  List<ImageProduct>? images;
  List<Category>? categories;
  List<Category>? categoryChildren;
  List<AttributeSearch>? attributeSearchList;
  List<AttributeSearch>? attributeSearchChildren;
  ProductDiscount? productDiscount;
  bool? hasInDiscount;
  bool? hasInBonusProduct;
  bool? hasInCombo;
  AgencyPrice? agencyPrice;
  double? percentCollaborator;
  double? percentAgency;
  String? contentForCollaborator;
  Inventory? inventory;
  List<ImportExport>? importExport;
  int? pointForAgency;
  int? typeShareCollaboratorNumber;
  double? moneyAmountCollaborator;
  int? level;
  int? customPoint;
  int? customStock;
  int? customView;
  String? videoUrl;
  bool? isMedicine;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        typeShareCollaboratorNumber: json["type_share_collaborator_number"],
        moneyAmountCollaborator: json["money_amount_collaborator"]?.toDouble(),
        shelfPosition: json["shelf_position"],
        storeId: json["store_id"],
        description: json["description"],
        indexImageAvatar: 0,
        productDiscount: json["product_discount"] == null
            ? null
            : ProductDiscount.fromJson(json["product_discount"]),
        hasInDiscount: json["has_in_discount"],
        hasInCombo: json["has_in_combo"],
        hasInBonusProduct: json["has_in_bonus_product"],
        price: double.tryParse(json["price"].toString()) ?? 0,
        weight: json["weight"] == null
            ? null
            : double.tryParse(json["weight"].toString()),
        priceImport: double.tryParse(json["import_price"].toString()) ?? 0,
        priceCapital:
            double.tryParse(json["main_cost_of_capital"].toString()) ?? 0,
        minPrice: double.tryParse(json["min_price"].toString()) ?? 0,
        maxPrice: double.tryParse(json["max_price"].toString()) ?? 0,
        maxPriceBeforeOverride:
            double.tryParse(json["max_price_before_override"].toString()) ?? 0,
        minPriceBeforeOverride:
            double.tryParse(json["min_price_before_override"].toString()) ?? 0,
        barcode: json["barcode"],
        sku: json["sku"],
        status: json["status"],
        mainStock: json["main_stock"],
        quantityInStock: json["quantity_in_stock"] == null
            ? null
            : json["quantity_in_stock"],
        pointForAgency:
            json["point_for_agency"] == null ? null : json["point_for_agency"],
        quantityInStockWithDistribute:
            json["quantity_in_stock_with_distribute"] == null
                ? null
                : json["quantity_in_stock_with_distribute"],
        sold: json["sold"],
        view: json["view"],
        likes: json['likes'],
        isNew: json['is_new'] ?? false,
        agencyPrice: json["agency_price"] == null
            ? null
            : AgencyPrice.fromJson(json["agency_price"]),
        isFavorite: json['is_favorite'] ?? false,
        isTopSale: json['is_top_sale'] ?? false,
        checkInventory:
            json['check_inventory'] == null ? false : json['check_inventory'],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        distributes: json['distributes'] != null && json['distributes'] is List
            ? List<Distributes>.from(
                json["distributes"].map((x) => Distributes.fromJson(x)))
            : <Distributes>[],
        attributes: json['attributes'] != null && json['attributes'] is List
            ? List<Attributes>.from(
                json["attributes"].map((x) => Attributes.fromJson(x)))
            : <Attributes>[],
        images: json["images"] == null
            ? null
            : List<ImageProduct>.from(
                json["images"].map((x) => ImageProduct.fromJson(x))),
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        categoryChildren: json["category_children"] == null
            ? null
            : List<Category>.from(
                json["category_children"].map((x) => Category.fromJson(x))),
        // attributeSearchList: json["category_children"] == null
        //         ? null
        //         : List<Category>.from(
        //             json["category_children"].map((x) => Category.fromJson(x))),
        attributeSearchChildren: json["search_children"] == null
            ? null
            : List<AttributeSearch>.from(json["search_children"]
                .map((x) => AttributeSearch.fromJson(x))),
        percentCollaborator: json["percent_collaborator"] == null
            ? 0
            : json["percent_collaborator"].toDouble(),
        percentAgency: json["percent_agency"] == null
            ? 0
            : json["percent_agency"].toDouble(),
        contentForCollaborator: json["content_for_collaborator"] == null
            ? null
            : json["content_for_collaborator"],
        inventory: json["inventory"] == null
            ? null
            : Inventory.fromJson(json["inventory"]),
        distributeStock: json["distribute_stock"] == null
            ? null
            : List<DistributeStock>.from(json["distribute_stock"]
                .map((x) => DistributeStock.fromJson(x))),
        importExport: json["import_export"] == null
            ? null
            : List<ImportExport>.from(
                json["import_export"].map((x) => ImportExport.fromJson(x))),
        level: json['level'],
        customPoint: json['custom_point'],
        customStock: json['custom_stock'],
        customView: json['custom_view'],
        videoUrl : json["video_url"],
        isMedicine: json["is_medicine"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "shelf_position": shelfPosition,
        "store_id": storeId,
        "description": description,
        "index_image_avatar": 0,
        "price": price,
        "import_price": priceImport,
        "main_cost_of_capital": priceCapital,
        "barcode": name,
        "status": status,
        "likes": likes,
        "main_stock": mainStock,
        "sold": sold,
        "type_share_collaborator_number": typeShareCollaboratorNumber,
        "money_amount_collaborator": moneyAmountCollaborator,
        "view": view,
        "check_inventory": checkInventory,
        "point_for_agency": pointForAgency,
        "product_discount":
            productDiscount == null ? null : productDiscount!.toJson(),
        "has_in_discount": hasInDiscount,
        "has_in_combo": hasInCombo,
        "distributes": distributes == null
            ? null
            : List<dynamic>.from(distributes!.map((x) => x.toJson())),
        "attributes": attributes == null
            ? null
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "images":
            images == null ? null : images!.map((e) => e.imageUrl).toList(),
        "categories":
            categories == null ? null : categories!.map((e) => e.id).toList(),
        "percent_collaborator": percentCollaborator,
        "percent_agency": percentAgency,
        "content_for_collaborator": contentForCollaborator,
        "level" :level,
        "is_medicine" : isMedicine
      };
}

class ImageProduct {
  ImageProduct({
    this.id,
    this.imageUrl,
  });

  int? id;

  String? imageUrl;

  factory ImageProduct.fromJson(Map<String, dynamic> json) => ImageProduct(
        id: json["id"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
      };
}

class ProductDiscount {
  ProductDiscount({
    this.value,
    this.discountPrice,
  });

  double? value;

  double? discountPrice;

  factory ProductDiscount.fromJson(Map<String, dynamic> json) =>
      ProductDiscount(
        value: json["value"] == null ? null : json["value"].toDouble(),
        discountPrice: json["discount_price"] == null
            ? null
            : double.tryParse(json["discount_price"].toString())!.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "discount_price": discountPrice,
      };
}

class Distributes {
  int? id;
  String? name;
  String? subElementDistributeName;
  String? createdAt;
  String? updatedAt;
  List<ElementDistributes>? elementDistributes;

  Distributes({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.elementDistributes,
    this.subElementDistributeName,
  });

  Distributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    subElementDistributeName = json['sub_element_distribute_name'] == null
        ? null
        : json['sub_element_distribute_name'];
    if (json['element_distributes'] != null) {
      elementDistributes = [];
      json['element_distributes'].forEach((v) {
        elementDistributes!.add(new ElementDistributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.elementDistributes != null) {
      data['element_distributes'] =
          this.elementDistributes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ElementDistributes {
  int? id;
  String? name;
  String? imageUrl;
  double? price;
  double? priceImport;
  double? priceCapital;
  double? defaultPrice;
  int? stock;
  int? quantityInStock;
  String? barcode;
  List<SubElementDistribute>? subElementDistribute;
  String? createdAt;
  String? updatedAt;
  double? importCostOfCapital;
  int? importCountStock;
  double? importTotalAmount;
  double? exportCostOfCapital;
  double? exportImportPrice;
  int? exportCountStock;
  double? exportTotalAmount;

  ElementDistributes({
    this.id,
    this.name,
    this.imageUrl,
    this.barcode,
    this.priceImport,
    this.priceCapital,
    this.defaultPrice,
    this.quantityInStock,
    this.createdAt,
    this.updatedAt,
    this.importCostOfCapital,
    this.importCountStock,
    this.importTotalAmount,
    this.exportCostOfCapital,
    this.exportImportPrice,
    this.exportCountStock,
    this.exportTotalAmount,
  });

  ElementDistributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    price = json['price'] == null ? null : json["price"].toDouble();
    priceImport =
        json['import_price'] == null ? null : json["import_price"].toDouble();
    priceCapital = json['cost_of_capital'] == null
        ? null
        : json["cost_of_capital"].toDouble();
    defaultPrice =
        json['default_price'] == null ? null : json["default_price"].toDouble();
    stock = json['stock'] == null ? null : json['stock'];
    quantityInStock =
        json['quantity_in_stock'] == null ? null : json['quantity_in_stock'];
    subElementDistribute = json["sub_element_distributes"] == null
        ? null
        : List<SubElementDistribute>.from(json["sub_element_distributes"]
            .map((x) => SubElementDistribute.fromJson(x)));
    barcode = json['barcode'] == null ? null : json['barcode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    importCostOfCapital = json["import_cost_of_capital"] == null
        ? null
        : json["import_cost_of_capital"].toDouble();
    importCountStock =
        json["import_count_stock"] == null ? null : json["import_count_stock"];
    importTotalAmount = json["import_total_amount"] == null
        ? null
        : json["import_total_amount"].toDouble();
    exportCostOfCapital = json["export_cost_of_capital"] == null
        ? null
        : json["export_cost_of_capital"].toDouble();
    exportImportPrice = json["export_import_price"] == null
        ? null
        : json["export_import_price"].toDouble();
    exportCountStock =
        json["export_count_stock"] == null ? null : json["export_count_stock"];
    exportTotalAmount = json["export_total_amount"] == null
        ? null
        : json["export_total_amount"].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['barcode'] = this.barcode;
    data['stock'] = this.stock;
    data['cost_of_capital'] = this.priceCapital;
    data['import_price'] = this.priceImport;
    data['image_url'] = this.imageUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['quantity_in_stock'] = this.quantityInStock;

    return data;
  }
}

class Attributes {
  int? id;
  int? storeId;
  int? productId;
  String? name;
  String? value;
  String? createdAt;
  String? updatedAt;

  Attributes(
      {this.id,
      this.storeId,
      this.productId,
      this.name,
      this.value,
      this.createdAt,
      this.updatedAt});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    productId = json['product_id'];
    name = json['name'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SubElementDistribute {
  SubElementDistribute({
    this.id,
    this.name,
    this.barcode,
    this.price,
    this.priceImport,
    this.priceCapital,
    this.defaultPrice,
    this.stock,
    this.quantityInStock,
    this.importCostOfCapital,
    this.importCountStock,
    this.importTotalAmount,
    this.exportCostOfCapital,
    this.exportImportPrice,
    this.exportCountStock,
    this.exportTotalAmount,
  });

  int? id;
  String? name;
  String? barcode;
  double? price;
  double? priceImport;
  double? priceCapital;
  double? defaultPrice;
  int? stock;
  int? quantityInStock;
  double? importCostOfCapital;
  int? importCountStock;
  double? importTotalAmount;
  double? exportCostOfCapital;
  double? exportImportPrice;
  int? exportCountStock;
  double? exportTotalAmount;

  factory SubElementDistribute.fromJson(Map<String, dynamic> json) =>
      SubElementDistribute(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        priceImport: json["import_price"] == null
            ? null
            : json["import_price"].toDouble(),
        priceCapital: json["cost_of_capital"] == null
            ? null
            : json["cost_of_capital"].toDouble(),
        defaultPrice: json["default_price"] == null
            ? null
            : json["default_price"].toDouble(),
        barcode: json["barcode"] == null ? null : json['barcode'],
        stock: json["stock"] == null ? null : json["stock"],
        quantityInStock: json["quantity_in_stock"] == null
            ? null
            : json["quantity_in_stock"],
        importCostOfCapital: json["import_cost_of_capital"] == null
            ? null
            : json["import_cost_of_capital"].toDouble(),
        importCountStock: json["import_count_stock"] == null
            ? null
            : json["import_count_stock"],
        importTotalAmount: json["import_total_amount"] == null
            ? null
            : json["import_total_amount"].toDouble(),
        exportCostOfCapital: json["export_cost_of_capital"] == null
            ? null
            : json["export_cost_of_capital"].toDouble(),
        exportImportPrice: json["export_import_price"] == null
            ? null
            : json["export_import_price"].toDouble(),
        exportCountStock: json["export_count_stock"] == null
            ? null
            : json["export_count_stock"],
        exportTotalAmount: json["export_total_amount"] == null
            ? null
            : json["export_total_amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "import_price": priceImport == null ? null : priceImport,
        "stock": stock == null ? null : stock,
        "quantity_in_stock": quantityInStock == null ? null : quantityInStock,
        "cost_of_capital": priceCapital == null ? null : priceCapital,
        "barcode": barcode == null ? null : barcode,
      };
}

class Inventory {
  Inventory({
    this.mainCostOfCapital,
    this.mainStock,
    this.distributes,
  });

  double? mainCostOfCapital;
  int? mainStock;
  List<Distributes>? distributes;

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        mainCostOfCapital: json["main_cost_of_capital"] == null
            ? null
            : json["main_cost_of_capital"].toDouble(),
        mainStock: json["main_stock"] == null ? null : json["main_stock"],
        distributes: json["distributes"] == null
            ? null
            : List<Distributes>.from(
                json["distributes"].map((x) => Distributes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "main_cost_of_capital":
            mainCostOfCapital == null ? null : mainCostOfCapital,
        "main_stock": mainStock == null ? null : mainStock,
        "distributes": distributes == null
            ? null
            : List<dynamic>.from(distributes!.map((x) => x.toJson())),
      };
}

class DistributeStock {
  DistributeStock({
    this.id,
    this.name,
    this.subElementDistributeName,
    this.elementDistributes,
  });

  int? id;
  String? name;
  String? subElementDistributeName;
  List<ElementDistributes>? elementDistributes;

  factory DistributeStock.fromJson(Map<String, dynamic> json) =>
      DistributeStock(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        subElementDistributeName: json["sub_element_distribute_name"] == null
            ? null
            : json["sub_element_distribute_name"],
        elementDistributes: json["element_distributes"] == null
            ? null
            : List<ElementDistributes>.from(json["element_distributes"]
                .map((x) => ElementDistributes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "sub_element_distribute_name":
            subElementDistributeName == null ? null : subElementDistributeName,
        "element_distributes": elementDistributes == null
            ? null
            : List<dynamic>.from(elementDistributes!.map((x) => x.toJson())),
      };
}

class ImportExport {
  ImportExport({
    this.id,
    this.name,
    this.subElementDistributeName,
    this.elementDistributes,
  });

  int? id;
  String? name;
  String? subElementDistributeName;
  List<ElementDistributes>? elementDistributes;

  factory ImportExport.fromJson(Map<String, dynamic> json) => ImportExport(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        subElementDistributeName: json["sub_element_distribute_name"] == null
            ? null
            : json["sub_element_distribute_name"],
        elementDistributes: json["element_distributes"] == null
            ? null
            : List<ElementDistributes>.from(json["element_distributes"]
                .map((x) => ElementDistributes.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "sub_element_distribute_name":
            subElementDistributeName == null ? null : subElementDistributeName,
        "element_distributes": elementDistributes == null
            ? null
            : List<dynamic>.from(elementDistributes!.map((x) => x.toJson())),
      };
}