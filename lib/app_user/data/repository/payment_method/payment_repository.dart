import 'package:com.ikitech.store/app_user/data/remote/response-request/payment_method/payment_method_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/payment_method/update_payment_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import '../../remote/response-request/payment_method/all_payment_method_res.dart';
import '../handle_error.dart';

class PaymentRepository {
  Future<AllPaymentMethodRes?> getPaymentMethod() async {
    try {
      var res = await SahaServiceManager()
          .service!
          .getPaymentMethod(UserInfo().getCurrentStoreCode());
      return res;
    } catch (err) {
      handleError(err);
    }
  }

  Future<UpdatePaymentResponse?> upDatePaymentMethod(
      int? idPaymentMethod, Map<String, dynamic>? body) async {
    try {
      var res = await SahaServiceManager().service!.upDatePaymentMethod(
          UserInfo().getCurrentStoreCode(), idPaymentMethod, body ?? {});
      return res;
    } catch (err) {
      handleError(err);
    }
  }
}
