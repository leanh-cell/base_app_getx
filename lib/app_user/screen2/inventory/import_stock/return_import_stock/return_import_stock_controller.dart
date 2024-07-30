import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/refund_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';

class ReturnImportStockController extends GetxController {
  var importStock = ImportStock().obs;
  ImportStock? importStockInput;
  var listImportStockItem = RxList<ImportStockItem>();
  var listImportStockItemChoose = RxList<ImportStockItem>();
  bool? isPercentInput = false;

  ReturnImportStockController({this.importStockInput}) {
    if (importStockInput != null) {
      importStockInput!.importStockItems!.toList().forEach((e) {
        e.quantityInit = e.quantity;
        e.quantityReturnMax = (e.quantity ?? 0) - (e.totalRefund ?? 0);
        e.quantity = (e.quantity ?? 0) - (e.totalRefund ?? 0);
        if (e.quantityReturnMax != 0) {
          listImportStockItem.add(e);
        }
      });
      importStock.value = importStockInput!;
    }
  }

  bool checkChooseItem(ImportStockItem importStockItem) {
    if (listImportStockItemChoose
        .map((e) => e.id)
        .toList()
        .contains(importStockItem.id)) {
      return true;
    } else {
      return false;
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
    if (listImportStockItem[index].quantity! <
        listImportStockItem[index].quantityReturnMax!) {
      listImportStockItem[index].quantity =
          (listImportStockItem[index].quantity ?? 0) + 1;
      listImportStockItem.refresh();
    }
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

    listImportStockItemChoose.forEach((e) {
      all = all + (e.quantity ?? 0);
    });

    return all;
  }

  double priceAll() {
    double priceAll = 0;

    listImportStockItemChoose.forEach((e) {
      priceAll = priceAll + ((e.importPrice ?? 0) * (e.quantity ?? 0));
    });

    return priceAll;
  }

  double priceDiscountRefund() {
    double discountRefund = 0;
    double discount = 0;
    double percent = 0;
    discount = (importStock.value.totalAmount ?? 0) -
        ((importStock.value.totalFinal ?? 0) - (importStockInput?.cost ?? 0));

    percent = discount / (importStock.value.totalAmount ?? 0);

    discountRefund = priceAll() * percent;

    return discountRefund;
  }

  double priceTotalRefund() {
    double total = 0;
    if (importStock.value.hasRefunded == true) {
      total = priceAll() - priceDiscountRefund();
    } else {
      total =
          priceAll() - priceDiscountRefund() + (importStockInput?.cost ?? 0);
    }
    return total;
  }

  double pricePaid() {
    double pricePaid = 0;
    pricePaid = (importStockInput?.totalFinal ?? 0) -
        (importStockInput?.remainingAmount ?? 0);
    return pricePaid;
  }

  Future<void> refundImportStock() async {
    try {
      var data = await RepositoryManager.importStockRepository
          .refundImportStock(
              importStockId: importStockInput!.id!,
              refundRequest: RefundRequest(
                  refundMoneyPaid: RefundMoneyPaid(
                    amountMoney: pricePaid() == 0
                        ? 0
                        : pricePaid() <= priceTotalRefund()
                            ? pricePaid()
                            : priceTotalRefund(),
                    paymentMethod: importStockInput?.paymentMethod ?? 0,
                  ),
                  newLineItems: listImportStockItemChoose
                      .map((e) =>
                          NewLineItem(lineItemId: e.id, quantity: e.quantity))
                      .toList()));
      Get.back();
      SahaAlert.showSuccess(message: "Đã hoàn trả NCC");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
