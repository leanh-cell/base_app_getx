import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/all_tally_sheet_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/history_inventory_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/inventory_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/tally_sheet_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/tally_sheet_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/data/repository/handle_error.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

class InventoryRepository {
  Future<HistoryInventoryRes?> historyInventory(
      {required int page,
      required int idProduct,
      String? distributeName,
      String? elm,
      String? sub}) async {
    try {
      var res = await SahaServiceManager().service!.historyInventory(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          {
            "product_id": idProduct,
            "distribute_name": distributeName,
            "element_distribute_name": elm,
            "sub_element_distribute_name": sub,
          },
          page);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> updateInventoryProduct(
      InventoryRequest inventoryRequest) async {
    try {
      var res = await SahaServiceManager().service!.updateInventoryProduct(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          inventoryRequest.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllTallySheetRes?> getAllTallySheet(
      {String? search, int? currentPage, int? status}) async {
    try {
      var res = await SahaServiceManager().service!.getAllTallySheet(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          search,
          status,
          currentPage);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<TallySheetRes?> getTallySheet(int? idTallySheet) async {
    try {
      var res = await SahaServiceManager().service!.getTallySheet(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          idTallySheet);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> updateTallySheet(
      int? idTallySheet, TallySheetRequest tallySheetRequest) async {
    try {
      var res = await SahaServiceManager().service!.updateTallySheet(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          idTallySheet,
          tallySheetRequest.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> balanceTallySheet(
    int? idTallySheet,
  ) async {
    try {
      var res = await SahaServiceManager().service!.balanceTallySheet(
            UserInfo().getCurrentStoreCode(),
            UserInfo().getCurrentIdBranch(),
            idTallySheet,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteTallySheet(int? idTallySheet) async {
    try {
      var res = await SahaServiceManager().service!.deleteTallySheet(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          idTallySheet);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> createTallySheet(
      TallySheetRequest tallySheetRequest) async {
    try {
      var res = await SahaServiceManager().service!.createTallySheet(
          UserInfo().getCurrentStoreCode(),
          UserInfo().getCurrentIdBranch(),
          tallySheetRequest.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
