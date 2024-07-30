// To parse this JSON data, do
//
//     final checkInCheckOutRequest = checkInCheckOutRequestFromJson(jsonString);

import 'dart:convert';

CheckInCheckOutRequest checkInCheckOutRequestFromJson(String str) =>
    CheckInCheckOutRequest.fromJson(json.decode(str));

String checkInCheckOutRequestToJson(CheckInCheckOutRequest data) =>
    json.encode(data.toJson());

class CheckInCheckOutRequest {
  CheckInCheckOutRequest({
    this.isRemote,
    this.wifiName,
    this.wifiMac,
    this.wifiIp,
    this.reason,
    this.deviceId,
    this.deviceName,
  });

  bool? isRemote;
  String? wifiName;
  String? wifiMac;
  String? wifiIp;
  String? reason;
  String? deviceId;
  String? deviceName;

  factory CheckInCheckOutRequest.fromJson(Map<String, dynamic> json) =>
      CheckInCheckOutRequest(
        isRemote: json["is_remote"] == null ? null : json["is_remote"],
        wifiName: json["wifi_name"] == null ? null : json["wifi_name"],
        wifiMac: json["wifi_mac"] == null ? null : json["wifi_mac"],
        wifiIp: json["wifi_ip"] == null ? null : json["wifi_ip"],
        reason: json["reason"] == null ? null : json["reason"],
      );

  Map<String, dynamic> toJson() => {
    "is_remote": isRemote == null ? null : isRemote,
    "wifi_name": wifiName == null ? null : wifiName,
    "wifi_mac": wifiMac == null ? null : wifiMac,
    "wifi_ip": wifiIp == null ? null : wifiIp,
    "reason": reason == null ? null : reason,
    "device_id": deviceId == null ? null : deviceId,
    "device_name": deviceName == null ? null : deviceName,
  };
}
