import 'package:com.ikitech.store/app_user/model/transfer_stock.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/tally_sheet_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/tally_sheet.dart';

class TransferStockDetailController extends GetxController {
  var transferStock = TransferStock().obs;
  var isLoading = false.obs;
  int transferStockId;

  TransferStockDetailController({required this.transferStockId}) {
    getTransferStock();
  }

  Future<void> getTransferStock() async {
    isLoading.value = true;
    try {
      var data = await RepositoryManager.transferStockRepository
          .getTransferStock(transferStockId: transferStockId);
      transferStock.value = data!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> updateTransferStock() async {
    try {
      var data =
          await RepositoryManager.transferStockRepository.updateTransferStock(
        transferStock: transferStock.value,
        transferStockId: transferStockId,
      );
      getTransferStock();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> changeStatusTransferStock(int status) async {
    try {
      var data = await RepositoryManager.transferStockRepository
          .changeStatusTransferStock(
        status: status,
        transferStockId: transferStockId,
      );
      Get.back(result: "reload");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
