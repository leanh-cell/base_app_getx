import 'package:com.ikitech.store/app_user/data/remote/response-request/profile/profile_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/data/repository/handle_error.dart';

import '../../remote/response-request/staff/add_staff_response.dart';

class ProfileRepository {
  Future<AddStaffResponse?> getProfile() async {
    try {
      var res = await SahaServiceManager().service!.getProfile();
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<ProfileResponse?> updateProfile(String? name, DateTime? dateOfBirth,
      String? avatarImage, int? sex) async {
    try {
      var res = await SahaServiceManager().service!.updateProfile({
        "name": name,
        "date_of_birth": dateOfBirth!.toIso8601String(),
        "avatar_image": avatarImage,
        "sex": sex,
      });
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
