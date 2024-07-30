import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:get/get.dart';

import '../../../model/filter_top_sale.dart';

class TopSaleController extends GetxController {
  var listSale = RxList<Staff>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;

  var filterOrder = FilterTopSale(
          staffs: [],
          dateFrom: SahaDateUtils().getFirstDayOfMonthDATETIME(),
          dateTo: SahaDateUtils().getEndDayOfMonthDateTime())
      .obs;

  FilterTopSale? filterTopSaleInput;

  TopSaleController({this.filterTopSaleInput}) {
    if (filterTopSaleInput != null) {
      filterOrder(filterTopSaleInput);
    }
    getTopSale(isRefresh: true);
  }

  Future<void> getTopSale({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }
print((filterOrder.value.staffs ?? []).isEmpty
    ? null
    : (filterOrder.value.staffs ?? [])
    .map((e) => e.id)
    .toString()
    .replaceAll("(", "")
    .replaceAll(")", ""),);
    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.saleRepo.getTopSale(
          page: currentPage,
          dateFrom: filterOrder.value.dateFrom ??
              SahaDateUtils().getFirstDayOfMonthDATETIME(),
          dateTo: filterOrder.value.dateTo ??
              SahaDateUtils().getEndDayOfMonthDateTime(),
          customerType: filterOrder.value.type,
          staffId: (filterOrder.value.staffs ?? []).isEmpty
              ? null
              : (filterOrder.value.staffs ?? [])
                  .map((e) => e.id)
                  .toString()
              .replaceAll("(", "")
              .replaceAll(")", ""),
          provinceIds: (filterOrder.value.provinceIds ?? []).isEmpty
              ? null
              : (filterOrder.value.provinceIds ?? [])
                  .map((e) => e.id)
                  .toString()
              .replaceAll("(", "")
              .replaceAll(")", ""),
        );

        if (isRefresh == true) {
          listSale(data!.data!.data!);
        } else {
          listSale.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      isLoading.value = false;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
