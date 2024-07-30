import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/tally_sheet_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/tally_sheet.dart';

class AddCheckInventoryController extends GetxController {
  var listTallySheetItem = RxList<TallySheetItem>();
  var tallySheetRequest = TallySheetRequest().obs;
  TallySheet? tallySheetInput;

  AddCheckInventoryController({this.tallySheetInput}) {
    if (tallySheetInput != null) {
      tallySheetInput!.listTallySheetItem!.forEach((e) {
        listTallySheetItem.add(TallySheetItem(
          realityExist: e.realityExist,
          stockOnline: e.existingBranch,
          imageProductUrl:
              e.product?.images != null && e.product!.images!.isNotEmpty
                  ? e.product!.images![0].imageUrl
                  : "",
          nameProduct: e.product?.name ?? "",
          productId: e.productId,
          distributeName: e.distributeName,
          elementDistributeName: e.elementDistributeName,
          subElementDistributeName: e.subElementDistributeName,
        ));
      });
      tallySheetRequest.value.note = tallySheetInput!.note;
    }
  }

  void updateRealityExistTallyItem(int index, int realityExist) {
    listTallySheetItem[index].realityExist = realityExist;
    listTallySheetItem.refresh();
  }

  void deleteRealityExistTallyItem(int index) {
    listTallySheetItem.removeAt(index);
    listTallySheetItem.refresh();
  }

  void increaseRealityExistTallyItem(int index) {
    listTallySheetItem[index].realityExist =
        (listTallySheetItem[index].realityExist ?? 0) + 1;
    listTallySheetItem.refresh();
  }

  void decreaseRealityExistTallyItem(int index) {
    if ((listTallySheetItem[index].realityExist ?? 0) >= 1) {
      listTallySheetItem[index].realityExist =
          (listTallySheetItem[index].realityExist ?? 0) - 1;
    }
    listTallySheetItem.refresh();
  }

  int quantityRealityExistAll() {
    int all = 0;

    listTallySheetItem.forEach((e) {
      all = all + (e.realityExist ?? 0);
    });

    return all;
  }

  int quantityStockOnlineAll() {
    int all = 0;

    listTallySheetItem.forEach((e) {
      all = all + (e.stockOnline ?? 0);
    });

    return all;
  }

  Future<void> updateTallySheet() async {
    tallySheetRequest.value.tallySheetItems = listTallySheetItem.toList();
    try {
      var data = await RepositoryManager.inventoryRepository
          .updateTallySheet(tallySheetInput!.id, tallySheetRequest.value);
      Get.back(result: "reload");
      SahaAlert.showSuccess(message: "Đã lưu");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> createTallySheet() async {
    tallySheetRequest.value.tallySheetItems = listTallySheetItem.toList();
    try {
      var data = await RepositoryManager.inventoryRepository
          .createTallySheet(tallySheetRequest.value);
      Get.back(result: "reload");
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
