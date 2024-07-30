
class TypeShopResponse {
  TypeShopResponse({
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
  List<DataTypeShop>?  data;

  factory TypeShopResponse.fromJson(Map<String, dynamic> json) => TypeShopResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<DataTypeShop>.from(json["data"].map((x) => DataTypeShop.fromJson(x))),
  );

}


class DataTypeShop {
  DataTypeShop({
    this.id,
    this.name,
    this.childs,
  });

  int? id;
  String? name;
  List<Child>? childs;

  factory DataTypeShop.fromJson(Map<String, dynamic> json) => DataTypeShop(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    childs: json["childs"] == null ? null : List<Child>.from(json["childs"].map((x) => Child.fromJson(x))),
  );

}


class Child {
  Child({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

}
