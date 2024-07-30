import 'package:com.ikitech.store/app_user/data/remote/response-request/badge/badge_user_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

import '../handle_error.dart';

class BadgeRepository {
  Future<BadgeUserResponse?> getBadgeUser() async {
    try {
      var res = await SahaServiceManager().service!.getBadgeUser(
          UserInfo().getCurrentStoreCode()!, UserInfo().getCurrentIdBranch()!);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
