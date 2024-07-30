import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/device.dart';
import 'package:com.ikitech.store/app_user/model/history_checkin_checkout.dart';

class ApproveController extends GetxController {
  var listDevice = RxList<Device>();
  var historyApprove = RxList<HistoryCheckInCheckout>();

  int currentPage = 1;
  String? textSearch;
  bool isEnd = false;
  var isLoading = false.obs;

  Future<void> getAllDeviceAwait() async {
    isLoading.value = true;
    try {
      var data =
          await RepositoryManager.timeKeepingRepository.getAllDeviceAwait();
      listDevice(data!.data!);
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> changeStatusDevice(
      {required int status, required int deviceId}) async {
    try {
      var data = await RepositoryManager.timeKeepingRepository
          .changeStatusDevice(status: status, deviceId: deviceId);
      getAllDeviceAwait();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> changeStatusApprove(
      {required int status, required int deviceId}) async {
    try {
      var data = await RepositoryManager.timeKeepingRepository
          .changeStatusApprove(status: status, deviceId: deviceId);
      getAllAwaitCheckInOutsAwait(isRefresh: true);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getAllAwaitCheckInOutsAwait({
    bool? isRefresh,
  }) async {
    if (isRefresh == true) {
      currentPage = 1;
      isEnd = false;
    }

    try {
      if (isEnd == false) {
        isLoading.value = true;
        var data = await RepositoryManager.timeKeepingRepository
            .getAllAwaitCheckInOutsAwait();

        if (isRefresh == true) {
          historyApprove(data!.data!.data!);
        } else {
          historyApprove.addAll(data!.data!.data!);
        }

        if (data.data!.nextPageUrl == null) {
          isEnd = true;
        } else {
          isEnd = false;
        }
      }
      isLoading.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
