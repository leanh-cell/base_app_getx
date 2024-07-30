import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_full_screen.dart';
import 'package:sahashop_customer/app_customer/model/banner_ads.dart';
import '../../../../../components/saha_user/loading/loading_container.dart';
import '../../../../../const/banner_ads_define.dart';
import 'banner_ads_edit_controller.dart';
import 'banner_ads_edit_detail/banner_ads_edit_detail_screen.dart';

class BannerAdsEditScreen extends StatelessWidget {
  late BannerAdsController bannerAdsController;
  int? positionInput;

  BannerAdsEditScreen(this.positionInput) {
    bannerAdsController = BannerAdsController(positionInput: positionInput);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${mapDefinePosition[positionInput] ?? ""}'),
      ),
      body: Obx(
        () => bannerAdsController.loading.value
            ? SahaLoadingFullScreen()
            : bannerAdsController.listBanner.isEmpty
                ? Center(child: Text('Chưa có banner quảng cáo'))
                : SingleChildScrollView(
                    child: Column(
                    children: bannerAdsController.listBanner
                        .map((e) => bannerAdsItem(e))
                        .toList(),
                  )),
      ),
    );
  }

  Widget bannerAdsItem(BannerAds bannerAdsItem) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${mapDefinePosition[bannerAdsItem.position] ?? ""}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => BannerAdsEditDetailScreen(
                            bannerAdsInput: bannerAdsItem,
                          ))!
                      .then((value) => {bannerAdsController.getAllBannerAds()});
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 8, right: 8, bottom: 2, top: 2),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Chỉnh sửa"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  SahaDialogApp.showDialogYesNo(
                      mess:
                          'Bạn có chắc chắn muốn xoá banner quảng có này không ?',
                      onOK: () {
                        bannerAdsController.deleteBannerAds(bannerAdsItem.id!);
                      });
                },
                child: Container(
                  padding:
                      EdgeInsets.only(left: 8, right: 8, bottom: 2, top: 2),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.delete,
                        size: 18,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Xoá"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              width: Get.width,
              fit: BoxFit.cover,
              height: 100,
              imageUrl: bannerAdsItem.imageUrl ?? "",
              placeholder: (context, url) => SahaLoadingContainer(),
              errorWidget: (context, url, error) => SahaEmptyImage(),
            ),
          ),
        ],
      ),
    );
  }
}
