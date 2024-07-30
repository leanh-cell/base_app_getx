
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/chat/all_chat_customer_reponse.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/chat/all_message_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/chat/send_message_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/chat/send_message_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

class ChatRepository {
  Future<AllChatCustomerResponse?> getAllChatUser(int? numberPage) async {
    try {
      var res = SahaServiceManager()
          .service!
          .getAllChatUser(UserInfo().getCurrentStoreCode(), numberPage!);
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());

    }
  }

  Future<AllMessageResponse?> getAllMessageUser(
      int? idCustomer, int numberPage) async {
    try {
      var res = await SahaServiceManager().service!.getAllMessageUser(
          UserInfo().getCurrentStoreCode(), idCustomer, numberPage);
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<SendMessageResponse?> sendMessageToCustomer(
      int? idCustomer, SendMessageRequest sendMessageRequest) async {
    try {
      var res = await SahaServiceManager().service!.sendMessageToCustomer(
          UserInfo().getCurrentStoreCode(),
          idCustomer,
          sendMessageRequest.toJson());
      return res;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
