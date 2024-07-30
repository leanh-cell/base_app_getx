class ProductDeleteResponse {
  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  Data? data;

  ProductDeleteResponse(
      {this.code, this.success, this.msgCode, this.msg, this.data});

  ProductDeleteResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int? idDeleted;

  Data({this.idDeleted});

  Data.fromJson(Map<String, dynamic> json) {
    idDeleted = json['idDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idDeleted'] = this.idDeleted;
    return data;
  }
}