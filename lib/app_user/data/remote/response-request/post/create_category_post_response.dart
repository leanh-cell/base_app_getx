
import 'package:sahashop_customer/app_customer/model/category_post.dart';

class CreateCategoryPostResponse {
  int? code;
  bool? success;
  String? msgCode;
  CategoryPost? data;

  CreateCategoryPostResponse(
      {this.code, this.success, this.msgCode, this.data});

  CreateCategoryPostResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    data = json['data'] != null ? new CategoryPost.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg_code'] = this.msgCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
