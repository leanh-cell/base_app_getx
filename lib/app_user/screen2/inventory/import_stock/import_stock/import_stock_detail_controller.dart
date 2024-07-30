import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';

class ImportStockDetailController extends GetxController {
  var importStock = ImportStock().obs;
  var isLoading = false.obs;
  int importStockInputId;


  ImportStockDetailController({required this.importStockInputId}) {
    getImportStock();
  }

  bool isReturnAllItem() {
    var check = true;
    for (ImportStockItem e in (importStock.value.importStockItems ?? [])) {
      if (e.quantity != e.totalRefund) {
        check = false;
        break;
      }
    }
    return check;
  }

  Future<void> getImportStock() async {
    isLoading.value = true;
    try {
      var data = await RepositoryManager.importStockRepository
          .getImportStock(importStockInputId);
      importStock.value = data!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  ChangeStatusHistory? checkStatus(int statusInput) {
    if (importStock.value.changeStatusHistory != null &&
        importStock.value.changeStatusHistory!.isNotEmpty) {
      var index = importStock.value.changeStatusHistory!
          .map((e) => e.status)
          .toList()
          .indexWhere((e) => e == statusInput);

      if (index != -1) {
        return importStock.value.changeStatusHistory![index];
      } else {
        return null;
      }
    }
  }

  String? checkPaymentStatus(int paymentStatus) {
    if (paymentStatus == 0) {
      return "Chưa thanh toán";
    }
    if (paymentStatus == 1) {
      return "Thanh toán một phần";
    }
    if (paymentStatus == 2) {
      return "Đã thanh toán";
    }
  }

  String? getStatus(int status) {
    if (status == 0) {
      return "Đặt hàng";
    }
    if (status == 1) {
      return "Duyệt";
    }
    if (status == 2) {
      return "Nhập kho";
    }
    if (status == 3) {
      return "Hoàn thành";
    }
    if (status == 4) {
      return "Đã huỷ";
    }
    if (status == 5) {
      return "Kết thúc";
    }
    if (status == 8) {
      return "Đã hoàn hết";
    }
  }

  Future<void> deleteImportStock() async {
    try {
      var data =
          await RepositoryManager.importStockRepository.deleteImportStock(
        importStockInputId,
      );
      Get.back(result: "reload");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateImportStock() async {
    try {
      var data = await RepositoryManager.importStockRepository
          .updateImportStock(importStockInputId, importStock.value);
      getImportStock();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateStatusImportStock(int status) async {
    try {
      var data = await RepositoryManager.importStockRepository
          .updateStatusImportStock(importStockInputId, status);
      SahaAlert.showSuccess(message: "Thành công");
      getImportStock();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

}
