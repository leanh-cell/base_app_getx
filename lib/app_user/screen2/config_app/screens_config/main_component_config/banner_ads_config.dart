import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/banner_ads.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';

import '../../../../components/saha_user/empty/saha_empty_image.dart';
import '../../../../components/saha_user/loading/loading_container.dart';
import '../../../../const/banner_ads_define.dart';
import 'banner_ads/banner_ads_edit_detail/banner_ads_edit_detail_screen.dart';
import 'banner_ads/banner_ads_edit_screen.dart';

class BannerAdsConfig extends StatefulWidget {
  @override
  State<BannerAdsConfig> createState() => _BannerAdsConfigState();
}

class _BannerAdsConfigState extends State<BannerAdsConfig> {
  DataAppCustomerController dataAppCustomerController = Get.find();

  @override
  Widget build(BuildContext context) {
    var data = dataAppCustomerController.homeData.value.bannerAdsApp;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                Get.to(() => BannerAdsEditDetailScreen())!.then((value) async {
                  if (value == 'reload') {
                    await dataAppCustomerController.getHomeData();
                    setState(() {});
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text("Thêm   ",
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        if (data?.position0 != null && data!.position0!.isNotEmpty)
          bannerAdsItem(data.position0!, 0),
        if (data?.position1 != null && data!.position1!.isNotEmpty)
          bannerAdsItem(data.position1!, 1),
        if (data?.position2 != null && data!.position2!.isNotEmpty)
          bannerAdsItem(data.position2!, 2),
        if (data?.position3 != null && data!.position3!.isNotEmpty)
          bannerAdsItem(data.position3!, 3),
        if (data?.position4 != null && data!.position4!.isNotEmpty)
          bannerAdsItem(data.position4!, 4),
      ],
    );
  }



  Widget bannerAdsItem(List<BannerAds> listBannerAdsItem, int position) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${mapDefinePosition[position] ?? ""} (${listBannerAdsItem.length} banner)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => BannerAdsEditScreen(position))!
                      .then((value) async {
                    await dataAppCustomerController.getHomeData();
                    setState(() {});
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
                        Icons.edit,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Chỉnh sửa"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 100,
            width: Get.width,
            child: CarouselSlider(
              items: listBannerAdsItem
                  .map(
                    (item) => Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            width: Get.width,
                            fit: BoxFit.cover,
                            imageUrl: item.imageUrl!,
                            placeholder: (context, url) =>
                                SahaLoadingContainer(),
                            errorWidget: (context, url, error) =>
                                SahaEmptyImage(),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  autoPlay: listBannerAdsItem.length <= 1 ? false : true,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  aspectRatio: 16 / 9,
                  onPageChanged: (index, reason) {}),
            ),
          ),
        ],
      ),
    );
  }
}
