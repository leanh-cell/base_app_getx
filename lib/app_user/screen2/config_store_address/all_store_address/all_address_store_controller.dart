import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/info_address.dart';

class AllAddressStoreController extends GetxController {
  var isLoadingAddress = false.obs;
  var listAddressStore = RxList<InfoAddress>();

  AllAddressStoreController() {
    getAllAddressStore();
  }

  Future<void> getAllAddressStore() async {
    isLoadingAddress.value = true;
    try {
      var res = await RepositoryManager.addressRepository.getAllAddressStore();
      listAddressStore.addAll(res!.data!);
      // SahaAlert.showSuccess(message: "Lưu thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAddress.value = false;
  }

  void refreshData() async {
    listAddressStore = new RxList<InfoAddress>();
    await getAllAddressStore();
  }
}
