// To parse this JSON data, do
//
//     final bonusTimeKeepingReq = bonusTimeKeepingReqFromJson(jsonString);

import 'dart:convert';

BonusTimeKeepingReq bonusTimeKeepingReqFromJson(String str) =>
    BonusTimeKeepingReq.fromJson(json.decode(str));

String bonusTimeKeepingReqToJson(BonusTimeKeepingReq data) =>
    json.encode(data.toJson());

class BonusTimeKeepingReq {
  BonusTimeKeepingReq({
    this.isBonus = true,
    this.checkinTime,
    this.checkoutTime,
    this.reason,
    this.staffId,
  });

  bool? isBonus = true;
  DateTime? checkinTime;
  DateTime? checkoutTime;
  String? reason;
  int? staffId;

  factory BonusTimeKeepingReq.fromJson(Map<String, dynamic> json) =>
      BonusTimeKeepingReq(
        isBonus: json["is_bonus"] == null ? null : json["is_bonus"],
        checkinTime: json["checkin_time"] == null
            ? null
            : DateTime.parse(json["checkin_time"]),
        checkoutTime: json["checkout_time"] == null
            ? null
            : DateTime.parse(json["checkout_time"]),
        reason: json["reason"] == null ? null : json["reason"],
        staffId: json["staff_id"] == null ? null : json["staff_id"],
      );

  Map<String, dynamic> toJson() => {
        "is_bonus": isBonus == null ? null : isBonus,
        "checkin_time":
            checkinTime == null ? null : checkinTime!.toIso8601String(),
        "checkout_time":
            checkoutTime == null ? null : checkoutTime!.toIso8601String(),
        "reason": reason == null ? null : reason,
        "staff_id": staffId == null ? null : staffId,
      };
}
