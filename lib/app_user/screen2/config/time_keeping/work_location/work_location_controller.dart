import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/checkin_location.dart';

class WorkLocationController extends GetxController {
  var listCheckInLCT = RxList<CheckInLocation>();

  WorkLocationController() {
    getCheckInLocation();
  }

  Future<void> getCheckInLocation() async {
    try {
      var data =
          await RepositoryManager.timeKeepingRepository.getCheckInLocation();
      listCheckInLCT(data!.data!);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
