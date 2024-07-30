import 'package:com.ikitech.store/app_user/model/popup_config.dart';

class ListPopupResponse {
  ListPopupResponse({
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
  List<PopupCf>? data;

  factory ListPopupResponse.fromJson(Map<String, dynamic> json) =>
      ListPopupResponse(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        msgCode: json["msg_code"] == null ? null : json["msg_code"],
        msg: json["msg"] == null ? null : json["msg"],
        data: json["data"] == null
            ? null
            : List<PopupCf>.from(json["data"].map((x) => PopupCf.fromJson(x))),
      );
}
