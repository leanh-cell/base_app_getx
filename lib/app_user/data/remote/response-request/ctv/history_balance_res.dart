
class HistoryBalanceRes {
  HistoryBalanceRes({
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

  factory HistoryBalanceRes.fromJson(Map<String, dynamic> json) => HistoryBalanceRes(
    code: json["code"],
    success: json["success"],
    msgCode: json["msg_code"],
    msg: json["msg"],
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
  List<HistoryBalance>? data;
  String? nextPageUrl;


  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<HistoryBalance>.from(json["data"]!.map((x) => HistoryBalance.fromJson(x))),
    nextPageUrl: json["next_page_url"],
  );
}

class HistoryBalance {
  HistoryBalance({
    this.id,
    this.storeId,
    this.collaboratorId,
    this.type,
    this.currentBalance,
    this.money,
    this.referencesId,
    this.referencesValue,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.typeName,
  });

  int? id;
  int? storeId;
  int? collaboratorId;
  int? type;
  int? currentBalance;
  int? money;
  int? referencesId;
  dynamic referencesValue;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? typeName;

  factory HistoryBalance.fromJson(Map<String, dynamic> json) => HistoryBalance(
    id: json["id"],
    storeId: json["store_id"],
    collaboratorId: json["collaborator_id"],
    type: json["type"],
    currentBalance: json["current_balance"],
    money: json["money"],
    referencesId: json["references_id"],
    referencesValue: json["references_value"],
    note: json["note"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    typeName: json["type_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store_id": storeId,
    "collaborator_id": collaboratorId,
    "type": type,
    "current_balance": currentBalance,
    "money": money,
    "references_id": referencesId,
    "references_value": referencesValue,
    "note": note,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "type_name": typeName,
  };
}
