import 'dart:convert';

import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../data/remote/response-request/customer/all_group_customer_res.dart';
import '../../../../model/agency_type.dart';

class UpdateMyProgramController extends GetxController {
  var isLoadingCreate = false.obs;
  var listSelectedProduct = RxList<Product>();
  var listProductParam = "";

  var group = [0].obs;

  var listAgencyType = RxList<AgencyType>();
  var agencyType = <AgencyType>[].obs;
  var listGroup = RxList<GroupCustomer>();
  var groupCustomer = <GroupCustomer>[].obs;


  UpdateMyProgramController() {
    getAllAgencyType();
    getAllGroupCustomer();
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

  Future<void> getAllAgencyType() async {
    try {
      var data = await RepositoryManager.agencyRepository.getAllAgencyType();
      listAgencyType(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateDiscount(
      int? idDiscount,
      bool isEnd,
      String name,
      String description,
      String imageUrl,
      String startTime,
      String endTime,
      double value,
      bool setLimitedAmount,
      int amount,
     
      String listIdProduct,
      ) async {
       
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
      var data = await RepositoryManager.marketingChanel.updateDiscount(
          idDiscount,
          isEnd,
          name,
          description,
          imageUrl,
          startTime,
          endTime,
          value,
          setLimitedAmount,
          amount,
          group,
          agencyType,
          groupCustomer,
          listIdProduct);
      SahaAlert.showSuccess(message: "Sửa thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCreate.value = false;
    listProductParam = "";
    Get.back();
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
}
