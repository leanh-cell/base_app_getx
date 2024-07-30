import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/image_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahashop_customer/app_customer/model/banner.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../../model/image_file.dart';
import '../../../config_controller.dart';

class SelectCarouselImagesController extends GetxController {
  Function? onUpload;
  Function? doneUpload;
  String? linkTo;

  RxList<ImageDataFile?> dataImages = <ImageDataFile>[].obs;

  void init() {
    ConfigController configController = Get.find();

    if (configController.configApp.carouselAppImages != null) {
      final listCarousel = configController.configApp.carouselAppImages!;

      dataImages(listCarousel
          .map((e) => ImageDataFile(
              linkImage: e.imageUrl, uploading: false, errorUpload: false))
          .toList());
    }
  }

  void removeImage(ImageDataFile imageData) {
    dataImages.remove(imageData);
    updateBannerToConfig();
  }

  void updateBannerToConfig() {
    ConfigController configController = Get.find();

    var banners = <BannerItem>[];

    dataImages.forEach((imageData) {
      if (imageData!.linkImage != null) {
        banners.add(BannerItem(
            imageUrl: imageData.linkImage, title: "", linkTo: linkTo));
      }
    });

    configController.configApp.carouselAppImages = banners;
    configController.createAppTheme();
  }

  void updateImage({required int index, ImageDataFile? imageData}) {
    var indexWithLength = index - 1;
    var newList = dataImages.toList();

    newList[indexWithLength] = imageData;

    dataImages(newList);
  }

  Future<String?> uploadImage(File file) async {
    try {
      var fileUpImageCompress =
          await ImageUtils.getImageCompress(file, quality: 50);

      var link = await RepositoryManager.imageRepository
          .uploadImage(fileUpImageCompress);

      //OK up load
      updateImage(
          index: dataImages.length,
          imageData: ImageDataFile(
              linkImage: link, uploading: false, errorUpload: false));

      updateBannerToConfig();

      return link;
    } catch (err) {
      updateImage(
          index: dataImages.length,
          imageData:
              ImageDataFile(file: file, uploading: false, errorUpload: true));

      updateBannerToConfig();
      SahaAlert.showError(message: "Có lỗi khi up ảnh xin thử lại");
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

      dataImages.add(ImageDataFile(
          file: File(croppedFile.path), uploading: true, errorUpload: false));

      return await uploadImage(File(croppedFile.path));
    } on Exception catch (e) {
      return null;
    }
  }
}
