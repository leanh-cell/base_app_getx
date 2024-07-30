import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:sahashop_customer/app_customer/model/attribute_search.dart';

class AttributeSearchController extends GetxController {
  var loading = false.obs;
  var listAttributeSearch = RxList<AttributeSearch>();
  var listAttributeSearchSelected = RxList<AttributeSearch>();
  var listAttributeSearchSelectedChild = RxList<AttributeSearch>();

  final List<AttributeSearch>? listAttributeSearchSelectedChildInput;

  AttributeSearchController({this.listAttributeSearchSelectedChildInput}) {
    if (listAttributeSearchSelectedChildInput != null) {
      listAttributeSearchSelectedChild(listAttributeSearchSelectedChildInput);
    }
    getAttributeSearch();
  }

  void selectAttributeSearch(AttributeSearch AttributeSearch) {
    listAttributeSearchSelected.refresh();
    if (listAttributeSearchSelected
        .map((element) => element.id)
        .toList()
        .contains(AttributeSearch.id)) {
      listAttributeSearchSelected
          .removeWhere((element) => element.id == AttributeSearch.id);
    } else {
      listAttributeSearchSelected.add(AttributeSearch);
    }
    listAttributeSearchSelected.forEach((element) {
      if (!listAttributeSearch.map((e) => e.id).toList().contains(element.id)) {
        listAttributeSearchSelected
            .removeWhere((element) => element.id == AttributeSearch.id);
      }
    });
  }

  void selectAttributeSearchChild(AttributeSearch AttributeSearchChild) {
    listAttributeSearchSelectedChild.refresh();
    if (listAttributeSearchSelectedChild
        .map((element) => element.id)
        .toList()
        .contains(AttributeSearchChild.id)) {
      listAttributeSearchSelectedChild
          .removeWhere((element) => element.id == AttributeSearchChild.id);
    } else {
      listAttributeSearchSelectedChild.add(AttributeSearchChild);
    }

    // listAttributeSearchSelectedChild.forEach((element) {
    //   if (!listAttributeSearch.map((e) => e.id).toList().contains(element.id)) {
    //     listAttributeSearchSelectedChild
    //         .removeWhere((element) => element.id == AttributeSearchChild.id);
    //   }
    // });
  }

  bool selected(AttributeSearch attributeSearch) {
    return listAttributeSearchSelected
        .map((element) => element.id)
        .toList()
        .contains(attributeSearch.id);
  }

  bool selectedChild(AttributeSearch attributeSearch) {
    return listAttributeSearchSelectedChild
        .map((element) => element.id)
        .toList()
        .contains(attributeSearch.id);
  }

  Future<bool?> getAttributeSearch() async {
    loading.value = true;
    try {
      var list =
          await RepositoryManager.attributeSearchRepo.getAttributeSearch();
      listAttributeSearch(list!.data!);
      loading.value = false;
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<bool?> sortAttributeSearch(int oldIndex, int newIndex) async {
    try {
      newIndex > oldIndex
          ? () {
              newIndex--;
              var row = listAttributeSearch.removeAt(oldIndex);
              listAttributeSearch.insert(newIndex, row);
            }()
          : () {
              var row = listAttributeSearch.removeAt(oldIndex);
              listAttributeSearch.insert(newIndex, row);
            }();

      var data = await RepositoryManager.attributeSearchRepo
          .sortAttributeSearch(
              listAttributeSearch.map((element) => element.id!).toList(),
              List.generate(listAttributeSearch.length, (index) => index)
                  .toList());

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    loading.value = false;
  }

  Future<bool?> deleteAttributeSearch(int AttributeSearchId) async {
    try {
      var data = await RepositoryManager.attributeSearchRepo
          .deleteAttributeSearch(AttributeSearchId);
      listAttributeSearch
          .removeWhere((element) => element.id == AttributeSearchId);
      SahaAlert.showSuccess(message: "Đã xóa");
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<bool?> deleteAttributeSearchChild(
      int AttributeSearchId, int AttributeSearchChildId) async {
    try {
      var data = await RepositoryManager.attributeSearchRepo
          .deleteAttributeChild(AttributeSearchId, AttributeSearchChildId);
      listAttributeSearch
          .removeWhere((element) => element.id == AttributeSearchId);
      SahaAlert.showSuccess(message: "Đã xóa");
      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
