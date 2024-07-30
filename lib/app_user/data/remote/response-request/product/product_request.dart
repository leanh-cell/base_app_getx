import 'dart:convert';

import 'package:sahashop_customer/app_customer/model/product.dart';



class ProductRequest {
  ProductRequest({
    this.description,
    this.name,
    this.indexImageAvatar,
    this.price,
    this.priceImport,
    this.checkInventory,
    this.priceCapital,
    this.priceDefault,
    this.barcode,
    this.sku,
    this.status = 0,
    this.mainStock,
    this.images,
    this.listDistribute,
    this.listAttribute,
    this.categories,
    this.categoriesChild,
    this.percentCollaborator,
    this.contentForCollaborator,
    this.inventory,
    this.pointForAgency,
    this.weight,
    this.shelfPosition,
    this.typeShareCollaboratorNumber,
    this.moneyAmountCollaborator,this.isMedicine,this.videoUrl,this.isProductRetailStep,this.productRetailSteps
  });

  String? description;
  String? name;
  String? shelfPosition;
  int? indexImageAvatar;
  bool? checkInventory;
  double? price;
  double? priceImport;
  double? priceCapital;
  double? priceDefault;
  String? barcode;
  String? sku;
  double? weight;
  int? status;
  int? mainStock;
  List<String>? images;
  List<DistributesRequest>? listDistribute;
  List<ListAttribute>? listAttribute;
  List<int>? categories;
  List<int>? categoriesChild;
  double? percentCollaborator;
  int? pointForAgency;
  String? contentForCollaborator;
  Inventory? inventory;
  int? typeShareCollaboratorNumber;
  double? moneyAmountCollaborator;
  bool? isMedicine;
  String? videoUrl;
  bool? isProductRetailStep;
  List<ProductRetailStep>? productRetailSteps;

  factory ProductRequest.fromJson(Map<String, dynamic> json) => ProductRequest(
        typeShareCollaboratorNumber: json["type_share_collaborator_number"],
        moneyAmountCollaborator: json["money_amount_collaborator"]?.toDouble(),
        description: json["description"] == null ? null : json["description"],
        name: json["name"] == null ? null : json["name"],
        shelfPosition:
            json["shelf_position"] == null ? null : json["shelf_position"],
        indexImageAvatar: json["index_image_avatar"] == null
            ? null
            : json["index_image_avatar"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
        priceCapital: json["main_cost_of_capital"] == null
            ? null
            : json["main_cost_of_capital"].toDouble(),
        priceDefault: json["default_price"] == null
            ? null
            : json["default_price"].toDouble(),
        priceImport: json["import_price"] == null
            ? null
            : json["import_price"].toDouble(),
        barcode: json["barcode"] == null ? null : json["barcode"],
        pointForAgency:
            json["point_for_agency"] == null ? null : json["point_for_agency"],
        sku: json["sku"] == null ? null : json["sku"],
        status: json["status"] == null ? null : json["status"],
        mainStock: json["main_stock"] == null ? null : json['main_stock'],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        listDistribute: json["list_distribute"] == null
            ? null
            : List<DistributesRequest>.from(json["list_distribute"]
                .map((x) => DistributesRequest.fromJson(x))),
        listAttribute: json["list_attribute"] == null
            ? null
            : List<ListAttribute>.from(
                json["list_attribute"].map((x) => ListAttribute.fromJson(x))),
        categories: json["categories"] == null
            ? null
            : List<int>.from(json["categories"].map((x) => x)),
        categoriesChild: json["category_children_ids"] == null
            ? null
            : List<int>.from(json["category_children_ids"].map((x) => x)),
        percentCollaborator: json["percent_collaborator"] == null
            ? null
            : json["percent_collaborator"],
        contentForCollaborator: json["content_for_collaborator"] == null
            ? null
            : json["content_for_collaborator"],
        inventory: json["inventory"] == null
            ? null
            : Inventory.fromJson(json["inventory"]),
        isMedicine: json['is_medicine'],
        videoUrl: json["video_url"],
        isProductRetailStep: json["is_product_retail_step"],
      productRetailSteps: json["product_retail_steps"] == null ? [] : List<ProductRetailStep>.from(json["product_retail_steps"].map((x) => ProductRetailStep.fromJson(x))),
      );

  factory ProductRequest.fromProduct(Product product) {
    List<ListAttribute> listAttributeRequest = [];
    product.attributes!.forEach((key) {
      if (key != null) {
        listAttributeRequest
            .add(ListAttribute(name: key.name, value: key.value));
      }
    });

    List<DistributesRequest> listDistribute = [];
    if (product.distributes != null) {
      listDistribute.addAll(product.distributes!.map((listDistribute) {
        bool boolHasImage = false;

        for (var elementDistribute in listDistribute.elementDistributes!) {
          if (elementDistribute.imageUrl != null) {
            boolHasImage = true;
          }
        }

        return DistributesRequest(
            boolHasImage: boolHasImage,
            name: listDistribute.name,
            elementDistributes: listDistribute.elementDistributes!
                .map((e) => ElementDistributesRequest(
                    name: e.name,
                    imageUrl: e.imageUrl,
                    priceCapital: e.priceCapital,
                    stock: e.stock,
                    price: e.price))
                .toList());
      }).toList());
    }

    return ProductRequest(
      description: product.description,
      name: product.name,
      shelfPosition: product.shelfPosition,
      indexImageAvatar: product.indexImageAvatar,
      price: product.price,
      priceImport: product.priceImport,
      barcode: product.barcode,
      sku: product.sku,
      status: product.status,
      mainStock: product.mainStock,
      images: product.images!.map((e) => e.imageUrl!).toList(),
      listDistribute: listDistribute,
      listAttribute: listAttributeRequest,
      categories: product.categories!.map((e) => e.id!).toList(),
      percentCollaborator: product.percentCollaborator,
      contentForCollaborator: product.contentForCollaborator,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type_share_collaborator_number": typeShareCollaboratorNumber,
      "money_amount_collaborator": moneyAmountCollaborator,
      "description": description,
      "name": name,
      "shelf_position": shelfPosition,
      "index_image_avatar": indexImageAvatar,
      "price": price,
      "weight": weight,
      "default_price": priceDefault,
      "import_price": priceImport,
      "main_cost_of_capital": priceCapital,
      "barcode": barcode,
      "sku": sku,
      "status": status ?? 0,
      "main_stock": mainStock,
      "images": images!,
      "check_inventory": checkInventory ?? false,
      "point_for_agency": pointForAgency,
      "list_distribute": listDistribute == null
          ? null
          : List<dynamic>.from(listDistribute!.map((x) => x.toJson())),
      "list_attribute": listAttribute == null
          ? null
          : List<dynamic>.from(listAttribute!.map((x) => x.toJson())),
      "categories": categories == null
          ? null
          : List<dynamic>.from(categories!.map((x) => x)),
      "category_children_ids": categoriesChild == null
          ? null
          : List<dynamic>.from(categoriesChild!.map((x) => x)),
      "percent_collaborator": percentCollaborator,
      "content_for_collaborator": contentForCollaborator,
      "is_medicine":isMedicine,
      "video_url":videoUrl,
      "is_product_retail_step":isProductRetailStep,
      "product_retail_steps": productRetailSteps == null
            ? null
            : List<dynamic>.from(productRetailSteps!.map((x) => x.toJson())),
    };
  }
}

class ListAttribute {
  ListAttribute({
    this.name,
    this.value,
  });

  String? name;
  String? value;

  factory ListAttribute.fromJson(Map<String, dynamic> json) => ListAttribute(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}

class DistributesRequest {
  int? id;
  bool? isNew;
  String? name;
  String? subElementDistributeName;
  bool? boolHasImage;
  bool? hasDistribute;
  bool? hasSub;
  String? createdAt;
  String? updatedAt;
  List<ElementDistributesRequest?>? elementDistributes;

  DistributesRequest(
      {this.id,
      this.name,
      this.hasSub,
      this.hasDistribute,
      this.subElementDistributeName,
      this.createdAt,
      this.boolHasImage = false,
      this.updatedAt,
      this.elementDistributes});

  DistributesRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subElementDistributeName = json['sub_element_distribute_name'] == null
        ? null
        : json['sub_element_distribute_name'];
    hasSub = json["has_sub"] == null ? null : json["has_sub"];
    hasDistribute =
        json["has_distribute"] == null ? null : json["has_distribute"];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['element_distributes'] != null) {
      elementDistributes = [];
      json['element_distributes'].forEach((v) {
        elementDistributes!.add(new ElementDistributesRequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['distribute_name'] = this.name;
    data['name'] = this.name;
    data['has_sub'] = this.hasSub;
    data['has_distribute'] = this.hasDistribute;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['sub_element_distribute_name'] = this.subElementDistributeName;
    if (this.elementDistributes != null) {
      data['element_distributes'] =
          this.elementDistributes!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class ElementDistributesRequest {
  int? id;
  bool? isEdit;
  String? name;
  String? beforeName;
  String? imageUrl;
  double? price;
  double? priceImport;
  double? priceCapital;
  double? defaultPrice;
  int? stock;
  String? sku;
  int? quantityInStock;
  String? barcode;
  List<SubElementDistributeRequest>? subElementDistribute;
  String? createdAt;
  String? updatedAt;

  ElementDistributesRequest(
      {this.id,
      this.isEdit,
      this.name,
      this.beforeName,
      this.imageUrl,
      this.price,
      this.priceImport,
      this.priceCapital,
      this.defaultPrice,
      this.stock,
      this.quantityInStock,
      this.subElementDistribute,
      this.barcode,this.sku,
      this.createdAt,
      this.updatedAt});

  ElementDistributesRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isEdit = json["is_edit"] == null ? null : json["is_edit"];
    name = json['name'];
    beforeName = json['before_name'];
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
        : List<SubElementDistributeRequest>.from(json["sub_element_distributes"]
            .map((x) => SubElementDistributeRequest.fromJson(x)));
    sku = json["sku"];
    barcode = json["barcode"] == null ? null : json["barcode"];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['before_name'] = this.beforeName;
    data['image_url'] = this.imageUrl;
    data['price'] = this.price ?? 0;
    data['import_price'] = this.priceImport ?? 0;
    data['cost_of_capital'] = this.priceCapital ?? 0;
    data['default_price'] = this.defaultPrice ?? 0;
    data['is_edit'] = this.isEdit;
    data['quantity_in_stock'] = this.quantityInStock ?? 0;
    data['stock'] = this.stock ?? 0;
    data['barcode'] = this.barcode ?? "";
    data['sub_element_distributes'] = this.subElementDistribute != null
        ? this.subElementDistribute!.map((v) => v.toJson()).toList()
        : null;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data["sku"] = this.sku;
    return data;
  }
}

class SubElementDistributeRequest {
  SubElementDistributeRequest({
    this.id,
    this.name,
    this.beforeName,
    this.isEdit,
    this.imageUrl,
    this.price,
    this.priceCapital,
    this.priceImport,
    this.defaultPrice,
    this.stock,
    this.quantityInStock,
    this.barcode,this.sku
  });

  int? id;
  String? name;
  String? beforeName;
  bool? isEdit;
  String? imageUrl;
  double? price;
  double? priceImport;
  double? defaultPrice;
  double? priceCapital;
  int? stock;
  int? quantityInStock;
  String? barcode;
  String? sku;

  factory SubElementDistributeRequest.fromJson(Map<String, dynamic> json) =>
      SubElementDistributeRequest(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        beforeName: json["before_name"] == null ? null : json["before_name"],
        isEdit: json["is_edit"] == null ? null : json["is_edit"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        priceCapital: json["cost_of_capital"] == null
            ? null
            : json["cost_of_capital"].toDouble(),
        priceImport: json["import_price"] == null
            ? null
            : json["import_price"].toDouble(),
        defaultPrice: json["default_price"] == null
            ? null
            : json["default_price"].toDouble(),
        stock: json["stock"] == null ? null : json["stock"],
        quantityInStock: json["quantity_in_stock"] == null
            ? null
            : json["quantity_in_stock"],
        barcode: json["barcode"] == null ? null : json["barcode"],
        sku: json["sku"]
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "before_name": beforeName == null ? null : beforeName,
        "is_edit": isEdit == null ? null : isEdit,
        "image_url": imageUrl == null ? null : imageUrl,
        "price": price == null ? 0 : price,
        "cost_of_capital": priceCapital == null ? 0 : priceCapital,
        "import_price": priceImport == null ? 0 : priceImport,
        "default_price": defaultPrice == null ? 0 : defaultPrice,
        "stock": stock == null ? 0 : stock,
        "quantity_in_stock": quantityInStock == null ? 0 : quantityInStock,
        "barcode": barcode == null ? "" : barcode,
        "sku" : sku
      };
}

class Inventory {
  Inventory({
    this.mainCostOfCapital,
    this.mainStock,
    this.elementDistributesStock,
    this.subElementDistributesStock,
  });

  double? mainCostOfCapital;
  int? mainStock;
  List<ElementDistributesStock>? elementDistributesStock;
  List<SubElementDistributesStock>? subElementDistributesStock;

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        mainCostOfCapital: json["main_cost_of_capital"] == null
            ? null
            : json["main_cost_of_capital"].toDouble(),
        elementDistributesStock: json["element_distributes_stock"] == null
            ? null
            : List<ElementDistributesStock>.from(
                json["element_distributes_stock"]
                    .map((x) => ElementDistributesStock.fromJson(x))),
        subElementDistributesStock:
            json["sub_element_distributes_stock"] == null
                ? null
                : List<SubElementDistributesStock>.from(
                    json["sub_element_distributes_stock"]
                        .map((x) => SubElementDistributesStock.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "main_cost_of_capital":
            mainCostOfCapital == null ? null : mainCostOfCapital,
        "main_stock": mainStock == null ? null : mainStock,
        "element_distributes_stock": elementDistributesStock == null
            ? null
            : List<dynamic>.from(
                elementDistributesStock!.map((x) => x.toJson())),
        "sub_element_distributes_stock": subElementDistributesStock == null
            ? null
            : List<dynamic>.from(
                subElementDistributesStock!.map((x) => x.toJson())),
      };
}

class ElementDistributesStock {
  ElementDistributesStock({
    this.distributeName,
    this.elementDistribute,
    this.costOfCapital,
    this.stock,
  });

  String? distributeName;
  String? elementDistribute;
  double? costOfCapital;
  int? stock;

  factory ElementDistributesStock.fromJson(Map<String, dynamic> json) =>
      ElementDistributesStock(
        distributeName:
            json["distribute_name"] == null ? null : json["distribute_name"],
        elementDistribute: json["element_distribute"] == null
            ? null
            : json["element_distribute"],
        costOfCapital: json["cost_of_capital"] == null
            ? null
            : json["cost_of_capital"].toDouble(),
        stock: json["stock"] == null ? null : json["stock"],
      );

  Map<String, dynamic> toJson() => {
        "distribute_name": distributeName == null ? null : distributeName,
        "element_distribute":
            elementDistribute == null ? null : elementDistribute,
        "cost_of_capital": costOfCapital == null ? null : costOfCapital,
        "stock": stock == null ? null : stock,
      };
}

class SubElementDistributesStock {
  SubElementDistributesStock({
    this.distributeName,
    this.elementDistribute,
    this.costOfCapital,
    this.stock,
    this.subElementDistribute,
  });

  String? distributeName;
  String? elementDistribute;
  double? costOfCapital;
  int? stock;
  String? subElementDistribute;

  factory SubElementDistributesStock.fromJson(Map<String, dynamic> json) =>
      SubElementDistributesStock(
        distributeName:
            json["distribute_name"] == null ? null : json["distribute_name"],
        elementDistribute: json["element_distribute"] == null
            ? null
            : json["element_distribute"],
        costOfCapital: json["cost_of_capital"] == null
            ? null
            : json["cost_of_capital"].toDouble(),
        stock: json["stock"] == null ? null : json["stock"],
        subElementDistribute: json["sub_element_distribute"] == null
            ? null
            : json["sub_element_distribute"],
      );

  Map<String, dynamic> toJson() => {
        "distribute_name": distributeName == null ? null : distributeName,
        "element_distribute":
            elementDistribute == null ? null : elementDistribute,
        "cost_of_capital": costOfCapital == null ? null : costOfCapital,
        "stock": stock == null ? null : stock,
        "sub_element_distribute":
            subElementDistribute == null ? null : subElementDistribute,
      };
}
