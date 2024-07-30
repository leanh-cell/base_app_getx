import 'package:com.ikitech.store/app_user/data/remote/response-request/piont/reward_pionts_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/model/reward_point.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import '../handle_error.dart';

class PointRepository {
  Future<RewardPointsResponse?> getRewardPoint() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getRewardPoint(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<RewardPointsResponse?> configRewardPoint(
      RewardPoint rewardPoint) async {
    try {
      var res = await SahaServiceManager().service!.configRewardPoint(
          UserInfo().getCurrentStoreCode(), rewardPoint.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<RewardPointsResponse?> resetRewardPoint() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .resetRewardPoint(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
