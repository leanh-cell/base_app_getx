class Lesson {
  Lesson({
    this.id,
    this.storeId,
    this.trainChapterId,
    this.title,
    this.shortDescription,
    this.description,
    this.linkVideoYoutube,
    this.position,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  int? trainChapterId;
  String? title;
  String? shortDescription;
  String? description;
  String? linkVideoYoutube;
  int? position;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        trainChapterId:
            json["train_chapter_id"] == null ? null : json["train_chapter_id"],
        title: json["title"] == null ? null : json["title"],
        shortDescription: json["short_description"] == null
            ? null
            : json["short_description"],
        description: json["description"] == null ? null : json["description"],
        linkVideoYoutube: json["link_video_youtube"] == null
            ? null
            : json["link_video_youtube"],
        position: json["position"] == null ? null : json["position"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "train_chapter_id": trainChapterId == null ? null : trainChapterId,
        "title": title == null ? null : title,
        "short_description": shortDescription == null ? null : shortDescription,
        "description": description == null ? null : description,
        "link_video_youtube":
            linkVideoYoutube == null ? null : linkVideoYoutube,
        "position": position == null ? null : position,

      };
}
