import 'package:com.ikitech.store/app_user/model/lesson.dart';

class Chapter {
  Chapter({
    this.id,
    this.storeId,
    this.trainCourseId,
    this.title,
    this.shortDescription,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.lessons,
  });

  int? id;
  int? storeId;
  int? trainCourseId;
  String? title;
  String? shortDescription;
  int? position;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Lesson>? lessons;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        trainCourseId:
            json["train_course_id"] == null ? null : json["train_course_id"],
        title: json["title"] == null ? null : json["title"],
        shortDescription: json["short_description"] == null
            ? null
            : json["short_description"],
        position: json["position"] == null ? null : json["position"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        lessons: json["lessons"] == null
            ? null
            : List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "train_course_id": trainCourseId == null ? null : trainCourseId,
        "title": title == null ? null : title,
        "short_description": shortDescription == null ? null : shortDescription,
      };
}
