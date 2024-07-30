import 'dart:convert';

DeleteAddressStoreResponse deleteAddressStoreResponseFromJson(String str) =>
    DeleteAddressStoreResponse.fromJson(json.decode(str));

String deleteAddressStoreResponseToJson(DeleteAddressStoreResponse data) =>
    json.encode(data.toJson());

class DeleteAddressStoreResponse {
  DeleteAddressStoreResponse({
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

  factory DeleteAddressStoreResponse.fromJson(Map<String, dynamic> json) =>
      DeleteAddressStoreResponse(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
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
