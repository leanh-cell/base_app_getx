import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_history_inventory_res.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/history_inventory.dart';

import '../../report_controller.dart';

class InventoryHistoryReportController extends GetxController {
  var listHistoryInventory = RxList<HistoryInventory>();

  var allHistoryInventory = AllHistoryInventory().obs;

  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;
  ReportController reportController = Get.find();

  InventoryHistoryReportController() {
    getAllHistoryInventory(isRefresh: true);
  }

  Future<void> getAllHistoryInventory({
    bool? isRefresh,
  }) async {
    EasyLoading.dismiss();
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }
    try {
      EasyLoading.show();
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.reportRepository
            .getAllHistoryInventory(
                dateFrom: reportController.fromDay.value,
                dateTo: reportController.toDay.value,
                page: currentPage);

        if (isRefresh == true) {
          allHistoryInventory(data!.data);
          listHistoryInventory(data.data!.data!);
        } else {
          listHistoryInventory.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          currentPage = currentPage +1;
          isEnd = false;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    EasyLoading.dismiss();
  }
}
