import 'package:com.ikitech.store/app_user/data/remote/response-request/distribute/distribute_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/distribute/elm_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/distribute/sub_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

import '../handle_error.dart';

class DistributeRepository {
  Future<DistributeRes?> getDistribute({
    required int productId,
  }) async {
    try {
      var res = await SahaServiceManager().service!.getDistribute(
            UserInfo().getCurrentStoreCode(),
            productId,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DistributeRes?> updateDistribute(
      {required int productId,
      required DistributesRequest distributesRequest}) async {
    try {
      var res = await SahaServiceManager().service!.updateDistribute(
            UserInfo().getCurrentStoreCode(),
            UserInfo().getCurrentIdBranch(),
            productId,
            distributesRequest.toJson(),
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DistributeRes?> addElmDistribute(
      {required int productId,
      required String elmName,
      required String elmValue}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addElmDistribute(UserInfo().getCurrentStoreCode(), productId, {
        "distribute_name": elmName,
        "element_distribute_value": elmValue,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DistributeRes?> addSubDistribute(
      {required int productId,
      required String subName,
      required String subValue}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .addSubDistribute(UserInfo().getCurrentStoreCode(), productId, {
        "sub_element_distribute_name": subName,
        "sub_element_distribute_value": subValue,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DistributeRes?> updateElmDistribute(
      {required int productId, required ElmRequest elmRequest}) async {
    try {
      var res = await SahaServiceManager().service!.updateElmDistribute(
          UserInfo().getCurrentStoreCode(), productId, elmRequest.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DistributeRes?> updateSubDistribute(
      {required int productId, required SubRequest subRequest}) async {
    try {
      var res = await SahaServiceManager().service!.updateSubDistribute(
          UserInfo().getCurrentStoreCode(), productId, subRequest.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DistributeRes?> deleteElmDistribute(
      {required int productId, required String name}) async {
    try {
      var res = await SahaServiceManager().service!.deleteElmDistribute(
          UserInfo().getCurrentStoreCode(), productId, {"name": name});
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<DistributeRes?> deleteSubDistribute(
      {required int productId, required String name}) async {
    try {
      var res = await SahaServiceManager().service!.deleteSubDistribute(
          UserInfo().getCurrentStoreCode(), productId, {"name": name});
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
