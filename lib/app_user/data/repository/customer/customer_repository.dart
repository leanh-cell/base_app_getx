import 'package:com.ikitech.store/app_user/data/remote/response-request/customer/all_customer_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/customer/info_cus_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';
import 'package:sahashop_customer/app_customer/remote/response-request/score/history_score_response.dart';

import '../../remote/response-request/customer/all_group_customer_res.dart';
import '../../remote/response-request/customer/group_customer_res.dart';
import '../handle_error.dart';

class CustomerRepository {
  Future<AllCustomerResponse?> getAllInfoCustomerSale(
    int numberPage,
    String? search,
    String? sortBy,
    bool? descending,
    String? fieldBy,
    String? fieldByValue,
    int? dayOfBirth,
    int? monthOfBirth,
    int? yearOfBirth,
    int? saleStaffId,
  ) async {
    try {
      var res = await SahaServiceManager().service!.getAllInfoCustomerSale(
            UserInfo().getCurrentStoreCode()!,
            numberPage,
            search,
            sortBy,
            descending,
            fieldBy,
            fieldByValue,
            dayOfBirth,
            monthOfBirth,
            yearOfBirth,
            saleStaffId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllCustomerResponse?> getAllInfoCustomer({
    required int numberPage,
    String? search,
    String? sortBy,
    bool? descending,
    String? fieldBy,
    String? fieldByValue,
    int? dayOfBirth,
    int? monthOfBirth,
    int? yearOfBirth,
    int? saleStaffId,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? customerType,
    String? customerIds,
    String? jsonListFilter,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getAllInfoCustomer(
            UserInfo().getCurrentStoreCode()!,
            numberPage,
            search,
            sortBy,
            descending,
            fieldBy,
            fieldByValue,
            dayOfBirth,
            monthOfBirth,
            yearOfBirth,
            saleStaffId,
            dateFrom == null ? null : dateFrom.toIso8601String(),
            dateTo == null ? null : dateTo.toIso8601String(),
            customerType,
            customerIds,
            jsonListFilter
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<InfoCustomerRes?> addCustomer(InfoCustomer infoCustomer) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addCustomer(UserInfo().getCurrentStoreCode(), infoCustomer.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<InfoCustomerRes?> addCustomerFromSale(
      InfoCustomer infoCustomer) async {
    try {
      var res = await SahaServiceManager().service!.addCustomerFromSale(
          UserInfo().getCurrentStoreCode(), infoCustomer.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> saleType(
      {required int customerId, required int type, int? agencyTypeId}) async {
    try {
      var res = await SahaServiceManager().service!.saleType(
          UserInfo().getCurrentStoreCode(),
          customerId,
          {"sale_type": type, "agency_type_id": agencyTypeId});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<InfoCustomerRes?> updateCustomer(
      int idCustomer, InfoCustomer infoCustomer) async {
    try {
      var res = await SahaServiceManager().service!.updateCustomer(
          UserInfo().getCurrentStoreCode(), idCustomer, infoCustomer.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<InfoCustomerRes?> updateCustomerFromSale(
      int idCustomer, InfoCustomer infoCustomer) async {
    try {
      var res = await SahaServiceManager().service!.updateCustomerFromSale(
          UserInfo().getCurrentStoreCode(), idCustomer, infoCustomer.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<InfoCustomerRes?> getInfoCustomer(
    int idCustomer,
  ) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getInfoCustomer(UserInfo().getCurrentStoreCode(), idCustomer);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<HistoryScoreResponse?> getHistoryPoints(
      {required int idCustomer, required int page}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getHistoryPoints(UserInfo().getCurrentStoreCode(), idCustomer, page);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteCustomer(int idCustomer) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteCustomer(UserInfo().getCurrentStoreCode(), idCustomer);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteCustomerFromSale(int idCustomer) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteCustomerFromSale(UserInfo().getCurrentStoreCode(), idCustomer);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllGroupCustomerRes?> getAllGroupCustomer({ int? page,int? limit}) async {
    try {
      var res = await SahaServiceManager().service!.getAllGroupCustomer(
            UserInfo().getCurrentStoreCode()!,page,limit
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<GroupCustomerRes?> getGroupCustomer({required int groupId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getGroupCustomer(UserInfo().getCurrentStoreCode()!, groupId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<GroupCustomerRes?> addGroupCustomer(
      {required GroupCustomer groupCustomer}) async {
    try {
      var res = await SahaServiceManager().service!.addGroupCustomer(
          UserInfo().getCurrentStoreCode()!, groupCustomer.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<GroupCustomerRes?> updateGroupCustomer(
      {required GroupCustomer groupCustomer, required int groupId}) async {
    try {
      var res = await SahaServiceManager().service!.updateGroupCustomer(
          UserInfo().getCurrentStoreCode()!, groupId, groupCustomer.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteGroupCustomer({required int groupId}) async {
    try {
      var res = await SahaServiceManager().service!.deleteGroupCustomer(
            UserInfo().getCurrentStoreCode()!,
            groupId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
