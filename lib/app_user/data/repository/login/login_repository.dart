import 'package:com.ikitech.store/app_user/data/remote/response-request/auth/check_exists_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/auth/login_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import '../handle_error.dart';

class LoginRepository {
  Future<DataLogin?> login({String? emailOrPhoneNumber, String? pass}) async {
    try {
      var res = await SahaServiceManager().service!.login({
        "email_or_phone_number": emailOrPhoneNumber,
        "password": pass,
      });
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }

  Future<bool?> resetPassword(
      {String? emailOrPhoneNumber, String? pass, String? otp, String? otpFrom}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .resetPassword({"email_or_phone_number": emailOrPhoneNumber, "password": pass, "otp": otp, "otp_from": otpFrom,});
      return true;
    } catch (err) {
      handleError(err);
      return false;
    }
  }

  Future<bool?> changePassword({String? newPass, String? oldPass}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .changePassword({"old_password": oldPass, "new_password": newPass});
      return true;
    } catch (err) {
      handleError(err);
      return false;
    }
  }

  Future<List<ExistsLogin>?> checkExists(
      {String? email, String? phoneNumber}) async {
    try {
      var res = await SahaServiceManager()
          .service!
          .checkExists({"email": email, "phone_number": phoneNumber});
      return res.data;
    } catch (err) {
      handleError(err);
    }
  }
}
