

class Shipment {
  Shipment({
    this.id,
    this.name,
    this.shipperConfig,this.imageUrl
  });

  int? id;
  String? name;
  ShipperConfig? shipperConfig;
  String? imageUrl;

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        id: json["id"],
        name: json["name"],
        shipperConfig: json["shipper_config"] == null
            ? null
            : ShipperConfig.fromJson(json["shipper_config"]),
        imageUrl: json["image_url"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "shipper_config": shipperConfig!.toJson(),
      };
}

class ShipperConfig {
  ShipperConfig({
    this.partnerId,
    this.token,
    this.use,
    this.cod,
    this.createdAt,
    this.updatedAt,
  });

  int? partnerId;
  String? token;
  bool? use;
  bool? cod;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ShipperConfig.fromJson(Map<String, dynamic> json) => ShipperConfig(
        partnerId: json["partner_id"],
        token: json["token"],
        use: json["use"],
        cod: json["cod"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "use": use,
        "cod": cod,
      };
}
