import 'package:com.ikitech.store/app_user/model/popup_config.dart';

class UpdatePopupResponse {
  UpdatePopupResponse({
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
  PopupCf? data;

  factory UpdatePopupResponse.fromJson(Map<String, dynamic> json) =>
      UpdatePopupResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null ? null : PopupCf.fromJson(json["data"]),
      );
}
