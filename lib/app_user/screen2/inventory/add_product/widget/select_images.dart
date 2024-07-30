import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/saha_user/empty/saha_empty_image.dart';
import '../../../../components/saha_user/loading/loading_widget.dart';
import '../../../../model/image_assset.dart';
import 'select_images_controller.dart';

// ignore: must_be_immutable
class SelectImages extends StatelessWidget {
  String title;
  String subTitle;
  Function? onUpload;
  Function? doneUpload;
  int maxImage;
  bool? enableCamera;
  final List<ImageData>? images;

  String type;
  late SelectImageController selectImageController;
  SelectImages(
      {this.onUpload,
      this.doneUpload,
      this.images,
      this.enableCamera,
      required this.type,
      required this.maxImage,
      required this.title,
      required this.subTitle}) {
    selectImageController = new SelectImageController(
        onUpload: onUpload,
        doneUpload: doneUpload,
        type: type,
        enableCamera: enableCamera,
        maxImage: maxImage);

    if (images != null) {
      selectImageController.dataImages.value = images!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: Obx(() {
        var dataImages = selectImageController.dataImages.toList();

        if (dataImages == null || dataImages.length == 0)
          return Row(
            children: [
              addImage(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          subTitle,
                          style: TextStyle(
                              color: Colors.grey, fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          );

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataImages.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  buildItemImageData(dataImages[index]),
                  index == dataImages.length - 1 &&
                          dataImages.length < MAX_SELECT
                      ? addImage()
                      : Container()
                ],
              );
            });
      }),
    );
  }

  Widget addImage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: () {

          selectImageController.loadAssets();
        },
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: Theme.of(Get.context!).primaryColor)),
          child: Center(
            child: Icon(
              Icons.camera_alt_outlined,
              color: Theme.of(Get.context!).primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItem() {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Theme.of(Get.context!).primaryColor)),
        height: 100,
        width: 100,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: CachedNetworkImage(
                  height: 95,
                  width: 95,
                  fit: BoxFit.cover,
                  imageUrl: "",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => SahaEmptyImage(),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
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
            )
          ],
        ),
      ),
    );
  }

  Widget buildItemImageData(ImageData imageData) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      margin: EdgeInsets.only(right: 5),
      child: SizedBox(
        height: 100,
        width: 100,
        child: Stack(
          alignment: Alignment.bottomLeft,
          clipBehavior: Clip.none,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: imageData.linkImage != null
                    ? CachedNetworkImage(
                        height: 300,
                        width: 300,
                        fit: BoxFit.cover,
                        imageUrl: imageData.linkImage!,
                        placeholder: (context, url) => Stack(
                          children: [
                            imageData.file == null
                                ? Container()
                                : Image.file(
                                    File(imageData.file!.path),
                                    width: 300,
                                    height: 300,
                              fit: BoxFit.cover,
                                  ),
                            SahaLoadingWidget(),
                          ],
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                    : imageData.file == null
                        ? SahaEmptyImage()
                        : Image.file(
                            File(imageData.file!.path),
                            width: 300,
                            height: 300,
                  fit: BoxFit.cover,
                          ),
              ),
            ),
            Positioned(
              top: -5,
              right: -5,
              child: InkWell(
                onTap: () {
                  selectImageController.deleteImage(imageData);
                },
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      "x",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            (imageData.uploading ?? false)
                ? SahaLoadingWidget(
                    size: 50,
                  )
                : Container(),
            (imageData.errorUpload ?? false)
                ? Icon(
                    Icons.error,
                    color: Colors.redAccent,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
