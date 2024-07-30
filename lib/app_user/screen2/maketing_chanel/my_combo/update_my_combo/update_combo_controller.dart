import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/combo/combo_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/combo.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../data/remote/response-request/customer/all_group_customer_res.dart';
import '../../../../model/agency_type.dart';

enum DiscountType { k0, k1 }

class UpdateMyComboController extends GetxController {
  var isLoadingCreate = false.obs;
  var dateStart = DateTime.now().obs;
  var timeStart = DateTime.now().add(Duration(minutes: 1)).obs;
  var dateEnd = DateTime.now().obs;
  var timeEnd = DateTime.now().add(Duration(hours: 2)).obs;
  var discountTypeInput = 0.obs;
  var listSelectedProduct = RxList<Product>();
  var listSelectedProductParam = RxList<ComboProduct>();

  var checkDayStart = false.obs;
  var checkDayEnd = false.obs;

  TextEditingController nameProgramEditingController =
      new TextEditingController();
  TextEditingController valueEditingController = new TextEditingController();
  TextEditingController amountCodeAvailableEditingController =
      new TextEditingController();
  Combo? comboInput;
  bool isSaveTypeCombo = false;
  HomeController homeController = Get.find();

  UpdateMyComboController({this.comboInput}) {
    getAllAgencyType();
    getAllGroupCustomer();
  }

  var textHideShowVoucher = "Hiển thị".obs;
  var isShowVoucher = true.obs;
  var isLimitedPrice = true.obs;
  var typeVoucherDiscount = "Chọn".obs;
  var isChoosedTypeVoucherDiscount = true.obs;
  Rx<DiscountType?> discountType = DiscountType.k1.obs;
  var discountTypeRequest = 1.obs;
  var validateComboPercent = false.obs;

  var group = [0].obs;

  var listAgencyType = RxList<AgencyType>();
  var agencyType = <AgencyType>[].obs;

  var listGroup = RxList<GroupCustomer>();
  var groupCustomer = <GroupCustomer>[].obs;

  Future<void> getAllGroupCustomer() async {
    try {
      var res =
          await RepositoryManager.customerRepository.getAllGroupCustomer(limit: 50);
      listGroup(res!.data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllAgencyType() async {
    try {
      var data = await RepositoryManager.agencyRepository.getAllAgencyType();
      listAgencyType(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void checkTypeDiscountInput() {
    if (discountTypeInput.value == 1) {
      typeVoucherDiscount.value =
          "Giảm ${SahaStringUtils().convertToMoney(valueEditingController.text)} %";
      discountType.value = DiscountType.k1;
    } else {
      typeVoucherDiscount.value =
          "Giảm đ${SahaStringUtils().convertToMoney(SahaStringUtils().convertFormatText(valueEditingController.text))}";
      discountType.value = DiscountType.k0;
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

  void checkTypeDiscount() {
    if (discountType.value == DiscountType.k1) {
      typeVoucherDiscount.value = "Giảm ${valueEditingController.text} %";
    } else {
      typeVoucherDiscount.value = "Giảm đ${valueEditingController.text}";
    }
  }

  void onChangeRatio(DiscountType? v) {
    if (discountType.value == DiscountType.k1) {
      valueEditingController.text = "";
    } else {
      valueEditingController.text = "";
    }
    discountType.value = v;
    if (discountType.value == DiscountType.k1) {
      discountTypeRequest.value = 1;
    } else {
      discountTypeRequest.value = 0;
    }
    print(discountTypeRequest.value);
  }

  Future<void> updateCombo(int? idCombo) async {
    isLoadingCreate.value = true;
    try {
      if (group.contains(2)) {
        if (agencyType.isEmpty) {
          SahaAlert.showError(message: 'Chưa chọn cấp đại lý');
          isLoadingCreate.value = false;
          return;
        }
      }

      if (group.contains(4)) {
        if (groupCustomer.isEmpty) {
          SahaAlert.showError(message: 'Chưa chọn nhóm khách hàng');
          isLoadingCreate.value = false;
          return;
        }
      }
      var res = await RepositoryManager.marketingChanel.updateCombo(
        idCombo,
        ComboRequest(
          name: nameProgramEditingController.text,
          description: "",
          imageUrl: "",
          startTime: DateTime(
                  dateStart.value.year,
                  dateStart.value.month,
                  dateStart.value.day,
                  timeStart.value.hour,
                  timeStart.value.minute,
                  timeStart.value.second,
                  timeStart.value.millisecond,
                  timeStart.value.microsecond)
              .toIso8601String(),
          endTime: DateTime(
                  dateEnd.value.year,
                  dateEnd.value.month,
                  dateEnd.value.day,
                  timeEnd.value.hour,
                  timeEnd.value.minute,
                  timeEnd.value.second,
                  timeEnd.value.millisecond,
                  timeEnd.value.microsecond)
              .toIso8601String(),
          discountType: discountTypeRequest.value,
          valueDiscount: isSaveTypeCombo == false
              ? comboInput?.valueDiscount ?? 0
              : double.parse(SahaStringUtils()
                  .convertFormatText(valueEditingController.text)),
          setLimitAmount:
              amountCodeAvailableEditingController.text.isEmpty ? false : true,
          amount: amountCodeAvailableEditingController.text.isEmpty
              ? 0
              : int.parse(amountCodeAvailableEditingController.text),
          comboProducts: listSelectedProductParam.toJson(),
            group: group,
         agencyTypes: agencyType,
         groupTypes: groupCustomer
        ),
      );
      homeController.getComboCustomer();
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
  }

  void deleteProduct(int idProduct) {
    listSelectedProduct.removeWhere((product) => product.id == idProduct);
    listSelectedProductParam
        .removeWhere((product) => product.productId == idProduct);
    listSelectedProduct.refresh();
  }

  void listSelectedProductToComboProduct() {
    listSelectedProduct.forEach((element) {
      int indexSame =
          listSelectedProductParam.indexWhere((e) => e.productId == element.id);
      if (indexSame == -1) {
        listSelectedProductParam
            .add(ComboProduct(productId: element.id, quantity: 1));
      }
    });
    print(listSelectedProductParam);
  }

  void increaseAmountProductCombo(int index) {
    listSelectedProductParam[index].quantity =
        listSelectedProductParam[index].quantity! + 1;
    listSelectedProductParam.refresh();
    print(listSelectedProductParam[0].quantity);
  }

  void decreaseAmountProductCombo(int index) {
    if (listSelectedProductParam[index].quantity! > 1) {
      listSelectedProductParam[index].quantity =
          listSelectedProductParam[index].quantity! - 1;
      listSelectedProductParam.refresh();
      print(listSelectedProductParam[0].quantity);
    }
  }
}
