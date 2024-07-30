import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/bonus_level.dart';
import 'package:com.ikitech.store/app_user/model/collaborator_configs.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';

import '../../../../model/agency_config.dart';

class CommissionAgencyController extends GetxController {
  var isLoading = false.obs;
  var listLevelBonus = RxList<BonusLevel>();
  var checkInput = RxList<bool>();
  var isAllowPaymentRequest = false.obs;
  var paymentOneOfMonth = false.obs;
  var payment16OfMonth = false.obs;
  var allowRoseReferralCustomer = false.obs;
  var bonusTypeForAgencyT2 = 0.obs;

  var limitMoneyEditingController = TextEditingController().obs;
  var percentRoseRankMoneyEditingController = TextEditingController().obs;

  CommissionAgencyController() {
    getAllLevelBonus();
    getConfigsCollabBonus();
  }

  Future<void> getAllLevelBonus({bool? isRefresh}) async {
    if (isRefresh == true) {
      checkInput([]);
    }
    try {
      isLoading.value = true;
      var data =
          await RepositoryManager.agencyRepository.getAllLevelBonusAgency();
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
      var data = await RepositoryManager.agencyRepository
          .addLevelBonusAgency(limit, bonus);
      SahaAlert.showSuccess(message: "Thành Công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateLevelBonus(int limit, int bonus, int idLevel) async {
    try {
      var data = await RepositoryManager.agencyRepository
          .updateLevelBonusAgency(limit, bonus, idLevel);
      SahaAlert.showSuccess(message: "Thành Công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteLevelBonus(int idLevel) async {
    try {
      var data = await RepositoryManager.agencyRepository
          .deleteLevelBonusAgency(idLevel);
      SahaAlert.showSuccess(message: "Xoá thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> configsCollabBonus() async {
    try {
      var data = await RepositoryManager.agencyRepository
          .configsCollabBonusAgency(AgencyConfig(
              typeRose: 0,
              allowPaymentRequest: isAllowPaymentRequest.value,
              payment1OfMonth: paymentOneOfMonth.value,
              payment16OfMonth: payment16OfMonth.value,
              paymentLimit: double.parse(SahaStringUtils().convertFormatText(
                  limitMoneyEditingController.value.text == ""
                      ? "0"
                      : limitMoneyEditingController.value.text)),
              ));
      SahaAlert.showSuccess(message: "Thành Công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getConfigsCollabBonus() async {
    try {
      var data = await RepositoryManager.agencyRepository
          .getConfigsCollabBonusAgency();
      isAllowPaymentRequest.value = data!.data!.allowPaymentRequest!;
      paymentOneOfMonth.value = data.data!.payment1OfMonth!;
      payment16OfMonth.value = data.data!.payment16OfMonth!;
      limitMoneyEditingController.value.text =
          "${SahaStringUtils().convertToUnit(data.data!.paymentLimit!.toString())}";
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
