import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

class BillController extends GetxController {
  bool isEndOrder = false;
  int pageLoadMore = 1;
  var isDoneLoadMore = false.obs;
  var isLoadInit = true.obs;
  var listOrder = RxList<Order>();
  var checkIsEmpty = false.obs;
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  var isAll = true.obs;
  int indexTabTime = 0;
  int indexChooseTime = 0;

  String? textSearch = "";
  bool? isReturn;
  var finish = FinishHandle(milliseconds: 500);

  Future<void> loadMoreOrder({bool? isSearch, bool? isRefresh}) async {
    isDoneLoadMore.value = false;
    finish.run(() async {
      checkIsEmpty.value = false;
      if (isSearch == true) {
        pageLoadMore = 1;
        isEndOrder = false;
      }

      if (isRefresh == true) {
        pageLoadMore = 1;
        isEndOrder = false;
      }

      try {
        if (!isEndOrder) {
          var res = await RepositoryManager.orderRepository.getAllOrder(
              numberPage: pageLoadMore,
              search: textSearch ?? "",
              dateFrom: isAll.value ? null : fromDay.value.toIso8601String(),
              dateTo: isAll.value ? null : toDay.value.toIso8601String(),
              orderStatusCode: isReturn == true ? "CUSTOMER_HAS_RETURNS" : null,
              fromPos: true);

          if (isRefresh == true || isSearch == true) {
            listOrder(res!.data!.data!);
          } else {
            listOrder.addAll(res!.data!.data!);
          }

          listOrder.refresh();

          if (listOrder.isEmpty) {
            checkIsEmpty.value = true;
          }

          if (res.data!.nextPageUrl != null) {
            pageLoadMore++;
            isEndOrder = false;
          } else {
            isEndOrder = true;
          }
          isDoneLoadMore.value = true;
        } else {
          isDoneLoadMore.value = true;
          return;
        }
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
      isDoneLoadMore.value = true;
      isLoadInit.value = false;
    });
  }
}
