import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/home_data/home_data_response.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/category_product_screen/category_product_screen.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/home/home_body.dart';
import 'package:url_launcher/url_launcher.dart';

class SpecialOffers extends StatelessWidget {
  final List<BannerUser> listBanner;
  final Function? onClear;
  const SpecialOffers({
    Key? key,
    required this.listBanner,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SectionTitle(
            title: "Ưu đãi cho bạn",
            pressTitleEnd: () {
              Get.to(CategoryProductScreen());
            },
            onClear: onClear != null
                ? () {
                    onClear!();
                  }
                : null,
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: CarouselSlider(
            options: CarouselOptions(
                //height: 100,
                viewportFraction: 0.99,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 8)),
            items: listBanner.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return SpecialOfferCard(
                    image: i.imageUrl!,
                    category: "Smartphone",
                    numOfBrands: 18,
                    press: () {
                      launch("${i.actionLink}");
                    },
                  );
                },
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: Get.width * 0.99,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: image,
            ),
          ),
        ),
      ),
    );
  }
}
