import 'package:get/get.dart';

import '../../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../../data/repository/repository_manager.dart';
import '../../../../../model/bonus_product.dart';

class ListBonusProductController extends GetxController {
  final int updateBonusProductId;
  var indexChoose = 0.obs;
  var loadInit = false.obs;
  var loadBonusProductItem = false.obs;

  var bonusProductItem =
      BonusProduct(selectProducts: [], bonusProducts: []).obs;

  ListBonusProductController({required this.updateBonusProductId}) {
    getBonusProduct(true);
  }
  var bonusProduct = BonusProduct(groupProducts: []).obs;
  Future<void> getBonusProduct(bool? isInit) async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.marketingChanel
          .getBonusProduct(updateBonusProductId);
      bonusProduct.value = res!.data!;
      if (isInit == true) {
        if ((bonusProduct.value.groupProducts ?? []).isNotEmpty) {
          await getBonusProductItem(
              groupProduct: bonusProduct.value.groupProducts!.isNotEmpty
                  ? bonusProduct.value.groupProducts![0]
                  : -1);
        } else {
           bonusProductItem.value = BonusProduct(selectProducts: [], bonusProducts: []);
        }
      }
      if ((bonusProduct.value.groupProducts ?? []).isEmpty) {
        indexChoose.value = -1;
      }
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getBonusProductItem({required int groupProduct}) async {
    loadBonusProductItem.value = true;
    try {
      var res = await RepositoryManager.marketingChanel.getBonusProductItem(
          bonusProductId: updateBonusProductId, groupProduct: groupProduct);
      bonusProductItem.value = res!.data!;
      loadBonusProductItem.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  void deleteProductSelected(int index) {
    bonusProductItem.value.selectProducts!.removeAt(index);
    bonusProductItem.refresh();
  }

  void decreaseProductSelected(int index) {
    if ((bonusProductItem.value.selectProducts![index].quantity ?? 0) > 1) {
      bonusProductItem.value.selectProducts![index].quantity =
          (bonusProductItem.value.selectProducts![index].quantity ?? 0) - 1;
    }
    bonusProductItem.refresh();
  }

  void increaseProductSelected(int index) {
    bonusProductItem.value.selectProducts![index].quantity =
        (bonusProductItem.value.selectProducts![index].quantity ?? 0) + 1;
    bonusProductItem.refresh();
  }

  void deleteBonusProductSelected(int index) {
    bonusProductItem.value.bonusProducts!.removeAt(index);
    bonusProductItem.refresh();
  }

  void decreaseBonusProductSelected(int index) {
    if ((bonusProductItem.value.bonusProducts![index].quantity ?? 0) > 1) {
      bonusProductItem.value.bonusProducts![index].quantity =
          (bonusProductItem.value.bonusProducts![index].quantity ?? 0) - 1;
    }
    bonusProductItem.refresh();
  }

  void increaseBonusProductSelected(int index) {
    bonusProductItem.value.bonusProducts![index].quantity =
        (bonusProductItem.value.bonusProducts![index].quantity ?? 0) + 1;
    bonusProductItem.refresh();
  }

  Future<void> addBonusProductItem() async {
    if((bonusProductItem.value.selectProducts ?? []).isEmpty){
      SahaAlert.showError(message: "Bạn chưa chọn sản phẩm mua");
      return;
    } 
     if((bonusProductItem.value.bonusProducts ?? []).isEmpty){
      SahaAlert.showError(message: "Bạn chưa chọn sản phẩm tặng");
      return;
    } 
    try {
      var res = await RepositoryManager.marketingChanel.addBonusProductItem(
          bonusProductId: updateBonusProductId,
          bonusProduct: bonusProductItem.value);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateBonusProductItem() async {
     if((bonusProductItem.value.selectProducts ?? []).isEmpty){
      SahaAlert.showError(message: "Bạn chưa chọn sản phẩm mua");
      return;
    } 
     if((bonusProductItem.value.bonusProducts ?? []).isEmpty){
      SahaAlert.showError(message: "Bạn chưa chọn sản phẩm tặng");
      return;
    } 
    try {
      var res = await RepositoryManager.marketingChanel.updateBonusProductItem(
          bonusProductId: updateBonusProductId,
          bonusProduct: bonusProductItem.value);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> deleteBonusProductItem() async {
    try {
      var res = await RepositoryManager.marketingChanel.deleteBonusProductItem(
          bonusProductId: updateBonusProductId,
          bonusProduct: bonusProductItem.value);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
