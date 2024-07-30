import 'dart:convert';

ReviewDeleteResponse reviewDeleteResponseFromJson(String str) =>
    ReviewDeleteResponse.fromJson(json.decode(str));

String reviewDeleteResponseToJson(ReviewDeleteResponse data) =>
    json.encode(data.toJson());

class ReviewDeleteResponse {
  ReviewDeleteResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  Data? data;

  factory ReviewDeleteResponse.fromJson(Map<String, dynamic> json) =>
      ReviewDeleteResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "msg_code": msgCode == null ? null : msgCode,
        "msg": msg == null ? null : msg,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.idDeleted,
  });

  int? idDeleted;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idDeleted: json["idDeleted"] == null ? null : json["idDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "idDeleted": idDeleted == null ? null : idDeleted,
      };
}
