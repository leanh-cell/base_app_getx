import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/image_utils.dart';
import 'package:sahashop_customer/app_customer/model/category_post.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';

class AddPostController extends GetxController {
  var isLoadingAdd = false.obs;
  var isLoadingCategory = false.obs;
  RxList<CategoryPost> listCategory = new RxList<CategoryPost>();
  var categoryPostSelected = CategoryPost().obs;
  var postSelected = CategoryPost().obs;

  String? title;
  File? image;
  var content = "".obs;
  var imageUrl = "";
  String? summary;
  bool? published;
  int? categoryId;

  Post? postInput;

  final TextEditingController textEditingControllerTitle =
      new TextEditingController();

  final TextEditingController textEditingControllerDescription =
      new TextEditingController();

  AddPostController({this.postInput}) {

    getAllCategory();
  }

  void setNewCategoryPostSelected(CategoryPost categoryPost) {
    categoryPostSelected.value = categoryPost;
  }

  Future<void> getOnePost() async {
    try {
      var res =
          await RepositoryManager.postRepository.getOnePost(postInput!.id!);
      imageUrl = res?.data?.imageUrl ?? "";
      title = res?.data?.title ?? "Tin tức";
      summary = res?.data?.summary ?? "";
      content.value = res?.data?.content ?? "";
      textEditingControllerTitle.text = res?.data?.title ?? "";
      textEditingControllerDescription.text = res?.data?.summary ?? "";
      categoryPostSelected.value = res!.data!.category!.isEmpty
          ? CategoryPost()
          : postInput!.category![0];
    } catch (err) {
      SahaAlert.showToastMiddle(message: err.toString());
    }
  }

  Future<bool?> createPost() async {
    isLoadingAdd.value = true;
    try {
      var imageUp;
      if (image != null) {
        imageUp = await ImageUtils.getImageCompress(image!);
      }

      var data = await RepositoryManager.postRepository.createPost(
          title: title,
          image: imageUp,
          summary: summary,
          published: published,
          categoryId: categoryPostSelected.value.id,
          content: content.value);

      SahaAlert.showSuccess(message: "Thêm thành công");
      Navigator.pop(Get.context!, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }

  Future<bool?> updatePost(int? postId) async {
    isLoadingAdd.value = true;
    try {
      var imageUp;
      if (image != null) {
        imageUp = await ImageUtils.getImageCompress(image!);
      }
      print(imageUrl);
      var data = await RepositoryManager.postRepository.updatePost(
        title: title ?? "",
        image: imageUp,
        imageUrl: imageUrl,
        summary: summary,
        published: published,
        categoryId: categoryPostSelected.value.id,
        content: content.value,
        postId: postId,
      );

      SahaAlert.showSuccess(message: "Thêm thành công");
      Navigator.pop(Get.context!, "added");

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingAdd.value = false;
  }

  Future<void> getAllCategory() async {
    listCategory([]);
    isLoadingCategory.value = true;
    try {
      var list = await RepositoryManager.postRepository.getAllCategoryPost();
      listCategory(list!);

      isLoadingCategory.value = false;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingCategory.value = false;
  }
}
