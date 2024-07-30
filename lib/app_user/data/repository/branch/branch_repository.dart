import 'package:com.ikitech.store/app_user/data/remote/response-request/branch/all_branch_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/branch/create_branch_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/success/success_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/model/branch.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

import '../handle_error.dart';

class BranchRepository {
  Future<SuccessResponse?> deleteBranch(int idBranch) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .deleteBranch(UserInfo().getCurrentStoreCode(), idBranch);
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CreateBranchResponse?> updateBranch(
      int idBranch, Branch branch) async {
    try {
      var res = await SahaServiceManager().service!.updateBranch(
          UserInfo().getCurrentStoreCode(), idBranch, branch.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<AllBranchResponse?> getAllBranch({bool? getAll}) async {
    try {
      var res = await SahaServiceManager().service!.getAllBranch(
            UserInfo().getCurrentStoreCode(),
          getAll,
          );
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<CreateBranchResponse?> createBranch(Branch branch) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .createBranch(UserInfo().getCurrentStoreCode(), branch.toJson());
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
