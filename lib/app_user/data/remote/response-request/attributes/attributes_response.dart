class AttributesResponse {
  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  List<String>? data;

  AttributesResponse(
      {this.code, this.success, this.msgCode, this.msg, this.data});

  AttributesResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    msg = json['msg'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg_code'] = this.msgCode;
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }
}