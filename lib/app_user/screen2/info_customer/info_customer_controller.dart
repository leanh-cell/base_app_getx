import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/const/const_revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/revenue_expenditure.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

class InfoCustomerController extends GetxController {
  var infoCustomer = InfoCustomer().obs;
  int infoCustomerId;
  var listRevenueExpenditure = RxList<RevenueExpenditure>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;

  int currentPageOrder = 1;
  var isDoneLoadMore = false.obs;
  var isLoadInit = true.obs;
  bool isEndOrder = false;
  var listOrder = RxList<Order>();
  var dateFrom = DateTime.now().obs;
  var dateTo = DateTime.now().obs;

  InfoCustomerController({required this.infoCustomerId}) {
    getInfoCustomer();
    getAllRevenueExpenditure(isRefresh: true);
    isLoadInit.value = true;
  }

  Future<void> loadMoreOrder({bool? isRefresh}) async {
    isDoneLoadMore.value = false;

    if (isRefresh == true) {
      currentPageOrder = 1;
      isEndOrder = false;
    }

    try {
      if (!isEndOrder) {
        var res = await RepositoryManager.orderRepository.getAllOrder(
          numberPage: currentPage,
          phoneNumber: infoCustomer.value.phoneNumber,
          dateFrom: dateFrom.value.toIso8601String(),
          dateTo: dateTo.value.toIso8601String(),
        );

        if (isRefresh == true) {
          listOrder(res!.data!.data!);
        } else {
          res!.data!.data!.forEach((element) {
            listOrder.add(element);
          });
        }

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

  Future<void> getInfoCustomer() async {
    try {
      var data = await RepositoryManager.customerRepository
          .getInfoCustomer(infoCustomerId);
      infoCustomer.value = data!.data!;
      loadMoreOrder();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllRevenueExpenditure({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    if (textSearch != null && textSearch != "") {
      currentPage = 1;
      listRevenueExpenditure([]);
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.revenueExpenditureRepository
            .getAllRevenueExpenditure(
                page: currentPage,
                recipientGroup: RECIPIENT_GROUP_CUSTOMER,
                recipientReferencesId: infoCustomerId);

        if (isRefresh == true) {
          listRevenueExpenditure(data!.data!.data!);
        } else {
          listRevenueExpenditure.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addCustomerToSale({required int staffId}) async {
    try {
      var data = await RepositoryManager.saleRepo.addCustomerToSale(
          listCustomerId: [infoCustomerId], staffId: staffId);
      Get.back();
      getInfoCustomer();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
