class BonusLevel {
  BonusLevel({
    this.id,
    this.storeId,
    this.limit,
    this.bonus,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  int? limit;
  int? bonus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory BonusLevel.fromJson(Map<String, dynamic> json) => BonusLevel(
    id: json["id"] == null ? null : json["id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    limit: json["limit"] == null ? null : json["limit"],
    bonus: json["bonus"] == null ? null : json["bonus"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "limit": limit == null ? null : limit,
    "bonus": bonus == null ? null : bonus,
  };
}
