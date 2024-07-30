import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/agency_type_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/all_agency_type_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/all_bonus_level_agency_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/all_request_payment_agency_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/bonus_step_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/collaborator_configs_agency_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/list_agency_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/update_agency_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/update_bonus_level_agency_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/update_bonus_step_agency_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/agency/update_price_agency_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/sale/history_check_in_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/model/agency_config.dart';
import 'package:com.ikitech.store/app_user/model/collaborator_configs.dart';
import 'package:com.ikitech.store/app_user/model/step_bonus.dart';
import 'package:com.ikitech.store/app_user/model/update_agency_request.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

import '../../../model/bonus_level.dart';
import '../../../model/sale_check_in.dart';
import '../../remote/response-request/agency/agency_res.dart';
import '../../remote/response-request/agency/all_agency_register_request_res.dart';
import '../../remote/response-request/agency/import_bonus_step_res.dart';
import '../../remote/response-request/ctv/all_bonus_level_response.dart';
import '../../remote/response-request/ctv/collaborator_configs_response.dart';
import '../../remote/response-request/ctv/history_balance_res.dart';
import '../../remote/response-request/ctv/update_bonus_level_response.dart';
import '../../remote/response-request/sale/all_history_check_in_res.dart';
import '../../remote/response-request/sale/sale_check_in_res.dart';
import '../handle_error.dart';

class AgencyRepository {
  Future<HistoryBalanceRes?> addSubHistoryBalanceAgency(
      {required int agencyId,
      required bool isSub,
      required double money,
      required String reason}) async {
    try {
      var res = await SahaServiceManager().service!.addSubHistoryBalanceAgency(
          UserInfo().getCurrentStoreCode(),
          agencyId,
          {"is_sub": isSub, "money": money, "reason": reason});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<HistoryBalanceRes?> getHistoryBalanceAgency(
      {required int page, required int customerId}) async {
    try {
      var res = await SahaServiceManager().service!.getHistoryBalanceAgency(
          UserInfo().getCurrentStoreCode(), customerId, page);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllAgencyTypeRes?> getAllAgencyType() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllAgencyType(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AgencyTypeRes?> addAgencyType(String name) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addAgencyType(UserInfo().getCurrentStoreCode(), {"name": name});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteAgencyType(int idAgency) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteAgencyType(UserInfo().getCurrentStoreCode(), idAgency);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AgencyTypeRes?> updateAgencyType(
      {required int idAgency,
      required String name,
      double? commissionPercent}) async {
    try {
      var res = await SahaServiceManager().service!.updateAgencyType(
          UserInfo().getCurrentStoreCode(),
          idAgency,
          {"name": name, "commission_percent": commissionPercent});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllBonusLevelAgencyResponse?> getAllLevelBonusAgency() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllLevelBonusAgency(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> addLevelBonusAgency(int limit, int bonus) async {
    try {
      var res = await SahaServiceManager().service!.addLevelBonusAgency(
          UserInfo().getCurrentStoreCode(), {"limit": limit, "bonus": bonus});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteLevelBonusAgency(int idLevel) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteLevelBonusAgency(UserInfo().getCurrentStoreCode(), idLevel);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<UpdateAgencyResponse?> updateAgency(
      int status, int idCtv, int? idAgencyType) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateAgency(UserInfo().getCurrentStoreCode(), idCtv, {
        "status": status,
        "agency_type_id": idAgencyType,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<UpdateBonusLevelAgencyResponse?> updateLevelBonusAgency(
      int limit, int bonus, int idLevel) async {
    try {
      var res = await SahaServiceManager().service!.updateLevelBonusAgency(
          UserInfo().getCurrentStoreCode(),
          idLevel,
          {"limit": limit, "bonus": bonus});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AgencyConfigResponse?> configsCollabBonusAgency(
      AgencyConfig agencyConfig) async {
    try {
      var res = await SahaServiceManager().service!.configsCollabBonusAgency(
          UserInfo().getCurrentStoreCode(), agencyConfig.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> configTypeBonusPeriodImport(int type) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .configTypeBonusPeriodImport(UserInfo().getCurrentStoreCode(), {
        'type_bonus_period_import': type,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AgencyConfigResponse?> getConfigsCollabBonusAgency() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getConfigsCollabBonusAgency(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ListAgencyResponse?> getListAgency(
      {String? search,
      String? sortBy,
      int? page,
      bool? descending,
      int? agencyTypeId}) async {
    try {
      var res = await SahaServiceManager().service!.getListAgency(
          UserInfo().getCurrentStoreCode()!,
          search,
          page,
          sortBy,
          descending,
          agencyTypeId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ListAgencyResponse?> getListAgencyForSale(
      {String? search,
      String? sortBy,
      int? page,
      bool? descending,
      int? agencyTypeId}) async {
    try {
      var res = await SahaServiceManager().service!.getListAgencyForSale(
          UserInfo().getCurrentStoreCode()!,
          search,
          page,
        );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

    Future<AgencyRes?> getAgencyForSale(
      {required int agencyId}) async {
    try {
      var res = await SahaServiceManager().service!.getAgencyForSale(
          UserInfo().getCurrentStoreCode()!,
          agencyId
        );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ListAgencyResponse?> getTopAgency(
      {String? search,
      String? sortBy,
      int? page,
      bool? descending,
      String? timeFrom,
      String? timeTo,
      String? reportType,
      bool? isCtv}) async {
    try {
      if (isCtv == true) {
        var res = await SahaServiceManager().service!.getTopAgencyCtv(
              UserInfo().getCurrentStoreCode()!,
              search,
              page,
              sortBy,
              descending,
              timeFrom,
              timeTo,
              reportType,
            );
        return res;
      } else {
        var res = await SahaServiceManager().service!.getTopAgency(
              UserInfo().getCurrentStoreCode()!,
              search,
              page,
              sortBy,
              descending,
              timeFrom,
              timeTo,
              reportType,
            );
        return res;
      }
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllRequestPaymentAgencyResponse?> getListRequestPaymentAgency() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getListRequestPaymentAgency(UserInfo().getCurrentStoreCode()!);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllRequestPaymentAgencyResponse?> getHistoryPaymentAgency(
      {String? sortBy, String? filterBy, String? filterByValue}) async {
    try {
      var res = await SahaServiceManager().service!.getHistoryPaymentAgency(
          UserInfo().getCurrentStoreCode()!, sortBy, filterBy, filterByValue);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> changeStatusPaymentAgency(
      int status, List<int> listId) async {
    try {
      var res = await SahaServiceManager().service!.changeStatusPaymentAgency(
          UserInfo().getCurrentStoreCode(),
          {"status": status, "list_id": listId});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> settlementPaymentAgency() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .settlementPaymentAgency(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<UpdatePriceAgencyRes?> getProductPriceAgency(
      {required int idProduct, required int agencyTypeId}) async {
    try {
      var res = await SahaServiceManager().service!.getProductPriceAgency(
          UserInfo().getCurrentStoreCode()!, idProduct, agencyTypeId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<UpdatePriceAgencyRes?> updateProductPriceAgency(
      int idProduct, UpdatePriceAgencyRequest updatePriceAgencyRequest) async {
    try {
      var res = await SahaServiceManager().service!.updateProductPriceAgency(
          UserInfo().getCurrentStoreCode(),
          idProduct,
          updatePriceAgencyRequest.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<BonusStepRes?> getBonusAgencyConfig() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getBonusAgencyConfig(UserInfo().getCurrentStoreCode()!);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<BonusStepRes?> updateBonusAgencyConfig(
      bool isEnd, DateTime start, DateTime end) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateBonusAgencyConfig(UserInfo().getCurrentStoreCode()!, {
        "is_end": isEnd,
        "start_time": start.toIso8601String(),
        "end_time": end.toIso8601String(),
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> addBonusStepAgency(StepBonus stepBonus) async {
    try {
      var res = await SahaServiceManager().service!.addBonusStepAgency(
          UserInfo().getCurrentStoreCode()!, stepBonus.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<UpdateBonusStepAgencyRes?> updateBonusStepAgency(
      int idStep, StepBonus stepBonus) async {
    try {
      var res = await SahaServiceManager().service!.updateBonusStepAgency(
          UserInfo().getCurrentStoreCode()!, idStep, stepBonus.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteBonusStepAgency(int idStep) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteBonusStepAgency(UserInfo().getCurrentStoreCode()!, idStep);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AgencyTypeRes?> editPercentAgency(int agencyTypeId,
      double percentAgency, List<int> productIds, bool isAll) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .editPercentAgency(UserInfo().getCurrentStoreCode()!, agencyTypeId, {
        "percent_agency": percentAgency,
        "is_all": isAll,
        "product_ids": productIds == null
            ? []
            : List<dynamic>.from(productIds.map((x) => x)),
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AgencyTypeRes?> editOverridePriceAgency(
      int agencyTypeId, double commissionPercent, List<int> productIds) async {
    try {
      var res = await SahaServiceManager().service!.editOverridePriceAgency(
          UserInfo().getCurrentStoreCode()!, agencyTypeId, {
        "commission_percent": commissionPercent,
        "product_ids": productIds == null
            ? []
            : List<dynamic>.from(productIds.map((x) => x)),
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  ///////////

  Future<ImportBonusStepsRes?> getImportBonusAgencyConfig() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getImportBonusAgencyConfig(UserInfo().getCurrentStoreCode()!);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> addImportBonusStepAgency(
      BonusLevel stepBonus) async {
    try {
      var res = await SahaServiceManager().service!.addImportBonusStepAgency(
          UserInfo().getCurrentStoreCode()!, stepBonus.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> updateImportBonusStepAgency(
      int idStep, BonusLevel stepBonus) async {
    try {
      var res = await SahaServiceManager().service!.updateImportBonusStepAgency(
          UserInfo().getCurrentStoreCode()!, idStep, stepBonus.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteImportBonusStepAgency(int idStep) async {
    try {
      var res = await SahaServiceManager().service!.deleteImportBonusStepAgency(
          UserInfo().getCurrentStoreCode()!, idStep);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

    Future<AllAgencyRegisterRequestsRes?> getAllAgencyRegisterRequest({required int page,int? status}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllAgencyRegisterRequest(UserInfo().getCurrentStoreCode()!,page,status);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
    Future<SuccessResponse?> updateAgencyRegisterStatus({required int idRequest,required int status,int? agencyTypeId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateAgencyRegisterStatus(UserInfo().getCurrentStoreCode()!,idRequest,{
            "status":status,
            "agency_type_id":agencyTypeId
          });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

   Future<SaleCheckInRes?> checkInAgency({required SaleCheckIn saleCheckIn}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .checkInAgency(UserInfo().getCurrentStoreCode()!,saleCheckIn.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

   Future<SaleCheckInRes?> checkOutAgency({required SaleCheckIn saleCheckIn,required int idCheckIn}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .checkOutAgency(UserInfo().getCurrentStoreCode()!,idCheckIn,saleCheckIn.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

   Future<AllHistoryCheckInRes?> getAllHistoryCheckIn({required int page,int? agencyId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllHistoryCheckIn(UserInfo().getCurrentStoreCode()!,page,agencyId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

   Future<HistoryCheckInRes?> getHistoryCheckIn({required int historyId}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getHistoryCheckIn(UserInfo().getCurrentStoreCode()!,historyId);
      return res;
    } catch (err) {
      handleError(err);
    }
  }


}
