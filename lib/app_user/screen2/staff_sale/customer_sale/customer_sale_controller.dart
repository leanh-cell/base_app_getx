import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';

import '../../../model/info_customer.dart';

class CustomerSaleController extends GetxController {
  var listInfoCustomer = RxList<InfoCustomer>();
  var isDoneLoadMore = false.obs;
  var isEndCustomer = false.obs;
  var pageLoadMore = 1;
  var isLoadInit = false.obs;
  var searching = false.obs;

  var search = "";
  var sortBy = "";
  var descending = false;
  var fieldBy = "";
  var fieldByValue = "";

  int? dayOfBirth;
  int? monthOfBirth;
  int? yearOfBirth;

  var timeInputSearch = DateTime.now();

  var typeSearch = 0.obs;
  var dateOfBirth = DateTime.now().obs;
  var finish = FinishHandle(milliseconds: 500);

  CustomerSaleController() {
    isLoadInit.value = true;
    getAllInfoCustomerSale(isRefresh: true);
  }

  Future<void> getAllInfoCustomerSale({bool? isRefresh}) async {
    finish.run(() async {
      isDoneLoadMore.value = false;

      if (isRefresh == true) {
        pageLoadMore = 1;
        isEndCustomer.value = false;
      }

      try {
        if (!isEndCustomer.value) {
          var res = await RepositoryManager.customerRepository
              .getAllInfoCustomerSale(
                  pageLoadMore,
                  search,
                  sortBy,
                  descending,
                  fieldBy,
                  fieldByValue,
                  dayOfBirth,
                  monthOfBirth,
                  yearOfBirth,
                  null);
          if (isRefresh == true) {
            listInfoCustomer(res!.data!.data!);
          } else {
            listInfoCustomer.addAll(res!.data!.data!);
          }

          if (res.data!.nextPageUrl != null) {
            pageLoadMore++;
            isEndCustomer.value = false;
          } else {
            isEndCustomer.value = true;
          }
        } else {
          isLoadInit.value = false;
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
