class ConfigSale {
  ConfigSale({
    this.id,
    this.storeId,
    this.allowSale,
    this.typeBonusPeriod,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  bool? allowSale;
  int? typeBonusPeriod;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ConfigSale.fromJson(Map<String, dynamic> json) => ConfigSale(
    id: json["id"],
    storeId: json["store_id"],
    allowSale: json["allow_sale"],
    typeBonusPeriod: json["type_bonus_period"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "allow_sale": allowSale,
    "type_bonus_period": typeBonusPeriod,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}