import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

class OrderManageController extends GetxController {
  var indexStateWatch = 0.obs;
  var isSearch = false.obs;
  var chooseTime = false.obs;
  int? agencyId;
  int? ctvId;
  String? phoneNumber;
  var dateFrom = DateTime.now().obs;
  var dateTo = DateTime.now().obs;
  int? indexTabTimeSave;
  int? indexChooseSave;
  DateTime? fromDateInput;
  DateTime? toDateInput;
  OrderManageController(
      {this.ctvId, this.agencyId, this.fromDateInput, this.toDateInput, this.phoneNumber}) {
    if (fromDateInput != null) {
      dateFrom.value = fromDateInput!;
      chooseTime.value = true;
    } else {
      dateFrom.value = DateTime(dateFrom.value.year - 2, dateFrom.value.month,
          dateFrom.value.day, 0, 0, 0);
    }
    if (toDateInput != null) {
      chooseTime.value = true;
      dateTo.value = toDateInput!;
    }
  }
  String? textSearch = "";
  void changeState(int index) {
    indexStateWatch.value = index;
    listCheckRefresh([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);
    refreshData(
      indexStateWatch.value == 0 ? "order_status_code" : "payment_status_code",
      indexStateWatch.value == 0 ? listStatusCode[0] : listStatusCodePayment[0],
      0,
    );
  }

  List<bool> listIsEndOrder = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<int> listPageLoadMore = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
  var isDoneLoadMore = false.obs;
  var isLoadInit = true.obs;
  var listAllOrder =
      RxList<List<Order>>([[], [], [], [], [], [], [], [], [], []]);
  var listAllOrderPayment = RxList<List<Order>>([[], [], [], [], [], []]);
  var listCheckIsEmpty = RxList<bool>(
      [false, false, false, false, false, false, false, false, false, false]);

  var listCheckRefresh = RxList<int>([1, 1, 1, 1, 1, 1, 1, 1, 1, 1]);

  var listStatusCode = [
    WAITING_FOR_PROGRESSING,
    PACKING,
    SHIPPING,
    COMPLETED,
    OUT_OF_STOCK,
    USER_CANCELLED,
    CUSTOMER_CANCELLED,
    DELIVERY_ERROR,
    CUSTOMER_RETURNING,
    CUSTOMER_HAS_RETURNS,
  ];

  var listStatusCodePayment = [
    WAITING_FOR_PROGRESSING,
    UNPAID,
    PAID,
    PARTIALLY_PAID,
    CANCELLED,
    REFUNDS,
  ];

  Future<void> loadInitOrder(
      String fieldBy, String filterByValue, int indexStatus) async {
    isLoadInit.value = true;
    listPageLoadMore[indexStatus] = 1;
    listIsEndOrder[indexStatus] = false;
    loadMoreOrder(fieldBy, filterByValue, indexStatus);
  }

  Future<void> loadMoreOrder(
      String fieldBy, String filterByValue, int indexStatus) async {
    isDoneLoadMore.value = false;
    listCheckIsEmpty[indexStatus] = false;
    if (isSearch.value == true) {
      listAllOrder[indexStatus] = [];
    }
    try {
      if (!listIsEndOrder[indexStatus]) {
        print(dateFrom);
        print(dateTo);
        var dateFromNew = DateTime(dateFrom.value.year, dateFrom.value.month,
            dateFrom.value.day, 0, 0, 0);
        var dateToNew = dateTo.value;

        if (dateTo.value.day < DateTime.now().day) {
          dateToNew = DateTime(dateFrom.value.year, dateFrom.value.month,
              dateFrom.value.day, 23, 59, 59);
        }
        var res = await RepositoryManager.orderRepository.getAllOrder(
          phoneNumber:phoneNumber ,
            numberPage: listPageLoadMore[indexStatus],
            search: textSearch ?? "",
            fieldBy: fieldBy,
            filterByValue: filterByValue,
            dateFrom: dateFromNew.toIso8601String(),
            dateTo: dateToNew.toIso8601String(),
            agencyByCustomerId: agencyId,
            collaboratorByCustomerId: ctvId);

        res!.data!.data!.forEach((element) {
          listAllOrder[indexStatus].add(element);
        });

        if (listAllOrder[indexStatus].isEmpty) {
          listCheckIsEmpty[indexStatus] = true;
        }

        listCheckRefresh[indexStatus]++;
        listAllOrder.refresh();

        if (res.data!.nextPageUrl != null) {
          listPageLoadMore[indexStatus]++;
          listIsEndOrder[indexStatus] = false;
        } else {
          listIsEndOrder[indexStatus] = true;
        }
      } else {
        isDoneLoadMore.value = true;
        return;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isDoneLoadMore.value = true;
    isLoadInit.value = false;
  }

  Future<void> refreshData(
      String fieldBy, String filterByValue, int indexStatus) async {
    isLoadInit.value = true;
    listAllOrder[indexStatus] = [];
    loadInitOrder(fieldBy, filterByValue, indexStatus);
  }
}
