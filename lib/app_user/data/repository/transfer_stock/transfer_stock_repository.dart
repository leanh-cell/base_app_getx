import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/data/repository/handle_error.dart';

import '../../../model/transfer_stock.dart';
import '../../../utils/user_info.dart';
import '../../remote/response-request/transfer_stock/all_transfer_stock_res.dart';
import '../../remote/response-request/transfer_stock/transfer_stock_res.dart';

class TransferStockRepository {
  Future<AllTransferStocksRes?> getAllTransferStocksRCV(
      {required int page, String? search}) async {
    try {
      var res = await SahaServiceManager().service!.getAllTransferStocksRCV(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          search,
          page);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllTransferStocksRes?> getAllTransferStocksSender(
      {required int page, String? search}) async {
    try {
      var res = await SahaServiceManager().service!.getAllTransferStocksSender(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          search,
          page);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<TransferStocksRes?> getTransferStock(
      {required int transferStockId}) async {
    try {
      var res = await SahaServiceManager().service!.getTransferStock(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          transferStockId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<TransferStocksRes?> createTransferStock(
      {required TransferStock transferStock}) async {
    try {
      var res = await SahaServiceManager().service!.createTransferStock(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          transferStock.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<TransferStocksRes?> updateTransferStock(
      {required int transferStockId,
      required TransferStock transferStock}) async {
    try {
      var res = await SahaServiceManager().service!.updateTransferStock(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          transferStockId,
          transferStock.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<TransferStocksRes?> changeStatusTransferStock(
      {required int transferStockId, required int status}) async {
    try {
      var res = await SahaServiceManager().service!.changeStatusTransferStock(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          transferStockId, {
        "status": status,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
