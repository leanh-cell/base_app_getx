import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';

class CategoryController extends GetxController {
  var loading = false.obs;
  var listCategory = RxList<Category>();
  var listCategorySelected = RxList<Category>();
  var listCategorySelectedChild = RxList<Category>();


  CategoryController() {
    getAllCategory();
  }

  void selectCategory(Category category) {
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

  void selectCategoryChild(Category categoryChild) {
    listCategorySelectedChild.refresh();
    if (listCategorySelectedChild
        .map((element) => element.id)
        .toList()
        .contains(categoryChild.id)) {
      listCategorySelectedChild
          .removeWhere((element) => element.id == categoryChild.id);
    } else {
      listCategorySelectedChild.add(categoryChild);
    }
    print(listCategorySelectedChild.map((element) => element.id).toList());
    // listCategorySelectedChild.forEach((element) {
    //   if (!listCategory.map((e) => e.id).toList().contains(element.id)) {
    //     listCategorySelectedChild
    //         .removeWhere((element) => element.id == categoryChild.id);
    //   }
    // });
  }

  bool selected(Category category) {
    return listCategorySelected
        .map((element) => element.id)
        .toList()
        .contains(category.id);
  }

  bool selectedChild(Category category) {
    return listCategorySelectedChild
        .map((element) => element.id)
        .toList()
        .contains(category.id);
  }

  Future<bool?> getAllCategory() async {
    EasyLoading.show();
    try {
      var list = await RepositoryManager.categoryRepository.getAllCategory();
      listCategory(list!);

      loading.value = false;
      EasyLoading.dismiss();
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    EasyLoading.dismiss();
  }

  Future<bool?> sortCategories(int oldIndex, int newIndex) async {
    try {
      newIndex > oldIndex
          ? () {
              newIndex--;
              var row = listCategory.removeAt(oldIndex);
              listCategory.insert(newIndex, row);
            }()
          : () {
              var row = listCategory.removeAt(oldIndex);
              listCategory.insert(newIndex, row);
            }();

      var data = await RepositoryManager.categoryRepository.sortCategories(
          listCategory.map((element) => element.id!).toList(),
          List.generate(listCategory.length, (index) => index).toList());

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<bool?> deleteCategory(int categoryId) async {
    try {
      var data =
          await RepositoryManager.categoryRepository.deleteCategory(categoryId);
      listCategory.removeWhere((element) => element.id == categoryId);
      SahaAlert.showSuccess(message: "Đã xóa");
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<bool?> deleteCategoryChild(int categoryId, int categoryChildId) async {
    try {
      var data = await RepositoryManager.categoryRepository
          .deleteCategoryChild(categoryId, categoryChildId);
      listCategory.removeWhere((element) => element.id == categoryId);
      SahaAlert.showSuccess(message: "Đã xóa");
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
