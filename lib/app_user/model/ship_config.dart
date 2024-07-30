class ShipConfig {
  ShipConfig({
    this.id,
    this.storeId,
    this.isCalculateShip,
    this.useFeeFromPartnership,
    this.useFeeFromDefault,
    this.urbanListIdProvince,
    this.urbanListNameProvince,
    this.feeUrban,
    this.feeSuburban,
    this.feeDefaultDescription,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  bool? isCalculateShip;
  bool? useFeeFromPartnership;
  bool? useFeeFromDefault;
  String? feeDefaultDescription;
  List<int>? urbanListIdProvince;
  List<String>? urbanListNameProvince;
  double? feeUrban;
  double? feeSuburban;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ShipConfig.fromJson(Map<String, dynamic> json) => ShipConfig(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        isCalculateShip: json["is_calculate_ship"] == null
            ? null
            : json["is_calculate_ship"],
        useFeeFromPartnership: json["use_fee_from_partnership"] == null
            ? null
            : json["use_fee_from_partnership"],
    useFeeFromDefault: json["use_fee_from_default"] == null
            ? null
            : json["use_fee_from_default"],
    feeDefaultDescription: json["fee_default_description"] == null
            ? null
            : json["fee_default_description"],
        urbanListIdProvince: json["urban_list_id_province"] == null
            ? null
            : List<int>.from(json["urban_list_id_province"].map((x) => x)),
        urbanListNameProvince: json["urban_list_name_province"] == null
            ? null
            : List<String>.from(json["urban_list_name_province"].map((x) => x)),
        feeUrban:
            json["fee_urban"] == null ? null : json["fee_urban"].toDouble(),
        feeSuburban: json["fee_suburban"] == null
            ? null
            : json["fee_suburban"].toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "is_calculate_ship": isCalculateShip == null ? null : isCalculateShip,
        "use_fee_from_default": useFeeFromDefault == null ? null : useFeeFromDefault,
        "fee_default_description": feeDefaultDescription == null ? null : feeDefaultDescription,
        "use_fee_from_partnership":
            useFeeFromPartnership == null ? null : useFeeFromPartnership,
        "urban_list_id_province":
            urbanListIdProvince == null ? null : urbanListIdProvince,
        "urban_list_name_province":
            urbanListNameProvince == null ? null : urbanListNameProvince,
        "fee_urban": feeUrban == null ? null : feeUrban,
        "fee_suburban": feeSuburban == null ? null : feeSuburban,
      };
}
