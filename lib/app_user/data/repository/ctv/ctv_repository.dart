import 'package:com.ikitech.store/app_user/data/remote/response-request/ctv/all_bonus_level_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/ctv/all_request_payment_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/ctv/collaborator_configs_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/ctv/list_ctv_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/ctv/update_bonus_level_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/ctv/update_ctv_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/model/collaborator_configs.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

import '../../remote/response-request/ctv/all_collaborator_register_request_res.dart';
import '../../remote/response-request/ctv/history_balance_res.dart';
import '../handle_error.dart';

class CtvRepository {
  Future<HistoryBalanceRes?> addSubHistoryBalance(
      {required bool isSub,
      required int ctvId,
      required double money,
      required String reason}) async {
    try {
      var res = await SahaServiceManager().service!.addSubHistoryBalance(
          UserInfo().getCurrentStoreCode(),
          ctvId,
          {"is_sub": isSub, "money": money, "reason": reason});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<HistoryBalanceRes?> getHistoryBalance(
      {required int page, required int customerId}) async {
    try {
      var res = await SahaServiceManager().service!.getHistoryBalance(
          UserInfo().getCurrentStoreCode(), customerId, page);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllBonusLevelResponse?> getAllLevelBonus() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllLevelBonus(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> addLevelBonus(int limit, int bonus) async {
    try {
      var res = await SahaServiceManager().service!.addLevelBonus(
          UserInfo().getCurrentStoreCode(), {"limit": limit, "bonus": bonus});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteLevelBonus(int idLevel) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteLevelBonus(UserInfo().getCurrentStoreCode(), idLevel);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<UpdateCtvResponse?> updateCtv(int status, int idCtv) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateCtv(UserInfo().getCurrentStoreCode(), idCtv, {
        "status": status,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<UpdateBonusLevelResponse?> updateLevelBonus(
      int limit, int bonus, int idLevel) async {
    try {
      var res = await SahaServiceManager().service!.updateLevelBonus(
          UserInfo().getCurrentStoreCode(),
          idLevel,
          {"limit": limit, "bonus": bonus});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CollaboratorConfigsResponse?> configsCollabBonus(
      CollaboratorConfig collaboratorConfig) async {
    try {
      var res = await SahaServiceManager().service!.configsCollabBonus(
          UserInfo().getCurrentStoreCode(), collaboratorConfig.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CollaboratorConfigsResponse?> getConfigsCollabBonus() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getConfigsCollabBonus(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ListCtvResponse?> getListCtv(
      {String? search, String? sortBy, int? page, bool? descending}) async {
    try {
      var res = await SahaServiceManager().service!.getListCtv(
          UserInfo().getCurrentStoreCode()!, search, page, sortBy, descending);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ListCtvResponse?> getTopCtv({
    String? search,
    String? sortBy,
    int? page,
    bool? descending,
    String? timeFrom,
    String? timeTo,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getTopCtv(
          UserInfo().getCurrentStoreCode()!,
          search,
          page,
          sortBy,
          descending,
          timeFrom,
          timeTo);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllRequestPaymentResponse?> getListRequestPayment() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getListRequestPayment(UserInfo().getCurrentStoreCode()!);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllRequestPaymentResponse?> getHistoryPayment(
      {String? sortBy, String? filterBy, String? filterByValue}) async {
    try {
      var res = await SahaServiceManager().service!.getHistoryPayment(
          UserInfo().getCurrentStoreCode()!, sortBy, filterBy, filterByValue);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> changeStatusPayment(
      int status, List<int> listId) async {
    try {
      var res = await SahaServiceManager().service!.changeStatusPayment(
          UserInfo().getCurrentStoreCode(),
          {"status": status, "list_id": listId});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> settlementPayment() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .settlementPayment(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }


  Future<AllCollaboratorRegisterRequestRes?> getAllCollaboratorRegisterRequest({required int page,int? status}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getAllCollaboratorRegisterRequest(UserInfo().getCurrentStoreCode(),page,status);
      return res;
    } catch (err) {
      handleError(err);
    }
  }
   Future<SuccessResponse?> updateStatusCollaboratorRequest({required int requestId,required int status}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .updateStatusCollaboratorRequest(UserInfo().getCurrentStoreCode(),requestId,{
            "status":status
          });
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
