

import 'package:com.ikitech.store/app_user/data/remote/response-request/decentralization/add_decentralization_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/decentralization/list_decentralization_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/model/decentralization.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

import '../handle_error.dart';

class DecentralizationRepository {
  Future<ListDecentralizationResponse?> getListDecentralization() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getListDecentralization(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AddDecentralizationResponse?> addDecentralization(
      Decentralization decentralization) async {
    try {
      var res = await SahaServiceManager().service!.addDecentralization(
          UserInfo().getCurrentStoreCode(), decentralization.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<SuccessResponse?> deleteDecentralization(
      int idDecentralization) async {
    try {
      var res = await SahaServiceManager().service!.deleteDecentralization(
          UserInfo().getCurrentStoreCode(), idDecentralization);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AddDecentralizationResponse?> updateDecentralization(
      Decentralization decentralization, int idDecentralization) async {
    try {
      var res = await SahaServiceManager().service!.updateDecentralization(
          UserInfo().getCurrentStoreCode(),
          idDecentralization,
          decentralization.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
