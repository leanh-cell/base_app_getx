import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

class HistoryOrderController extends GetxController {
  int currentPage = 1;
  var isDoneLoadMore = false.obs;
  var isLoadInit = true.obs;
  bool isEndOrder = false;
  var listOrder = RxList<Order>();
  String phoneNumber;

  HistoryOrderController({required this.phoneNumber}) {
    isLoadInit.value = true;
    loadMoreOrder();
  }

  Future<void> loadMoreOrder() async {
    isDoneLoadMore.value = false;
    try {
      if (!isEndOrder) {
        var res = await RepositoryManager.orderRepository
            .getAllOrder(numberPage: currentPage, phoneNumber: phoneNumber);

        res!.data!.data!.forEach((element) {
          listOrder.add(element);
        });

        if (res.data!.nextPageUrl != null) {
          currentPage++;
          isEndOrder = false;
        } else {
          isEndOrder = true;
        }
      } else {
        isDoneLoadMore.value = true;
        isLoadInit.value = false;
        return;
      }
      isLoadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isDoneLoadMore.value = true;
    isLoadInit.value = false;
  }
}
