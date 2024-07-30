import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

import 'package:com.ikitech.store/app_user/utils/image_utils.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';

class AddCategoryController extends GetxController {
  var isLoadingAdd = false.obs;

  Category? category;

  String? name;
  File? image;
  var isShowHome = false.obs;

  final TextEditingController textEditingControllerName =
      new TextEditingController();

  AddCategoryController({this.category}) {
    if (category != null) {
      isShowHome.value = category!.isShowHome ?? false;
    }
  }

  Future<bool?> createCategory({int? categoryId, String? imageUrl}) async {
    isLoadingAdd.value = true;
    try {
      var imageUp;

      if (image != null) {
        imageUp = await ImageUtils.getImageCompress(image!);
      }

      if (categoryId == null) {
        var data = await RepositoryManager.categoryRepository
            .createCategory(textEditingControllerName.text, image ?? imageUp,isShowHome.value);
      } else {
        var data = await RepositoryManager.categoryRepository.updateCategory(
            textEditingControllerName.text,
            categoryId,
            image ?? imageUp,
            isShowHome.value);
      }

      SahaAlert.showSuccess(message: "Thêm thành công");
      Navigator.pop(Get.context!, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }
}
