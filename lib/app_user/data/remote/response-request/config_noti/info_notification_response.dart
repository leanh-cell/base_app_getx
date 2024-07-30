class InfoNotificationResponse {
  InfoNotificationResponse({
    this.code,
    this.success,
    this.data,
    this.msgCode,
    this.msg,
  });

  int? code;
  bool? success;
  Data? data;
  String? msgCode;
  String? msg;

  factory InfoNotificationResponse.fromJson(Map<String, dynamic> json) =>
      InfoNotificationResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
      );
}

class Data {
  Data({
    this.id,
    this.storeId,
    this.key,
    this.lastTimeSend,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  String? key;
  DateTime? lastTimeSend;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        key: json["key"] == null ? null : json["key"],
        lastTimeSend: json["last_time_send"] == null
            ? null
            : DateTime.parse(json["last_time_send"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
