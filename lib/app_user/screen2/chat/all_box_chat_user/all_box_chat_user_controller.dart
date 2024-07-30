import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/box_chat_customer.dart';
import '../../../../saha_data_controller.dart';

class AllBoxChatUserController extends GetxController {
  var isLoadingBoxChatCustomer = false.obs;
  var listBoxChatCustomer = RxList<BoxChatCustomer>();
  var pageLoadMoreBoxChatCustomer = 1;
  var isSearch = false.obs;
  var unread = 0.obs;
  var limitedSocket = 0.obs;
  var isLoadMore = true.obs;
  var isEndPageUser = false;
  var timeNow = DateTime.now().obs;
  SahaDataController sahaDataController = Get.find();

  @override
  void onInit() {
    refreshWhenRealtime();
    loadInitChatUser();
    super.onInit();
  }

  @override
  void onClose() {
    // SocketUser().close();
    super.onClose();
  }

  void refreshWhenRealtime() {
    timeNow.value = DateTime.now();
    sahaDataController.unread.listen((unread) {
      if (unread != 0) {
        loadInitChatUser();
      }
    });
  }

  Future<void> loadInitChatUser() async {
    isLoadingBoxChatCustomer.value = true;
    listBoxChatCustomer([]);
    pageLoadMoreBoxChatCustomer = 1;
    isEndPageUser = false;
    loadMoreChatUser();
  }

  Future<void> loadMoreChatUser() async {
    isLoadMore.value = true;
    try {
      if (isEndPageUser == false) {
        var res = await RepositoryManager.chatRepository
            .getAllChatUser(pageLoadMoreBoxChatCustomer);
        res!.data!.data!.forEach((element) {
          listBoxChatCustomer.add(element);
        });
        if (res.data!.nextPageUrl != null) {
          pageLoadMoreBoxChatCustomer++;
          isEndPageUser = false;
        } else {
          isEndPageUser = true;
        }
      } else {
        isLoadMore.value = false;
        isLoadingBoxChatCustomer.value = false;
        return;
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadMore.value = false;
    isLoadingBoxChatCustomer.value = false;
  }
}