import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/tally_sheet_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/tally_sheet.dart';

class TallySheetController extends GetxController {
  var tallySheet = TallySheet().obs;
   bool? isBalance;
  var isLoading = false.obs;
  int tallySheetInputId;

  TallySheetController({required this.tallySheetInputId}) {
    getTallySheet();
  }

  Future<void> getTallySheet() async {
    isLoading.value = true;
    try {
      var data = await RepositoryManager.inventoryRepository
          .getTallySheet(tallySheetInputId);
      tallySheet.value = data!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> updateTallySheet() async {
    try {
      var data = await RepositoryManager.inventoryRepository.updateTallySheet(
          tallySheetInputId,
          TallySheetRequest(
            note: tallySheet.value.note,
          ));
      getTallySheet();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> balanceTallySheet() async {
    try {
      var data = await RepositoryManager.inventoryRepository.balanceTallySheet(
        tallySheetInputId,
      );
      isBalance = true;
      SahaAlert.showSuccess(message: "Đã cân bằng");
      getTallySheet();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteTallySheet() async {
    try {
      var data = await RepositoryManager.inventoryRepository.deleteTallySheet(
        tallySheetInputId,
      );
      Get.back(result: "reload");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
