import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/schedule_noti.dart';

class ScheduleNotiController extends GetxController {

  var listSchedule = RxList<ScheduleNoti>();

  ScheduleNotiController() {
    getAllScheduleNoti();
  }

  String convertDay (int dayOfWeek) {
    if (dayOfWeek == 0) {
      return "Thứ 2" ;
    } else
    if (dayOfWeek == 1) {
      return "Thứ 3" ;
    }else
    if (dayOfWeek == 2) {
      return "Thứ 4" ;
    }else
    if (dayOfWeek == 3) {
      return "Thứ 5" ;
    }else
    if (dayOfWeek == 4) {
      return "Thứ 6" ;
    }else
    if (dayOfWeek == 5) {
      return "Thứ 7" ;
    }else
    if (dayOfWeek == 6) {
      return "Chủ nhật" ;
    } else {
      return "";
    }
  }

  Future<void> updateScheduleNoti(ScheduleNoti scheduleNoti) async {
    try {
      var res = await RepositoryManager.configNotificationRepository
          .updateScheduleNoti(ScheduleNoti(
          title: scheduleNoti.title,
          description: scheduleNoti.description,
          groupCustomer: scheduleNoti.groupCustomer,
          typeSchedule: scheduleNoti.typeSchedule,
          dayOfWeek: scheduleNoti.dayOfWeek,
          dayOfMonth: scheduleNoti.dayOfMonth,
          timeOfDay: scheduleNoti.timeOfDay,
          timeRun: scheduleNoti.timeRun,
          status: scheduleNoti.status == 0 ? 1 : 0), scheduleNoti.id!);
     var index = listSchedule.indexWhere((element) => element.id == scheduleNoti.id);
     if (index != -1) {
       listSchedule[index].status = scheduleNoti.status == 0 ? 1 : 0;
       listSchedule.refresh();
     }
      SahaAlert.showSuccess(message: "Sửa thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteScheduleNoti(int idSchedule) async {
    try {
      var res = await RepositoryManager.configNotificationRepository.deleteScheduleNoti(
        idSchedule,);
      listSchedule.removeWhere((element) => element.id == idSchedule);
      listSchedule.refresh();
     SahaAlert.showSuccess(message: "Xoá thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllScheduleNoti() async {
    try {
      var data = await RepositoryManager.configNotificationRepository.getAllScheduleNoti();
      listSchedule(data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}