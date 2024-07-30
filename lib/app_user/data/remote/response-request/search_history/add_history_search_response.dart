import 'all_search_history_response.dart';

class AddSearchHistoryResponse {
  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  HistorySearch? data;

  AddSearchHistoryResponse(
      {this.code, this.success, this.msgCode, this.msg, this.data});

  AddSearchHistoryResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    msg = json['msg'];
    data = json['data'] != null ? new HistorySearch.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg_code'] = this.msgCode;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
