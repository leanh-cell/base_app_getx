import 'package:com.ikitech.store/app_user/data/remote/response-request/staff/add_staff_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/staff/all_staff_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

import '../../remote/response-request/sale/over_view_sale_res.dart';
import '../../remote/response-request/staff/all_operation_history_res.dart';
import '../handle_error.dart';

class StaffRepository {

  Future<OverViewSaleRes?> getOverviewOneSale({
    required int staffId,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getOverviewOneSale(
            UserInfo().getCurrentStoreCode()!,
            staffId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<OverViewSaleRes?> getOverviewSale({
    required int staffId,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getOverviewSale(
        UserInfo().getCurrentStoreCode()!,
        staffId,
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllOperationHistoryRes?> getAllOperationHistory({
    required int page,
    String? functionType,
    String? actionType,
    int? staffId,
    int? branchId,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getAllOperationHistory(
            UserInfo().getCurrentStoreCode(),
            page,
            functionType,
            actionType,
            staffId,
            branchId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllStaffResponse?> getListStaff({bool? isSale}) async {
    try {
      var res = await SahaServiceManager().service!.getListStaff(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          isSale);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AddStaffResponse?> addStaff(Staff staff) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addStaff(UserInfo().getCurrentStoreCode(), staff.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AddStaffResponse?> updateSaleStt(Staff staff, bool isSale) async {
    try {
      var res = await SahaServiceManager().service!.updateSaleStt(
          UserInfo().getCurrentStoreCode(), staff.id!, {"is_sale": isSale});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteStaff(int idStaff) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteStaff(UserInfo().getCurrentStoreCode(), idStaff);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AddStaffResponse?> updateStaff(int idStaff, Staff staff) async {
    try {
      var res = await SahaServiceManager().service!.updateStaff(
          UserInfo().getCurrentStoreCode(), idStaff, staff.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
