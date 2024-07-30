// To parse this JSON data, do
//
//     final deleteDiscountResponse = deleteDiscountResponseFromJson(jsonString);

import 'dart:convert';

DeleteProgramResponse deleteDiscountResponseFromJson(String str) =>
    DeleteProgramResponse.fromJson(json.decode(str));

String deleteDiscountResponseToJson(DeleteProgramResponse data) =>
    json.encode(data.toJson());

class DeleteProgramResponse {
  DeleteProgramResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  Data? data;

  factory DeleteProgramResponse.fromJson(Map<String, dynamic> json) =>
      DeleteProgramResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.idDeleted,
  });

  int? idDeleted;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idDeleted: json["idDeleted"],
      );

  Map<String, dynamic> toJson() => {
        "idDeleted": idDeleted,
      };
}
