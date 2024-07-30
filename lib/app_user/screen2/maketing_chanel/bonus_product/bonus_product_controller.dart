import 'package:com.ikitech.store/app_user/model/bonus_product.dart';
import 'package:get/get.dart';

import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';

class BonusProductController extends GetxController {
  var listBonusProduct = RxList<BonusProduct>();
  var isLoading = false.obs;

  ImportStockController() {
    getAllBonusProduct();
  }

  Future<void> getAllBonusProduct() async {
    try {
      isLoading.value = true;
      var data = await RepositoryManager.marketingChanel.getAllBonusProduct();

      listBonusProduct(data!.data!);

      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;

  Future<void> getEndBonusProduct({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.marketingChanel.getEndBonusProduct(
          numberPage: currentPage,
        );

        if (isRefresh == true) {
          listBonusProduct(data!.data!.data!);
        } else {
          listBonusProduct.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> endBonusProduct(int? bonusProductId) async {
    try {
      var data = await RepositoryManager.marketingChanel
          .updateBonusProduct(bonusProductId, BonusProduct(isEnd: true));
      SahaAlert.showSuccess(message: "Thành công");
      getAllBonusProduct();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteCombo(
    int? bonusProductId,
  ) async {
    try {
      var data = await RepositoryManager.marketingChanel.deleteBonusProduct(
        bonusProductId,
      );
      getAllBonusProduct();
      SahaAlert.showSuccess(message: "Xoá thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
