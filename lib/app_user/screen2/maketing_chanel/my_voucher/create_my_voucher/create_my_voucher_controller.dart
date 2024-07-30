import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../data/remote/response-request/customer/all_group_customer_res.dart';
import '../../../../model/agency_type.dart';

enum DiscountType { k0, k1 }

class CreateMyVoucherController extends GetxController {
  var isLoadingCreate = false.obs;
  var dateStart = DateTime.now().obs;
  var timeStart = DateTime.now().add(Duration(minutes: 1)).obs;
  var dateEnd = DateTime.now().obs;
  var timeEnd = DateTime.now().add(Duration(hours: 2)).obs;
  var listSelectedProduct = RxList<Product>();
  var listProductParam = "";
  var discountFor = 0.obs;
  var isFreeShip = false.obs;
  var isUseOnce = false.obs;
  var checkDayStart = false.obs;
  var checkDayEnd = false.obs;
  var isUseOnceCodeMultipleTime = true.obs;
  var listGroup = RxList<GroupCustomer>();
  var groupCustomer = <GroupCustomer>[].obs;
  var isPublic = true.obs;

  TextEditingController nameProgramEditingController =
      new TextEditingController();
  TextEditingController codeVoucherEditingController =
      new TextEditingController();
  TextEditingController pricePermanentEditingController =
      new TextEditingController();
  TextEditingController pricePercentEditingController =
      new TextEditingController();
  TextEditingController priceDiscountLimitedEditingController =
      new TextEditingController();
  TextEditingController minimumOrderEditingController =
      new TextEditingController();
  TextEditingController amountCodeAvailableEditingController =
      new TextEditingController();

  TextEditingController valueShipEdit = new TextEditingController();
  var amountUseOnce = TextEditingController();
  var voucherLength = TextEditingController();
  var startingCharacter = TextEditingController();
  var textHideShowVoucher = "Hiển thị".obs;
  var isShowVoucher = true.obs;
  var isLimitedPrice = true.obs;
  var typeVoucherDiscount = "Chọn loại giảm giá".obs;
  var isChoosedTypeVoucherDiscount = true.obs;
  var isCheckMinimumOrderDiscount = true.obs;

  Rx<DiscountType?> discountType = DiscountType.k1.obs;
  var discountTypeRequest = 0.obs;

  var group = [0].obs;

  var listAgencyType = RxList<AgencyType>();
  var agencyType = <AgencyType>[].obs;

  CreateMyVoucherController() {
    getAllAgencyType();
    getAllGroupCustomer();
  }

  Future<void> getAllAgencyType() async {
    try {
      var data = await RepositoryManager.agencyRepository.getAllAgencyType();
      listAgencyType(data!.data!);
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

  void checkTypeDiscount() {
    if (discountType.value == DiscountType.k0) {
      if (priceDiscountLimitedEditingController.text.isEmpty) {
        typeVoucherDiscount.value =
            "Không giới hạn - " + pricePercentEditingController.text + "%";
      } else {
        typeVoucherDiscount.value = "Giới hạn - " +
            priceDiscountLimitedEditingController.text +
            "đ -" +
            pricePercentEditingController.text +
            "%";
      }
    } else {
      typeVoucherDiscount.value =
          "Cố định - " + pricePermanentEditingController.text + "đ";
    }
  }

  void onChangeRatio(DiscountType? v) {
    discountType.value = v;
    if (discountType.value == DiscountType.k1) {
      discountTypeRequest.value = 0;
    } else {
      discountTypeRequest.value = 1;
    }
  }

  void deleteProduct(int idProduct) {
    listSelectedProduct.removeWhere((product) => product.id == idProduct);
    listSelectedProduct.refresh();
  }

  void listSelectedProductToString() {
    listProductParam = "";
    listSelectedProduct.forEach((element) {
      if (element != listSelectedProduct.last) {
        listProductParam = listProductParam + "${element.id.toString()},";
      } else {
        listProductParam = listProductParam + "${element.id.toString()}";
      }
    });
    print(listProductParam);
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

  Future<void> createVoucher({int? voucherType}) async {
    try {
      if (group.contains(2)) {
        if (agencyType.isEmpty) {
          SahaAlert.showError(message: 'Chưa chọn cấp đại lý');
          isLoadingCreate.value = false;
          return;
        }
      }if (group.contains(4) ) {
        if (groupCustomer.isEmpty ) {
          SahaAlert.showError(message: 'Chưa chọn nhóm khách hàng');
          isLoadingCreate.value = false;
          return;
        }
      }
      var res = await RepositoryManager.marketingChanel.createVoucher(
        VoucherRequest(
          isShowVoucher: isShowVoucher.value,
          isPublic :isPublic.value,
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
          voucherType: voucherType,
          discountType: discountTypeRequest.value,
          shipDiscountValue: valueShipEdit.text == ''
              ? null
              : double.parse(
                  SahaStringUtils().convertFormatText(valueShipEdit.text)),
          discountFor: discountFor.value,
          isFreeShip: isFreeShip.value,
          valueDiscount: discountFor.value != 1
              ? discountTypeRequest.value == 0
                  ? double.parse(SahaStringUtils()
                      .convertFormatText(pricePermanentEditingController.text))
                  : double.parse(SahaStringUtils()
                      .convertFormatText(pricePercentEditingController.text))
              : null,
          setLimitValueDiscount: isLimitedPrice.value,
          maxValueDiscount: priceDiscountLimitedEditingController.text.isEmpty
              ? 0
              : int.parse(SahaStringUtils().convertFormatText(
                  priceDiscountLimitedEditingController.text)),
          setLimitTotal: true,
          valueLimitTotal: minimumOrderEditingController.text.isEmpty
              ? 0
              : int.parse(SahaStringUtils()
                  .convertFormatText(minimumOrderEditingController.text)),
          setLimitAmount: true,
          amount: amountCodeAvailableEditingController.text.isEmpty
              ? 0
              : int.parse(SahaStringUtils().convertFormatText(
                  amountCodeAvailableEditingController.text)),
          code: codeVoucherEditingController.text,
          products: listProductParam,
          group: group,
          agencyTypes: agencyType,
          groupTypes: groupCustomer,
          isUseOnce: isUseOnce.value,
          startingCharacter: startingCharacter.text == "" ? null : startingCharacter.text,
          voucherLength: int.tryParse(voucherLength.text),
          isUseOnceCodeMultipleTime: isUseOnceCodeMultipleTime.value,
          amountUseOnce: int.tryParse(amountUseOnce.text)
        ),
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
  }
}
