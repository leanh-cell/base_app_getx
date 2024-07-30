import 'package:com.ikitech.store/app_user/const/banner_ads_define.dart';
import 'package:com.ikitech.store/app_user/screen2/config_app/screens_config/main_component_config/banner_ads/banner_ads_edit_detail/widget/select_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/banner_ads.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/category_post.dart';
import 'package:sahashop_customer/app_customer/model/post.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import '../../../../../../components/picker/category_post/category_post_picker.dart';
import '../../../../../../components/picker/post/post_picker.dart';
import '../../../../../../components/picker/product/product_picker.dart';
import '../../../../../../components/saha_user/button/saha_button.dart';
import '../../../../../../components/saha_user/toast/saha_alert.dart';
import '../../../../../../model/image_file.dart';
import '../../../../../inventory/categories/category_screen.dart';
import 'banner_ads_edit_detail_controller.dart';
import 'widget/dialog_choose_banner_ads.dart';

class BannerAdsEditDetailScreen extends StatelessWidget {
 late BannerAdsEditDetailController bannerAdsEditDetailController;

  BannerAds? bannerAdsInput;

  BannerAdsEditDetailScreen({this.bannerAdsInput} ) {
    bannerAdsEditDetailController =
        BannerAdsEditDetailController(bannerAdsInput: bannerAdsInput);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(bannerAdsInput != null ? 'Chỉnh sửa banner quảng cáo': 'Thêm banner quảng cáo'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: SelectBannerAdsImages(
                  onUpload: () {},
                  images: bannerAdsEditDetailController.listImages.toList(),
                  doneUpload: (List<ImageDataFile> listImages) {
                    bannerAdsEditDetailController.listImages(listImages);
                    print(listImages.map((e) => e.linkImage));
                    bannerAdsEditDetailController.bannerAds.value.imageUrl = listImages[0].linkImage;
                  },
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {
                DialogBannerAds.showPosition(
                    positionInput:
                        bannerAdsEditDetailController.bannerAds.value.position,
                    onTap: (p) {
                      bannerAdsEditDetailController.bannerAds.value.position =
                          p;
                      bannerAdsEditDetailController.bannerAds.refresh();
                      Get.back();
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => Text(mapDefinePosition[
                                bannerAdsEditDetailController
                                    .bannerAds.value.position] ??
                            'Chọn vị trí banner quảng cáo', style: TextStyle(
                          color: mapDefinePosition[
                          bannerAdsEditDetailController
                              .bannerAds.value.position] == null ?  Colors.red : null,
                        ),),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {
                DialogBannerAds.showTypeAction(
                    typeActionInput: bannerAdsEditDetailController
                        .bannerAds.value.typeAction,
                    onTap: (t) {
                      bannerAdsEditDetailController.bannerAds.value.typeAction =
                          t;
                      bannerAdsEditDetailController.bannerAds.value.title = null;
                      bannerAdsEditDetailController.bannerAds.value.value = null;
                      bannerAdsEditDetailController.bannerAds.refresh();
                      Get.back();
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => Text(mapDefineTypeAction[
                                bannerAdsEditDetailController
                                    .bannerAds.value.typeAction] ??
                            'Chọn chuyển hướng banner quảng cáo', style: TextStyle(
                          color: mapDefineTypeAction[
                          bannerAdsEditDetailController
                              .bannerAds.value.typeAction] == null ?  Colors.red : null,
                        ),),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.all(10.0),
                child: showValueBox(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "LƯU",
              onPressed: () {
                if (bannerAdsInput != null) {
                  bannerAdsEditDetailController.updateBannerAds();
                } else {
                  bannerAdsEditDetailController.addBannerAds();
                }
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget showValueBox() {
    var codeCurrent = bannerAdsEditDetailController.bannerAds.value.typeAction;
    if (codeCurrent == "LINK") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nhập địa chỉ Website",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              new Expanded(
                child: new TextField(
                  controller:
                      bannerAdsEditDetailController.textEditingController,
                  decoration: new InputDecoration(

                    prefixText: "https://",
                  ),
                  onSubmitted: (v) {
                    if (GetUtils.isURL(v)) {
                      bannerAdsEditDetailController.bannerAds.value.value =
                          "https://$v";
                    } else {
                      bannerAdsEditDetailController.textEditingController.text =
                          "";
                      bannerAdsEditDetailController.bannerAds.value.title =
                          null;
                      SahaAlert.showError(
                          message: "Không tồn tại địa chỉ web này");
                    }
                  },
                ),
              )
            ],
          ),
        ],
      );
    } else if (codeCurrent == "PRODUCT") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chọn Sản phẩm",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              bannerAdsEditDetailController.bannerAds.value.typeAction =
                  'PRODUCT';
              addValueAction('PRODUCT');
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: Theme.of(Get.context!).primaryColor)),
              child: Center(
                child: Obx(
                  () => Text(
                    "${bannerAdsEditDetailController.bannerAds.value.title ?? "Nhấn chọn"}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (codeCurrent == "CATEGORY_PRODUCT") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chọn Danh mục sản phẩm",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              bannerAdsEditDetailController.bannerAds.value.typeAction =
                  'CATEGORY_PRODUCT';
              addValueAction('CATEGORY_PRODUCT');
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: Theme.of(Get.context!).primaryColor)),
              child: Center(
                child: Obx(
                  () => Text(
                    "${bannerAdsEditDetailController.bannerAds.value.title ?? "Nhấn chọn"}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (codeCurrent == "POST") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chọn Bài viết",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              bannerAdsEditDetailController.bannerAds.value.typeAction = 'POST';
              addValueAction('POST');
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: Theme.of(Get.context!).primaryColor)),
              child: Center(
                child: Obx(
                  () => Text(
                    "${bannerAdsEditDetailController.bannerAds.value.title ?? "Nhấn chọn"}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else if (codeCurrent == "CATEGORY_POST") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chọn Danh mục bài viết",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              bannerAdsEditDetailController.bannerAds.value.typeAction =
                  'CATEGORY_POST';
              addValueAction('CATEGORY_POST');
            },
            child: Container(
              height: 50,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                  border:
                      Border.all(color: Theme.of(Get.context!).primaryColor)),
              child: Center(
                child: Obx(
                  () => Text(
                    "${bannerAdsEditDetailController.bannerAds.value.title ?? "Nhấn chọn"}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  void addValueAction(String typeAction) async {
    if (typeAction == 'LINK') {}
    if (typeAction == 'PRODUCT') {
      List<Product>? productsCheck;
      await Get.to(() => ProductPickerScreen(
        listProductInput: [],
        onlyOne: true,
        callback: (List<Product> products) {
          if (products.length > 1) {
            SahaAlert.showError(message: "Chọn tối đa 1 sản phẩm");
          } else {
            productsCheck = products;
            bannerAdsEditDetailController.bannerAds.value.value = products[0].id.toString();
            bannerAdsEditDetailController.bannerAds.value.title = products[0].name.toString();
          }
        },
      ))!
          .then((value) => {
        if (productsCheck != null && productsCheck!.length > 1)
          {
            SahaAlert.showError(message: "Chọn tối đa 1 sản phẩm"),
          }
      });
      bannerAdsEditDetailController.bannerAds.refresh();
      return;
    }

    if (typeAction == 'CATEGORY_PRODUCT') {
      await Get.to(() => CategoryScreen(
        isSelect: true,
      ))!.then((categories) {
        List<Category> categories2 = categories["list_cate"];
        if (categories2.length > 1) {
          SahaAlert.showError(message: "Chọn tối đa 1 Danh mục");
        } else if (categories2.length == 1) {
          print(categories);
          bannerAdsEditDetailController.bannerAds.value.value = categories2[0].id.toString();
          bannerAdsEditDetailController.bannerAds.value.title = categories2[0].name.toString();
        }
      });
      bannerAdsEditDetailController.bannerAds.refresh();
      return;
    }

    if (typeAction == 'POST') {
      await Get.to(() => PostPickerScreen(
        listPostInput: [],
        onlyOne: true,
        callback: (List<Post> post) {
          if (post.length > 1 || post.length == 0) {
            SahaAlert.showError(message: "Chọn tối đa 1 Bài viết");
          } else {
            bannerAdsEditDetailController.bannerAds.value.value = post[0].id.toString();
            bannerAdsEditDetailController.bannerAds.value.title = post[0].title.toString();
          }
        },
      ));
      bannerAdsEditDetailController.bannerAds.refresh();
      return;
    }

    if (typeAction == 'CATEGORY_POST') {
      await Get.to(() => CategoryPostPickerScreen(
        isSelect: true,
      ))!
          .then((categories) {
        List<CategoryPost> categories2 = categories;
        if (categories2.length == 1) {
          bannerAdsEditDetailController.bannerAds.value.value = categories2[0].id.toString();
          bannerAdsEditDetailController.bannerAds.value.title = categories2[0].title.toString();
        } else if (categories2.length > 1) {
          SahaAlert.showError(message: "Chọn tối đa 1 Danh mục bài viết");
        }
      });
      bannerAdsEditDetailController.bannerAds.refresh();
      return;
    }
  }
}
