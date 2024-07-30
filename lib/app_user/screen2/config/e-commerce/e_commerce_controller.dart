import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:get/get.dart';

import '../../../model/e_commerce.dart';

class ECommerceController extends GetxController {
  var listEcommerce = RxList<ECommerce>();
  var loadInit = true.obs;

  String? platformName;

  ECommerceController() {
    getAllEcommerce();
  }

  Future<void> getAllEcommerce() async {
    try {
      var res = await RepositoryManager.eCommerceRepo
          .getAllEcommerce(platformName: platformName);
      listEcommerce.value = res!.data!;
      loadInit.value = false;
    } on Exception catch (e) {
      SahaAlert.showError(message: e.toString());
    }
  }
}
