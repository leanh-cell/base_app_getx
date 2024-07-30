import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/screen2/config_app/screens_config/main_component_config/banner_ads/banner_ads_edit_detail/widget/select_images_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import '../../../../../../../model/image_file.dart';

// ignore: must_be_immutable
class SelectBannerAdsImages extends StatelessWidget {
  Function? onUpload;
  Function? doneUpload;
  final List<ImageDataFile>? images;

  late SelectImageBannerAdsController selectImageController;
  SelectBannerAdsImages({this.onUpload, this.doneUpload, this.images}) {
    selectImageController = new SelectImageBannerAdsController(
        onUpload: onUpload, doneUpload: doneUpload);

    if (images != null) {
      selectImageController.dataImages.value = images!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Obx(() {
        var dataImages = selectImageController.dataImages.toList();

        if (dataImages == null || dataImages.length == 0) return addImage();

        return buildItemImageData(dataImages[0]!);
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
          width: double.infinity,
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

  Widget buildItemImageData(ImageDataFile imageData) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 100,
        width: Get.width,
        child: Stack(
          alignment: Alignment.bottomLeft,
          clipBehavior: Clip.none,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: imageData.linkImage != null
                    ? CachedNetworkImage(
                        width: Get.width,
                        fit: BoxFit.cover,
                        imageUrl: imageData.linkImage!,
                        placeholder: (context, url) => Stack(
                          children: [
                            imageData.file == null
                                ? Container()
                                : Image.file(
                                    imageData.file!,
                                    width: Get.width,
                                    height: 100,
                                  ),
                            SahaLoadingWidget(),
                          ],
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                    : imageData.file == null
                        ? SahaEmptyImage()
                        : Image.file(
                            imageData.file!,
                            width: Get.width,
                            height: 100,
                          ),
              ),
            ),
            Positioned(
              top: -5,
              right: -5,
              child: InkWell(
                onTap: () {
                  selectImageController.removeImage(imageData);
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
            imageData.uploading!
                ? SahaLoadingWidget(
                    size: 50,
                  )
                : Container(),
            imageData.errorUpload!
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
