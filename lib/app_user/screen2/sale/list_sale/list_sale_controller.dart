import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';

class ListSaleController extends GetxController {
  var listStaff = RxList<Staff>();
  var listStaffChoose = RxList<Staff>();
  var loading = false.obs;
  List<Staff>? listStaffInput;
  bool? isStaffOnline;
  var isSale = true.obs;

  ListSaleController({this.listStaffInput, this.isStaffOnline}) {
    getListStaff();
    if (listStaffInput != null) {
      listStaffChoose(listStaffInput);
    }
  }

  bool checkChoose(Staff staff) {
    if (listStaffChoose.map((e) => e.id).toList().contains(staff.id))
      return true;
    return false;
  }

  Future<void> updateSaleStt(Staff staff, bool isSale) async {
    try {
      var data =
          await RepositoryManager.staffRepository.updateSaleStt(staff, isSale);
      var index = listStaff.indexWhere((e) => e.id == staff.id);
      if (index != -1) {
        listStaff[index] = data!.staff!;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<void> getListStaff() async {
    loading.value = true;
    try {
      var data = await RepositoryManager.staffRepository
          .getListStaff(isSale: isSale.value == true ? true : null);
      if (isStaffOnline == true) {
        listStaff(data!.data!.where((e) => e.online! == true).toList());
      } else {
        listStaff(data!.data!);
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
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
