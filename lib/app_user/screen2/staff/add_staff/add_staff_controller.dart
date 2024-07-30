import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/decentralization.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

class AddStaffController extends GetxController {
  var staff = Staff().obs;
  Staff? staffInput;
  var stateResetPassword = false.obs;
  var listDecentralization = RxList<Decentralization>();
  var listSex = RxList<String>(["Không xác định", "Nam", "Nữ"]);
  var indexSex = 0.obs;
  var isLoading = false.obs;

  AddStaffController({this.staffInput}) {
    getListDecentralization().then((value) {
      if (staffInput != null) {
        staff.value = staffInput!;
        if (staffInput?.decentralization?.id != null) {
          staff.value.idDecentralization = staff.value.decentralization?.id;
        } else {
          if (listDecentralization.isNotEmpty) {
            staff.value.idDecentralization = listDecentralization[0].id;
          }
        }
        indexSex.value = staffInput!.sex!;
      }
    });
  }

  Future<void> getListDecentralization() async {
    try {
      var data = await RepositoryManager.decentralizationRepository
          .getListDecentralization();
      listDecentralization(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addStaff() async {
    isLoading.value = true;
    try {
      staff.value.branchId = UserInfo().getCurrentIdBranch();
      staff.value.idDecentralization = staff.value.decentralization?.id;
      var data = await RepositoryManager.staffRepository.addStaff(staff.value);
      SahaAlert.showSuccess(message: "Đã thêm thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> updateStaff() async {
    isLoading.value = true;
    try {
      staff.value.branchId = UserInfo().getCurrentIdBranch();
      staff.value.idDecentralization = staff.value.decentralization?.id;
      var data = await RepositoryManager.staffRepository
          .updateStaff(staffInput!.id!, staff.value);
      SahaAlert.showSuccess(message: "Đã chỉnh sửa thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> deleteStaff(int idStaff) async {
    try {
      var data = await RepositoryManager.staffRepository.deleteStaff(idStaff);
      SahaAlert.showSuccess(message: "Đã xoá");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
