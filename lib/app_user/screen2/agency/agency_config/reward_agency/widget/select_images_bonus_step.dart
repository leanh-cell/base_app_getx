import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import 'package:com.ikitech.store/app_user/screen2/agency/list_agency_type/product_agency/edit_price/widget/select_images_controller.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';

class SelectStepBonusImages extends StatelessWidget {
  Function? onUpload;
  Function? doneUpload;
  final List<ImageData>? images;

  late SelectImageController selectImageController;
  SelectStepBonusImages({this.onUpload, this.doneUpload, this.images,}) {
    selectImageController =
        new SelectImageController(onUpload: onUpload, doneUpload: doneUpload);

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

        if (dataImages.length == 0) return addImage();

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dataImages.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  buildItemImageData(dataImages[index])
                ],
              );
            });
      }),
    );
  }

  Widget addImage() {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          selectImageController.loadAssets();
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

  Widget buildItem() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: SahaPrimaryColor)),
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
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
                                : AssetThumb(
                                    asset: imageData.file!,
                                    width: 300,
                                    height: 300,
                                    spinner: SahaLoadingWidget(
                                      size: 50,
                                    ),
                                  ),
                            SahaLoadingWidget(),
                          ],
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                    : imageData.file == null
                        ? SahaEmptyImage()
                        : AssetThumb(
                            asset: imageData.file!,
                            width: 300,
                            height: 300,
                            spinner: SahaLoadingWidget(
                              size: 50,
                            ),
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
