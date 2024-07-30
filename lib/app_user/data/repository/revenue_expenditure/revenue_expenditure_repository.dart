import 'package:com.ikitech.store/app_user/data/remote/response-request/revenue_expenditure/all_revenue_expenditure_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/revenue_expenditure/revenue_expenditure_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/revenue_expenditure/revenue_expenditure_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/data/repository/handle_error.dart';
import 'package:com.ikitech.store/app_user/model/revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

class RevenueExpenditureRepository {
  Future<AllRevenueExpenditureRes?> getAllRevenueExpenditure(
      {int? page, int? recipientGroup, int? recipientReferencesId}) async {
    try {
      var res = await SahaServiceManager().service!.getAllRevenueExpenditure(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          page,
          recipientGroup,
          recipientReferencesId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<RevenueExpenditureRes?> getRevenueExpenditure(
      {int? idRevenueExpenditure}) async {
    try {
      var res = await SahaServiceManager().service!.getRevenueExpenditure(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          idRevenueExpenditure);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<RevenueExpenditureRes?> createRevenueExpenditure(
      {required RevenueExpenditure revenueExpenditure}) async {
    try {
      var res = await SahaServiceManager().service!.createRevenueExpenditure(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          revenueExpenditure.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
