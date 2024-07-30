import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/decentralization.dart';

class AddDecentralizationController extends GetxController {
  var decentralization = Decentralization().obs;
  var isOpenMain = false.obs;
  var isOpenDecentralization = false.obs;
  var isOpenStaffManager = false.obs;
  var isOpenCusManager = false.obs;
  var isOpenProductManager = false.obs;
  var isOpenMarketingManager = false.obs;
  var isOpenPostManager = false.obs;
  var isOpenConfigApp = false.obs;
  var isOpenConfigWeb = false.obs;
  var isOpenAddressManager = false.obs;
  var isOpenShipmentManager = false.obs;
  var isOpenPaymentManager = false.obs;
  var isOpenNotificationManager = false.obs;
  var isOpenCtvManager = false.obs;
  Decentralization? decentralizationInput;

  AddDecentralizationController({this.decentralizationInput}) {
    if (decentralizationInput != null) {
      decentralization.value = decentralizationInput!;
      isOpenMain.value = true;
      isOpenDecentralization.value = true;
      isOpenStaffManager.value = true;
      isOpenCusManager.value = true;
      isOpenProductManager.value = true;
      isOpenMarketingManager.value = true;
      isOpenPostManager.value = true;
      isOpenConfigApp.value = true;
      isOpenConfigWeb.value = true;
      isOpenAddressManager.value = true;
      isOpenShipmentManager.value = true;
      isOpenPaymentManager.value = true;
      isOpenNotificationManager.value = true;
      isOpenCtvManager.value = true;
    }
  }

  Future<void> addDecentralization() async {
    try {
      var data = await RepositoryManager.decentralizationRepository
          .addDecentralization(decentralization.value);
      SahaAlert.showSuccess(message: "Thêm thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateDecentralization() async {
    try {
      var data = await RepositoryManager.decentralizationRepository
          .updateDecentralization(
              decentralization.value, decentralization.value.id!);
      SahaAlert.showSuccess(message: "Cập nhật thành công");
      Get.back(result: "reload");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
