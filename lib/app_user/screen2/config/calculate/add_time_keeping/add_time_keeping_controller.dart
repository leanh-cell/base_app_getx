import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/bonus_time_keeping_req.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';

class AddTimeKeepingController extends GetxController {
  var bonus = BonusTimeKeepingReq().obs;
  var staff = Staff().obs;
  var dateChoose = DateTime.now().obs;
  var timeCheckIn = DateTime(0, 0, 0, 0, 0, 0).obs;
  var timeCheckOut = DateTime(0, 0, 0, 0, 0, 0).obs;
  var checkWrongTime = false.obs;

  Future<void> bonusCheckInOut() async {
    if (staff.value.id == null) {
      SahaAlert.showError(message: "Chưa chọn đối tượng áp dụng");
      return;
    }
    try {
      bonus.value.staffId = staff.value.id;
      bonus.value.checkinTime = DateTime(
          dateChoose.value.year,
          dateChoose.value.month,
          dateChoose.value.day,
          timeCheckIn.value.hour,
          timeCheckIn.value.minute);
      bonus.value.checkoutTime = DateTime(
          dateChoose.value.year,
          dateChoose.value.month,
          dateChoose.value.day,
          timeCheckOut.value.hour,
          timeCheckOut.value.minute);

      var data = await RepositoryManager.timeKeepingRepository
          .bonusCheckInOut(bonusTimeKeepingReq: bonus.value);
      SahaAlert.showSuccess(message: "Thành công");
      Get.back(result: "reload");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
