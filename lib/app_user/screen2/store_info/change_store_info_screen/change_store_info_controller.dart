import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/store/all_store_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/store/type_store_respones.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/utils/image_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ChangeStoreInfoController extends GetxController {
  var store = Store().obs;
  var sex = "".obs;
  var logoUrl = "".obs;
  var idTypeShop = 0.obs;
  var idTypeChild = 0.obs;
  var isUpdatingImage = false.obs;
  var isChange = false.obs;
  Rx<ImageData?> dataImages = ImageData().obs;
  var listDataType = RxList<DataTypeShop>([]);
  var listChild = RxList<Child>();
  var nameChild = "".obs;
  var nameEditingController = new TextEditingController().obs;
  var addressEditingController = new TextEditingController().obs;

  ChangeStoreInfoController() {
    HomeController homeController = Get.find();
    store(homeController.storeCurrent!.value);
    nameEditingController.value.text = store.value.name ?? "";
    addressEditingController.value.text = store.value.address ?? "";

    idTypeShop.value = store.value.idTypeOfStore ?? -1;
    logoUrl.value = store.value.logoUrl ?? "";

    dataImages.value = ImageData(
        linkImage: store.value.logoUrl, uploading: false, errorUpload: false);

    getAllShopType();
  }

  Future<List<DataTypeShop>?> getAllShopType() async {
    try {
      var listDataTypeShop =
          (await RepositoryManager.typeOfShopRepository.getAll())!;
      listDataType(listDataTypeShop);
      await convertIndexInit();
      convertIndexChildInit();
      store.refresh();
    } catch (err) {}
  }

  var indexTypeOfStore = 0.obs;
  var indexChild = 0.obs;

  Future<void> convertIndexInit() async {
    var index = listDataType
        .indexWhere((element) => element.id == store.value.idTypeOfStore);
    if (index != -1) {
      indexTypeOfStore.value = index;
    } else {
      indexTypeOfStore.value = 0;
    }
  }

  void convertIndexChildInit() {
    var index = listDataType[indexTypeOfStore.value]
        .childs!
        .indexWhere((element) => element.id == store.value.career);
    print(" ====== child ${index}");
    if (index != -1) {
      indexChild.value = index;
    } else {
      indexChild.value = 0;
    }
  }


  void changeTypeChild(int typeChild) {
    nameChild.value = listChild[typeChild].name!;
    idTypeChild.value = listChild[typeChild].id!;
    nameChild.refresh();
  }

  Future<void> updateInfoStore() async {
    try {
      var res = await RepositoryManager.storeRepository.update(
          store.value.storeCode,
          nameShop: nameEditingController.value.text,
          address: addressEditingController.value.text,
          logoUrl: logoUrl.value,
          idCareer: idTypeChild.value,
          idTypeShop: idTypeShop.value);
      HomeController homeController = Get.find();
      homeController.storeCurrent!(res);

      Get.back();
      SahaAlert.showSuccess(message: "Sửa thành công");
    } catch (err) {
      SahaAlert.showError(message: "Có lỗi xin thử lại");
    }
  }

  void updateImage({ImageData? imageData}) {
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
              ImageData(linkImage: link, uploading: false, errorUpload: false));
      logoUrl.value = link;
    } catch (err) {
      updateImage(
          imageData:
              ImageData(file: file, uploading: false, errorUpload: true));

      SahaAlert.showError(message: "Có lỗi khi up ảnh xin thử lại");
    }
    isUpdatingImage.value = false;
  }

  Future<String?> loadAssets() async {
    try {
      final picker = ImagePicker();
      final pickedFile = (await picker.getImage(source: ImageSource.gallery))!;
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

      dataImages.value =
          ImageData(file: File(croppedFile.path), uploading: true, errorUpload: false);

      return await uploadImage(File(croppedFile.path));
    } on Exception catch (e) {
      return null;
    }
  }
}

class ImageData {
  File? file;
  String? linkImage;
  bool? errorUpload;
  bool? uploading;

  ImageData({this.file, this.linkImage, this.errorUpload, this.uploading});
}

