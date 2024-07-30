import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_revenue_expenditure_report_res.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/revenue_expenditure.dart';

import '../../report_controller.dart';

class RevenueExpenditureReportController extends GetxController {
  var listRevenueExpenditure = RxList<RevenueExpenditure>();
  var allRevenueExpenditureReport = AllRevenueExpenditureReport().obs;
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;

  ReportController reportController = Get.find();

  RevenueExpenditureReportController() {
    getAllRevenueExpenditureReport(isRefresh: true);
  }

  Future<void> getAllRevenueExpenditureReport({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.reportRepository
            .getAllRevenueExpenditureReport(dateFrom: reportController.fromDay.value, dateTo: reportController.toDay.value, page: currentPage);

        if (isRefresh == true) {
          listRevenueExpenditure(data!.data!.data!);
          allRevenueExpenditureReport(data.data);
        } else {
          listRevenueExpenditure.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage +1;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}