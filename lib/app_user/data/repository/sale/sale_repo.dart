import 'package:com.ikitech.store/app_user/data/remote/response-request/sale/config_sale_res.dart';
import 'package:com.ikitech.store/app_user/model/config_sale.dart';

import '../../../utils/user_info.dart';
import '../../remote/response-request/ctv/all_bonus_level_response.dart';
import '../../remote/response-request/ctv/update_bonus_level_response.dart';
import '../../remote/response-request/sale/list_id_customer_staff_sale_top_res.dart';
import '../../remote/response-request/sale/over_view_sale_res.dart';
import '../../remote/response-request/sale/top_sale_res.dart';
import '../../remote/response-request/success/success_response.dart';
import '../../remote/saha_service_manager.dart';
import '../handle_error.dart';

class SaleRepo {
  Future<ListIdCustomerStaffSaleTopRes?> getIdCustomerStaffSaleTop(
      {DateTime? dateFrom,
      DateTime? dateTo,
      int? customerType,
      String? staffId,
        String?  provinceIds
      }) async {
    try {
      var res = await SahaServiceManager().service!.getIdCustomerStaffSaleTop(
          UserInfo().getCurrentStoreCode(),
          dateFrom == null ? null : dateFrom.toIso8601String(),
          dateTo == null ? null : dateTo.toIso8601String(),
          customerType,
          staffId,
          provinceIds,
      );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<TopSaleRes?> getTopSale({
    required int page,
    DateTime? dateFrom,
    DateTime? dateTo,
    int? customerType,
    String? staffId,
    String? provinceIds,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getTopSale(
          UserInfo().getCurrentStoreCode(),
          page,
          dateFrom == null ? null : dateFrom.toIso8601String(),
          dateTo == null ? null : dateTo.toIso8601String(),
          customerType,
          staffId,
          provinceIds);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<OverViewSaleRes?> getOverViewSale() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getOverViewSale(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ConfigSaleRes?> getConfigSale() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getConfigSale(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ConfigSaleRes?> setConfigSale(ConfigSale configSale) async {
    try {
      var res = await SahaServiceManager().service!.setConfigSale(
            UserInfo().getCurrentStoreCode(),
            configSale.toJson(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllBonusLevelResponse?> getBonusStepSale() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getBonusStepSale(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> addLevelBonusSale(int limit, int bonus) async {
    try {
      var res = await SahaServiceManager().service!.addLevelBonusSale(
          UserInfo().getCurrentStoreCode(), {"limit": limit, "bonus": bonus});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteLevelBonusSale(int idLevel) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteLevelBonusSale(UserInfo().getCurrentStoreCode(), idLevel);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<UpdateBonusLevelResponse?> updateLevelBonusSale(
      int limit, int bonus, int idLevel) async {
    try {
      var res = await SahaServiceManager().service!.updateLevelBonusSale(
          UserInfo().getCurrentStoreCode(),
          idLevel,
          {"limit": limit, "bonus": bonus});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> addCustomerToSale(
      {required List<int> listCustomerId, required int staffId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addCustomerToSale(UserInfo().getCurrentStoreCode(), {
        "list_customer_id": listCustomerId == null
            ? []
            : List<dynamic>.from(listCustomerId.map((x) => x)),
        "staff_id": staffId,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
