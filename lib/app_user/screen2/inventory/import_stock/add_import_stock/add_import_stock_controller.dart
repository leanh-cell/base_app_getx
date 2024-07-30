import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';

class AddImportStockController extends GetxController {
  var importStock = ImportStock().obs;
  ImportStock? importStockInput;
  var listImportStockItem = RxList<ImportStockItem>();
  bool? isPercentInput = false;
  var totalNeedPayment = 0.0.obs;
  List<String> list = <String>['Tiền mặt', 'Quẹt thẻ', 'Cod', 'Chuyển khoản'];
  var dropdownValue = "Tiền mặt".obs;

  AddImportStockController({this.importStockInput}) {
    if (importStockInput != null) {
      listImportStockItem(importStockInput!.importStockItems!.toList());
      importStock.value = importStockInput!;
      dropdownValue.value = list[importStock.value.paymentMethod ?? 0];
      caculatePayment();
    }else{
      importStock.value.paymentMethod = 0;
    }
  }

  void updateQuantityTallyItem(int index, int quantity) {
    listImportStockItem[index].quantity = quantity;
    listImportStockItem.refresh();
  }

  void updatePriceTallyItem(int index, double importPrice) {
    listImportStockItem[index].importPrice = importPrice;
    listImportStockItem.refresh();
  }

  void deleteQuantityTallyItem(int index) {
    listImportStockItem.removeAt(index);
    listImportStockItem.refresh();
  }

  void increaseQuantityTallyItem(int index) {
    listImportStockItem[index].quantity =
        (listImportStockItem[index].quantity ?? 0) + 1;
    listImportStockItem.refresh();
  }

  void decreaseQuantityTallyItem(int index) {
    if ((listImportStockItem[index].quantity ?? 0) >= 1) {
      listImportStockItem[index].quantity =
          (listImportStockItem[index].quantity ?? 0) - 1;
    }
    listImportStockItem.refresh();
  }

  int quantityAll() {
    int all = 0;

    listImportStockItem.forEach((e) {
      all = all + (e.quantity ?? 0);
    });

    return all;
  }

  double priceAll() {
    double priceAll = 0;

    listImportStockItem.forEach((e) {
      priceAll = priceAll + ((e.importPrice ?? 0) * (e.quantity ?? 0));
    });

    return priceAll;
  }

  Future<void> updateImportStock() async {
    importStock.value.importStockItems = listImportStockItem.toList();
    try {
      var data = await RepositoryManager.importStockRepository
          .updateImportStock(importStockInput!.id, importStock.value);
      Get.back(result: "reload");
      SahaAlert.showSuccess(message: "Đã lưu");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> createImportStock() async {
    importStock.value.importStockItems = listImportStockItem.toList();
    importStock.value.supplierId = importStock.value.supplier?.id;
    try {
      var data = await RepositoryManager.importStockRepository
          .createImportStock(importStock.value);
      Get.back();
      Get.back(result: {"import_stock": data?.data});
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void caculatePayment(){
    totalNeedPayment.value = priceAll() + (importStock.value.cost ?? 0) + (importStock.value.vat ?? 0) - (importStock.value.discount ?? 0);
  }
}
