import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

class PayBillController extends GetxController {
  String orderCode;

  PayBillController({required this.orderCode}) ;

  Future<void> payBill(
      {required int paymentMethod, required double amountMoney}) async {
    try {
      var data = await RepositoryManager.orderRepository.payBill(
        orderCode: orderCode,
        paymentMethod: paymentMethod,
        amountMoney: amountMoney,
      );
      SahaAlert.showSuccess(message: "Đã thanh toán");
      Get.back();
      Get.back(result: "reload");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
