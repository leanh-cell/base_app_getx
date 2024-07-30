import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/calendar_shifts_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/put_one_calendar_shifts_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';

class CalendarShiftsController extends GetxController {
  var dateFrom = DateTime.now().obs;
  var dateTo = DateTime.now().obs;
  var listCalendarShifts = RxList<CalendarShifts>();
  var daysInMonth = 0.obs;
  var listDate = RxList<DateTime>();
  CalendarShiftsController() {
    dateFrom.value = SahaDateUtils().getFirstDayOfWeekDATETIME();
    dateTo.value = SahaDateUtils().getEndDayOfWeekDATETIME();
    getCalendarShifts();
  }

  Future<void> getCalendarShifts() async {
    try {
      var data = await RepositoryManager.timeKeepingRepository
          .getCalendarShifts(dateFrom: dateFrom.value, dateTo: dateTo.value);
      listDate(SahaDateUtils().getDaysInBetween(dateFrom.value, dateTo.value));
      listCalendarShifts(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addCalendarShiftsPutOne(PutOneCalendarShiftsRequest putOneCalendarShiftsRequest) async {
    try {
      var data = await RepositoryManager.timeKeepingRepository
          .addCalendarShiftsPutOne(putOneCalendarShiftsRequest: putOneCalendarShiftsRequest);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }


}
