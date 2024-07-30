import 'package:com.ikitech.store/app_user/model/mini_game.dart';

class MiniGameRes {
  MiniGameRes({
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
  MiniGame? data;

  factory MiniGameRes.fromJson(Map<String, dynamic> json) => MiniGameRes(
        code: json["code"],
        success: json["success"],
        msgCode: json["msg_code"],
        msg: json["msg"],
        data: MiniGame.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "msg_code": msgCode,
        "msg": msg,
        "data": data!.toJson(),
      };
}
