import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

class ConfigNotificationController extends GetxController {
  var hasKey = false.obs;
  var key = "".obs;

  ConfigNotificationController() {
    getConfigNotification();
  }

  var titleEditingController = new TextEditingController().obs;
  var contentEditingController = new TextEditingController().obs;
  var keyEditingController = new TextEditingController().obs;

  Future<void> getConfigNotification() async {
    try {
      var res = await RepositoryManager.configNotificationRepository
          .getConfigNotification();
      if (res!.data != null) {
        key.value = res.data!.key!;
      }
      if (key.value != "") {
        hasKey.value = true;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> configNotification() async {
    try {
      var res = await RepositoryManager.configNotificationRepository
          .configNotification(keyEditingController.value.text);
      SahaAlert.showSuccess(message: "Thêm thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> sendNotification() async {
    try {
      var res = await RepositoryManager.configNotificationRepository
          .sendNotification(titleEditingController.value.text,
              contentEditingController.value.text);
      SahaAlert.showSuccess(message: "Gửi thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
