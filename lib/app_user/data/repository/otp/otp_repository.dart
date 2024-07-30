import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import '../handle_error.dart';

class OtpRepository {
  Future<bool?> sendOtp({String numberPhone = ""}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .sendOtp({"phone_number": numberPhone});
      return true;
    } catch (err) {
      handleError(err);
    }
  }

  Future<bool?> sendEmailOtpCus({String email = ""}) async {
    try {
      var res = await SahaServiceManager().service!.sendEmailOtpCus(
          UserInfo().getCurrentStoreCode(), {"email": email});
      return true;
    } catch (err) {
      handleError(err);
    }
  }

  Future<bool?> sendEmailOtp({String email = ""}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .sendOtpEmail({"email": email});
      return true;
    } catch (err) {
      handleError(err);
    }
  }
}
