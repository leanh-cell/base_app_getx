import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/image_utils.dart';
import 'package:sahashop_customer/app_customer/model/category_post.dart';

class AddCategoryPostController extends GetxController {
  var isLoadingAdd = false.obs;

  final TextEditingController textEditingControllerTitle =
      new TextEditingController();

  final TextEditingController textEditingControllerDescription =
      new TextEditingController();

  String? title;
  File? image;
  String? description;

  CategoryPost? categoryEd;

  Future<bool?> createCategoryPost() async {
    isLoadingAdd.value = true;
    try {
      var imageUp;
      if (image != null) {
        imageUp = await ImageUtils.getImageCompress(image!);
      }

      if (categoryEd != null) {
        var data = await RepositoryManager.postRepository.updateCategoryPost(
            imageUrl: categoryEd!.imageUrl,
            categoryPostId: categoryEd!.id,
            title: textEditingControllerTitle.text,
            image: imageUp,
            description: textEditingControllerDescription.text);
        SahaAlert.showSuccess(message: "Sửa thành công");
      } else {
        var data = await RepositoryManager.postRepository.createCategoryPost(
            title: textEditingControllerTitle.text,
            image: imageUp,
            description: textEditingControllerDescription.text);
        SahaAlert.showSuccess(message: "Thêm thành công");
      }

      Navigator.pop(Get.context!, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }
}
