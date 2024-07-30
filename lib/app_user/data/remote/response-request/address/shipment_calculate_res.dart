import 'dart:convert';

ShipmentCalculateRes shipmentCalculateResFromJson(String str) => ShipmentCalculateRes.fromJson(json.decode(str));

String shipmentCalculateResToJson(ShipmentCalculateRes data) => json.encode(data.toJson());

class ShipmentCalculateRes {
  ShipmentCalculateRes({
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
  List<ShipmentCalculate>? data;

  factory ShipmentCalculateRes.fromJson(Map<String, dynamic> json) => ShipmentCalculateRes(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<ShipmentCalculate>.from(json["data"].map((x) => ShipmentCalculate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "msg_code": msgCode == null ? null : msgCode,
    "msg": msg == null ? null : msg,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ShipmentCalculate {
  ShipmentCalculate({
    this.partnerId,
    this.fee,
    this.name,
    this.description,
    this.shipperName,
    this.imageUrl,
    this.shipType,
  });

  String? partnerId;
  double? fee;
  String? name;
  String? description;
  String? shipperName;
  String? imageUrl;
  int? shipType;

  factory ShipmentCalculate.fromJson(Map<String, dynamic> json) => ShipmentCalculate(
    partnerId: json["partner_id"] == null ? null : json["partner_id"],
    fee: json["fee"] == null ? null : json["fee"].toDouble(),
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    shipperName: json["shipper_name"] == null ? null : json["shipper_name"],
    imageUrl: json["image_url"] == null ? null : json["image_url"],
    shipType: json["ship_type"] == null ? null : json["ship_type"],
  );

  Map<String, dynamic> toJson() => {
    "partner_id": partnerId == null ? null : partnerId,
    "fee": fee == null ? null : fee,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "shipper_name": shipperName == null ? null : shipperName,
    "image_url": imageUrl == null ? null : imageUrl,
    "ship_type": shipType == null ? null : shipType,
  };
}
