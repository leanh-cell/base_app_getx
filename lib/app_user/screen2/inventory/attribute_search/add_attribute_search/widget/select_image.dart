import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';

// ignore: must_be_immutable
class SelectAttributeSearchImage extends StatelessWidget {
  SelectImageController selectImageController = new SelectImageController();

  final Function? onChange;

  final File? fileSelected;
  final String? linkImage;

  SelectAttributeSearchImage(
      {Key? key, this.onChange, this.fileSelected, this.linkImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: Obx(() {
        var deviceImage = selectImageController.pathImage;

        if (linkImage != null && linkImage != "" && deviceImage.value == null ||
            deviceImage.value == "")
          return Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    imageUrl: linkImage ?? "",
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) => Container()),
                addImage()
              ],
            ),
          );

        if (deviceImage.value == null || deviceImage.value == "")
          return addImage();
        return buildItemAsset(File(deviceImage.value));
      }),
    );
  }

  Widget addImage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {
          selectImageController.getImage((file) {
            onChange!(file);
          });
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: SahaPrimaryColor)),
          child: Center(
            child: Icon(Icons.camera_alt_outlined),
          ),
        ),
      ),
    );
  }

  Widget buildItemAsset(File asset) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: SahaPrimaryColor)),
        child: SizedBox(
          height: 100,
          width: 100,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.file(
                      asset,
                      fit: BoxFit.cover,
                      width: 300,
                      height: 300,
                    )),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    selectImageController.removeImage();
                    onChange!(null);
                  },
                  child: Container(
                    height: 17,
                    width: 17,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: Center(
                      child: Text(
                        "x",
                        style: TextStyle(
                          fontSize: 10,
                          height: 1,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectImageController extends GetxController {
  var pathImage = "".obs;
  final picker = ImagePicker();
  Future getImage(Function onPick) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pathImage.value = pickedFile.path;
      var file = File(pickedFile.path);

      final dir = await path_provider.getTemporaryDirectory();
      final targetPath = dir.absolute.path + basename(pickedFile.path) + ".jpg";

      var result = (await FlutterImageCompress.compressAndGetFile(
          file.absolute.path, targetPath,
          quality: 60, minHeight: 512, minWidth: 512))!;

      onPick(File(result.path));
    } else {
      print('No image selected.');
    }
  }

  void removeImage() {
    pathImage("");
    pathImage.refresh();
  }
}
