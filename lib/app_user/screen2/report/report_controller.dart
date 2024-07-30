import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_customer_debt_report_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_product_IE_stock_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_revenue_expenditure_report_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_supplier_debt_report_res.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/profit_and_loss.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';

class ReportController extends GetxController {
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  var fromDayCP = DateTime.now().obs;
  var toDayCP = DateTime.now().obs;
  var isCompare = false.obs;
  var page = 0.obs;
  int indexTabTime = 0;
  int indexChooseTime = 0;


  var allProductIEStock = AllProductIEStock().obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;

  Future<void> getProductIEStock({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.reportRepository.getProductIEStock(
            dateFrom: fromDay.value, dateTo: toDay.value, page: currentPage);

        allProductIEStock.value = data!.data!;
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  var profitLoss = ProfitAndLoss().obs;

  var listProfitLoss = RxList<ProfitAndLoss>();
  var listXAxisString = [];
  var profitUp = 0.0.obs;

  DateTime getDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Future<void> getProfitAndLoss() async {
    listProfitLoss([]);
    listXAxisString = [];
    try {
      var data = await RepositoryManager.reportRepository
          .getProfitAndLoss(dateFrom: fromDay.value, dateTo: toDay.value);
      listProfitLoss.add(data!.data!);
      profitLoss(data.data);
      if (fromDay.value.isAtSameMomentAs(toDay.value)) {
        listXAxisString.add("${SahaDateUtils().getDDMMYY2(toDay.value)}");
      } else {
        listXAxisString.add(
            "${SahaDateUtils().getDDMMYY2(fromDay.value)} - ${SahaDateUtils().getDDMMYY2(toDay.value)}");
      }
      int dateBetween = SahaDateUtils().daysBetween(fromDay.value, toDay.value);
      DateTime toDay2 = toDay.value.subtract(Duration(days: 1));
      DateTime fromDay2 = fromDay.value.subtract(Duration(days: dateBetween == 0 ? 1 : dateBetween));
      var data2 = await RepositoryManager.reportRepository
          .getProfitAndLoss(dateFrom: fromDay2, dateTo: toDay2);
      listProfitLoss.add(data2!.data!);
      if (fromDay.value.isAtSameMomentAs(toDay.value)) {
        listXAxisString.add("${SahaDateUtils().getDDMMYY2(toDay2)}");
      } else {
        listXAxisString.add(
            "${SahaDateUtils().getDDMMYY2(fromDay2)} - ${SahaDateUtils().getDDMMYY2(toDay2)}");
      }
      profitUp.value = (((listProfitLoss[0].profit ?? 0) -
          (listProfitLoss[1].profit ?? 0)) /
          (listProfitLoss[1].profit == 0 ? 1 : listProfitLoss[1].profit ?? 1)) * 100;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  var allRevenueExpenditureReport = AllRevenueExpenditureReport().obs;

  Future<void> getAllRevenueExpenditureReport() async {
    try {
      var data = await RepositoryManager.reportRepository
          .getAllRevenueExpenditureReport(
              dateFrom: fromDay.value, dateTo: toDay.value, page: 1);
      allRevenueExpenditureReport(data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  var allCustomerDebtReport = AllCustomerDebtReport().obs;

  Future<void> getAllCustomerDebtReport() async {
    try {
      if (isEnd == false) {
        var data = await RepositoryManager.reportRepository
            .getAllCustomerDebtReport(date: toDay.value, page: 1);
        allCustomerDebtReport(data!.data);
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  var allSupplierDebtReport = AllSupplierDebtReport().obs;

  Future<void> getAllSupplierDebtReport() async {
    try {
      var data = await RepositoryManager.reportRepository
          .getAllSupplierDebtReport(date: toDay.value, page: 1);

      allSupplierDebtReport(data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
