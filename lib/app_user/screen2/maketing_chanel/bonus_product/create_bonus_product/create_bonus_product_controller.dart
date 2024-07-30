import 'package:com.ikitech.store/app_user/model/bonus_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

import '../../../../data/remote/response-request/customer/all_group_customer_res.dart';
import '../../../../model/agency_type.dart';

class CreateBonusProductController extends GetxController {
  var isLoadingCreate = false.obs;
  var dateStart = DateTime.now().obs;
  var timeStart = DateTime.now().add(Duration(minutes: 1)).obs;
  var dateEnd = DateTime.now().obs;
  var timeEnd = DateTime.now().add(Duration(hours: 2)).obs;
  var listSelectedProduct = RxList<BonusProductSelected>();
  var listBonusProductSelected = RxList<BonusProductSelected>();
  var dataLadder = DataLadder().obs;

  var checkDayStart = false.obs;
  var checkDayEnd = false.obs;

  var multiProduct = false.obs;
  var ladderReward = false.obs;

  TextEditingController nameProgramEditingController =
      new TextEditingController();
  TextEditingController valueEditingController = new TextEditingController();
  TextEditingController amountCodeAvailableEditingController =
      new TextEditingController();

  BonusProduct? bonusProductInput;

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

  CreateBonusProductController({this.bonusProductInput}) {
    dataLadder.value.list = [];
    getAllAgencyType();
    getAllGroupCustomer();
    if (bonusProductInput != null) {
      getBonusProduct();
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

  Future<void> createBonusProduct() async {
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
      if (ladderReward.value == true) {
        if ((dataLadder.value.list ?? []).isEmpty) {
          SahaAlert.showError(message: 'Chưa chọn sản phẩm tặng');
          return;
        }
        if (listSelectedProduct.isEmpty) {
          SahaAlert.showError(message: 'Chưa chọn sản phẩm mua');
          return;
        }
        var product = listSelectedProduct[0];
        dataLadder.value.productId = product.productId;
        dataLadder.value.distributeName = product.distributeName;
        dataLadder.value.elementDistributeName = product.elementDistributeName;
        dataLadder.value.subElementDistributeName =
            product.subElementDistributeName;
      }
      var res = await RepositoryManager.marketingChanel.createBonusProduct(
        BonusProduct(
          name: nameProgramEditingController.text,
          description: "",
          imageUrl: "",
          multiplyByNumber: multiProduct.value,
          startTime: DateTime(
              dateStart.value.year,
              dateStart.value.month,
              dateStart.value.day,
              timeStart.value.hour,
              timeStart.value.minute,
              timeStart.value.second,
              timeStart.value.millisecond,
              timeStart.value.microsecond),
          endTime: DateTime(
              dateEnd.value.year,
              dateEnd.value.month,
              dateEnd.value.day,
              timeEnd.value.hour,
              timeEnd.value.minute,
              timeEnd.value.second,
              timeEnd.value.millisecond,
              timeEnd.value.microsecond),
          setLimitAmount:
              amountCodeAvailableEditingController.text.isEmpty ? false : true,
          amount: amountCodeAvailableEditingController.text.isEmpty
              ? 0
              : int.parse(amountCodeAvailableEditingController.text),
          bonusProducts: ladderReward.value ? null : listBonusProductSelected,
          selectProducts: ladderReward.value ? null : listSelectedProduct,
          ladderReward: ladderReward.value,
          dataLadder: dataLadder.value,
          group: group,
          agencyTypes: agencyType,
          groupTypes: groupCustomer,
        ),
      );
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
  }

  Future<void> getBonusProduct() async {
    isLoadingCreate.value = true;
    try {
      var res = await RepositoryManager.marketingChanel
          .getBonusProduct(bonusProductInput!.id!);

      nameProgramEditingController.text = res!.data!.name!;
      group.value = res.data!.group ?? [];
      agencyType.value = res.data!.agencyTypes ?? [];
      groupCustomer.value = res.data?.groupTypes ?? [];
      dateStart.value = DateTime(
        res.data!.startTime!.year,
        res.data!.startTime!.month,
        res.data!.startTime!.day,
        res.data!.startTime!.hour,
        res.data!.startTime!.minute,
        res.data!.startTime!.second,
        res.data!.startTime!.millisecond,
        res.data!.startTime!.microsecond,
      );
      dateEnd.value = DateTime(
        res.data!.endTime!.year,
        res.data!.endTime!.month,
        res.data!.endTime!.day,
        res.data!.endTime!.hour,
        res.data!.endTime!.minute,
        res.data!.endTime!.second,
        res.data!.endTime!.millisecond,
        res.data!.endTime!.microsecond,
      );
      timeStart.value = DateTime(
        res.data!.startTime!.year,
        res.data!.startTime!.month,
        res.data!.startTime!.day,
        res.data!.startTime!.hour,
        res.data!.startTime!.minute,
        res.data!.startTime!.second,
        res.data!.startTime!.millisecond,
        res.data!.startTime!.microsecond,
      );
      timeEnd.value = DateTime(
        res.data!.endTime!.year,
        res.data!.endTime!.month,
        res.data!.endTime!.day,
        res.data!.endTime!.hour,
        res.data!.endTime!.minute,
        res.data!.endTime!.second,
        res.data!.endTime!.millisecond,
        res.data!.endTime!.microsecond,
      );

      amountCodeAvailableEditingController.text =
          res.data!.amount == null ? "" : res.data!.amount.toString();

      multiProduct.value = res.data!.multiplyByNumber ?? false;

      print(res.data!.selectProducts);
      listSelectedProduct(res.data!.selectProducts);

      listBonusProductSelected(res.data!.bonusProducts);
      ladderReward.value = res.data!.ladderReward ?? false;
      if (ladderReward.value == false) {
        // ladderReward.value = false;
      } else {
        // ladderReward.value = true;
        dataLadder.value.distributeName =
            res.data!.bonusProductsLadder![0].distributeName ?? "";
        dataLadder.value.subElementDistributeName =
            res.data!.bonusProductsLadder![0].subElementDistributeName ?? "";
        dataLadder.value.elementDistributeName =
            res.data!.bonusProductsLadder![0].elementDistributeName ?? "";
        dataLadder.value.productId =
            res.data!.bonusProductsLadder![0].productId ?? 0;
        listSelectedProduct([
          BonusProductSelected(
            bonusProductId: res.data!.bonusProductsLadder![0].product?.id,
            product: res.data!.bonusProductsLadder![0].product,
            elementDistributeName:
                res.data!.bonusProductsLadder![0].elementDistributeName,
            subElementDistributeName:
                res.data!.bonusProductsLadder![0].subElementDistributeName,
            distributeName: res.data!.bonusProductsLadder![0].distributeName,
          )
        ]);
        print(listSelectedProduct[0].bonusProductId);
        dataLadder.value.list = (res.data!.bonusProductsLadder ?? [])
            .map((e) => ListOffer(
                fromQuantity: e.fromQuantity,
                bonusQuantity: e.boQuantity,
                boProductId: e.boProductId,
                boDistributeName: e.boDistributeName,
                boElementDistributeName: e.boElementDistributeName,
                boSubElementDistributeName: e.boSubElementDistributeName,
                productName: e.boProduct?.name ?? ""))
            .toList();
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
  }

  Future<void> updateBonusProduct() async {
    if (group.contains(2)) {
      if (agencyType.isEmpty) {
        SahaAlert.showError(message: 'Chưa chọn cấp đại lý');
        isLoadingCreate.value = false;
        return;
      }
    }
    try {
      if (ladderReward.value == true) {
        if ((dataLadder.value.list ?? []).isEmpty) {
          SahaAlert.showError(message: 'Chưa chọn sản phẩm tặng');
          return;
        }
        if (listSelectedProduct.isEmpty) {
          SahaAlert.showError(message: 'Chưa chọn sản phẩm mua');
          return;
        }

        var product = listSelectedProduct[0];
        print(product.productId);
        dataLadder.value.productId = product.bonusProductId;
        dataLadder.value.distributeName = product.distributeName;
        dataLadder.value.elementDistributeName = product.elementDistributeName;
        dataLadder.value.subElementDistributeName =
            product.subElementDistributeName;
      }
      var data = await RepositoryManager.marketingChanel.updateBonusProduct(
        bonusProductInput!.id!,
        BonusProduct(
          name: nameProgramEditingController.text,
          description: "",
          imageUrl: "",
          multiplyByNumber: multiProduct.value,
          startTime: DateTime(
              dateStart.value.year,
              dateStart.value.month,
              dateStart.value.day,
              timeStart.value.hour,
              timeStart.value.minute,
              timeStart.value.second,
              timeStart.value.millisecond,
              timeStart.value.microsecond),
          endTime: DateTime(
              dateEnd.value.year,
              dateEnd.value.month,
              dateEnd.value.day,
              timeEnd.value.hour,
              timeEnd.value.minute,
              timeEnd.value.second,
              timeEnd.value.millisecond,
              timeEnd.value.microsecond),
          setLimitAmount:
              amountCodeAvailableEditingController.text.isEmpty ? false : true,
          amount: amountCodeAvailableEditingController.text.isEmpty
              ? 0
              : int.parse(amountCodeAvailableEditingController.text),
          bonusProducts: ladderReward.value ? null : listBonusProductSelected,
          selectProducts: ladderReward.value ? null : listSelectedProduct,
          ladderReward: ladderReward.value,
          dataLadder: dataLadder.value,
          group: group,
          agencyTypes: agencyType,
          groupTypes: groupCustomer,
        ),
      );

      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void deleteBonusProductSelected(int index) {
    listBonusProductSelected.removeAt(index);
    listBonusProductSelected.refresh();
  }

  void decreaseBonusProductSelected(int index) {
    if ((listBonusProductSelected[index].quantity ?? 0) > 1) {
      listBonusProductSelected[index].quantity =
          (listBonusProductSelected[index].quantity ?? 0) - 1;
    }
    listBonusProductSelected.refresh();
  }

  void increaseBonusProductSelected(int index) {
    listBonusProductSelected[index].quantity =
        (listBonusProductSelected[index].quantity ?? 0) + 1;
    listBonusProductSelected.refresh();
  }

  void deleteProductSelected(int index) {
    listSelectedProduct.removeAt(index);
    listSelectedProduct.refresh();
  }

  void decreaseProductSelected(int index) {
    if ((listSelectedProduct[index].quantity ?? 0) > 1) {
      listSelectedProduct[index].quantity =
          (listSelectedProduct[index].quantity ?? 0) - 1;
    }
    listSelectedProduct.refresh();
  }

  void increaseProductSelected(int index) {
    listSelectedProduct[index].quantity =
        (listSelectedProduct[index].quantity ?? 0) + 1;
    listSelectedProduct.refresh();
  }
}
