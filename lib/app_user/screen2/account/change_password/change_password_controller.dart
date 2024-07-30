import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

class ChangePasswordController extends GetxController {
  var resting = false.obs;
  var newPassInputting = false.obs;

  TextEditingController textEditingControllerNewPass =
  new TextEditingController();
  TextEditingController textEditingControllerOldPass =
  new TextEditingController();

  Future<void> onChange() async {
    resting.value = true;
    try {
      var loginData = (await RepositoryManager.loginRepository.changePassword(
        newPass: textEditingControllerNewPass.text,
          oldPass: textEditingControllerOldPass.text,))!;

      SahaAlert.showSuccess(message: "Thay đổi mật khẩu thành công");
      Get.back();
      resting.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      resting.value = false;
    }
    resting.value = false;
  }
}
