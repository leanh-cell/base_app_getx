import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

class AttributeController extends GetxController {
  var loading = false.obs;
  var listAttribute = RxList<String>();

  AttributeController() {
    getAllAttribute();
  }

  Future<bool?> getAllAttribute() async {
    loading.value = true;
    try {
      var list =
          await RepositoryManager.attributesRepository.getAllAttributes();
      listAttribute(list!);

      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<bool?> updateAttribute() async {
    loading.value = true;
    try {
      var list = await RepositoryManager.attributesRepository
          .updateAttributes(listAttribute.toList());
      listAttribute(list!);

      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<void> addAttribute(va) async {
    listAttribute.add(va);
    updateAttribute();
  }

  Future<void> removeAttribute(va) async {
    listAttribute.remove(va);
    updateAttribute();
  }
}
