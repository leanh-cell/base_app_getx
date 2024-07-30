import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/product_last_inventory_res.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

class ImportStockReportController extends GetxController {
  var date = DateTime.now().obs;

  var listProduct = RxList<ProductLastInventory>();

  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;

  var totalValueStock = 0.0.obs;
  var totalStock = 0.obs;

  ImportStockReportController() {
    getProductLastInventory(isRefresh: true);
  }

  Future<void> getProductLastInventory({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }
    EasyLoading.show();
    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.reportRepository
            .getProductLastInventory(date: date.value, page: currentPage);

        if (isRefresh == true) {
          totalValueStock.value = data!.data!.totalValueStock ?? 0;
          totalStock.value = data.data!.totalStock ?? 0;
          listProduct(data.data!.data!);
        } else {
          listProduct.addAll(data!.data!.data!);
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
