import 'dart:io';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

import 'package:com.ikitech.store/app_user/utils/image_utils.dart';
import 'package:sahashop_customer/app_customer/model/attribute_search.dart';

class AddAttributeSearchController extends GetxController {
  var isLoadingAdd = false.obs;

  AttributeSearch? attributeSearch;
  SahaDataController sahaDataController = Get.find();
  String? name;
  var image = ''.obs;

  final TextEditingController textEditingControllerName =
      new TextEditingController();

  AddAttributeSearchController({this.attributeSearch}) {
    if (attributeSearch != null) {
      textEditingControllerName.text = attributeSearch!.name!;
      image.value = attributeSearch!.imageUrl ?? '';
    }
  }

  Future<void> createAttributeSearch({int? attributeSearchId}) async {
    isLoadingAdd.value = true;
    try {
      if (attributeSearchId == null) {
        if (sahaDataController
                .badgeUser.value.decentralization?.productAttributeAdd !=
            true) {
          SahaAlert.showError(message: "Bạn chưa được phân quyền");
          return;
        }
        var data = await RepositoryManager.attributeSearchRepo
            .createAttributeSearch(textEditingControllerName.text, image.value);
      } else {
        if (sahaDataController
                .badgeUser.value.decentralization?.productAttributeUpdate !=
            true) {
          SahaAlert.showError(message: "Bạn chưa được phân quyền");
          return;
        }
        var data = await RepositoryManager.attributeSearchRepo
            .updateAttributeSearch(
                attributeSearchId, textEditingControllerName.text, image.value);
      }

      SahaAlert.showSuccess(message: "Thêm thành công");
      Navigator.pop(Get.context!, "added");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }
}
