class ProductCommerce {
  ProductCommerce(
      {this.id,
      this.storeId,
      this.mainProductId,
      this.name,
      this.nameStrFilter,
      this.sku,
      this.videoUrl,
      this.description,
      this.likes,
      this.sold,
      this.view,
      this.indexImageAvatar,
      this.price,
      this.importPrice,
      this.checkInventory,
      this.quantityInStock,
      this.percentCollaborator,
      this.minPrice,
      this.maxPrice,
      this.barcode,
      this.status,
      this.jsonImages,
      this.seoTitle,
      this.seoDescription,
      this.fromPlatform,
      this.shopId,
      this.shopName,
      this.code,
      this.createdAt,
      this.updatedAt,
      this.slug,
      this.images,
      this.productIdInEcommerce,
      this.skuInEcommerce});

  int? id;
  int? storeId;
  dynamic mainProductId;
  String? name;
  String? nameStrFilter;
  String? sku;
  String? productIdInEcommerce;
  dynamic videoUrl;
  String? description;
  int? likes;
  int? sold;
  int? view;
  dynamic indexImageAvatar;
  double? price;
  double? importPrice;
  bool? checkInventory;
  int? quantityInStock;
  double? percentCollaborator;
  double? minPrice;
  double? maxPrice;
  dynamic barcode;
  int? status;
  String? jsonImages;
  dynamic seoTitle;
  dynamic seoDescription;
  String? fromPlatform;
  String? shopId;
  dynamic shopName;
  dynamic code;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? slug;
  List<String>? images;
  String? skuInEcommerce;

  factory ProductCommerce.fromJson(Map<String, dynamic> json) =>
      ProductCommerce(
          id: json["id"],
          storeId: json["store_id"],
          mainProductId: json["main_product_id"],
          name: json["name"],
          nameStrFilter: json["name_str_filter"],
          sku: json["sku"],
          videoUrl: json["video_url"],
          description: json["description"],
          likes: json["likes"],
          sold: json["sold"],
          view: json["view"],
          indexImageAvatar: json["index_image_avatar"],
          price: json["price"] == null ? null : json["price"].toDouble(),
          importPrice: json["import_price"] == null
              ? null
              : json["import_price"].toDouble(),
          checkInventory: json["check_inventory"],
          quantityInStock: json["quantity_in_stock"],
          percentCollaborator: json["percent_collaborator"] == null
              ? null
              : json["percent_collaborator"].toDouble(),
          minPrice:
              json["min_price"] == null ? null : json["min_price"].toDouble(),
          maxPrice:
              json["max_price"] == null ? null : json["max_price"].toDouble(),
          barcode: json["barcode"],
          status: json["status"],
          jsonImages: json["json_images"],
          seoTitle: json["seo_title"],
          seoDescription: json["seo_description"],
          fromPlatform: json["from_platform"],
          shopId: json["shop_id"],
          shopName: json["shop_name"],
          code: json["code"],
          createdAt: json["created_at"] == null
              ? null
              : DateTime.parse(json["created_at"]),
          updatedAt: json["updated_at"] == null
              ? null
              : DateTime.parse(json["updated_at"]),
          slug: json["slug"],
          images: json["images"] == null
              ? []
              : List<String>.from(json["images"]!.map((x) => x)),
          productIdInEcommerce: json['product_id_in_ecommerce'],
          skuInEcommerce: json['sku_in_ecommerce']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "main_product_id": mainProductId,
        "name": name,
        "name_str_filter": nameStrFilter,
        "sku": sku,
        "video_url": videoUrl,
        "description": description,
        "likes": likes,
        "sold": sold,
        "view": view,
        "index_image_avatar": indexImageAvatar,
        "price": price,
        "import_price": importPrice,
        "check_inventory": checkInventory,
        "quantity_in_stock": quantityInStock,
        "percent_collaborator": percentCollaborator,
        "min_price": minPrice,
        "max_price": maxPrice,
        "barcode": barcode,
        "status": status,
        "json_images": jsonImages,
        "seo_title": seoTitle,
        "seo_description": seoDescription,
        "from_platform": fromPlatform,
        "shop_id": shopId,
        "shop_name": shopName,
        "code": code,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "slug": slug,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        'product_id_in_ecommerce': productIdInEcommerce,
        'sku_in_ecommerce': skuInEcommerce
      };
}
