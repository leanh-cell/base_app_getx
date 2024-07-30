import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/voucher_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/voucher.dart';
import 'package:com.ikitech.store/app_user/screen2/maketing_chanel/my_combo/create_my_combo/create_combo_controller.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../data/remote/response-request/customer/all_group_customer_res.dart';
import '../../../../model/agency_type.dart';

class UpdateVoucherController extends GetxController {
  var loadInit = false.obs;
  var isLoadingCreate = false.obs;
  var dateStart = DateTime.now().obs;
  var timeStart = DateTime.now().add(Duration(minutes: 1)).obs;
  var dateEnd = DateTime.now().obs;
  var timeEnd = DateTime.now().add(Duration(hours: 2)).obs;
  var listSelectedProduct = RxList<Product>();
  var listProductParam = "";
  var isShowVoucher = true.obs;
  var isPublic = true.obs;
  var voucherRes = Voucher().obs;
  var checkDayStart = false.obs;
  var checkDayEnd = false.obs;
  var discountFor = 0.obs;
  var isFreeShip = false.obs;
  var isUseOnce = false.obs;
  var amountUseOnce = TextEditingController();
  var voucherLength = TextEditingController();
  var startingCharacter = TextEditingController();
  var isUseOnceCodeMultipleTime = true.obs;

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

  var textHideShowVoucher = "Hiển thị".obs;
  var isLimitedPrice = true.obs;
  var typeVoucherDiscount = "Chọn loại giảm giá".obs;
  var isChoosedTypeVoucherDiscount = true.obs;
  var isCheckMinimumOrderDiscount = true.obs;
  Voucher? voucherInput;

  var listGroup = RxList<GroupCustomer>();
  var groupCustomer = <GroupCustomer>[].obs;

  UpdateVoucherController({this.voucherInput}) {
    getAllAgencyType();
    getAllGroupCustomer();
    getVoucher();
  }

  Rx<DiscountType?> discountType = DiscountType.k1.obs;
  var discountTypeRequest = 0.obs;
  var discountTypeInput = 0.obs;
  var voucherTypeInput = 0.obs;
  bool isSaveTypeDiscount = false;

  var group = [0].obs;

  var listAgencyType = RxList<AgencyType>();
  var agencyType = <AgencyType>[].obs;

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

  void checkTypeDiscountInput() {
    if (discountTypeInput.value == 1) {
      if (isLimitedPrice.value == false) {
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
    isSaveTypeDiscount = false;
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
    listSelectedProduct.forEach((element) {
      if (element != listSelectedProduct.last) {
        listProductParam = listProductParam + "${element.id.toString()},";
      } else {
        listProductParam = listProductParam + "${element.id.toString()}";
      }
    });
    print(listProductParam);
  }

  Future<void> updateVoucher(int? idVoucher) async {
    print(discountTypeRequest.value);
    isLoadingCreate.value = true;
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
    try {
      var res = await RepositoryManager.marketingChanel.updateVoucher(
        idVoucher,
        VoucherRequest(
            isShowVoucher: isShowVoucher.value,
            isPublic: isPublic.value,
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
            voucherType:
                listSelectedProduct.isEmpty ? 0 : voucherTypeInput.value,
            discountType: isSaveTypeDiscount == true
                ? discountTypeRequest.value
                : voucherInput!.discountType,
            valueDiscount: isSaveTypeDiscount == true
                ? discountTypeRequest.value == 1
                    ? double.parse(pricePercentEditingController.text)
                    : double.parse(SahaStringUtils().convertFormatText(
                        pricePermanentEditingController.text))
                : voucherInput!.valueDiscount,
            setLimitValueDiscount: isLimitedPrice.value,
            shipDiscountValue: valueShipEdit.text == ''
                ? null
                : double.parse(
                    SahaStringUtils().convertFormatText(valueShipEdit.text)),
            discountFor: discountFor.value,
            isFreeShip: isFreeShip.value,
            maxValueDiscount: priceDiscountLimitedEditingController.text.isEmpty
                ? 0
                : int.parse(
                    SahaStringUtils().convertFormatText(priceDiscountLimitedEditingController.text)),
            setLimitTotal: true,
            valueLimitTotal: minimumOrderEditingController.text.isEmpty ? 0 : int.parse(SahaStringUtils().convertFormatText(minimumOrderEditingController.text)),
            setLimitAmount: true,
            amount: amountCodeAvailableEditingController.text.isEmpty ? 0 : int.parse(SahaStringUtils().convertFormatText(amountCodeAvailableEditingController.text)),
            code: codeVoucherEditingController.text,
            products: listProductParam,
            group: group,
            agencyTypes: agencyType,
            groupTypes: groupCustomer,
            isUseOnce: isUseOnce.value),
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
    Get.back();
  }

  Future<void> getVoucher() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.marketingChanel
          .getVoucher(voucherId: voucherInput!.id!);
      voucherRes.value = res!.data!;
      convertRes();
      await getProductVoucher();
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showSuccess(message: e.toString());
    }
  }

  void convertRes() {
    nameProgramEditingController.text = voucherRes.value.name!;
    codeVoucherEditingController.text = voucherRes.value.code!;
    isShowVoucher.value = voucherRes.value.isShowVoucher ?? true;
    listSelectedProduct.value = voucherRes.value.products ?? [];

    dateStart.value = DateTime(
      voucherRes.value.startTime!.year,
      voucherRes.value.startTime!.month,
      voucherRes.value.startTime!.day,
      voucherRes.value.startTime!.hour,
      voucherRes.value.startTime!.minute,
      voucherRes.value.startTime!.second,
      voucherRes.value.startTime!.millisecond,
      voucherRes.value.startTime!.microsecond,
    );
    dateEnd.value = DateTime(
      voucherRes.value.endTime!.year,
      voucherRes.value.endTime!.month,
      voucherRes.value.endTime!.day,
      voucherRes.value.endTime!.hour,
      voucherRes.value.endTime!.minute,
      voucherRes.value.endTime!.second,
      voucherRes.value.endTime!.millisecond,
      voucherRes.value.endTime!.microsecond,
    );
    timeStart.value = DateTime(
      voucherRes.value.startTime!.year,
      voucherRes.value.startTime!.month,
      voucherRes.value.startTime!.day,
      voucherRes.value.startTime!.hour,
      voucherRes.value.startTime!.minute,
      voucherRes.value.startTime!.second,
      voucherRes.value.startTime!.millisecond,
      voucherRes.value.startTime!.microsecond,
    );
    timeEnd.value = DateTime(
      voucherRes.value.endTime!.year,
      voucherRes.value.endTime!.month,
      voucherRes.value.endTime!.day,
      voucherRes.value.endTime!.hour,
      voucherRes.value.endTime!.minute,
      voucherRes.value.endTime!.second,
      voucherRes.value.endTime!.millisecond,
      voucherRes.value.endTime!.microsecond,
    );
    discountTypeInput.value = voucherRes.value.discountType ?? 0;
    voucherTypeInput.value = voucherRes.value.voucherType ?? 0;

    if (voucherRes.value.discountFor != 1) {
      if (voucherRes.value.discountType! == 1) {
        pricePercentEditingController.text = SahaStringUtils()
            .convertToUnit(voucherRes.value.valueDiscount!.toString());
      } else {
        pricePermanentEditingController.text = SahaStringUtils()
            .convertToUnit(voucherRes.value.valueDiscount.toString());
      }
    }

    priceDiscountLimitedEditingController.text =
        voucherRes.value.maxValueDiscount == null
            ? ""
            : SahaStringUtils()
                .convertToUnit(voucherRes.value.maxValueDiscount.toString());
    isLimitedPrice.value = voucherRes.value.setLimitValueDiscount!;
    minimumOrderEditingController.text = SahaStringUtils()
        .convertToUnit(voucherRes.value.valueLimitTotal.toString());
    amountCodeAvailableEditingController.text = voucherRes.value.amount == null
        ? ""
        : SahaStringUtils().convertToUnit(voucherRes.value.amount.toString());
    checkTypeDiscountInput();
    onChangeRatio((voucherRes.value.discountType ?? 0) == 0
        ? DiscountType.k1
        : DiscountType.k0);

    discountFor.value = voucherRes.value.discountFor ?? 0;
    isFreeShip.value = voucherRes.value.isFreeShip ?? false;
    valueShipEdit.text = voucherRes.value.shipDiscountValue == null
        ? ""
        : SahaStringUtils()
            .convertToUnit(voucherRes.value.shipDiscountValue.toString());
    group.value = voucherRes.value.group ?? [];
    agencyType.value = voucherRes.value.agencyTypes ?? [];
    groupCustomer.value = voucherRes.value.groupTypes ?? [];
    isUseOnce.value = voucherRes.value.isUseOnce ?? false;
    isUseOnceCodeMultipleTime.value =
        voucherRes.value.isUseOnceCodeMultipleTime ?? true;
    amountUseOnce.text = voucherRes.value.amountUseOnce == null
        ? ""
        : voucherRes.value.amountUseOnce!.toString();
    voucherLength.text = voucherRes.value.voucherLength == null
        ? ""
        : voucherRes.value.voucherLength!.toString();
    startingCharacter.text = voucherRes.value.startingCharacter == null
        ? ""
        : voucherRes.value.startingCharacter!.toString();
    isPublic.value = voucherRes.value.isPublic ?? true;
  }

  Future<void> getProductVoucher() async {
    try {
      var res = await RepositoryManager.marketingChanel
          .getAllProductVoucher(page: 1, voucherId: voucherInput!.id!);
      listSelectedProduct.value = res!.data!.data!;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
