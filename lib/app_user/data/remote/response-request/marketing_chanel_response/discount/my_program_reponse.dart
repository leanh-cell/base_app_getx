
import 'package:com.ikitech.store/app_user/model/discount_product_list.dart';

class MyProgramResponse {
  int? code;
  bool? success;
  String? msgCode;
  List<DiscountProductsList>? data;

  MyProgramResponse({
    this.code,
    this.success,
    this.msgCode,
    this.data,
  });

  MyProgramResponse.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    success = json["success"];
    msgCode = json["msg_code"];
    if (json['data'] != null) {
      data =  [];
      json['data'].forEach((v) {
        data!.add(new DiscountProductsList.fromJson(v));
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
