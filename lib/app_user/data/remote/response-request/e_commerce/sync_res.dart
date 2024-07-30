class SyncRes {
  SyncRes({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  SyncData? data;

  factory SyncRes.fromJson(Map<String, dynamic> json) => SyncRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: json["data"] == null ? null : SyncData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class SyncData {
  SyncData({
    this.totalInPage,
    this.syncCreated,
    this.syncUpdated,
  });

  int? totalInPage;
  int? syncCreated;
  int? syncUpdated;

  factory SyncData.fromJson(Map<String, dynamic> json) => SyncData(
        totalInPage: json["total_in_page"],
        syncCreated: json["sync_created"],
        syncUpdated: json["sync_updated"],
      );

  Map<String, dynamic> toJson() => {
        "total_in_page": totalInPage,
        "sync_created": syncCreated,
        "sync_updated": syncUpdated,
      };
}
