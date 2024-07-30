import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/device.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';

class DeviceApproveController extends GetxController {
  var listDevice = RxList<Device>();
  var isLoading = false.obs;

  Staff staff;
  DeviceApproveController({required this.staff}) {
    getAllDeviceApproveStaff();
  }

  Future<void> deleteDevice({required int deviceId}) async {
    try {
      var res = await RepositoryManager.timeKeepingRepository
          .deleteDevice(deviceId: deviceId);
      getAllDeviceApproveStaff();
      SahaAlert.showSuccess(message: "Đã xoá");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllDeviceApproveStaff() async {
    try {
      isLoading.value = true;
      var data = await RepositoryManager.timeKeepingRepository
          .getAllDeviceApproveStaff(staffId: staff.id!);
      listDevice(data!.data!);
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }
}
