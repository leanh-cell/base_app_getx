import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import '../../../../../components/saha_user/dialog/dialog.dart';
import '../../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../../model/image_file.dart';
import 'select_image_carousel_controller.dart';

class SelectCarouselImages extends StatelessWidget {
  SelectCarouselImagesController selectImageController =
      SelectCarouselImagesController();

  @override
  Widget build(BuildContext context) {
    selectImageController.init();
    return Container(
      child: Obx(() {
        var dataImages = selectImageController.dataImages.toList();

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    await SahaDialogApp.showDialogInput(
                        title: "Nhập địa chỉ web",
                        hintText: "https://",
                        onCancel: () {
                          return;
                        },
                        onInput: (va) {
                          if (va.length == 0) {
                            SahaAlert.showError(
                                message: "Địa chỉ web được trống");
                            return;
                          } else {
                            selectImageController.linkTo = va;
                            Get.back();
                            addImage();
                          }
                        });

                    return;
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text("Thêm",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            CarouselSlider(
              options: CarouselOptions(
                  height: 140.0,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.9),
              items: dataImages.map((imageData) {
                return Builder(
                  builder: (BuildContext context) {
                    return buildItemImageData(imageData!);
                  },
                );
              }).toList(),
            ),
          ],
        );
      }),
    );
  }

  void addImage() {
    selectImageController.loadAssets();
  }

  Widget buildItemImageData(ImageDataFile imageData) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        child: Stack(
          alignment: Alignment.bottomLeft,
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: imageData.linkImage != null
                    ? CachedNetworkImage(
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: imageData.linkImage!,
                        placeholder: (context, url) => Stack(
                          children: [
                            imageData.file == null
                                ? Container()
                                : Image.file(
                                    imageData.file!,
                                    width: 300,
                                    height: 300,
                                  ),
                            SahaLoadingWidget(),
                          ],
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                    : Image.file(
                        imageData.file!,
                        width: 300,
                        height: 300,
                      )),
            Positioned(
              top: -5,
              right: -5,
              child: InkWell(
                onTap: () {
                  selectImageController.removeImage(imageData);
                },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: Colors.black,
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
            ),
            imageData.uploading!
                ? SahaLoadingWidget(
                    size: 50,
                  )
                : Container(),
            imageData.errorUpload! ? Icon(Icons.error) : Container(),
          ],
        ),
      ),
    );
  }
}
