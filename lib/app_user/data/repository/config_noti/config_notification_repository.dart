

import 'package:com.ikitech.store/app_user/data/remote/response-request/config_noti/all_schedule_noti_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/config_noti/info_notification_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/config_noti/schedule_noti_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/model/schedule_noti.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

import '../handle_error.dart';

class ConfigNotificationRepository {
  Future<InfoNotificationResponse?> getConfigNotification() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getConfigNotification(UserInfo().getCurrentStoreCode()!);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> configNotification(String key) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .configNotification(UserInfo().getCurrentStoreCode()!, {"key": key});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> sendNotification(
      String title, String content) async {
    try {
      var res = await SahaServiceManager().service!.sendNotification(
          UserInfo().getCurrentStoreCode()!,
          {"title": title, "content": content});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllScheduleNotiResponse?> getAllScheduleNoti() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllScheduleNoti(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ScheduleNotiResponse?> setScheduleNoti(
      ScheduleNoti scheduleNoti) async {
    try {
      var res = await SahaServiceManager().service!.setScheduleNoti(
          UserInfo().getCurrentStoreCode(), scheduleNoti.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ScheduleNotiResponse?> updateScheduleNoti(
      ScheduleNoti scheduleNoti, int idSchedule) async {
    try {
      var res = await SahaServiceManager().service!.updateScheduleNoti(
          UserInfo().getCurrentStoreCode(),idSchedule, scheduleNoti.toJson(),);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteScheduleNoti(int idSchedule) async {
    try {
      var res = await SahaServiceManager().service!.deleteScheduleNoti(
        UserInfo().getCurrentStoreCode(),idSchedule,);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
