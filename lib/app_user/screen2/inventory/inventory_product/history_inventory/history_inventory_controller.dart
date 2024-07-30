import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/history_inventory_res.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

class HistoryInventoryController extends GetxController {
  var listHistoryInventory = RxList<HistoryInventory>();

  int idProduct;
  String? distributeName;
  String? elm;
  String? sub;

  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  HistoryInventoryController(
      {required this.idProduct, this.elm, this.distributeName, this.sub}) {
    getHistoryInventory(isRefresh: true);
  }

  Future<void> getHistoryInventory({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.inventoryRepository.historyInventory(
            page: currentPage,
            idProduct: idProduct,
            distributeName: distributeName,
            elm: elm,
            sub: sub);

        if (isRefresh == true) {
          listHistoryInventory(data!.data!.data!);
        } else {
          listHistoryInventory.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
