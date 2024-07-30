import 'package:get/get.dart';

import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../data/remote/response-request/e_commerce/sync_res.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/e_commerce.dart';

class OrderCommerceController extends GetxController {
  var listEcommerce = RxList<ECommerce>();
  var loadInit = true.obs;

  var platformName = ''.obs;

  var listShopId = <String>[].obs;
  var dataSync = SyncData();
  int pageCommerce = 1;

  OrderCommerceController() {
    getAllEcommerce();
  }

  Future<void> getAllEcommerce() async {
    try {
      var res = await RepositoryManager.eCommerceRepo
          .getAllEcommerce(platformName: platformName.value);
      listEcommerce.value = res!.data!;
      loadInit.value = false;
    } on Exception catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }

  Future<void> syncOrder() async {
    try {
      var res = await RepositoryManager.eCommerceRepo
          .syncOrder(shopId: listShopId, page: pageCommerce);
      dataSync = res!.data!;
    } on Exception catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
