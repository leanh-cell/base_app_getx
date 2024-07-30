import 'package:com.ikitech.store/app_user/data/remote/response-request/customer/all_group_customer_res.dart';
import 'package:com.ikitech.store/app_user/model/info_customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';

class AddGroupCustomerController extends GetxController {
  TextEditingController nameEdit = TextEditingController();
  TextEditingController noteEdit = TextEditingController();
  var loadInit = false.obs;
  var isSelectCustomer = false.obs;
  var listCustomerChoose = <InfoCustomer>[].obs;

  var groupCustomerRq = GroupCustomer(conditionItems: []).obs;

  GroupCustomer? groupCustomerInput;

  AddGroupCustomerController({this.groupCustomerInput}) {
    if (groupCustomerInput != null) {
      getGroupCustomer();
    }
  }

  Future<void> addGroupCustomer() async {
    if (isSelectCustomer.value == false) {
      groupCustomerRq.value.customerIds = null;
      if ((groupCustomerRq.value.conditionItems ?? []).isEmpty) {
        SahaAlert.showError(message: 'Chưa chọn các điều kiện');
        return;
      }
    } else {
      groupCustomerRq.value.conditionItems = null;
      if ((groupCustomerRq.value.customerIds ?? []).isEmpty) {
        SahaAlert.showError(message: 'Chưa chọn khách hàng nào');
        return;
      }
    }
    try {
      var res = await RepositoryManager.customerRepository
          .addGroupCustomer(groupCustomer: groupCustomerRq.value);
      SahaAlert.showSuccess(message: "Đã thêm");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateGroupCustomer() async {
    if (isSelectCustomer.value == false) {
      groupCustomerRq.value.customerIds = null;
      if ((groupCustomerRq.value.conditionItems ?? []).isEmpty) {
        SahaAlert.showError(message: 'Chưa chọn các điều kiện');
        return;
      }
    } else {
      groupCustomerRq.value.conditionItems = null;
      if ((groupCustomerRq.value.customerIds ?? []).isEmpty) {
        SahaAlert.showError(message: 'Chưa chọn khách hàng nào');
        return;
      }
    }

    try {
      var res = await RepositoryManager.customerRepository.updateGroupCustomer(
          groupCustomer: groupCustomerRq.value,
          groupId: groupCustomerInput!.id!);
      SahaAlert.showSuccess(message: "Đã sửa");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getGroupCustomer() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.customerRepository
          .getGroupCustomer(groupId: groupCustomerInput!.id!);
      groupCustomerRq(res!.data!);
      nameEdit.text = groupCustomerRq.value.name ?? "";
      noteEdit.text = groupCustomerRq.value.note ?? "";
      if (groupCustomerRq.value.groupType == 1) {
        isSelectCustomer.value = true;
        listCustomerChoose(groupCustomerRq.value.customers ?? []);
        groupCustomerRq.value.customerIds =
            (groupCustomerRq.value.customers ?? [])
                .map((e) => e.id ?? -1)
                .toList();
      }
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
