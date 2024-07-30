class CheckInLocation {
  CheckInLocation({
    this.id,
    this.storeId,
    this.branchId,
    this.name,
    this.wifiName,
    this.wifiMac,
    this.wifiIp,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  int? branchId;
  String? name;
  String? wifiName;
  String? wifiMac;
  String? wifiIp;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CheckInLocation.fromJson(Map<String, dynamic> json) => CheckInLocation(
    id: json["id"] == null ? null : json["id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    branchId: json["branch_id"] == null ? null : json["branch_id"],
    name: json["name"] == null ? null : json["name"],
    wifiName: json["wifi_name"] == null ? null : json["wifi_name"],
    wifiMac: json["wifi_mac"] == null ? null : json["wifi_mac"],
    wifiIp: json["wifi_ip"] == null ? null : json["wifi_ip"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "wifi_name": wifiName == null ? null : wifiName,
    "wifi_mac": wifiMac == null ? null : wifiMac,
    "wifi_ip": wifiIp == null ? null : wifiIp,
  };
}