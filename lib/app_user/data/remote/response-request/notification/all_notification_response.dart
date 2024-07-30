class AllNotificationResponse {
  AllNotificationResponse({
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
  Data? data;

  factory AllNotificationResponse.fromJson(Map<String, dynamic> json) =>
      AllNotificationResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.totalUnread,
    this.listNotification,
  });

  int? totalUnread;
  ListNotification? listNotification;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalUnread: json["total_unread"] == null ? null : json["total_unread"],
        listNotification: json["list_notification"] == null
            ? null
            : ListNotification.fromJson(json["list_notification"]),
      );
}

class ListNotification {
  ListNotification({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<NotificationUser>? data;
  String? nextPageUrl;

  factory ListNotification.fromJson(Map<String, dynamic> json) =>
      ListNotification(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<NotificationUser>.from(
                json["data"].map((x) => NotificationUser.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );
}

class NotificationUser {
  NotificationUser({
    this.id,
    this.storeId,
    this.content,
    this.title,
    this.type,
    this.referencesValue,
    this.unread,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  String? content;
  String? title;
  String? type;
  String? referencesValue;
  bool? unread;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NotificationUser.fromJson(Map<String, dynamic> json) =>
      NotificationUser(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        content: json["content"] == null ? null : json["content"],
        title: json["title"] == null ? null : json["title"],
        type: json["type"] == null ? null : json["type"],
        referencesValue:
            json["references_value"] == null ? null : json["references_value"],
        unread: json["unread"] == null ? null : json["unread"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
