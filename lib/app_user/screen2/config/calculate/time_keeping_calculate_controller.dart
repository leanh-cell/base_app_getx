import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/time_keeping_calculate_res.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';

class TimeKeepingCalculateController extends GetxController {
  var timeKeepingCalculate = TimeKeepingCalculate().obs;
  var dateFrom = DateTime.now().obs;
  var dateTo = DateTime.now().obs;
  var finish = FinishHandle(milliseconds: 500);
  var allSalary = 0.0.obs;

  TimeKeepingCalculateController() {
    dateFrom.value = SahaDateUtils().getFirstDayOfWeekDATETIME();
    dateTo.value = SahaDateUtils().getEndDayOfWeekDATETIME();
    getTimeKeepingCalculate();
  }

  Future<TimeKeepingCalculateRes?> getTimeKeepingCalculate() async {
    finish.run(() async {
      try {
        var data = await RepositoryManager.timeKeepingRepository
            .getTimeKeepingCalculate(
          dateFrom: SahaDateUtils().getDate(dateFrom.value),
          dateTo: SahaDateUtils().getDate(dateTo.value),
        );
        timeKeepingCalculate(data!.data!);
        allSalary.value = 0;
        (timeKeepingCalculate.value.listStaffTimekeeping ?? []).forEach((e) {
          allSalary.value = allSalary.value + (e.totalSalary ?? 0);
        });
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
    });
  }
}
