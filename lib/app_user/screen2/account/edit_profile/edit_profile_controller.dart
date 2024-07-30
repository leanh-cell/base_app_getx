import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';

class EditProfileController extends GetxController {
  final String? linkAvatarInput;
  final DateTime? dateOfBirthInput;
  final int? sexIndexInput;

  EditProfileController(
      {this.sexIndexInput, this.linkAvatarInput, this.dateOfBirthInput}) {
    linkAvatar.value = linkAvatarInput ?? "";
    dateOfBirth.value = dateOfBirthInput ?? DateTime.now();
    onChangeSexPicker(sexIndexInput ?? 0);
  }

  var linkAvatar = "".obs;
  var dateOfBirth = DateTime.now().obs;
  var sex = "".obs;
  var sexIndex = 0;

  void onChangeSexPicker(int value) {
    if (value == 0) {
      sex.value = "Khác";
      sexIndex = 0;
    } else {
      if (value == 1) {
        sex.value = "Nam";
        sexIndex = 1;
      } else {
        sex.value = "Nữ";
        sexIndex = 2;
      }
    }
  }

  Future<void> updateProfile({
    String? name,
  }) async {
    try {
      var res = await RepositoryManager.profileRepository
          .updateProfile(name, dateOfBirth.value, linkAvatar.value, sexIndex);
      SahaDataController sahaDataController = Get.find();
      sahaDataController.getUser();
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
