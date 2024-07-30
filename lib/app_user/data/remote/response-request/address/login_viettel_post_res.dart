class LoginViettelPostRes {
  LoginViettelPostRes({
    this.code,
    this.success,
    this.data,
    this.msgCode,
  });

  int? code;
  bool? success;
  LoginViettelPost? data;
  String? msgCode;

  factory LoginViettelPostRes.fromJson(Map<String, dynamic> json) =>
      LoginViettelPostRes(
        code: json["code"],
        success: json["success"],
        data: json["data"] == null
            ? null
            : LoginViettelPost.fromJson(json["data"]),
      );
}

class LoginViettelPost {
  String? token;
  LoginViettelPost({this.token});

  factory LoginViettelPost.fromJson(Map<String, dynamic> json) =>
      LoginViettelPost(token: json["token"]);
}
