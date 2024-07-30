import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.code,
    this.data,
  });

  int? code;
  DataLogin? data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    code: json["code"],
    data: DataLogin.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data!.toJson(),
  };
}

class DataLogin {
  DataLogin({
    this.id,
    this.token,
    this.refreshToken,
    this.tokenExpried,
    this.refreshTokenExpried,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? token;
  String? refreshToken;
  DateTime? tokenExpried;
  DateTime? refreshTokenExpried;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DataLogin.fromJson(Map<String, dynamic> json) => DataLogin(
    id: json["id"],
    token: json["token"],
    refreshToken: json["refresh_token"],
    tokenExpried: DateTime.parse(json["token_expried"]),
    refreshTokenExpried: DateTime.parse(json["refresh_token_expried"]),
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
    "refresh_token": refreshToken,
    "token_expried": tokenExpried!.toIso8601String(),
    "refresh_token_expried": refreshTokenExpried!.toIso8601String(),
    "user_id": userId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}