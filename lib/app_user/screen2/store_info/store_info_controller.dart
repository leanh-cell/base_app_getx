import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';

class StoreInfoController extends GetxController {
  StoreInfoController() {
    getInfoStore();
  }

  Future<void> getInfoStore() async {
    try {
      HomeController homeController = Get.find();
      var res = await RepositoryManager.storeRepository
          .getOne(UserInfo().getCurrentStoreCode());
      homeController.storeCurrent!(res);
    } catch (err) {}
  }
}
