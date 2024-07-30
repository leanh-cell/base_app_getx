import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/refund_request.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/refund_calculate.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/state_order.dart';

class RefundController extends GetxController {
  Order? inputOrder;
  var isHideInputQuantity = false.obs;
  var orderResponse = Order().obs;
  var isLoadingOrder = false.obs;
  var refundRequest = RefundRequest();
  var listMax = [];
  int? indexItem;
  var isLoading = false.obs;
  var priceToTal = 0.0.obs;
  var listNewItem = RxList<NewLineItem>();

  var refundCalculateShow = RefundCalculate().obs;

  RefundController({this.inputOrder}) {
    getOneOrder();
  }

  var listStateOrder = RxList<StateOrder>();

  void totalPrice() {
    priceToTal.value = 0;
    listNewItem.forEach((e) {
      priceToTal.value =
          priceToTal.value + ((e.quantity ?? 0) * (e.price ?? 0));
    });
  }

  Future<void> getOneOrder() async {
    isLoading.value = true;
    try {
      var res = await RepositoryManager.orderRepository
          .getOneOrder(inputOrder!.orderCode!);
      orderResponse(res!.data);
      List<LineItem> listRequest = [];
      (orderResponse.value.lineItems ?? []).forEach((e) {
        if ((e.quantity ?? 0) - (e.totalRefund ?? 0) != 0) {
          listRequest.add(e);
        }
      });
      orderResponse.value.lineItems = listRequest;
      (orderResponse.value.lineItems ?? []).forEach((e) {
        listMax.add((e.quantity ?? 0) - (e.totalRefund ?? 0));
        e.quantity = (e.quantity ?? 0) - (e.totalRefund ?? 0);
      });
      (orderResponse.value.lineItems ?? []).forEach((e) {
        listNewItem.add(NewLineItem(
          lineItemId: e.id!,
          quantity: (e.quantity ?? 0),
          price: e.itemPrice,
        ));
      });
      refundCalculate();
    } catch (err) {
      isLoading.value = false;
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
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

  Future<void> changeOrderStatus(String orderStatusCode) async {
    try {
      var res = await RepositoryManager.orderRepository
          .changeOrderStatus(inputOrder!.orderCode, orderStatusCode);
      getOneOrder();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> refund() async {
    try {
      var res = await RepositoryManager.orderRepository.refund(RefundRequest(
          orderCode: inputOrder!.orderCode, newLineItems: listNewItem));
      //  getOneOrder();
      Get.back();
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> refundCalculate() async {
    try {
      if (listNewItem.isEmpty) {
        refundCalculateShow.value = RefundCalculate();
        return;
      }
      var res = await RepositoryManager.orderRepository.refundCalculate(
          RefundRequest(
              orderCode: inputOrder!.orderCode, newLineItems: listNewItem));

      refundCalculateShow.value = res!.data!;
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
}
