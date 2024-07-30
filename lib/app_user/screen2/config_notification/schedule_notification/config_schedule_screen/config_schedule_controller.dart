import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/schedule_noti.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:intl/intl.dart';

import '../../../../model/agency_type.dart';

class ConfigScheduleController extends GetxController {
  ScheduleNoti? scheduleInput;

  var dateNotification = DateTime.now().obs;
  var timeNotification = DateTime.now().obs;
  var timeNotificationDay = DateTime.now().obs;

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController desEditingController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  var typeAction = ''.obs;
  var valueAction = ''.obs;
  var reminiscentName = ''.obs;

  var indexSendTo = 0.obs;
  var listSendTo = [
    "Tất cả",
    "Khách hàng có ngày sinh nhật",
    "Đại lý",
    "Cộng tác viên"
  ];

  var indexTypeSchedule = 0.obs;
  var listTypeSchedule = ["1 lần", "Hàng ngày", "Hàng tuần", "Hàng tháng"];

  var indexOfWeek = 0.obs;
  var listDayWeek = [
    "Thứ 2",
    "Thứ 3",
    "Thứ 4",
    "Thứ 5",
    "Thứ 6",
    "Thứ 7",
    "Chủ nhật",
  ];

  var indexOfMonth = 0.obs;
  var listDayMonth = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
  ];

  var listAgencyType = RxList<AgencyType>();
  var agencyType = AgencyType().obs;
  var pushing = false.obs;

  ConfigScheduleController({this.scheduleInput}) {
    getAllAgencyType();
    if (scheduleInput != null) {
      titleEditingController.text = scheduleInput!.title ?? "";
      desEditingController.text = scheduleInput!.description ?? "";
      indexSendTo.value = scheduleInput!.groupCustomer ?? 0;
      indexTypeSchedule.value = scheduleInput!.typeSchedule ?? 0;
      indexOfWeek.value = scheduleInput!.dayOfWeek ?? 0;
      indexOfMonth.value = (scheduleInput!.dayOfMonth ?? 0) - 1;

      timeNotificationDay.value = DateTime.parse(
          "${SahaDateUtils().getYYMMDD(DateTime.now())}${scheduleInput?.timeOfDay == null ? "" : " "}${scheduleInput?.timeOfDay ?? ""}");
      dateNotification.value = scheduleInput?.timeRun ?? DateTime.now();
      timeNotification.value = scheduleInput?.timeRun ?? DateTime.now();
      typeAction.value = scheduleInput!.typeAction ?? "";
      valueAction.value = scheduleInput!.valueAction ?? "";
      reminiscentName.value = scheduleInput!.reminiscentName ?? "";
      agencyType.value = AgencyType(
          name: scheduleInput!.agencyTypeName, id: scheduleInput!.agencyTypeId);
    }
  }

  Future<void> getAllAgencyType() async {
    try {
      var data = await RepositoryManager.agencyRepository.getAllAgencyType();
      listAgencyType(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> setScheduleNoti() async {
    pushing.value = true;
    try {
      var res = await RepositoryManager.configNotificationRepository
          .setScheduleNoti(ScheduleNoti(
        title: titleEditingController.text,
        description: desEditingController.text,
        groupCustomer: indexSendTo.value,
        typeSchedule: indexTypeSchedule.value,
        dayOfWeek: indexOfWeek.value,
        dayOfMonth: indexOfMonth.value + 1,
        timeOfDay: DateFormat('HH:mm:ss').format(timeNotificationDay.value),
        timeRun: DateTime(
            dateNotification.value.year,
            dateNotification.value.month,
            dateNotification.value.day,
            timeNotification.value.hour,
            timeNotification.value.minute),
        status: 0,
        typeAction: typeAction.value,
        reminiscentName: reminiscentName.value,
        valueAction: valueAction.value,
        agencyTypeId: agencyType.value.id ?? 0,
        agencyTypeName: agencyType.value.name ?? "",
      ));
      SahaAlert.showSuccess(message: "Đã lên lịch thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    pushing.value = false;
  }

  Future<void> updateScheduleNoti() async {
    pushing.value = true;
    try {
      var res = await RepositoryManager.configNotificationRepository
          .updateScheduleNoti(
              ScheduleNoti(
                title: titleEditingController.text,
                description: desEditingController.text,
                groupCustomer: indexSendTo.value,
                typeSchedule: indexTypeSchedule.value,
                dayOfWeek: indexOfWeek.value,
                dayOfMonth: indexOfMonth.value + 1,
                timeOfDay:
                    DateFormat('HH:mm:ss').format(timeNotificationDay.value),
                timeRun: DateTime(
                    dateNotification.value.year,
                    dateNotification.value.month,
                    dateNotification.value.day,
                    timeNotification.value.hour,
                    timeNotification.value.minute),
                status: 0,
                typeAction: typeAction.value,
                reminiscentName: reminiscentName.value,
                valueAction: valueAction.value,
                agencyTypeId: agencyType.value.id ?? 0,
                agencyTypeName: agencyType.value.name ?? "",
              ),
              scheduleInput!.id!);
      SahaAlert.showSuccess(message: "Sửa thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    pushing.value = false;
  }

  void onChangeDate(DateTime date) {
    if (date.isBefore(dateNotification.value) == true) {
    } else {
      dateNotification.value = date;
    }
  }

  void aaa() {
    print({
      "${SahaDateUtils().getYYMMDD(DateTime.now())} ${scheduleInput!.timeOfDay}"
    });
  }
}
