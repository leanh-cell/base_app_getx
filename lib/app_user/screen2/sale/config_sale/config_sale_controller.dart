import 'package:com.ikitech.store/app_user/model/config_sale.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/bonus_level.dart';

class ConfigSaleController extends GetxController {
  var configSale = ConfigSale().obs;

  ConfigSaleController() {
    getConfigSale();
    getBonusStepSale();
  }

  Future<void> getConfigSale() async {
    try {
      var data = await RepositoryManager.saleRepo.getConfigSale();
      configSale(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> setConfigSale() async {
    try {
      var data =
          await RepositoryManager.saleRepo.setConfigSale(configSale.value);
      configSale(data!.data!);
      SahaAlert.showSuccess(message: 'Thành công');
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  var listTypeCMS =
  RxList<String>(["% Theo doanh số", "% Theo hoa hồng giới thiệu"]);
  var typeCMSChoose = "% Theo doanh số".obs;
  var isLoading = false.obs;
  var listLevelBonus = RxList<BonusLevel>();
  var checkInput = RxList<bool>();
  var isAllowPaymentRequest = false.obs;
  var paymentOneOfMonth = false.obs;
  var payment16OfMonth = false.obs;
  var allowRoseReferralCustomer = false.obs;
  var bonusTypeForSaleT2 = 0.obs;

  var limitMoneyEditingController = TextEditingController().obs;
  var percentRoseRankMoneyEditingController = TextEditingController().obs;


  Future<void> getBonusStepSale({bool? isRefresh}) async {
    if (isRefresh == true) {
      checkInput([]);
    }
    try {
      isLoading.value = true;
      var data = await RepositoryManager.saleRepo.getBonusStepSale();
      listLevelBonus(data!.data);
      listLevelBonus.forEach((e) {
        if (e.limit != null && e.bonus != null) {
          checkInput.add(false);
        } else {
          checkInput.add(true);
        }
      });
      if (listLevelBonus.isEmpty) {
        checkInput.add(false);
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> addLevelBonus(int limit, int bonus) async {
    try {
      var data =
      await RepositoryManager.saleRepo.addLevelBonusSale(limit, bonus);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateLevelBonus(int limit, int bonus, int idLevel) async {
    try {
      var data = await RepositoryManager.saleRepo
          .updateLevelBonusSale(limit, bonus, idLevel);
      SahaAlert.showSuccess(message: "Thành Công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteLevelBonus(int idLevel) async {
    try {
      var data =
      await RepositoryManager.saleRepo.deleteLevelBonusSale(idLevel);
      SahaAlert.showSuccess(message: "Xoá thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
