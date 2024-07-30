import 'dart:io';

import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/course_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/image_file.dart';
import '../../../utils/image_utils.dart';

class AddCourseController extends GetxController {
  var isLoading = false.obs;
  var titleTextEditingController = new TextEditingController();
  var shortDescriptionTextEditingController = new TextEditingController();

  var description = ''.obs;

  CourseList? courseListInput;
  Rx<ImageDataFile?> dataImages = ImageDataFile().obs;
  var isUpdatingImage = false.obs;
  var linkImage = ''.obs;

  AddCourseController({this.courseListInput}) {
    if (courseListInput != null) {
      titleTextEditingController.text = courseListInput?.title ?? "";
      shortDescriptionTextEditingController.text =
          courseListInput?.shortDescription ?? "";
      description.value =
          courseListInput?.description ?? "";
      linkImage.value = courseListInput!.imageUrl ?? "";
    }
  }

  Future<void> addCourse({
    required String title,
    required String shortDescription,
    required String description,
  }) async {
    isLoading.value = true;
    if (title == "") {
      SahaAlert.showError(message: 'Chưa nhập tiêu đề');
      return;
    }
    try {
      var data = await RepositoryManager.educationReposition.addCourses(
        title: title,
        shortDescription: shortDescription,
        description: description,
        imageUrl: linkImage.value,
      );
      print(data!.data);
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  Future<void> updateCourse() async {
    try {
      if (titleTextEditingController.value.text == "") {
        SahaAlert.showError(message: 'Chưa nhập tiêu đề');
        return;
      }
      var res = await RepositoryManager.educationReposition.updateCourse(
          courseListInput!.id,
          CourseList(
            title: titleTextEditingController.value.text,
            shortDescription: shortDescriptionTextEditingController.value.text,
            description: description.value,
            imageUrl: linkImage.value,
          ));
      SahaAlert.showSuccess(message: "Lưu thành công");
      Get.back();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<String?> loadAssets() async {
    try {
      final picker = ImagePicker();
      final pickedFile = (await picker.pickImage(source: ImageSource.gallery))!;
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      if (croppedFile == null) return "";

      dataImages.value = ImageDataFile(
          file: File(croppedFile.path), uploading: true, errorUpload: false);

      return await uploadImage(File(croppedFile.path));
    } on Exception catch (e) {
      return null;
    }
  }

  Future<String?> uploadImage(File file) async {
    isUpdatingImage.value = true;
    try {
      var fileUpImageCompress =
          await ImageUtils.getImageCompress(file, quality: 20);

      var link = (await RepositoryManager.imageRepository
          .uploadImage(fileUpImageCompress))!;

      dataImages.value =
          ImageDataFile(linkImage: link, uploading: false, errorUpload: false);
      linkImage.value = link;
    } catch (err) {
      SahaAlert.showError(message: "Có lỗi khi up ảnh xin thử lại");
    }
    isUpdatingImage.value = false;
  }
}
