class ECommerce {
  ECommerce({
    this.id,
    this.storeId,
    this.platform,
    this.shopId,
    this.shopIsd,
    this.shopName,
    this.typeSyncProducts,
    this.typeSyncInventory,
    this.typeSyncOrders,
    this.customerName,
    this.customerPhone,
    this.expiryToken,
    this.token,
    this.refreshToken,
    this.tokenType,
    this.scope,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  String? platform;
  String? shopId;
  String? shopIsd;
  String? shopName;
  int? typeSyncProducts;
  int? typeSyncInventory;
  int? typeSyncOrders;
  String? customerName;
  String? customerPhone;
  DateTime? expiryToken;
  String? token;
  String? refreshToken;
  String? tokenType;
  String? scope;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ECommerce.fromJson(Map<String, dynamic> json) => ECommerce(
        id: json["id"],
        storeId: json["store_id"],
        platform: json["platform"],
        shopId: json["shop_id"],
        shopIsd: json["shop_isd"],
        shopName: json["shop_name"],
        typeSyncProducts: json["type_sync_products"],
        typeSyncInventory: json["type_sync_inventory"],
        typeSyncOrders: json["type_sync_orders"],
        customerName: json["customer_name"],
        customerPhone: json["customer_phone"],
        expiryToken: json["expiry_token"] == null
            ? null
            : DateTime.parse(json["expiry_token"]),
        token: json["token"],
        refreshToken: json["refresh_token"],
        tokenType: json["token_type"],
        scope: json["scope"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "platform": platform,
        "shop_id": shopId,
        "shop_isd": shopIsd,
        "shop_name": shopName,
        "type_sync_products": typeSyncProducts,
        "type_sync_inventory": typeSyncInventory,
        "type_sync_orders": typeSyncOrders,
        "customer_name": customerName,
        "customer_phone": customerPhone,
        "expiry_token": expiryToken?.toIso8601String(),
        "token": token,
        "refresh_token": refreshToken,
        "token_type": tokenType,
        "scope": scope,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
