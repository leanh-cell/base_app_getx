

import 'package:com.ikitech.store/app_user/data/remote/response-request/notification/all_notification_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

import '../handle_error.dart';

class NotificationRepository {
  Future<AllNotificationResponse?> historyNotification(int page) async {
    try {
      var res = await SahaServiceManager().service!.historyNotification(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          page);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> readAllNotification() async {
    try {
      var res = await SahaServiceManager().service!.readAllNotification(
          UserInfo().getCurrentStoreCode(), UserInfo().getCurrentIdBranch());
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}