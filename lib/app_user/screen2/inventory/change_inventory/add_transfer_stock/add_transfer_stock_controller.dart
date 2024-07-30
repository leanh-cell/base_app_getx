import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import '../../../../model/branch.dart';
import '../../../../model/transfer_stock.dart';
import '../../../../model/transfer_stock_item.dart';

class AddTransferStockController extends GetxController {
  var listTransferStockItem = RxList<TransferStockItem>();
  var transferStockRequest = TransferStock().obs;
  TransferStock? transferStockInput;
  SahaDataController sahaDataController = Get.find();
  var listBranch = RxList<Branch>();

  AddTransferStockController({this.transferStockInput}) {
    getAllBranch();
    if (transferStockInput != null) {
      transferStockInput!.transferStockItems!.forEach((e) {
        listTransferStockItem.add(TransferStockItem(
          product: e.product,
          productId: e.productId,
          quantity: e.quantity,
          distributeName: e.distributeName,
          elementDistributeName: e.elementDistributeName,
          subElementDistributeName: e.subElementDistributeName,
        ));
      });
      transferStockRequest.value.note = transferStockInput!.note;
      transferStockRequest.value.toBranchId = transferStockInput!.toBranchId;
      transferStockRequest.value.fromBranchId =
          transferStockInput!.fromBranchId;
      transferStockRequest.value.toBranch = transferStockInput!.toBranch;
      transferStockRequest.value.fromBranch = transferStockInput!.fromBranch;
    } else {
      transferStockRequest.value.fromBranchId =
          sahaDataController.branchCurrent.value.id;
      transferStockRequest.value.fromBranch =
          sahaDataController.branchCurrent.value;
    }
  }

  Future<void> getAllBranch() async {
    try {
      var data =
          await RepositoryManager.branchRepository.getAllBranch(getAll: true);
      listBranch(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void updateQuantityTransferStock(int index, int quantity) {
    listTransferStockItem[index].quantity = quantity;
    listTransferStockItem.refresh();
  }

  void deleteQuantityTransferStock(int index) {
    listTransferStockItem.removeAt(index);
    listTransferStockItem.refresh();
  }

  void increaseQuantityTransferStock(int index) {
    listTransferStockItem[index].quantity =
        (listTransferStockItem[index].quantity ?? 0) + 1;
    listTransferStockItem.refresh();
  }

  void decreaseQuantityTransferStock(int index) {
    if ((listTransferStockItem[index].quantity ?? 0) >= 1) {
      listTransferStockItem[index].quantity =
          (listTransferStockItem[index].quantity ?? 0) - 1;
    }
    listTransferStockItem.refresh();
  }

  int quantityAll() {
    int all = 0;

    listTransferStockItem.forEach((e) {
      all = all + (e.quantity ?? 0);
    });

    return all;
  }

  Future<void> updateTransferStock() async {
    transferStockRequest.value.transferStockItems =
        listTransferStockItem.toList();
    try {
      var data = await RepositoryManager.transferStockRepository
          .updateTransferStock(
              transferStockId: transferStockInput!.id!,
              transferStock: transferStockRequest.value);
      Get.back(result: "reload");
      SahaAlert.showSuccess(message: "Đã lưu");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> createTransferStock() async {
    if (transferStockRequest.value.toBranchId == null) {
      SahaAlert.showToastMiddle(message: "Chưa chọn chi nhánh nhận");
      return;
    }
    transferStockRequest.value.transferStockItems =
        listTransferStockItem.toList();
    try {
      var data = await RepositoryManager.transferStockRepository
          .createTransferStock(transferStock: transferStockRequest.value);
      Get.back(result: "reload");
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
