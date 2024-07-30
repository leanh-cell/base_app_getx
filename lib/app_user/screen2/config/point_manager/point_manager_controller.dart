import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/reward_point.dart';
import '../../../utils/string_utils.dart';

class PointManagerController extends GetxController {
  var moneyAPointEdit = TextEditingController(text: "0").obs;
  TextEditingController limitOrderEdit = TextEditingController();
  var percentRefundEdit = TextEditingController(text: "0").obs;
  TextEditingController orderMaxPointEdit = TextEditingController();
  TextEditingController reviewPointEdit = TextEditingController();
  TextEditingController introducePointEdit = TextEditingController();
  TextEditingController percentMaxPointUseEdit = TextEditingController();

  var permissionUsePoint = false.obs;
  var limitedPoint = false.obs;
  var rewardPoint = RewardPoint().obs;
  var isPercentUse = false.obs;
  var bonusPointBonusProductToAgency = false.obs;
  var bonusPointProductToAgency = false.obs;

  PointManagerController() {
    getRewardPoint();
  }

  void convertEdit() {
    moneyAPointEdit.value.text = SahaStringUtils()
        .convertToUnit(rewardPoint.value.moneyAPoint.toString());
    percentRefundEdit.value.text = rewardPoint.value.percentRefund.toString();
    orderMaxPointEdit.text = rewardPoint.value.orderMaxPoint.toString();
    reviewPointEdit.text = rewardPoint.value.pointReview.toString();
    introducePointEdit.text = rewardPoint.value.pointIntroduceCustomer.toString();
    permissionUsePoint.value = rewardPoint.value.allowUsePointOrder!;
    limitedPoint.value = rewardPoint.value.isSetOrderMaxPoint!;
    percentMaxPointUseEdit.text = (rewardPoint.value.percentUseMaxPoint ?? 0).toString();
    isPercentUse.value = rewardPoint.value.isPercentUseMaxPoint!;
    bonusPointBonusProductToAgency.value = rewardPoint.value.bonusPointBonusProductToAgency!;
    bonusPointProductToAgency.value = rewardPoint.value.bonusPointProductToAgency!;
    moneyAPointEdit.refresh();
    percentRefundEdit.refresh();
  }

  Future<void> getRewardPoint() async {
    try {
      var res = await RepositoryManager.pointRepository.getRewardPoint();
      rewardPoint.value = res!.rewardPoint!;
      convertEdit();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> resetRewardPoint() async {
    try {
      var res = await RepositoryManager.pointRepository.resetRewardPoint();
      rewardPoint.value = res!.rewardPoint!;
      convertEdit();
      SahaAlert.showSuccess(message: "Đặt lại thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> configRewardPoint() async {
    try {
      rewardPoint.value.moneyAPoint = double.parse(SahaStringUtils()
          .convertFormatText(moneyAPointEdit.value.text == ""
              ? "0"
              : moneyAPointEdit.value.text));
      rewardPoint.value.isSetOrderMaxPoint = limitedPoint.value;
      rewardPoint.value.isPercentUseMaxPoint = isPercentUse.value;
      rewardPoint.value.allowUsePointOrder = permissionUsePoint.value;
      rewardPoint.value.pointReview =
          double.parse(reviewPointEdit.text == "" ? "0" : reviewPointEdit.text);
      rewardPoint.value.pointIntroduceCustomer = double.parse(
          introducePointEdit.text == "" ? "0" : introducePointEdit.text);
      rewardPoint.value.orderMaxPoint = double.tryParse(
          orderMaxPointEdit.text == "" ? "0" : orderMaxPointEdit.text);
      rewardPoint.value.percentRefund = double.parse(
          percentRefundEdit.value.text == ""
              ? "0"
              : percentRefundEdit.value.text);
      rewardPoint.value.percentUseMaxPoint = double.parse(percentMaxPointUseEdit.value.text);
      rewardPoint.value.bonusPointBonusProductToAgency = bonusPointBonusProductToAgency.value;
      rewardPoint.value.bonusPointProductToAgency = bonusPointProductToAgency.value;
      var res = await RepositoryManager.pointRepository
          .configRewardPoint(rewardPoint.value);
      rewardPoint.value = res!.rewardPoint!;
      SahaAlert.showSuccess(message: "Đã lưu");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
