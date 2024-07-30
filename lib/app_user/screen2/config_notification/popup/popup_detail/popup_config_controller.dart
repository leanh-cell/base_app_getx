import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/picker/category_post/category_post_picker.dart';
import 'package:com.ikitech.store/app_user/components/picker/post/post_picker.dart';
import 'package:com.ikitech.store/app_user/components/picker/product/product_picker.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import 'package:com.ikitech.store/app_user/const/type_popup.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/popup_config.dart';
import 'package:com.ikitech.store/app_user/screen2/config_app/screens_config/main_component_config/image_carousel/select_image_carousel_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/categories/category_screen.dart';
import 'package:com.ikitech.store/app_user/utils/image_utils.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/category_post.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../model/image_file.dart';

class PopupConfigController extends GetxController {
  var popupCf = PopupCf().obs;
  PopupCf? popupCfInput;

  PopupConfigController({this.popupCfInput}) {
    if (popupCfInput != null) {
      codeCurrent.value = popupCfInput!.typeAction!;
      logoUrl.value = popupCfInput!.linkImage!;
      popupCf.value = popupCfInput!;
      popupCf.value.name = popupCfInput!.name;
      if (popupCf.value.valueAction != null) {
        textEditingController.text =
            popupCf.value.valueAction!.replaceAll("https://", "");
      } else {
        textEditingController.text = "";
      }
    }
  }

  var listTypeConfig = RxList<String>([
    "LINK",
    "PRODUCT",
    "CATEGORY_PRODUCT",
    "POST",
    "CATEGORY_POST",
  ]);

  var codeCurrent = "LINK".obs;

  Rx<ImageDataFile?> dataImages = ImageDataFile().obs;
  var isUpdatingImage = false.obs;
  var logoUrl = "".obs;
  TextEditingController textEditingController = TextEditingController();

  Future<void> updatePopup() async {
    popupCf.value.typeAction = codeCurrent.value;
    try {
      var popup = popupCf.value;
      if (popup.name == null ||
          popup.linkImage == null ||
          popup.valueAction == null ||
          popup.typeAction == null) {
        SahaAlert.showError(message: "Bạn cần nhập đầy đủ thông tin");
      } else {
        var data = RepositoryManager.popupRepository
            .updatePopup(popupCfInput!.id!, popupCf.value);
        SahaAlert.showSuccess(message: "Cập nhật thành công");
        Get.back(result: popupCf.value);
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> addPopupTo() async {
    popupCf.value.typeAction = codeCurrent.value;
    try {
      var popup = popupCf.value;
      
      if (popup.name == null ||
          popup.linkImage == null ||
          popup.valueAction == null ||
          popup.typeAction == null) {
        print(popup.name);
        print(popup.linkImage);
        print(popup.valueAction);
        print(popup.typeAction);

        SahaAlert.showError(message: "Bạn cần nhập đầy đủ thông tin");
        return;

      } 
      if(GetUtils.isURL(popup.valueAction?? '') != true && codeCurrent == "LINK"){
        SahaAlert.showError(message: "Không tồn tại địa chỉ web này");
        return;
      }
   
        var data =
            await RepositoryManager.popupRepository.addPopup(popupCf.value);
        Get.back(result: popupCf.value);
        SahaAlert.showSuccess(message: "Thêm thành công");
     
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void updateImage({ImageDataFile? imageData}) {
    dataImages.value = imageData;
  }

  Future<String?> uploadImage(File file) async {
    isUpdatingImage.value = true;
    try {
      var fileUpImageCompress =
          await ImageUtils.getImageCompress(file, quality: 20);

      var link = (await RepositoryManager.imageRepository
          .uploadImage(fileUpImageCompress))!;

      //OK up load
      updateImage(
          imageData: ImageDataFile(
              linkImage: link, uploading: false, errorUpload: false));
      logoUrl.value = link;
      popupCf.value.linkImage = link;
    } catch (err) {
      updateImage(
          imageData:
              ImageDataFile(file: file, uploading: false, errorUpload: true));

      SahaAlert.showError(message: "Có lỗi khi up ảnh xin thử lại");
    }
    isUpdatingImage.value = false;
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

  void addPopup(String typePopup) async {
    if (typePopup == typeActionPopup[TYPE_POPUP.LINK]) {}
    if (typePopup == typeActionPopup[TYPE_POPUP.PRODUCT]) {
      List<Product>? productsCheck;
      await Get.to(() => ProductPickerScreen(
                listProductInput: [],
                onlyOne: true,
                callback: (List<Product> products) {
                  if (products.length > 1) {
                    SahaAlert.showError(message: "Chọn tối đa 1 sản phẩm");
                  } else {
                    productsCheck = products;
                    popupCf.value.valueAction = products[0].id.toString();
                    popupCf.value.name = products[0].name.toString();
                  }
                },
              ))!
          .then((value) => {
                if (productsCheck != null && productsCheck!.length > 1)
                  {
                    SahaAlert.showError(message: "Chọn tối đa 1 sản phẩm"),
                  }
              });
      popupCf.refresh();
      return;
    }

    if (typePopup == typeActionPopup[TYPE_POPUP.CATEGORY_PRODUCT]) {
      await Get.to(() => CategoryScreen(
                isSelect: true,
              ))!
          .then((categories) {
        List<Category> categories2 = categories["list_cate"];
        if (categories2.length > 1) {
          SahaAlert.showError(message: "Chọn tối đa 1 Danh mục");
        } else if (categories2.length == 1) {
          print(categories);
          popupCf.value.valueAction = categories2[0].id.toString();
          popupCf.value.name = categories2[0].name.toString();
        }
      });
      popupCf.refresh();
      return;
    }

    if (typePopup == typeActionPopup[TYPE_POPUP.POST]) {
      await Get.to(() => PostPickerScreen(
            listPostInput: [],
            onlyOne: true,
            callback: (List<Post> post) {
              if (post.length > 1 || post.length == 0) {
                SahaAlert.showError(message: "Chọn tối đa 1 Bài viết");
              } else {
                popupCf.value.valueAction = post[0].id.toString();
                popupCf.value.name = post[0].title.toString();
              }
            },
          ));
      popupCf.refresh();
      return;
    }

    if (typePopup == typeActionPopup[TYPE_POPUP.CATEGORY_POST]) {
      await Get.to(() => CategoryPostPickerScreen(
                isSelect: true,
              ))!
          .then((categories) {
        List<CategoryPost> categories2 = categories;
        if (categories2.length == 1) {
          popupCf.value.valueAction = categories2[0].id.toString();
          popupCf.value.name = categories2[0].title.toString();
        } else if (categories2.length > 1) {
          SahaAlert.showError(message: "Chọn tối đa 1 Danh mục bài viết");
        }
      });
      popupCf.refresh();
      return;
    }
  }
}
