class CalculateFeeOrderRes {
  CalculateFeeOrderRes({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  CalculateFeeOder? data;
  String? msgCode;
  String? msg;

  factory CalculateFeeOrderRes.fromJson(Map<String, dynamic> json) =>
      CalculateFeeOrderRes(
        code: json["code"],
        success: json["success"],
        data: json["data"] == null
            ? null
            : CalculateFeeOder.fromJson(json["data"]),
        msgCode: json["msg_code"],
        msg: json["msg"],
      );
}

class CalculateFeeOder {
  CalculateFeeOder({
    this.info,
    this.data,
  });

  String? info;
  List<ItemFee>? data;

  factory CalculateFeeOder.fromJson(Map<String, dynamic> json) =>
      CalculateFeeOder(
        info: json["info"],
        data: json["data"] == null
            ? []
            : List<ItemFee>.from(json["data"]!.map((x) => ItemFee.fromJson(x))),
      );
}

class ItemFee {
  ItemFee({
    this.partnerId,
    this.fee,
    this.name,
    this.use,
    this.shipType,
  });

  int? partnerId;
  double? fee;
  String? name;
  bool? use;
  int? shipType;

  factory ItemFee.fromJson(Map<String, dynamic> json) => ItemFee(
        partnerId: json["partner_id"],
        fee: json["fee"] == null ? null : json["fee"].toDouble(),
        name: json["name"],
        use: json["use"],
        shipType: json["ship_type"],
      );
}
