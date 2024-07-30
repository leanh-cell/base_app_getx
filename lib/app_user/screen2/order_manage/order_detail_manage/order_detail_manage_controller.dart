import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/history_shipper_response.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/shipment.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:com.ikitech.store/app_user/model/branch.dart' as b;
import 'package:sahashop_customer/app_customer/model/state_order.dart';

import '../../../data/remote/response-request/order/calculate_fee_order_res.dart';
import '../../../utils/string_utils.dart';

class OrderDetailController extends GetxController {
  Order? inputOrder;

  var orderResponse = Order().obs;
  var isLoadingOrder = false.obs;
  bool isToOrderRefund = false;
  var listBranch = RxList<b.Branch>();
  var listShipmentStore = RxList<Shipment>();

  TextEditingController weightEdit = TextEditingController();
  TextEditingController widthEdit = TextEditingController();
  TextEditingController heightEdit = TextEditingController();
  TextEditingController lengthEdit = TextEditingController();
  TextEditingController cod = TextEditingController();
  var listItemFee = RxList<ItemFee>();

  OrderDetailController({this.inputOrder}) {
    getAllBranch();
    getOneOrder();
    getStateHistoryOrder();
    getStateHistoryShipper();
    //calculateFeeOrder();
    getAllShipmentStore();
  }

  var listStateOrder = RxList<StateOrder>();
  var listHistoryShipper = RxList<HistoryShipper>();

  Future<void> getAllBranch() async {
    try {
      var data =
          await RepositoryManager.branchRepository.getAllBranch(getAll: true);
      listBranch(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllShipmentStore() async {
    try {
      var res = await RepositoryManager.addressRepository.getAllShipmentStore();
      listShipmentStore(res!.data!);
      print('=======> ${listShipmentStore.map((element) => element.name)}');
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> calculateFeeOrder() async {
    try {
      var data = await RepositoryManager.orderRepository
          .calculateFeeOrder(inputOrder!.orderCode!);
      listItemFee(data!.data?.data ?? []);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getOneOrder({String? orderCode}) async {
    isLoadingOrder.value = true;
    try {
      var res = await RepositoryManager.orderRepository
          .getOneOrder(orderCode ?? inputOrder!.orderCode!);
      orderResponse(res!.data);
      print(orderResponse.value.packageWeight);
      weightEdit.text = orderResponse.value.packageWeight == null
          ? ""
          : SahaStringUtils()
              .convertToUnit(orderResponse.value.packageWeight.toString());
      heightEdit.text = orderResponse.value.packageHeight == null
          ? ""
          : SahaStringUtils()
              .convertToUnit(orderResponse.value.packageHeight.toString());
      widthEdit.text = orderResponse.value.packageWidth == null
          ? ""
          : SahaStringUtils()
              .convertToUnit(orderResponse.value.packageWidth.toString());
      lengthEdit.text = orderResponse.value.packageLength == null
          ? ""
          : SahaStringUtils()
              .convertToUnit(orderResponse.value.packageLength.toString());
      cod.text = orderResponse.value.cod == null
          ? ""
          : SahaStringUtils()
              .convertToUnit(orderResponse.value.cod.toString());
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingOrder.value = false;
  }

  Future<void> getStateHistoryOrder() async {
    try {
      var res = await RepositoryManager.orderRepository
          .getStateHistoryOrder(inputOrder!.id);
      listStateOrder(res!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getStateHistoryShipper() async {
    try {
      var res = await RepositoryManager.orderRepository
          .getStateHistoryShipper(inputOrder!.orderCode);
      listHistoryShipper(res!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> changeOrderStatus(String orderStatusCode) async {
    try {
      var res = await RepositoryManager.orderRepository
          .changeOrderStatus(inputOrder!.orderCode, orderStatusCode);
      getOneOrder();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updateOrder(
      {int? partnerShipperId, double? totalShippingFee, int? branchId}) async {
    try {
      var res = await RepositoryManager.orderRepository.updateOrder(
          inputOrder!.orderCode!, partnerShipperId, totalShippingFee, branchId);
      getOneOrder();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> changePaymentStatus(String paymentStatusCode) async {
    try {
      var res = await RepositoryManager.orderRepository
          .changePaymentStatus(inputOrder!.orderCode, paymentStatusCode);
      getOneOrder();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> sendOrderToShipper() async {
    try {
      var res = await RepositoryManager.orderRepository.sendOrderToShipper(
        inputOrder!.orderCode,
      );
      changeOrderStatus(SHIPPING);
      getStateHistoryShipper();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> updatePackage() async {
    try {
      var res = await RepositoryManager.orderRepository.updatePackage(
        inputOrder!.orderCode!,
        double.tryParse(SahaStringUtils().convertFormatText(heightEdit.text)) ??
            0,
        double.tryParse(SahaStringUtils().convertFormatText(widthEdit.text)) ??
            0,
        double.tryParse(SahaStringUtils().convertFormatText(lengthEdit.text)) ??
            0,
        double.tryParse(SahaStringUtils().convertFormatText(weightEdit.text)) ??
            0,
         double.tryParse(SahaStringUtils().convertFormatText(cod.text)) ??
            0,
      );
      orderResponse(res!.data!);
      weightEdit.text = orderResponse.value.packageWeight == null
          ? ""
          : SahaStringUtils()
              .convertToUnit(orderResponse.value.packageWeight.toString());
      heightEdit.text = orderResponse.value.packageHeight == null
          ? ""
          : SahaStringUtils()
              .convertToUnit(orderResponse.value.packageHeight.toString());
      widthEdit.text = orderResponse.value.packageWidth == null
          ? ""
          : SahaStringUtils()
              .convertToUnit(orderResponse.value.packageWidth.toString());
      lengthEdit.text = orderResponse.value.packageLength == null
          ? ""
          : SahaStringUtils()
              .convertToUnit(orderResponse.value.packageLength.toString());
      SahaAlert.showSuccess(message: "Đã cập nhật kiện hàng");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
