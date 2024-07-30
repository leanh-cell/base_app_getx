import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

import 'package:com.ikitech.store/app_user/utils/image_utils.dart';
import 'package:sahashop_customer/app_customer/model/attribute_search.dart';

class AddChildAttributeSearchController extends GetxController {
  var isLoadingAdd = false.obs;

  AttributeSearch attributeSearch;
  AttributeSearch? attributeSearchChild;

  String? name;
  var image = ''.obs;

  final TextEditingController textEditingControllerName =
      new TextEditingController();

  AddChildAttributeSearchController(
      {required this.attributeSearch, this.attributeSearchChild}) {
    if (attributeSearchChild != null) {
      image.value = attributeSearchChild!.imageUrl ?? '';
      textEditingControllerName.text = attributeSearchChild?.name ?? "";
    }
  }

  Future<bool?> createAttributeSearchChild() async {
    isLoadingAdd.value = true;
    try {
      var data = await RepositoryManager.attributeSearchRepo
          .createAttributeSearchChild(
              attributeSearch.id!, textEditingControllerName.text, image.value);

      SahaAlert.showSuccess(message: "Thêm thành công");
      Navigator.pop(Get.context!, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }

  Future<bool?> updateAttributeSearchChild() async {
    isLoadingAdd.value = true;
    try {
      var data = await RepositoryManager.attributeSearchRepo
          .updateAttributeSearchChild(
              attributeSearch.id,
              attributeSearchChild?.id,
              textEditingControllerName.text,
              image.value);

      SahaAlert.showSuccess(message: "Sửa thành công");
      Navigator.pop(Get.context!, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }

// var data = await RepositoryManager.attributeSearchRepository.updateattributeSearch(
// textEditingControllerName.text, attributeSearchId, imageUp);

}
