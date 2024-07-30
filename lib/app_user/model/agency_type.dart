class AgencyType {
  AgencyType({
    this.id,
    this.storeId,
    this.name,
    this.position,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  String? name;
  dynamic position;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AgencyType.fromJson(Map<String, dynamic> json) => AgencyType(
    id: json["id"] == null ? null : json["id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    name: json["name"] == null ? null : json["name"],
    position: json["position"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "store_id": storeId == null ? null : storeId,
    "name": name == null ? null : name,
    "position": position,
  };
}
