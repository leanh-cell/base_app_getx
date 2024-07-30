import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../../data/repository/repository_manager.dart';
import '../../../../../model/info_customer.dart';

class ChooseCustomerController extends GetxController {
  var listCustomer = RxList<InfoCustomer>();
  var listCustomerChoose = RxList<InfoCustomer>();
  List<InfoCustomer> listCustomerInput;
  int currentPage = 1;
  var search = TextEditingController();
  bool isEnd = false;
  var loadInit = true.obs;

  var isLoading = false.obs;

  ChooseCustomerController({required this.listCustomerInput}) {
    getAllInfoCustomer(isRefresh: true);
    listCustomerChoose.value = listCustomerInput.toList();
    
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
        //isLoading.value = true;
        isLoading.value = true;
        var data = await RepositoryManager.customerRepository.getAllInfoCustomer(
          search: search.text,
          numberPage: currentPage,
        );

        if (isRefresh == true) {
          listCustomer(data!.data!.data!);
          listCustomer.refresh();
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
      loadInit.value = false;
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}