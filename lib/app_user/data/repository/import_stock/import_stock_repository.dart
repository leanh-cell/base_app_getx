import 'package:com.ikitech.store/app_user/data/remote/response-request/import_stock/all_import_stock_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/import_stock/import_stock_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/refund_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import '../handle_error.dart';

class ImportStockRepository {
  Future<AllImportStocksRes?> getAllImportStock(
      {String? search, int? currentPage, int? supplierId, String? status}) async {
    try {
      var res = await SahaServiceManager().service!.getAllImportStock(
            UserInfo().getCurrentStoreCode(),
            UserInfo().getCurrentIdBranch(),
            search,
            status,
            currentPage,
            supplierId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ImportStocksRes?> getImportStock(int? importStockId) async {
    try {
      var res = await SahaServiceManager().service!.getImportStock(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          importStockId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ImportStocksRes?> updateImportStock(
      int? importStockId, ImportStock importStock) async {
    try {
      var res = await SahaServiceManager().service!.updateImportStock(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          importStockId,
          importStock.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteImportStock(int? importStockId) async {
    try {
      var res = await SahaServiceManager().service!.deleteImportStock(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          importStockId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ImportStocksRes?> createImportStock(ImportStock importStock) async {
    try {
      var res = await SahaServiceManager().service!.createImportStock(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          importStock.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> refundImportStock(
      {required int importStockId,
      required RefundRequest refundRequest}) async {
    try {
      var res = await SahaServiceManager().service!.refundImportStock(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          importStockId,
          refundRequest.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> updateStatusImportStock(
      int? importStockId, int status) async {
    try {
      var res = await SahaServiceManager().service!.updateStatusImportStock(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          importStockId, {
        "status": status,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> paymentImportStock(
      int? importStockId, double amountMoney, int paymentMethod) async {
    try {
      var res = await SahaServiceManager().service!.payImportStock(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          importStockId, {
        "amount_money": amountMoney,
        "payment_method": paymentMethod,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
