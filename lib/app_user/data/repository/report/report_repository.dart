import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_customer_debt_report_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_history_inventory_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_product_IE_stock_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_revenue_expenditure_report_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/all_supplier_debt_report_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/product_last_inventory_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/product_report_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/profit_and_loss_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/report_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

import '../handle_error.dart';

class ReportRepository {
  Future<ReportResponse?> getReport(
    String timeFrom,
    String timeTo,
    String dateFromCompare,
    String dateToCompare,
    int? collaboratorByCustomerId,
    int? agencyByCustomerId,
  ) async {
    try {
      var res = await SahaServiceManager().service!.getReport(
            UserInfo().getCurrentStoreCode()!,
            UserInfo().getCurrentIdBranch()!,
            timeFrom,
            timeTo,
            dateFromCompare,
            dateToCompare,
            collaboratorByCustomerId,
            agencyByCustomerId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ReportResponse?> getReportCtvAgency(
    String timeFrom,
    String timeTo,
    String dateFromCompare,
    String dateToCompare,
    int? collaboratorByCustomerId,
    int? agencyByCustomerId,
    int? agencyCtvByCustomerId,
  ) async {
    try {
      var res = await SahaServiceManager().service!.getReportCtvAgency(
            UserInfo().getCurrentStoreCode()!,
            timeFrom,
            timeTo,
            dateFromCompare,
            dateToCompare,
            collaboratorByCustomerId,
            agencyByCustomerId,
            agencyCtvByCustomerId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ProductReportResponse?> getProductReport(
    String timeFrom,
    String timeTo,
  ) async {
    try {
      var res = await SahaServiceManager().service!.getProductReport(
            UserInfo().getCurrentStoreCode()!,
            UserInfo().getCurrentIdBranch()!,
            timeFrom,
            timeTo,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ProductLastInventoryRes?> getProductLastInventory({
    DateTime? date,
    int? page,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getProductLastInventory(
            UserInfo().getCurrentStoreCode()!,
            UserInfo().getCurrentIdBranch()!,
            date?.toIso8601String(),
            page,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllHistoryInventoryRes?> getAllHistoryInventory({
    DateTime? dateFrom,
    DateTime? dateTo,
    int? page,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getAllHistoryInventory(
            UserInfo().getCurrentStoreCode()!,
            UserInfo().getCurrentIdBranch()!,
            dateFrom?.toIso8601String(),
            dateTo?.toIso8601String(),
            page,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllProductIEStockRes?> getProductIEStock({
    DateTime? dateFrom,
    DateTime? dateTo,
    int? page,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getProductIEStock(
            UserInfo().getCurrentStoreCode()!,
            UserInfo().getCurrentIdBranch()!,
            dateFrom?.toIso8601String(),
            dateTo?.toIso8601String(),
            page,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllRevenueExpenditureReportRes?> getAllRevenueExpenditureReport({
    DateTime? dateFrom,
    DateTime? dateTo,
    int? page,
    bool? isRevenue,
  }) async {
    try {
      var res =
          await SahaServiceManager().service!.getAllRevenueExpenditureReport(
                UserInfo().getCurrentStoreCode()!,
                UserInfo().getCurrentIdBranch()!,
                dateFrom?.toIso8601String(),
                dateTo?.toIso8601String(),
                page,
                isRevenue,
              );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ProfitAndLossRes?> getProfitAndLoss({
    DateTime? dateFrom,
    DateTime? dateTo,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getProfitAndLoss(
            UserInfo().getCurrentStoreCode()!,
            UserInfo().getCurrentIdBranch()!,
            dateFrom?.toIso8601String(),
            dateTo?.toIso8601String(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllSupplierDebtReportRes?> getAllSupplierDebtReport({
    DateTime? date,
    int? page,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getAllSupplierDebtReport(
            UserInfo().getCurrentStoreCode()!,
            UserInfo().getCurrentIdBranch()!,
            date?.toIso8601String(),
            page,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllCustomerDebtReportRes?> getAllCustomerDebtReport({
    DateTime? date,
    int? page,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getAllCustomerDebtReport(
            UserInfo().getCurrentStoreCode()!,
            UserInfo().getCurrentIdBranch()!,
            date?.toIso8601String(),
            page,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
