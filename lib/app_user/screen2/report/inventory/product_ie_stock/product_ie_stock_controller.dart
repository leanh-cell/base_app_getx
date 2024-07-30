import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_product_IE_stock_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/product_last_inventory_res.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/screen2/report/report_controller.dart';

class ProductIEStockController extends GetxController {
  var listProduct = RxList<ProductLastInventory>();
  var allProductIEStock = AllProductIEStock().obs;
  int currentPage = 1;
  bool isEnd = false;
  var isLoading = false.obs;

  ReportController reportController = Get.find();

  ProductIEStockController() {
    getProductIEStock(isRefresh: true);
  }

  Future<void> getProductIEStock({
    bool? isRefresh,
  }) async {    EasyLoading.dismiss();
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        EasyLoading.show();

        isLoading.value = true;
        var data = await RepositoryManager.reportRepository.getProductIEStock(
            dateFrom: reportController.fromDay.value, dateTo: reportController.toDay.value, page: currentPage);

        if (isRefresh == true) {
          allProductIEStock.value = data!.data!;
          listProduct(data.data!.data!);
        } else {
          listProduct.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          currentPage = currentPage + 1;
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
