import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

import 'package:com.ikitech.store/app_user/utils/image_utils.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';

class AddChildCategoryController extends GetxController {
  var isLoadingAdd = false.obs;

  Category category;
  Category? categoryChild;

  String? name;
  File? image;

  final TextEditingController textEditingControllerName =
      new TextEditingController();

  AddChildCategoryController({required this.category, this.categoryChild});

  Future<bool?> createCategoryChild() async {
    isLoadingAdd.value = true;
    try {
      var imageUp;

      if (image != null) {
        imageUp = await ImageUtils.getImageCompress(image!);
      }

      var data = await RepositoryManager.categoryRepository.createCategoryChild(
          category.id!, textEditingControllerName.text, image ?? imageUp);

      SahaAlert.showSuccess(message: "Thêm thành công");
      Navigator.pop(Get.context!, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }

  Future<bool?> updateCategoryChild() async {
    isLoadingAdd.value = true;
    try {
      var imageUp;

      if (image != null) {
        imageUp = await ImageUtils.getImageCompress(image!);
      }

      var data = await RepositoryManager.categoryRepository.updateCategoryChild(
          category.id,
          categoryChild?.id,
          textEditingControllerName.text,
          imageUp);

      SahaAlert.showSuccess(message: "Sửa thành công");
      Navigator.pop(Get.context!, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }

// var data = await RepositoryManager.categoryRepository.updateCategory(
// textEditingControllerName.text, categoryId, imageUp);

}
