import 'dart:io';

import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:sahashop_customer/app_customer/model/community_post.dart';

import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../utils/image_utils.dart';

class AddUpdateCommunityPostController extends GetxController {
  var listCommunityPost = RxList<CommunityPost>();
  var contentCommunityPost = new TextEditingController();
  var communityPostRequest = CommunityPost().obs;
  var listImageFile = RxList<File>();
  var listImageAsset = RxList<Asset>();
  var collapse = true.obs;
  var maxLine = 7.obs;
  var isLoading = false.obs;
  CommunityPost? communityPostInput;

  AddUpdateCommunityPostController({this.communityPostInput}) {
    if (communityPostInput != null) {
      communityPostRequest.value = communityPostInput!;
      contentCommunityPost.text = communityPostInput!.content ?? "";
    }
  }

  Future<void> addCommunityPost() async {
    isLoading.value = true;
    await uploadListImage();
    try {
      var data = await RepositoryManager.communityRepository.createPostCmt(
        communityPostRequest.value,
      );
      print(data!.data);
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> updateCommunityPost() async {
    isLoading.value = true;
    if (communityPostInput == null) {
      await uploadListImage();
    }

    try {
      var data = await RepositoryManager.communityRepository.updatePostCmt(
         communityPostRequest.value.id!,
         communityPostRequest.value,
      );
      print(data!.data);
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> loadAssets() async {
    try {
      var resultList = await MultiImagePicker.pickImages(
        maxImages: 10 - listImageAsset.length,
        enableCamera: true,
        selectedAssets: listImageAsset,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "SahaShop",
          allViewTitle: "Mời chọn ảnh",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      listImageAsset(resultList);
      listImageFile([]);
      await Future.wait(resultList.map((asset) {
        return assetToFile(asset);
      }));

      if (communityPostInput != null) {
        isLoading.value = true;
        await uploadListImage();
        communityPostRequest.refresh();
        isLoading.value = false;
      }
    } on Exception catch (e) {
      print(e.toString());
      // error = e.toString();
    }
  }

  Future<void> uploadListImage() async {
    int stackComplete = 0;

    var responses = await Future.wait(listImageFile.map((imageFile) {
      return uploadImageData(
          file: imageFile,
          onOK: () {
            stackComplete++;
          });
    }));

    print(stackComplete);
  }

  Future<void> uploadImageData(
      {required File file, required Function onOK}) async {
    try {
      var fileUp = await ImageUtils.getImageCompress(file, quality: 15);
      var link =
          await RepositoryManager.imageRepository.uploadImage(fileUp);
      if (communityPostRequest.value.images == null) {
        communityPostRequest.value.images = [];
      }
      communityPostRequest.value.images!.add(link ?? "");
    } catch (err) {
      print(err);
    }
    onOK();
  }

  Future<void> assetToFile(Asset asset) async {
    var fileUp = await ImageUtils.getImageFileFromAsset(asset);
    if (fileUp != null) listImageFile.add(fileUp);
  }
}
