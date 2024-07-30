class LoginVietNamPostRes {
  LoginVietNamPostRes({
    this.code,
    this.success,
    this.data,
    this.msgCode,
  });

  int? code;
  bool? success;
  LoginVietNamPost? data;
  String? msgCode;

  factory LoginVietNamPostRes.fromJson(Map<String, dynamic> json) =>
      LoginVietNamPostRes(
        code: json["code"],
        success: json["success"],
        data: json["data"] == null
            ? null
            : LoginVietNamPost.fromJson(json["data"]),
      );
}

class LoginVietNamPost {
  String? token;
  LoginVietNamPost({this.token});

  factory LoginVietNamPost.fromJson(Map<String, dynamic> json) =>
      LoginVietNamPost(token: json["token"]);
}
