
import 'package:com.ikitech.store/app_user/model/staff.dart';

class HistoryCheckInCheckout {
  HistoryCheckInCheckout({
    this.id,
    this.checkoutForCheckinId,
    this.storeId,
    this.branchId,
    this.staffId,
    this.staff,
    this.dateTimekeepingId,
    this.timeCheck,
    this.isCheckin,
    this.status,
    this.note,
    this.date,
    this.reason,
    this.wifiName,
    this.wifiMac,
    this.wifiIp,
    this.remoteTimekeeping,
    this.fromUser,
    this.isBonus,
    this.createdAt,
    this.updatedAt,
    this.fromStaffCreated,
    this.fromUserCreated,
  });

  int? id;
  int? checkoutForCheckinId;
  int? storeId;
  int? branchId;
  int? staffId;
  Staff? staff;
  int? dateTimekeepingId;
  DateTime? timeCheck;
  bool? isCheckin;
  int? status;
  String? note;
  DateTime? date;
  String? reason;
  String? wifiName;
  String? wifiMac;
  String? wifiIp;
  bool? remoteTimekeeping;
  bool? isBonus;
  bool? fromUser;
  Staff? fromStaffCreated;
  Staff? fromUserCreated;

  DateTime? createdAt;
  DateTime? updatedAt;

  factory HistoryCheckInCheckout.fromJson(Map<String, dynamic> json) => HistoryCheckInCheckout(
    id: json["id"] == null ? null : json["id"],
    checkoutForCheckinId: json["checkout_for_checkin_id"] == null ? null : json["checkout_for_checkin_id"],
    storeId: json["store_id"] == null ? null : json["store_id"],
    fromStaffCreated: json["from_staff_created"] == null ? null : Staff.fromJson(json["from_staff_created"]),
    fromUserCreated: json["from_user_created"] == null ? null : Staff.fromJson(json["from_user_created"]),
    branchId: json["branch_id"] == null ? null : json["branch_id"],
    staffId: json["staff_id"] == null ? null : json["staff_id"],
    staff: json["staff"] == null ? null : Staff.fromJson(json["staff"]),
    dateTimekeepingId: json["date_timekeeping_id"] == null ? null : json["date_timekeeping_id"],
    timeCheck: json["time_check"] == null ? null : DateTime.parse(json["time_check"]),
    isCheckin: json["is_checkin"] == null ? null : json["is_checkin"],
    status: json["status"] == null ? null : json["status"],
    note: json["note"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    reason: json["reason"] == null ? null : json["reason"],
    wifiName: json["wifi_name"] == null ? null : json["wifi_name"],
    wifiMac: json["wifi_mac"] == null ? null : json["wifi_mac"],
    wifiIp: json["wifi_ip"] == null ? null : json["wifi_ip"],
    remoteTimekeeping: json["remote_timekeeping"] == null ? null : json["remote_timekeeping"],
    fromUser: json["from_user"] == null ? null : json["from_user"],
    isBonus: json["is_bonus"] == null ? null : json["is_bonus"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "checkout_for_checkin_id": checkoutForCheckinId == null ? null : checkoutForCheckinId,
    "store_id": storeId == null ? null : storeId,
    "branch_id": branchId == null ? null : branchId,
    "staff_id": staffId == null ? null : staffId,
    "date_timekeeping_id": dateTimekeepingId == null ? null : dateTimekeepingId,
    "time_check": timeCheck == null ? null : timeCheck!.toIso8601String(),
    "is_checkin": isCheckin == null ? null : isCheckin,
    "status": status == null ? null : status,
    "note": note,
    "reason": reason == null ? null : reason,
    "wifi_name": wifiName == null ? null : wifiName,
    "wifi_mac": wifiMac == null ? null : wifiMac,
    "wifi_ip": wifiIp == null ? null : wifiIp,
    "remote_timekeeping": remoteTimekeeping == null ? null : remoteTimekeeping,
  };
}
