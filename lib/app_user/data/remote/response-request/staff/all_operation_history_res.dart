
class AllOperationHistoryRes {
  AllOperationHistoryRes({
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

  factory AllOperationHistoryRes.fromJson(Map<String, dynamic> json) =>
      AllOperationHistoryRes(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  int? currentPage;
  List<OperationHistory>? data;
  String? nextPageUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"] == null ? null : json["current_page"],
        data: json["data"] == null
            ? null
            : List<OperationHistory>.from(
                json["data"].map((x) => OperationHistory.fromJson(x))),
        nextPageUrl:
            json["next_page_url"] == null ? null : json["next_page_url"],
      );
}

class OperationHistory {
  OperationHistory({
    this.id,
    this.storeId,
    this.functionType,
    this.actionType,
    this.staffId,
    this.staffName,
    this.userId,
    this.userName,
    this.branchId,
    this.branchName,
    this.content,
    this.ip,
    this.referencesId,
    this.referencesValue,
    this.createdAt,
    this.updatedAt,
    this.functionTypeName,
  });

  int? id;
  int? storeId;
  String? functionType;
  String? actionType;
  String? staffId;
  String? staffName;
  String? userId;
  String? userName;
  int? branchId;
  int? branchName;
  String? content;
  String? ip;
  int? referencesId;
  String? referencesValue;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? functionTypeName;

  factory OperationHistory.fromJson(Map<String, dynamic> json) =>
      OperationHistory(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        functionType:
            json["function_type"] == null ? null : json["function_type"],
        actionType: json["action_type"] == null ? null : json["action_type"],
        staffId: json["staff_id"],
        staffName: json["staff_name"],
        userId: json["user_id"] == null ? null : json["user_id"],
        userName: json["user_name"] == null ? null : json["user_name"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        branchName: json["branch_name"] == null ? null : json["branch_name"],
        content: json["content"] == null ? null : json["content"],
        ip: json["ip"] == null ? null : json["ip"],
        referencesId:
            json["references_id"] == null ? null : json["references_id"],
        referencesValue:
            json["references_value"] == null ? null : json["references_value"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        functionTypeName: json["function_type_name"] == null
            ? null
            : json["function_type_name"],
      );
}
