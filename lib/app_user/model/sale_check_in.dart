class SaleCheckIn {
  int? storeId;
  int? staffId;
  int? agencyId;
  DateTime? timeCheckin;
  double? latitude;
  double? longitude;
  String? note;
  bool? isAgencyOpen;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  List<String>? images;
  double? latCheckout;
  double? longCheckout;
  DateTime? timeCheckout;
  String? addressCheckin;
  String? deviceName;

  SaleCheckIn(
      {this.storeId,
      this.staffId,
      this.agencyId,
      this.timeCheckin,
      this.latitude,
      this.longitude,
      this.note,
      this.isAgencyOpen,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.images,
      this.latCheckout,
      this.longCheckout,this.timeCheckout,this.addressCheckin,this.deviceName});

  factory SaleCheckIn.fromJson(Map<String, dynamic> json) => SaleCheckIn(
        storeId: json["store_id"],
        staffId: json["staff_id"],
        agencyId: json["agency_id"],
        timeCheckin: json["time_checkin"] == null
            ? null
            : DateTime.parse(json["time_checkin"]),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        note: json["note"],
        isAgencyOpen: json["is_agency_open"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        latCheckout: json["lat_checkout"] == null
            ? null
            : json["lat_checkout"].toDouble(),
        longCheckout: json["long_checkout"] == null
            ? null
            : json["long_checkout"].toDouble(),
        timeCheckout: json["time_checkout"] == null
            ? null
            : DateTime.parse(json["time_checkout"]),
        addressCheckin :json["address_checkin"],
        deviceName:json["device_name"]
      );

  Map<String, dynamic> toJson() => {
        "store_id": storeId,
        "staff_id": staffId,
        "agency_id": agencyId,
        "time_checkin": timeCheckin?.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "note": note,
        "is_agency_open": isAgencyOpen,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "lat_checkout": latCheckout,
        "long_checkout": longCheckout,
        "time_checkout":timeCheckout?.toIso8601String(),
        "address_checkin":addressCheckin,
        "device_name" : deviceName
      };
}
