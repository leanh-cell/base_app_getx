import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/tally_sheet_request.dart';

class InputQuantityController extends GetxController {
  var tallySheetItem = TallySheetItem().obs;
  var quantityRealityExistCheck = 0.obs;
  TallySheetItem tallySheetItemInput;
  InputQuantityController({required this.tallySheetItemInput}) {
    tallySheetItem.value = tallySheetItemInput;
    quantityRealityExistCheck.value = tallySheetItemInput.realityExist ?? 0;
  }

  void increaseRealityExist() {
    tallySheetItem.value.realityExist =
        (tallySheetItem.value.realityExist ?? 0) + 1;
    tallySheetItem.refresh();
  }

  void decreaseRealityExist() {
    if ((tallySheetItem.value.realityExist ?? 0) >= 1)
      tallySheetItem.value.realityExist =
          (tallySheetItem.value.realityExist ?? 0) - 1;
    tallySheetItem.refresh();
  }

  void increaseRealityExistIsUp() {
    quantityRealityExistCheck = quantityRealityExistCheck + 1;
    tallySheetItem.refresh();
  }

  void decreaseRealityExistIsUp() {
    if (quantityRealityExistCheck >= 1)
      quantityRealityExistCheck = quantityRealityExistCheck - 1;
    tallySheetItem.refresh();
  }
}
