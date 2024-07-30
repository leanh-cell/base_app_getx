import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/image_utils.dart';

import '../../../../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../../../../model/image_file.dart';

class SelectImageBannerAdsController extends GetxController {
  Function? onUpload;
  Function? doneUpload;
  SelectImageBannerAdsController({this.onUpload, this.doneUpload});

  RxList<ImageDataFile?> dataImages = <ImageDataFile>[].obs;

  void removeImage(ImageDataFile ImageDataFile) {
    dataImages.remove(ImageDataFile);
    // updateBannerToConfig();
  }

  Future<String?> uploadImage(File file) async {
    try {
      var fileUpImageCompress =
          await ImageUtils.getImageCompress(file, quality: 50);

      var link = await RepositoryManager.imageRepository
          .uploadImage(fileUpImageCompress);

      updateImage(
          index: dataImages.length,
          imageDataFile: ImageDataFile(
              linkImage: link, uploading: false, errorUpload: false));

      doneUpload!([
        ImageDataFile(
            file: file, linkImage: link, uploading: false, errorUpload: false)
      ]);

      return link;
    } catch (err) {
      updateImage(
          index: dataImages.length,
          imageDataFile:
              ImageDataFile(file: file, uploading: false, errorUpload: true));

      // updateBannerToConfig();
      SahaAlert.showError(message: "Có lỗi khi up ảnh xin thử lại");
    }
  }

  void updateImage({required int index, ImageDataFile? imageDataFile}) {
    var indexWithLength = index - 1;
    var newList = dataImages.toList();

    newList[indexWithLength] = imageDataFile;

    dataImages(newList);
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

      dataImages.add(ImageDataFile(
          file: File(croppedFile.path), uploading: true, errorUpload: false));

      return await uploadImage(File(croppedFile.path));
    } on Exception catch (e) {
      return null;
    }
  }
}
