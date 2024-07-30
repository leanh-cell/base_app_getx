
import 'package:sahashop_customer/app_customer/model/category_post.dart';

class UpdateCategoryPostResponse {
  int? code;
  bool? success;
  String? msgCode;
  CategoryPost? data;

  UpdateCategoryPostResponse(
      {this.code, this.success, this.msgCode, this.data});

  UpdateCategoryPostResponse.fromJson(Map<String, dynamic> json) {
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
