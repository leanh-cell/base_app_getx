import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../components/saha_user/decentralization/decentralization_widget.dart';
import '../../../../data/repository/repository_manager.dart';
import '../../../../model/image_assset.dart';

final MAX_SELECT = 10;

class SelectImageController extends GetxController {
  Function? onUpload;
  Function? doneUpload;
  String type;
  int maxImage;
  bool? enableCamera;
  SelectImageController(
      {this.onUpload,
      this.doneUpload,
      this.enableCamera,
      required this.type,
      required this.maxImage});

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

  void updateListImage(List<XFile?> listAsset) {
    print(listAsset.map((e) => e!.path));
    print(dataImages.map((e) => e.file?.path));
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
        var check =
            listPre.map((e) => e.file?.path).toList().contains(asset!.path);
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

      var link = await RepositoryManager.imageRepository
          .uploadImage(File(dataImages[indexImage].file!.path));

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
    showChooseOption((v) async {
      try {
        print("sss");
        List<XFile> pickedFileList = [];
        dataImages.forEach((e) {
          if (e.file != null) {
            pickedFileList.add(e.file!);
          }
        });

        if (v == 1) {
          var xFile = await ImagePicker().pickImage(
            source: ImageSource.camera,
            imageQuality: 50,
          );
          if (xFile != null) {
            print("sasdasdasdasdas");
            pickedFileList.add(xFile);
          }
        } else {
          pickedFileList = await ImagePicker().pickMultiImage(
                imageQuality: 50,
              ) ??
              [];
        }

        print(pickedFileList);

        if ((pickedFileList).length > maxImage) {
          List<XFile> list = [];
          for (int i = 0; i < maxImage; i++) {
            list.add(pickedFileList[i]);
          }
          pickedFileList = list;
        }
        print((pickedFileList).map((e) => e.path));
        if (pickedFileList != null) {
          updateListImage(pickedFileList);
        }
      } on Exception catch (e) {
        print(e);
      }
    });
  }

  void showChooseOption(Function onChoose) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.camera,
                  color: Colors.blue,
                ),
                title: Text(
                  'Chụp ảnh',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  Get.back();
                  onChoose(1);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_album_outlined, color: Colors.red),
                title: Text(
                  'Chọn từ Album ảnh',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Get.back();
                  onChoose(2);
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }
}
