import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/bonus_level.dart';
import 'package:com.ikitech.store/app_user/model/collaborator_configs.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';

class CommissionCtvController extends GetxController {
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
  var bonusTypeForCtvT2 = 0.obs;

  var limitMoneyEditingController = TextEditingController().obs;
  var percentRoseRankMoneyEditingController = TextEditingController().obs;

  CommissionCtvController() {
    getAllLevelBonus();
    getConfigsCollabBonus();
  }

  Future<void> getAllLevelBonus({bool? isRefresh}) async {
    if (isRefresh == true) {
      checkInput([]);
    }
    try {
      isLoading.value = true;
      var data = await RepositoryManager.ctvRepository.getAllLevelBonus();
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
          await RepositoryManager.ctvRepository.addLevelBonus(limit, bonus);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateLevelBonus(int limit, int bonus, int idLevel) async {
    try {
      var data = await RepositoryManager.ctvRepository
          .updateLevelBonus(limit, bonus, idLevel);
      SahaAlert.showSuccess(message: "Thành Công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteLevelBonus(int idLevel) async {
    try {
      var data =
          await RepositoryManager.ctvRepository.deleteLevelBonus(idLevel);
      SahaAlert.showSuccess(message: "Xoá thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> configsCollabBonus() async {
    try {
      var data = await RepositoryManager.ctvRepository.configsCollabBonus(
          CollaboratorConfig(
              typeRose: 0,
              allowPaymentRequest: isAllowPaymentRequest.value,
              payment1OfMonth: paymentOneOfMonth.value,
              payment16OfMonth: payment16OfMonth.value,
              allowRoseReferralCustomer: allowRoseReferralCustomer.value,
              bonusTypeForCtvT2: bonusTypeForCtvT2.value,
              paymentLimit: double.parse(SahaStringUtils().convertFormatText(
                  limitMoneyEditingController.value.text == ""
                      ? "0"
                      : limitMoneyEditingController.value.text)),
              percentCollaboratorT1: double.tryParse(
                  "${percentRoseRankMoneyEditingController.value.text == "" ? "0" : percentRoseRankMoneyEditingController.value.text}")));
      SahaAlert.showSuccess(message: "Thành Công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getConfigsCollabBonus() async {
    try {
      var data = await RepositoryManager.ctvRepository.getConfigsCollabBonus();
      if (data!.data!.typeRose! == 0) {
        typeCMSChoose.value = "% Theo doanh số";
      } else {
        typeCMSChoose.value = "% Theo hoa hồng giới thiệu";
      }
      isAllowPaymentRequest.value = data.data?.allowPaymentRequest ?? false;
      paymentOneOfMonth.value = data.data?.payment1OfMonth ?? false;
      payment16OfMonth.value = data.data?.payment16OfMonth ?? false;
      bonusTypeForCtvT2.value = data.data?.bonusTypeForCtvT2 ?? 0;
      allowRoseReferralCustomer.value =
          data.data?.allowRoseReferralCustomer ?? false;
      limitMoneyEditingController.value.text =
          "${SahaStringUtils().convertToUnit(data.data!.paymentLimit!.toString())}";
      percentRoseRankMoneyEditingController.value.text =
          "${data.data!.percentCollaboratorT1 ?? 0}";
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
