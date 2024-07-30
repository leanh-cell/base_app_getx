import 'package:com.ikitech.store/app_user/data/remote/response-request/customer/all_group_customer_res.dart';
import 'package:get/get.dart';

import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../data/repository/repository_manager.dart';

class GroupCustomerController extends GetxController {
  var listGroup = RxList<GroupCustomer>();
  var loading = true.obs;

  int currentPage = 1;

  bool isEnd = false;
  var loadInit = true.obs;

  var isLoading = false.obs;

  GroupCustomerController() {
    getAllGroupCustomer();
  }

  // Future<void> getAllGroupCustomer() async {
  //   try {
  //     var res =
  //         await RepositoryManager.customerRepository.getAllGroupCustomer();
  //     listGroup(res!.data!.data);
  //   } catch (err) {
  //     SahaAlert.showError(message: err.toString());
  //   }
  //   loading.value = false;
  // }

  Future<void> deleteGroupCustomer(int groupId) async {
    try {
      var res =
          await RepositoryManager.customerRepository.deleteGroupCustomer(groupId:groupId);
      SahaAlert.showSuccess(message: "Đã xoá");
      getAllGroupCustomer();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }


  Future<void> getAllGroupCustomer({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        //isLoading.value = true;
        isLoading.value = true;
        var data = await RepositoryManager.customerRepository.getAllGroupCustomer(
          page: currentPage,
        );

        if (isRefresh == true) {
          listGroup(data!.data!.data!);
          listGroup.refresh();
        } else {
          listGroup.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
          currentPage = currentPage + 1;
        }
      }
      loadInit.value = false;
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
