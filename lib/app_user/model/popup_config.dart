class PopupCf {
  PopupCf({
    this.id,
    this.storeId,
    this.name,
    this.linkImage,
    this.showOnce = false,
    this.typeAction,
    this.valueAction,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  String? name;
  String? linkImage;
  bool? showOnce;
  String? typeAction;
  String? valueAction;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PopupCf.fromJson(Map<String, dynamic> json) => PopupCf(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        name: json["name"] == null ? null : json["name"],
        linkImage: json["link_image"] == null ? null : json["link_image"],
        showOnce: json["show_once"] == null ? null : json["show_once"],
        typeAction: json["type_action"] == null ? null : json["type_action"],
        valueAction: json["value_action"] == null ? null : json["value_action"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "name": "$name",
        "type_action": typeAction,
        "link_image": linkImage,
        "value_action": valueAction,
        "show_once": showOnce,
      };
}
