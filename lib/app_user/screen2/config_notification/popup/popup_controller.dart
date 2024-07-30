import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/picker/category_post/category_post_picker.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/picker/image/image_dialog_picker.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/picker/post/post_picker.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/picker/product/product_picker.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/const/type_popup.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/popup_config.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/categories/category_screen.dart';
import 'package:com.ikitech.store/app_user/utils/image_utils.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/category_post.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import '../../../model/image_file.dart';

class PopupController extends GetxController {
  Rx<ImageDataFile?> dataImages = ImageDataFile().obs;
  var isUpdatingImage = false.obs;
  var logoUrl = "".obs;
  var titlePopup = "".obs;
  var popupCf = PopupCf();
  var listPopupCf = RxList<PopupCf>([]);

  PopupController() {
    getListPopup();
  }

  String convertTypePopup(String typeAction) {
    if (typeAction == "LINK") {
      return "Website";
    } else if (typeAction == "PRODUCT") {
      return "Sản phẩm";
    } else if (typeAction == "CATEGORY_PRODUCT") {
      return "Danh mục SP";
    } else if (typeAction == "POST") {
      return "Bài viết";
    } else if (typeAction == "CATEGORY_POST") {
      return "Danh mục BV";
    } else {
      return "";
    }
  }

  Future<void> deletePopup(int idPopup) async {
    try {
      SahaDialogApp.showDialogYesNo(
          mess: "Bạn có chắc muốn xoá quảng cáo này không ?",
          onOK: () async {
            var res =
                await RepositoryManager.popupRepository.deletePopup(idPopup);
            var index =
                listPopupCf.indexWhere((element) => element.id == idPopup);
            if (idPopup != -1) {
              listPopupCf.removeAt(index);
            }
            SahaAlert.showSuccess(message: "Xoá thành công");
          });
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getListPopup() async {
    try {
      var data = await RepositoryManager.popupRepository.getListPopup();
      listPopupCf(data!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void addPopup(String typePopup) async {
    if (typePopup == typeActionPopup[TYPE_POPUP.LINK]) {
      var stop = false;
      await SahaDialogApp.showDialogInput(
          title: "Nhập địa chỉ web",
          hintText: "http://",
          onCancel: () {
            stop = true;
            Get.back();
            return;
          },
          onInput: (va) {
            if (GetUtils.isURL(va)) {
              popupCf.valueAction = va;
              Get.back();
            } else {
              SahaAlert.showError(message: "Địa chỉ không hợp lệ");
              stop = true;
              Get.back();
              return;
            }
          });
      if (stop) return;
      ImageDialogPicker.showPickOnePopup(onSuccess: (path) {
        popupCf.linkImage = path;
        // currentButtonCfs.add(newButton);
      }, onCancel: () {
        return;
      });
      return;
    }

    if (typePopup == typeActionPopup[TYPE_POPUP.PRODUCT]) {
      var stop = false;
      List<Product>? productsCheck;
      await Get.to(() => ProductPickerScreen(
                listProductInput: [],
                callback: (List<Product> products) {
                  if (products.length > 1) {
                    SahaAlert.showError(message: "Chọn tối đa 1 sản phẩm");
                    stop = true;
                    Get.back();
                  } else {
                    productsCheck = products;
                    popupCf.valueAction = products[0].id.toString();
                    Get.back();
                  }
                },
              ))!
          .then((value) => {
                if (productsCheck == null)
                  {
                    stop = true,
                    SahaAlert.showError(message: "Chọn tối đa 1 sản phẩm"),
                    Get.back(),
                  }
              });

      if (stop) return;
      ImageDialogPicker.showPickOnePopup(onSuccess: (path) {
        popupCf.linkImage = path;
        // currentButtonCfs.add(newButton);
      }, onCancel: () {
        return;
      });

      return;
    }

    if (typePopup == typeActionPopup[TYPE_POPUP.CATEGORY_PRODUCT]) {
      var stop = false;
      await Get.to(() => CategoryScreen(
                isSelect: true,
              ))!
          .then((categories) {
        List<Category> categories2 = categories;
        if (categories2.length > 1 || categories2.length == 0) {
          SahaAlert.showError(message: "Chọn tối đa 1 Danh mục");
          stop = true;
          Get.back();
        } else {
          popupCf.valueAction = categories2[0].id.toString();
          Get.back();
        }
      });
      if (stop) return;
      ImageDialogPicker.showPickOnePopup(onSuccess: (path) {
        popupCf.linkImage = path;
        // currentButtonCfs.add(newButton);
      }, onCancel: () {
        return;
      });

      return;
    }

    if (typePopup == typeActionPopup[TYPE_POPUP.POST]) {
      var stop = false;
      await Get.to(() => PostPickerScreen(
            listPostInput: [],
            callback: (List<Post> post) {
              if (post.length > 1 || post.length == 0) {
                SahaAlert.showError(message: "Chọn tối đa 1 Bài viết");
                stop = true;
                Get.back();
              } else {
                popupCf.valueAction = post[0].id.toString();
                Get.back();
              }
            },
          ));
      if (stop) return;
      ImageDialogPicker.showPickOnePopup(onSuccess: (path) {
        popupCf.linkImage = path;
        // currentButtonCfs.add(newButton);
      }, onCancel: () {
        return;
      });
      return;
    }

    if (typePopup == typeActionPopup[TYPE_POPUP.CATEGORY_POST]) {
      var stop = false;
      await Get.to(() => CategoryPostPickerScreen(
                isSelect: true,
              ))!
          .then((categories) {
        List<CategoryPost> categories2 = categories;
        if (categories2.length > 1 || categories2.length == 0) {
          SahaAlert.showError(message: "Chọn tối đa 1 Danh mục bài viết");
          stop = true;
          Get.back();
        } else {
          popupCf.valueAction = categories2[0].id.toString();
          Get.back();
        }
      });

      if (stop) return;
      ImageDialogPicker.showPickOnePopup(onSuccess: (path) {
        popupCf.linkImage = path;
        // currentButtonCfs.add(newButton);
      }, onCancel: () {
        return;
      });
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
          imageData:
          ImageDataFile(linkImage: link, uploading: false, errorUpload: false));
      logoUrl.value = link;
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
}
