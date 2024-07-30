import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../data/remote/response-request/customer/all_group_customer_res.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/agency_type.dart';
import '../../../../model/bonus_product.dart';

class UpdateBonusProductController extends GetxController {
  final int updateBonusProductId;
  var loadInit = false.obs;
  var bonusProductReq =
      BonusProduct(group: [], groupTypes: [], agencyTypes: []).obs;

  //////////////////
  /////////////
  TextEditingController nameProgramEditingController =
      new TextEditingController();
  TextEditingController valueEditingController = new TextEditingController();
  TextEditingController amountCodeAvailableEditingController =
      new TextEditingController();
  /////////////
  var dateStart = DateTime.now().obs;
  var timeStart = DateTime.now().add(Duration(minutes: 1)).obs;
  var dateEnd = DateTime.now().obs;
  var timeEnd = DateTime.now().add(Duration(hours: 2)).obs;
  var checkDayStart = false.obs;
  var checkDayEnd = false.obs;
  /////////
  UpdateBonusProductController({required this.updateBonusProductId}){
    getAllAgencyType();
    getAllGroupCustomer();
    getBonusProduct();
  }
  var listAgencyType = RxList<AgencyType>();
  var listGroup = RxList<GroupCustomer>();

  Future<void> getAllAgencyType() async {
    try {
      var data = await RepositoryManager.agencyRepository.getAllAgencyType();
      listAgencyType(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllGroupCustomer() async {
    try {
      var res =
          await RepositoryManager.customerRepository.getAllGroupCustomer(limit: 50);
      listGroup(res!.data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void onChangeDateStart(DateTime date) {
    if (date.isBefore(dateStart.value) == true) {
      checkDayStart.value = true;
      dateStart.value = date;
    } else {
      checkDayStart.value = false;
      dateStart.value = date;
    }
  }

  void onChangeDateEnd(DateTime date) {
    if (date.isBefore(dateStart.value) == true) {
      checkDayEnd.value = true;
      dateEnd.value = date;
    } else {
      checkDayEnd.value = false;
      dateEnd.value = date;
    }
  }

  void onChangeTimeEnd(DateTime date) {
    if (date.isBefore(timeStart.value) == true) {
      checkDayEnd.value = true;
      timeEnd.value = date;
    } else {
      checkDayEnd.value = false;
      timeEnd.value = date;
    }
  }

  Future<void> getBonusProduct() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.marketingChanel
          .getBonusProduct(updateBonusProductId);
      bonusProductReq.value = res!.data!;
      convertRes();
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void convertRes() {
    nameProgramEditingController.text = bonusProductReq.value.name!;
    dateStart.value = DateTime(
      bonusProductReq.value.startTime!.year,
      bonusProductReq.value.startTime!.month,
      bonusProductReq.value.startTime!.day,
      bonusProductReq.value.startTime!.hour,
      bonusProductReq.value.startTime!.minute,
      bonusProductReq.value.startTime!.second,
      bonusProductReq.value.startTime!.millisecond,
      bonusProductReq.value.startTime!.microsecond,
    );
    dateEnd.value = DateTime(
      bonusProductReq.value.endTime!.year,
      bonusProductReq.value.endTime!.month,
      bonusProductReq.value.endTime!.day,
      bonusProductReq.value.endTime!.hour,
      bonusProductReq.value.endTime!.minute,
      bonusProductReq.value.endTime!.second,
      bonusProductReq.value.endTime!.millisecond,
      bonusProductReq.value.endTime!.microsecond,
    );
    timeStart.value = DateTime(
      bonusProductReq.value.startTime!.year,
      bonusProductReq.value.startTime!.month,
      bonusProductReq.value.startTime!.day,
      bonusProductReq.value.startTime!.hour,
      bonusProductReq.value.startTime!.minute,
      bonusProductReq.value.startTime!.second,
      bonusProductReq.value.startTime!.millisecond,
      bonusProductReq.value.startTime!.microsecond,
    );
    timeEnd.value = DateTime(
      bonusProductReq.value.endTime!.year,
      bonusProductReq.value.endTime!.month,
      bonusProductReq.value.endTime!.day,
      bonusProductReq.value.endTime!.hour,
      bonusProductReq.value.endTime!.minute,
      bonusProductReq.value.endTime!.second,
      bonusProductReq.value.endTime!.millisecond,
      bonusProductReq.value.endTime!.microsecond,
    );

    amountCodeAvailableEditingController.text =
        bonusProductReq.value.amount == null
            ? ""
            : bonusProductReq.value.amount.toString();
  }
}
