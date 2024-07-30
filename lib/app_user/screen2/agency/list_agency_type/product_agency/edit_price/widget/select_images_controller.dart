import 'dart:io';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/image_utils.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';

final MAX_SELECT = 10;

class SelectImageController extends GetxController {
  Function? onUpload;
  Function? doneUpload;
  SelectImageController({this.onUpload, this.doneUpload});

  var dataImages = <ImageData>[].obs;

  void deleteImage(ImageData? imageData) {
    if (imageData!.file == null) {
      var indexRm = dataImages
          .toList()
          .map((e) => e.linkImage)
          .toList()
          .indexOf(imageData.linkImage!);
      dataImages.removeAt(indexRm);
    } else {
      var indexRm = dataImages
          .toList()
          .map((e) => e.file)
          .toList()
          .indexOf(imageData.file!);
      dataImages.removeAt(indexRm);
    }
    //updateListImage(dataImages.map((element) => element.file).toList());
    doneUpload!(dataImages.toList());
  }

  void updateListImage(List<Asset?> listAsset) {
    print(listAsset.map((e) => e!.identifier!));
    print(dataImages.map((e) => e.file?.identifier));
    onUpload!();

    var listPre = dataImages.toList();

    for (var asset in listAsset) {
      if (listPre.isEmpty) {
        dataImages.add(ImageData(
            file: asset,
            linkImage: null,
            errorUpload: false,
            uploading: false));
      } else {
        var check = listPre
            .map((e) => e.file?.identifier)
            .toList()
            .contains(asset!.identifier);
        print(check);
        if (check) {
          print("da ton tai");
        } else {
          print("add");
          dataImages.add(ImageData(
              file: asset,
              linkImage: null,
              errorUpload: false,
              uploading: false));
        }
      }
    }
    uploadListImage();
  }

  void uploadListImage() async {
    int stackComplete = 0;

    var responses = await Future.wait(dataImages.map((imageData) {
      if (imageData.linkImage == null) {
        return uploadImageData(
            indexImage: dataImages.indexOf(imageData),
            onOK: () {
              stackComplete++;
            });
      } else
        return Future.value(null);
    }));

    doneUpload!(dataImages.toList());
  }

  Future<void> uploadImageData(
      {required int indexImage, required Function onOK}) async {
    try {
      dataImages[indexImage].uploading = true;
      dataImages.refresh();

      var fileUp =
          await ImageUtils.getImageFileFromAsset(dataImages[indexImage].file);
      var fileUpImageCompress =
          await ImageUtils.getImageCompress(fileUp!, quality: 50);

      var link = await RepositoryManager.imageRepository
          .uploadImage(fileUpImageCompress);

      dataImages[indexImage].linkImage = link;
      dataImages[indexImage].errorUpload = false;
      dataImages[indexImage].uploading = false;
      dataImages.refresh();
    } catch (err) {
      print(err);
      dataImages[indexImage].linkImage = null;
      dataImages[indexImage].errorUpload = true;
      dataImages[indexImage].uploading = false;
      dataImages.refresh();
    }
    onOK();
  }

  Future<File> getImageFileFromAssetsAndroid(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future<void> loadAssets() async {
    List<Asset?> resultList = dataImages.toList().map((e) => e.file).toList();
    String error = 'No Error Detected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: MAX_SELECT - resultList.length,
        enableCamera: true,
        selectedAssets: dataImages
            .toList()
            .where((e) => e.file != null)
            .map((e) => e.file!)
            .toList(),
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "SahaShop",
          allViewTitle: "Mời chọn ảnh",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
    updateListImage(resultList);
  }
}

class ImageData {
  Asset? file;
  String? linkImage;
  bool? errorUpload;
  bool? uploading;

  ImageData({this.file, this.linkImage, this.errorUpload, this.uploading});
}
