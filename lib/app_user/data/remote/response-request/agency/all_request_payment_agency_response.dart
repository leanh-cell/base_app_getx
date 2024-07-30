
import 'package:com.ikitech.store/app_user/model/request_payment.dart';

class AllRequestPaymentAgencyResponse {
  AllRequestPaymentAgencyResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.data,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  List<RequestPayment>? data;

  factory AllRequestPaymentAgencyResponse.fromJson(Map<String, dynamic> json) => AllRequestPaymentAgencyResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    data: json["data"] == null ? null : List<RequestPayment>.from(json["data"].map((x) => RequestPayment.fromJson(x))),
  );
}

