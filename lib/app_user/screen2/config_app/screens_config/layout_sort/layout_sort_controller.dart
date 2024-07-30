import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_customer/app_customer/model/home_data.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';

class LayoutSortChangeController extends GetxController {
  var loading = false.obs;
  var listLayout = RxList<LayoutHome>();
  DataAppCustomerController dataAppCustomerController = Get.find();

  LayoutSortChangeController() {
    getAllLayout();
  }

  Future<bool?> getAllLayout() async {
    loading.value = true;
    try {
      await dataAppCustomerController.getLayout();
      listLayout(dataAppCustomerController.homeData.value.listLayout!);
      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<bool?> updateLayout() async {
    try {
      var list = await RepositoryManager.configUiRepository
          .updateLayoutSort(listLayout.toList());
      await dataAppCustomerController.getHomeData();
      listLayout(list!);

      SahaAlert.showSuccess(message: "Đã cập nhật");
      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  void changeIndex(int oldIndex, int newIndex) {
    var pre = listLayout[oldIndex];

    if (oldIndex > newIndex) {
      listLayout.removeAt(oldIndex);
      listLayout.insert((newIndex) < 0 ? 0 : newIndex, pre);
    } else {
      listLayout.removeAt(oldIndex);
      listLayout.insert((newIndex - 1) < 0 ? 0 : newIndex - 1, pre);
    }

    updateLayout();
  }

  Future<void> changeHide(LayoutHome va) async {
    var index = listLayout.indexOf(va);
    listLayout[index].hide = !(listLayout[index].hide ?? false);
    updateLayout();
  }
}
