import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/order_commerce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCommerceDetailController extends GetxController {
  var orderCommerceReq = OrderCommerce().obs;
  var loadInit = false.obs;
  var weightEdit = TextEditingController();
  var heightEdit = TextEditingController();
  var lengthEdit = TextEditingController();
  var widthEdit = TextEditingController();
  OrderCommerce orderCommerce;
  OrderCommerceDetailController({required this.orderCommerce}) {
    getOrderCommerce();
  }

  Future<void> getOrderCommerce() async {
    loadInit.value = true;
    try {
      var res = await RepositoryManager.eCommerceRepo
          .getOrderCommerce(oderCode: orderCommerce.orderCode ?? '');
      orderCommerceReq.value = res!.data!;
      loadInit.value = false;
    } catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
