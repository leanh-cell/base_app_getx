import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/payment_history.dart';

class PaymentHistoryController extends GetxController {
  String orderCode;

  PaymentHistoryController({required this.orderCode}) {
    getPaymentHistory();
  }

  var listPaymentHistory = RxList<PaymentHistory>();

  Future<void> getPaymentHistory() async {
    try {
      var data =
          await RepositoryManager.orderRepository.getPaymentHistory(orderCode);
      listPaymentHistory(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
