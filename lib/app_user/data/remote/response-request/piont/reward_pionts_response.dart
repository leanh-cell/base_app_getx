
import 'package:com.ikitech.store/app_user/model/reward_point.dart';

class RewardPointsResponse {
  RewardPointsResponse({
    this.code,
    this.success,
    this.msgCode,
    this.msg,
    this.rewardPoint,
  });

  int? code;
  bool? success;
  String? msgCode;
  String? msg;
  RewardPoint? rewardPoint;

  factory RewardPointsResponse.fromJson(Map<String, dynamic> json) => RewardPointsResponse(
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    msgCode: json["msg_code"] == null ? null : json["msg_code"],
    msg: json["msg"] == null ? null : json["msg"],
    rewardPoint: json["data"] == null ? null : RewardPoint.fromJson(json["data"]),
  );

}
