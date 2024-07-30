import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_revenue_expenditure_report_res.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/revenue_expenditure.dart';

class AccountantController extends GetxController {
  var listRevenue = RxList<RevenueExpenditure>();
  var listExpenditure = RxList<RevenueExpenditure>();
  var allRevenueExpenditureReport = AllRevenueExpenditureReport().obs;
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;

  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  var fromDayCP = DateTime.now().obs;
  var toDayCP = DateTime.now().obs;
  var isCompare = false.obs;
  var page = 0.obs;
  int indexTabTime = 0;
  int indexChooseTime = 0;

  AccountantController() {
    getAllRevenueExpenditureReport(isRefresh: true);
  }

  Future<void> getAllRevenueExpenditureReport({
    bool? isRefresh,
    bool? isRevenue,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.reportRepository
            .getAllRevenueExpenditureReport(
                dateFrom: fromDay.value,
                dateTo: toDay.value,
                page: currentPage,
                isRevenue: isRevenue);

        if (isRefresh == true) {
          if (isRevenue == true) {
            listRevenue(data!.data!.data!);
          } else {
            listExpenditure(data!.data!.data!);
          }

          allRevenueExpenditureReport(data.data);
        } else {
          if (isRevenue == true) {
            listRevenue.addAll(data!.data!.data!);
          } else {
            listExpenditure.addAll(data!.data!.data!);
          }
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
