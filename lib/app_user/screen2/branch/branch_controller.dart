import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/branch.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';

class BranchController extends GetxController {
  SahaDataController sahaDataController = Get.find();
  HomeController homeController = Get.find();
  var listBranch = RxList<Branch>();

  BranchController() {
    getAllBranch();
  }

  Future<void> getAllBranch() async {
    try {
      var data = await RepositoryManager.branchRepository.getAllBranch();
      listBranch(data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteBranch(int idStore) async {
    try {
      if (idStore == UserInfo().getCurrentIdBranch()) {
        homeController.cartCurrent.value.id = 0;
        sahaDataController.branchCurrent.value =
            sahaDataController.listBranch[0];
        UserInfo().setCurrentNameBranch(sahaDataController.listBranch[0].name);
        UserInfo().setCurrentBranchId(sahaDataController.listBranch[0].id);
      }
      var data = await RepositoryManager.branchRepository.deleteBranch(idStore);
      sahaDataController.getAllBranch();
      SahaAlert.showSuccess(message: "Đã xoá");
      getAllBranch();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
