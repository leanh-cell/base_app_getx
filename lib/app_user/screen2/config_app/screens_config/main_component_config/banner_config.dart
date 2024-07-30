import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/carousel/carousel_select.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/repository_widget_config.dart';
import '../../config_controller.dart';

class BoxPionConfig extends StatelessWidget {
  final ConfigController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        CarouselSelect(
          height: 220,
          isNotUserFake: true,
          listWidget: RepositoryWidgetCustomer()
              .LIST_WIDGET_BANNER
              .map((e) => Column(
                  mainAxisAlignment: MainAxisAlignment.center, children: [e]))
              .toList(),
          indexSelected: controller.configApp.carouselType,
          initPage: controller.configApp.carouselType,
          onChange: (index) {
            controller.configApp.carouselType = index;
            print("index : $index");
          },
        )
      ],
    );
  }
}
