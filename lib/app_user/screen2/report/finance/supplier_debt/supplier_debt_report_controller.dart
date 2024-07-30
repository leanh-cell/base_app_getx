import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_supplier_debt_report_res.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/supplier.dart';

import '../../report_controller.dart';

class SupplierDebtReportController extends GetxController {
  var listSupplier = RxList<Supplier>();
  var allSupplierDebtReport = AllSupplierDebtReport().obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  var date = DateTime.now().obs;

  ReportController reportController = Get.find();

  SupplierDebtReportController() {
    getAllSupplierDebtReport(isRefresh: true);
  }

  Future<void> getAllSupplierDebtReport({
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
            .getAllSupplierDebtReport(date: date.value, page: currentPage);

        if (isRefresh == true) {
          listSupplier(data!.data!.data!);
          allSupplierDebtReport(data.data);
        } else {
          listSupplier.addAll(data!.data!.data!);
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