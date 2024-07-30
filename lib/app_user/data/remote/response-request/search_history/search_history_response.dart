class DeleteAllSearchHistoryResponse {
  int? code;
  bool? success;
  String? msgCode;
  String? msg;

  DeleteAllSearchHistoryResponse(
      {this.code, this.success, this.msgCode, this.msg});

  DeleteAllSearchHistoryResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg_code'] = this.msgCode;
    data['msg'] = this.msg;
    return data;
  }
}