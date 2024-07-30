import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_customer/app_customer/model/category_post.dart';

class CategoryPickerController extends GetxController {
  var loading = false.obs;
  var listCategory = RxList<CategoryPost>();
  var listCategorySelected = RxList<CategoryPost>();

  CategoryPickerController() {
    getAllCategory();
  }

  void selectCategory(CategoryPost category) {
    listCategorySelected.refresh();
    if (listCategorySelected
        .map((element) => element.id)
        .toList()
        .contains(category.id)) {
      listCategorySelected.removeWhere((element) => element.id == category.id);
    } else {
      listCategorySelected.add(category);
    }
    listCategorySelected.forEach((element) {
      if (!listCategory.map((e) => e.id).toList().contains(element.id)) {
        listCategorySelected
            .removeWhere((element) => element.id == category.id);
      }
    });
  }

  bool selected(CategoryPost category) {
    return listCategorySelected
        .map((element) => element.id)
        .toList()
        .contains(category.id);
  }

  Future<bool?> getAllCategory() async {
    loading.value = true;
    try {
      var list = await RepositoryManager.postRepository.getAllCategoryPost();
      listCategory(list!);

      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }


}
