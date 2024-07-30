class AllHistoryResponse {
  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  List<HistorySearch>? data;

  AllHistoryResponse(
      {this.code, this.success, this.msgCode, this.msg, this.data});

  AllHistoryResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'] ?? null;
    success = json['success'] ?? null;
    msgCode = json['msg_code'] ?? null;
    msg = json['msg'] ?? null;

    data = json['data'] != null
        ? List<HistorySearch>.from(
        json["data"].map((x) => HistorySearch.fromJson(x)))
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg_code'] = this.msgCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistorySearch {
  int? id;
  int? status;
  String? deviceId;
  String? text;
  String? createdAt;
  String? updatedAt;

  HistorySearch(
      {this.id,
      this.status,
      this.deviceId,
      this.text,
      this.createdAt,
      this.updatedAt});

  HistorySearch.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? null;
    status = json['status'] ?? null;
    deviceId = json['device_id'] ?? null;
    text = json['text'] ?? null;
    createdAt = json['created_at'] ?? null;
    updatedAt = json['updated_at'] ?? null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['device_id'] = this.deviceId;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
