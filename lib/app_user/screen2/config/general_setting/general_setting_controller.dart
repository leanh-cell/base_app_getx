import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/general_setting.dart';

class GeneralSettingController extends GetxController {
  var generalSetting = GeneralSetting().obs;
  TextEditingController notiStockCountNearEdit = TextEditingController();
  var percentVat = TextEditingController(); 
  var loadInit = false.obs;
  

  GeneralSettingController() {
    getGeneralSettings();
  }

  Future<void> getGeneralSettings() async {
    loadInit.value = true;
    try {
      var data =
          await RepositoryManager.generalSettingRepository.getGeneralSettings();
      generalSetting.value = data!.data!;
      notiStockCountNearEdit.text = data.data!.notiStockCountNear.toString();
      percentVat.text = data.data!.percentVat.toString();
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> editGeneralSettings() async {
    if(generalSetting.value.enableVat == true && generalSetting.value.percentVat == null){
      SahaAlert.showError(message: "Vui lòng nhập phí VAT");
      return;
    }
    try {
      var data = await RepositoryManager.generalSettingRepository
          .editGeneralSettings(generalSetting.value);
      generalSetting.value = data!.data!;
      SahaAlert.showSuccess(message: "Cập nhật thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
