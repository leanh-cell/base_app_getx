import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:sahashop_customer/app_customer/model/info_address_customer.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';
import 'package:sahashop_customer/app_customer/model/shipment_method.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/orders/order_request.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';

class ConfirmUserController extends GetxController {
  var isLoadingOrder = false.obs;
  Rx<InfoAddressCustomer?> infoAddressCustomer = InfoAddressCustomer().obs;
  var isLoadingAddress = false.obs;
  var shipmentMethodCurrent = ShipmentMethod().obs;
  var listShipmentFast = RxList<ShipmentMethod>();
  var isLoadingShipmentMethod = false.obs;
  var idPaymentCurrent = 0.obs;
  var paymentMethodName = "Thanh toán khi nhận hàng".obs;
  var opacityCurrent = 1.0.obs;
  var opacityPaymentCurrent = 1.0.obs;
  var colorAnimateAddress = Colors.transparent.obs;
  var colorAnimatePayment = Colors.transparent.obs;
  var amountMoney = 0.0.obs;
   HomeController homeController = Get.find();

  double? cod;


  InfoCustomer? infoCustomer;
  TextEditingController noteCustomerEditingController = TextEditingController();
  int partnerShipperId = 0;
  int shipperType = 0;
  int totalShippingFee = 0;
  var paymentMethod = 2.obs;


  ConfirmUserController() {
    if(paymentMethod.value == 2){
      cod = (homeController.cartCurrent.value.cartData?.totalFinal ?? 0) - amountMoney.value;
    }
    shipmentMethodCurrent.value.fee = 0;
    infoAddressCustomer.value = InfoAddressCustomer(id: 0);
  }

}
