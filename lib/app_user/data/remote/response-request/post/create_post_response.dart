
import 'package:sahashop_customer/app_customer/model/post.dart';

class CreatePostResponse {
  int? code;
  bool? success;
  String? msgCode;
  Post? data;

  CreatePostResponse({this.code, this.success, this.msgCode, this.data});

  CreatePostResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    msgCode = json['msg_code'];
    data = json['data'] != null ? new Post.fromJson(json['data']) : null;
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

