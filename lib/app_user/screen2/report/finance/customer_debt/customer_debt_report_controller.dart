import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_customer_debt_report_res.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';
import '../../report_controller.dart';

class CustomerDebtReportController extends GetxController {
  var listCustomer = RxList<InfoCustomer>();
  var allCustomerDebtReport = AllCustomerDebtReport().obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  var date = DateTime.now().obs;

  ReportController reportController = Get.find();

  CustomerDebtReportController() {
    getAllCustomerDebtReport(isRefresh: true);
  }

  Future<void> getAllCustomerDebtReport({
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
            .getAllCustomerDebtReport(date: date.value, page: currentPage);

        if (isRefresh == true) {
          listCustomer(data!.data!.data!);
          allCustomerDebtReport(data.data);
        } else {
          listCustomer.addAll(data!.data!.data!);
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