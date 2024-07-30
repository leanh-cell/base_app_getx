import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/sale/over_view_sale_res.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

import '../../../../data/repository/repository_manager.dart';
import '../../../../model/info_customer.dart';
import '../../../../model/staff.dart';
import '../../../../utils/finish_handle_utils.dart';

class SaleDetailController extends GetxController {
  var staff = Staff().obs;
  Staff staffInput;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  var isDoneLoadMore = false.obs;
  bool isEndOrder = false;
  var listOrder = RxList<Order>();
  var overViewSale = OverViewSale().obs;
  var listInfoCustomer = RxList<InfoCustomer>();
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

  SaleDetailController({required this.staffInput}) {
    staff(staffInput);
    getOverviewSale();
    getAllCustomer(isRefresh: true);
    loadMoreOrder(isRefresh: true);
    isLoadInit.value = true;
  }

  var type = 0.obs;

  Future<void> getOverviewSale() async {
    try {
      var data = await RepositoryManager.staffRepository
          .getOverviewSale(staffId: staffInput.id!);
      overViewSale(data!.data!);
      type.value = overViewSale.value.saleConfig?.typeBonusPeriod ?? 0;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllCustomer({bool? isRefresh}) async {
    finish.run(() async {
      isDoneLoadMore.value = false;

      if (isRefresh == true) {
        pageLoadMore = 1;
        isEndCustomer.value = false;
      }

      try {
        if (!isEndCustomer.value) {
          var res = await RepositoryManager.customerRepository
              .getAllInfoCustomer(
                  numberPage: pageLoadMore,
                  search : search,
                  sortBy : sortBy,
                  descending : descending,
                  fieldBy : fieldBy,
                  fieldByValue : fieldByValue,
                  dayOfBirth : dayOfBirth,
                  monthOfBirth : monthOfBirth,
                  yearOfBirth : yearOfBirth,
                  saleStaffId :staffInput.id,
             );
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

  var pageLoadMore2 = 1;
  var isLoadInit2 = false.obs;
  bool isEndOrder2 = false;
  var isDoneLoadMore2 = false.obs;

  Future<void> loadMoreOrder({bool? isSearch, bool? isRefresh}) async {
    isDoneLoadMore2.value = false;
    finish.run(() async {
      if (isSearch == true) {
        pageLoadMore2 = 1;
        isEndOrder2 = false;
      }

      if (isRefresh == true) {
        pageLoadMore2 = 1;
        isEndOrder2 = false;
      }

      try {
        if (!isEndOrder2) {
          var res = await RepositoryManager.orderRepository.getAllOrder(
              numberPage: pageLoadMore2,
              search: textSearch ?? "",
              staffId: staffInput.id);

          if (isRefresh == true || isSearch == true) {
            listOrder(res!.data!.data!);
          } else {
            listOrder.addAll(res!.data!.data!);
          }

          listOrder.refresh();

          if (res.data!.nextPageUrl != null) {
            pageLoadMore2++;
            isEndOrder2 = false;
          } else {
            isEndOrder2 = true;
          }
          isLoadInit2.value = false;
          isDoneLoadMore2.value = true;
        } else {
          isLoadInit2.value = false;
          isDoneLoadMore2.value = true;
          return;
        }
        isLoadInit2.value = false;
      } catch (err) {
        isLoadInit2.value = false;
        SahaAlert.showError(message: err.toString());
      }
      isDoneLoadMore2.value = true;
      isLoadInit2.value = false;
    });
  }
}
