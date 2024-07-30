import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';

class PayImportStockController extends GetxController {
  // const PAYMENT_TYPE_CASH = 0; //Tiền mặt
  //     const PAYMENT_TYPE_SWIPE = 1; // Quẹt
  //     const PAYMENT_TYPE_COD = 2; //COD
  //     const PAYMENT_TYPE_TRANSFER = 3; //Chuyển khoản

  var isCash = 999.obs;
  var payMust = 0.0.obs;
  var payAmount = 0.0.obs;
  var payInput = 0.0.obs;

  double payMustInput = 0;ImportStock importStock;

  PayImportStockController({required this.payMustInput, required this.importStock}) {
    payMust.value = payMustInput;
    payAmount.value = payMustInput;
  }

  Future<void> paymentImportStock() async {
    try {
      var data = await RepositoryManager.importStockRepository
          .paymentImportStock(importStock.id,payAmount.value,isCash.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back(result: "reload");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
