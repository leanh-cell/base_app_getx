import 'agency.dart';

class HistoryCheckIn {
    int? id;
    int? storeId;
    int? staffId;
    bool? isAgencyOpen;
    int? agencyId;
    DateTime? timeCheckin;
    DateTime? timeCheckout;
    int? timeVisit;
    double? latitude;
    double? longitude;
    double? latCheckout;
    double? longCheckout;
    String? note;
    String? deviceName;
    String? addressCheckin;
    List<String>? images;
    DateTime? createdAt;
    DateTime? updatedAt;
    Agency? agency;

    HistoryCheckIn({
        this.id,
        this.storeId,
        this.staffId,
        this.isAgencyOpen,
        this.agencyId,
        this.timeCheckin,
        this.timeCheckout,
        this.timeVisit,
        this.latitude,
        this.longitude,
        this.latCheckout,
        this.longCheckout,
        this.note,
        this.deviceName,
        this.images,
        this.createdAt,
        this.updatedAt,
        this.agency,this.addressCheckin
    });

    factory HistoryCheckIn.fromJson(Map<String, dynamic> json) => HistoryCheckIn(
        id: json["id"],
        storeId: json["store_id"],
        staffId: json["staff_id"],
        isAgencyOpen: json["is_agency_open"],
        agencyId: json["agency_id"],
        timeCheckin: json["time_checkin"] == null ? null : DateTime.parse(json["time_checkin"]),
        timeCheckout: json["time_checkout"] == null ? null : DateTime.parse(json["time_checkout"]),
        timeVisit: json["time_visit"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        latCheckout: json["lat_checkout"]?.toDouble(),
        longCheckout: json["long_checkout"]?.toDouble(),
        note: json["note"],
        deviceName: json["device_name"],
        addressCheckin : json["address_checkin"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        agency: json["agency"] == null ? null : Agency.fromJson(json["agency"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "store_id": storeId,
        "staff_id": staffId,
        "is_agency_open": isAgencyOpen,
        "agency_id": agencyId,
        "time_checkin": timeCheckin?.toIso8601String(),
        "time_checkout": timeCheckout?.toIso8601String(),
        "time_visit": timeVisit,
        "latitude": latitude,
        "longitude": longitude,
        "lat_checkout": latCheckout,
        "long_checkout": longCheckout,
        "note": note,
        
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "agency": agency?.toJson(),
    };
}