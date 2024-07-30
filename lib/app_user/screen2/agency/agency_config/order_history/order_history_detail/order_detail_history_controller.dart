import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/toast/saha_alert.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/state_order.dart';
import 'package:sahashop_customer/app_customer/repository/repository_customer.dart';


class OrderHistoryDetailCtvController extends GetxController {
  Order? orderInput;
  var listChoose = RxList<bool>([false, false, false, false, false, false]);
  var reason = "";
  var isLoading = false.obs;
  var order = Order().obs;

  OrderHistoryDetailCtvController({this.orderInput}) {
    getOneOrderHistory();
    getStateHistoryCustomerOrder();
  }

  var listStateOrder = RxList<StateOrder>();

  Future<void> getStateHistoryCustomerOrder() async {
    try {
      var res = await CustomerRepositoryManager.orderCustomerRepository
          .getStateHistoryCustomerOrder(orderInput!.id);
      listStateOrder(res!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getOneOrderHistory() async {
    isLoading.value = true;
    try {
      var res = await CustomerRepositoryManager.orderCustomerRepository
          .getOneOrderHistory(orderInput!.orderCode);
      order.value = res!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> cancelOrder() async {
    try {
      var res = await CustomerRepositoryManager.orderCustomerRepository
          .cancelOrder(orderInput!.orderCode, reason);
      Get.back(result: "CANCELLED");
    } catch (err) {

    }
  }

  void checkChooseReason(bool value, int index) {
    listChoose([false, false, false, false, false, false]);
    if (value == false) {
      listChoose[index] = true;
    }
  }
}
