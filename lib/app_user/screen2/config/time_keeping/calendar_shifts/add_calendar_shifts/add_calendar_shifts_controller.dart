import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/calendar_shifts_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/shifts.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';

class AddCalendarShiftsController extends GetxController {
  var dateFrom = DateTime.now().obs;
  var dateTo = DateTime.now().obs;
  var listStaff = RxList<Staff>();
  var listShifts = RxList<Shifts>();

  AddCalendarShiftsController() {
    dateFrom.value = SahaDateUtils().getFirstDayOfWeekDATETIME();
    dateTo.value = SahaDateUtils().getEndDayOfWeekDATETIME();
    if (checkPast(dateFrom.value) == true) {
      dateFrom.value = DateTime.now();
    }
  }

  bool checkPast(DateTime date) {
    if (date.isBefore(DateTime.now()) ||
        date.isAtSameMomentAs(DateTime.now())) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addCalendarShifts() async {
    try {
      if (listShifts.isNotEmpty && listStaff.isNotEmpty) {
        var data =
            await RepositoryManager.timeKeepingRepository.addCalendarShifts(
                calendarShiftsRequest: CalendarShiftsRequest(
          startTime: dateFrom.value,
          endTime: dateTo.value,
          listShiftId: listShifts.map((e) => e.id ?? 0).toList(),
          listStaffId: listStaff.map((e) => e.id ?? 0).toList(),
        ));
        Get.back(result: 'reload');
      } else {
        SahaAlert.showError(message: "Vui lòng chọn đầy đủ thông tin");
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
