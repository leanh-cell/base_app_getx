import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/profit_and_loss.dart';

import '../../report_controller.dart';

class ProfitLossReportController extends GetxController{

  ReportController reportController = Get.find();

  var profitLoss  = ProfitAndLoss().obs;

  ProfitLossReportController() {
    getProfitAndLoss();
  }

  Future<void> getProfitAndLoss() async {
     try {
       var data = await RepositoryManager.reportRepository.getProfitAndLoss(dateFrom: reportController.fromDay.value, dateTo: reportController.toDay.value);
       profitLoss(data!.data);
     }catch (err) {
       SahaAlert.showError(message: err.toString());
     }
  }
}