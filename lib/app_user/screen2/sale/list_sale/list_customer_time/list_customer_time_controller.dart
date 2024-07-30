import 'package:com.ikitech.store/app_user/model/review.dart';
import 'package:get/get.dart';

import '../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/info_customer.dart';
import '../../../../model/location_address.dart';

class ListCustomerTimeController extends GetxController {
  DateTime? dateFrom;
  DateTime? dateTo;
  int? type;
  String staffId;
  List<LocationAddress>? provinceIds;
  var listID = RxList<int>();

  var loading = false.obs;

  var listCustomer = RxList<InfoCustomer>();
  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;
  var loadInit = true.obs;

  ListCustomerTimeController(
      { this.dateFrom,
       this.dateTo,
      this.type,
      required this.staffId,
      this.provinceIds}) {
    getIdCustomerStaffSaleTop();
  }

  Future<void> getIdCustomerStaffSaleTop() async {
    loading.value = true;
    try {
      var data = await RepositoryManager.saleRepo.getIdCustomerStaffSaleTop(
        dateFrom: dateFrom,
        dateTo: dateTo,
        customerType: type,
        staffId: staffId,
        provinceIds: (provinceIds ?? []).isEmpty
            ? null
            : (provinceIds ?? [])
                .map((e) => e.id)
                .toString()
                .replaceAll("(", "")
                .replaceAll(")", ""),
      );
      listID(data!.data!);
      getAllInfoCustomer(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<void> getAllInfoCustomer({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.customerRepository
            .getAllInfoCustomer(
               numberPage: currentPage,
               
                descending :false,
             
                dateFrom :dateFrom,
                dateTo : dateTo,
                customerType: type.toString(),
                customerIds :listID.toString().replaceAll("[", "").replaceAll("]", ""),);

        if (isRefresh == true) {
          listCustomer(data!.data!.data!);
        } else {
          listCustomer.addAll(data!.data!.data!);
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
