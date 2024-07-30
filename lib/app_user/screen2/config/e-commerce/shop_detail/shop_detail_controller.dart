import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/e_commerce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/remote/response-request/e_commerce/all_werehouses_res.dart';

class ShopDetailController extends GetxController {
  /////
  List<String> list1 = <String>[
    'Thủ công',
    'Tự động',
  ];
  String dropDown1 = 'Thủ công';

  List<String> list2 = <String>[
    'Thủ công',
    'Tự động',
  ];
  String dropDown2 = 'Thủ công';
  List<String> list3 = <String>[
    'Thủ công',
    'Tự động',
  ];
  String dropDown3 = 'Thủ công';
  var eCommerceReq = ECommerce().obs;
  ECommerce eCommerce;
  var shopName = TextEditingController();
  var customerName = TextEditingController();
  var customerPhoneNumber = TextEditingController();
  var listWereHouse = RxList<Warehouses>();
  ShopDetailController({required this.eCommerce}) {
    eCommerceReq.value = eCommerce;
    convertInfo();
    if (eCommerceReq.value.platform == 'TIKI') {
      getAllWarehouses();
    }
  }
  Future<void> updateECommerce() async {
    try {
      var res = await RepositoryManager.eCommerceRepo.updateCommerce(
          shopId: eCommerceReq.value.shopId ?? '',
          eCommerce: eCommerceReq.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> getAllWarehouses() async {
    try {
      var res = await RepositoryManager.eCommerceRepo.getAllWarehouses(
        shopId: eCommerceReq.value.shopId ?? '',
      );
      listWereHouse(res!.data!);
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> updateWarehouses(
      {required int warehouseId, required bool allowSync}) async {
    try {
      var res = await RepositoryManager.eCommerceRepo
          .updateWarehouses(warehouseId: warehouseId, allowSync: allowSync);
      getAllWarehouses();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }


  void convertInfo() {
    shopName.text = eCommerceReq.value.shopName ?? '';
    customerName.text = eCommerceReq.value.customerName ?? '';
    customerPhoneNumber.text = eCommerceReq.value.customerPhone ?? '';
    dropDown1 =
        eCommerceReq.value.typeSyncProducts == 0 ? "Thủ công" : "Tự động";
    dropDown2 =
        eCommerceReq.value.typeSyncInventory == 0 ? "Thủ công" : "Tự động";
    dropDown3 = eCommerceReq.value.typeSyncOrders == 0 ? "Thủ công" : "Tự động";
  }

  Future<void> deleteCommerce() async {
    try {
      var res = await RepositoryManager.eCommerceRepo.deleteCommerce(
        shopId: eCommerce.shopId ?? '',
      );
      SahaAlert.showSuccess(message: "Thành công");
      Get.back();
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
