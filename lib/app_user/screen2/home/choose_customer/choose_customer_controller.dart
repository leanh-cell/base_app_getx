import 'dart:convert';
import 'dart:math';

import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';

import '../../../model/agency_type.dart';
import '../../../model/info_customer.dart';

class ChooseCustomerController extends GetxController {
  var listInfoCustomer = RxList<InfoCustomer>();
  var listInfoCustomerChoose = RxList<InfoCustomer>();
  var isDoneLoadMore = false.obs;
  var isEndCustomer = false.obs;
  var pageLoadMore = 1;
  var isLoadInit = false.obs;
  var searching = false.obs;
  var isPutSale = false.obs;

  var search = "";
  var sortBy = "";
  var descending = false;
  var fieldBy = "";
  var fieldByValue = "";
  var typeCompare = 0.obs;

  int? dayOfBirth;
  int? monthOfBirth;
  int? yearOfBirth;

  var timeInputSearch = DateTime.now();

  var typeSearch = 0.obs;
  var dateOfBirth = DateTime.now().obs;
  var finish = FinishHandle(milliseconds: 500);
  SahaDataController sahaDataController = Get.find();
  List<String> jsonListFilter = [];

  ChooseCustomerController() {
    isLoadInit.value = true;
    getAllCustomer(isRefresh: true);
    getAllAgencyType();
  }

  Future<void> getAllCustomer({bool? isRefresh}) async {
    finish.run(() async {
      isDoneLoadMore.value = false;

      if (isRefresh == true) {
        pageLoadMore = 1;
        isEndCustomer.value = false;
      }

      print(sahaDataController.badgeUser.value.decentralization?.customerList);

      try {
        if (!isEndCustomer.value) {
          var res =
              await RepositoryManager.customerRepository.getAllInfoCustomer(
            numberPage: pageLoadMore,
            search: search,
            sortBy: sortBy,
            descending: descending,
            fieldBy: fieldBy,
            fieldByValue: fieldByValue,
            dayOfBirth: dayOfBirth,
            monthOfBirth: monthOfBirth,
            yearOfBirth: yearOfBirth,
            saleStaffId: checkIsSaleId(),
            jsonListFilter: jsonListFilter.toString(),
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

  int? checkIsSaleId() {
    if (sahaDataController.badgeUser.value.isSale == true) {
      if ((sahaDataController.badgeUser.value.decentralization?.customerList ??
              false) ==
          true) {
        return null;
      } else {
        return sahaDataController.user.value.id;
      }
    }

    return null;
  }

  Future<void> addCustomerToSale({required int staffId}) async {
    try {
      var data = await RepositoryManager.saleRepo.addCustomerToSale(
          listCustomerId: listInfoCustomerChoose.map((e) => e.id ?? 0).toList(),
          staffId: staffId);
      Get.back();
      getAllCustomer(isRefresh: true);
      listInfoCustomerChoose.clear();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> saleType(
      {required int customerId, required int type, int? agencyTypeId}) async {
    try {
      var data = await RepositoryManager.customerRepository.saleType(
          customerId: customerId, type: type, agencyTypeId: agencyTypeId);
      getAllCustomer(isRefresh: true);
      listInfoCustomerChoose.clear();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  var listAgencyType = RxList<AgencyType>();

  Future<void> getAllAgencyType() async {
    try {
      var data = await RepositoryManager.agencyRepository.getAllAgencyType();
      listAgencyType(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  String queryCustomer(String typeCompare) {
    Map query = {
      "type_compare": "$typeCompare",
      "comparison_expression": "=",
      "value_compare": "0"
    };

    return jsonEncode(query);
  }
}
