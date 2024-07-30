import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/bonus_step_res.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/step_bonus.dart';
import 'package:com.ikitech.store/app_user/screen2/agency/list_agency_type/product_agency/edit_price/widget/select_images_controller.dart';

import '../../../../data/remote/response-request/agency/import_bonus_step_res.dart';
import '../../../../model/agency_config.dart';
import '../../../../model/bonus_level.dart';
import '../../../../utils/string_utils.dart';

class RewardAgencyController extends GetxController {
  var dataBonusConfig = DataConfigBonus().obs;
  var listImportBonusStep = RxList<BonusLevel>();
  var isLoading = false.obs;
  var isLoadingImport = false.obs;
  var uploadingImages = false.obs;
  List<ImageData>? listImages = [];
  var dateStart = DateTime.now().obs;
  var timeStart = DateTime.now().add(Duration(minutes: 1)).obs;
  var dateEnd = DateTime.now().obs;
  var timeEnd = DateTime.now().add(Duration(hours: 2)).obs;
  var checkDayStart = false.obs;
  var checkDayEnd = false.obs;
  var indexW = 0.obs;
  var bonusTypeForCtvT2 = 0.obs;
  var typeBonusPeriodImport = 0.obs;

  var limitMoneyEditingController = TextEditingController().obs;
  var percentRoseRankMoneyEditingController = TextEditingController().obs;
  var loadingRose = false.obs;

  RewardAgencyController() {
    getBonusAgencyConfig(isRefresh: true);
    getImportBonusAgencyConfig();
    getAllLevelBonusAgency();
    getConfigsCollabBonus();
  }

  void setUploadingImages(bool value) {
    uploadingImages.value = value;
  }

  Future<void> getBonusAgencyConfig({bool? isRefresh}) async {
    if (isRefresh == true) {
      isLoading.value = true;
    }
    try {
      var data =
          await RepositoryManager.agencyRepository.getBonusAgencyConfig();
      dataBonusConfig.value = data!.data!;
      dateStart.value =
          dataBonusConfig.value.config?.startTime ?? DateTime.now();
      dateEnd.value = dataBonusConfig.value.config?.endTime ?? DateTime.now();
      timeStart.value = DateTime(dateStart.value.year, dateStart.value.month,
          dateStart.value.day, dateStart.value.hour, dateStart.value.minute);
      timeEnd.value = DateTime(dateEnd.value.year, dateEnd.value.month,
          dateEnd.value.day, dateEnd.value.hour, dateEnd.value.minute);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> addBonusStepAgency(StepBonus stepBonus) async {
    try {
      var data = await RepositoryManager.agencyRepository
          .addBonusStepAgency(stepBonus);
      getBonusAgencyConfig();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateBonusAgencyConfig(
      bool isEnd, DateTime startTime, DateTime endTime) async {
    try {
      var data = await RepositoryManager.agencyRepository
          .updateBonusAgencyConfig(isEnd, startTime, endTime);
      getBonusAgencyConfig();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateBonusStepAgency(int idStep, StepBonus stepBonus) async {
    try {
      var data = await RepositoryManager.agencyRepository
          .updateBonusStepAgency(idStep, stepBonus);
      getBonusAgencyConfig();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteBonusStepAgency(int idStep) async {
    try {
      var data = await RepositoryManager.agencyRepository
          .deleteBonusStepAgency(idStep);
      getBonusAgencyConfig();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  var listTypeCMS =
      RxList<String>(["% Theo doanh số", "% Theo hoa hồng giới thiệu"]);
  var typeCMSChoose = "% Theo doanh số".obs;
  var listLevelBonus = RxList<BonusLevel>();
  var checkInput = RxList<bool>();
  var isAllowPaymentRequest = false.obs;
  var paymentOneOfMonth = false.obs;
  var payment16OfMonth = false.obs;

  Future<void> getAllLevelBonusAgency({bool? isRefresh}) async {
    if (isRefresh == true) {
      checkInput([]);
    }
    try {
      loadingRose.value = true;
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
    loadingRose.value = false;
  }

  Future<void> addLevelBonusAgency(int limit, int bonus) async {
    if (limit == 0) {
      SahaAlert.showError(message: "Mức đạt không được để trống");
      return;
    }
    if (bonus == 0) {
      SahaAlert.showError(message: "Mức thưởng không được để trống");
      return;
    }
    try {
      var data = await RepositoryManager.agencyRepository
          .addLevelBonusAgency(limit, bonus);
      getAllLevelBonusAgency(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateLevelBonusAgency(int limit, int bonus, int idLevel) async {
    if (limit == 0) {
      SahaAlert.showError(message: "Mức đạt không được để trống");
      return;
    }
    if (bonus == 0) {
      SahaAlert.showError(message: "Mức thưởng không được để trống");
      return;
    }
    try {
      var data = await RepositoryManager.agencyRepository
          .updateLevelBonusAgency(limit, bonus, idLevel);
      getAllLevelBonusAgency(isRefresh: true);
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
              bonusTypeForCtvT2: bonusTypeForCtvT2.value,
              percentAgencyT1: double.parse(
                  "${percentRoseRankMoneyEditingController.value.text == "" ? "0" : percentRoseRankMoneyEditingController.value.text}")));
      SahaAlert.showSuccess(message: "Thành Công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getConfigsCollabBonus() async {
    try {
      var data = await RepositoryManager.agencyRepository
          .getConfigsCollabBonusAgency();
      if (data!.data!.typeRose == 0) {
        typeCMSChoose.value = "% Theo doanh số";
      } else {
        typeCMSChoose.value = "% Theo hoa hồng giới thiệu";
      }
      isAllowPaymentRequest.value = data.data?.allowPaymentRequest ?? false;
      paymentOneOfMonth.value = data.data?.payment1OfMonth ?? false;
      payment16OfMonth.value = data.data?.payment16OfMonth ?? false;
      limitMoneyEditingController.value.text =
          "${SahaStringUtils().convertToUnit(data.data!.paymentLimit!.toString())}";
      percentRoseRankMoneyEditingController.value.text =
          "${data.data!.percentAgencyT1 ?? 0}";
      bonusTypeForCtvT2.value = data.data?.bonusTypeForCtvT2 ?? 0;
      typeBonusPeriodImport.value = data.data?.typeBonusPeriodImport ?? 0;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> configTypeBonusPeriodImport() async {
    try {
      var data = await RepositoryManager.agencyRepository
          .configTypeBonusPeriodImport(typeBonusPeriodImport.value);
      getConfigsCollabBonus();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  ///////////////////

  Future<void> getImportBonusAgencyConfig({bool? isRefresh}) async {
    isLoadingImport.value = true;
    if (isRefresh == true) {}
    try {
      var data =
          await RepositoryManager.agencyRepository.getImportBonusAgencyConfig();
      listImportBonusStep(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingImport.value = false;
  }

  Future<void> addImportBonusStepAgency(BonusLevel stepBonus) async {
    if (stepBonus.limit == null) {
      SahaAlert.showError(message: "Mức đạt không được để trống");
      return;
    }
    if (stepBonus.bonus == null) {
      SahaAlert.showError(message: "Mức thưởng không được để trống");
      return;
    }
    try {
      var data = await RepositoryManager.agencyRepository
          .addImportBonusStepAgency(stepBonus);
      getImportBonusAgencyConfig(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateImportBonusStepAgency(
      int idStep, BonusLevel stepBonus) async {
    if (stepBonus.limit == null) {
      SahaAlert.showError(message: "Mức đạt không được để trống");
      return;
    }
    if (stepBonus.bonus == null) {
      SahaAlert.showError(message: "Mức thưởng không được để trống");
      return;
    }
    try {
      var data = await RepositoryManager.agencyRepository
          .updateImportBonusStepAgency(idStep, stepBonus);
      getImportBonusAgencyConfig(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteImportBonusStepAgency(int idStep) async {
    try {
      var data = await RepositoryManager.agencyRepository
          .deleteImportBonusStepAgency(idStep);
      getImportBonusAgencyConfig();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
