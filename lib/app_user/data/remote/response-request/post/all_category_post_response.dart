import 'package:sahashop_customer/app_customer/model/category_post.dart';

class AllCategoryPostResponse {
  int? code;
  bool? success;
  String? msgCode;
  List<CategoryPost>? data;

  AllCategoryPostResponse({this.code, this.success, this.msgCode, this.data});

  AllCategoryPostResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new CategoryPost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    data['msg_code'] = this.msgCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

