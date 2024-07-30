import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';

class ChooseStaffController extends GetxController {
  var listStaff = RxList<Staff>();

  ChooseStaffController() {
    getListStaff();
  }

  Future<void> getListStaff() async {
    try {
      var data = await RepositoryManager.staffRepository.getListStaff();
      listStaff(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> deleteStaff(int idStaff) async {
    try {
      var data = await RepositoryManager.staffRepository.deleteStaff(idStaff);
      SahaAlert.showSuccess(message: "Đã xoá");
      getListStaff();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
