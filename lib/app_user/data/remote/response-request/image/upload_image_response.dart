class UploadImageResponse {
  int? code;
  bool? success;
  String? msgCode;
  String? data;

  UploadImageResponse({this.code, this.success, this.msgCode, this.data});

  UploadImageResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg_code'] = this.msgCode;
    data['data'] = this.data;
    return data;
  }
}