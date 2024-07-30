import 'package:get/get.dart';

import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/info_customer.dart';
import '../../../model/staff.dart';
import '../../../utils/finish_handle_utils.dart';

class ChooseCustomerSaleController extends GetxController {
  Staff staffInput;

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

  var listCustomerChoose = RxList<InfoCustomer>();

  ChooseCustomerSaleController({required this.staffInput}) {
    isLoadInit.value = true;
    getAllCustomer(isRefresh: true);
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

  Future<void> addCustomerToSale() async {
    if (listCustomerChoose.isEmpty) {
      SahaAlert.showError(message: 'Chưa chọn khác hàng');
      return;
    }
    try {
      var data = await RepositoryManager.saleRepo.addCustomerToSale(
          listCustomerId: listCustomerChoose.map((e) => e.id!).toList(),
          staffId: staffInput.id!);
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
