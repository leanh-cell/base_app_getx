import 'staff.dart';

class Device {
  Device({
    this.id,
    this.storeId,
    this.branchId,
    this.staffId,
    this.staff,
    this.name,
    this.deviceId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  int? branchId;
  int? staffId;
  Staff? staff;
  String? name;
  String? deviceId;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        staffId: json["staff_id"] == null ? null : json["staff_id"],
        staff: json["staff"] == null ? null : Staff.fromJson(json["staff"]),
        name: json["name"] == null ? null : json["name"],
        deviceId: json["device_id"] == null ? null : json["device_id"],
        status: json["status"] == null ? null : json["status"],
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
        "branch_id": branchId == null ? null : branchId,
        "staff_id": staffId == null ? null : staffId,
        "name": name == null ? null : name,
        "device_id": deviceId == null ? null : deviceId,
        "status": status == null ? null : status,
      };
}