class ProfileUser {
  ProfileUser({
    this.id,
    this.phoneNumber,
    this.areaCode,
    this.createMaximumStore,
    this.phoneVerifiedAt,
    this.email,
    this.emailVerifiedAt,
    this.name,
    this.dateOfBirth,
    this.avatarImage,
    this.score,
    this.sex,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? phoneNumber;
  String? areaCode;
  int? createMaximumStore;
  int? phoneVerifiedAt;
  String? email;
  String? emailVerifiedAt;
  String? name;
  DateTime? dateOfBirth;
  String? avatarImage;
  int? score;
  int? sex;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ProfileUser.fromJson(Map<String, dynamic> json) => ProfileUser(
        id: json["id"] == null ? null : json["id"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        areaCode: json["area_code"] == null ? null : json["area_code"],
        createMaximumStore: json["create_maximum_store"] == null
            ? null
            : json["create_maximum_store"],
        phoneVerifiedAt: json["phone_verified_at"] == null
            ? null
            : json["phone_verified_at"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        name: json["name"] == null ? null : json["name"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        avatarImage: json["avatar_image"] == null ? null : json["avatar_image"],
        score: json["score"] == null ? null : json["score"],
        sex: json["sex"] == null ? null : json["sex"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "area_code": areaCode == null ? null : areaCode,
        "create_maximum_store":
            createMaximumStore == null ? null : createMaximumStore,
        "phone_verified_at": phoneVerifiedAt,
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt,
        "name": name == null ? null : name,
        "date_of_birth": dateOfBirth,
        "avatar_image": avatarImage == null ? null : avatarImage,
        "score": score,
        "sex": sex,
      };
}
