import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/revenue_expenditure.dart';

class RevenueExpenditureController extends GetxController {
  var revenueExpenditure = RevenueExpenditure().obs;
  var nameRecipientReferencesId = "".obs;
  bool isSuccess = false;
  TextEditingController desEditingController = TextEditingController();

  int? recipientGroup;
  int? recipientReferencesId;
  String? nameRecipientReferencesIdInput;
  double? changeMoney;
  bool isRevenue;
  RevenueExpenditure? revenueExpenditureInput;
  var loading = false.obs;

  RevenueExpenditureController({
    this.recipientGroup,
    this.recipientReferencesId,
    this.changeMoney,
    this.nameRecipientReferencesIdInput,
    required this.isRevenue,
    this.revenueExpenditureInput,
  }) {
    nameRecipientReferencesId.value = nameRecipientReferencesIdInput ?? "";
    revenueExpenditure.value.recipientGroup = recipientGroup;
    revenueExpenditure.value.recipientReferencesId = recipientReferencesId;
    revenueExpenditure.value.changeMoney = changeMoney;
    revenueExpenditure.value.isRevenue = isRevenue;
    revenueExpenditure.value.paymentMethod = 0;
    if (revenueExpenditureInput != null) {
      getRevenueExpenditure();
    }
  }

  Future<void> getRevenueExpenditure() async {
    loading.value = true;
    try {
      var data = await RepositoryManager.revenueExpenditureRepository
          .getRevenueExpenditure(
              idRevenueExpenditure: revenueExpenditureInput!.id!);
      revenueExpenditure.value = data!.data!;
      if (revenueExpenditure.value.customer != null) {
        nameRecipientReferencesId.value =
            revenueExpenditure.value.customer?.name ?? "";
      }
      if (revenueExpenditure.value.supplier != null) {
        nameRecipientReferencesId.value =
            revenueExpenditure.value.supplier?.name ?? "";
      }
      if (revenueExpenditure.value.staff != null) {
        nameRecipientReferencesId.value =
            revenueExpenditure.value.staff?.name ?? "";
      }
      desEditingController.text = revenueExpenditure.value.description ?? "";
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<void> createRevenueExpenditure() async {
    try {
      if (revenueExpenditure.value.type == null) {
        SahaAlert.showError(
            message: "Chưa chọn loại phiếu ${isRevenue ? "thu" : "chi"}");
        return;
      }

      if (revenueExpenditure.value.recipientGroup == null) {
        SahaAlert.showError(message: "Chưa chọn nhóm người nộp");
        return;
      }

      var data = await RepositoryManager.revenueExpenditureRepository
          .createRevenueExpenditure(
              revenueExpenditure: revenueExpenditure.value);
      revenueExpenditure.value = data!.data!;
      SahaAlert.showSuccess(
          message: ""
              "Tạo phiếu thành công");
      isSuccess = true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
