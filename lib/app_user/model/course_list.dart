class CourseList {
  CourseList({
    this.id,
    this.storeId,
    this.title,
    this.shortDescription,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  String? title;
  String? shortDescription;
  String? description;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CourseList.fromJson(Map<String, dynamic> json) => CourseList(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        title: json["title"] == null ? null : json["title"],
        shortDescription: json["short_description"] == null
            ? null
            : json["short_description"],
        description: json["description"] == null ? null : json["description"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "title": title == null ? null : title,
        "short_description": shortDescription == null ? null : shortDescription,
        "description": description == null ? null : description,
        "image_url": imageUrl == null ? null : imageUrl,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
