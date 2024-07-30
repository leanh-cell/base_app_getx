import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import '../../model/staff.dart';

class AccountController extends GetxController {
  var user = Staff().obs;
  var loadInit = false.obs;

  AccountController() {
    getUser();
  }

  Future<void> getUser() async {
    loadInit.value = true;
    try {
      var data = await RepositoryManager.profileRepository.getProfile();
      user.value = data!.staff!;
      loadInit.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
