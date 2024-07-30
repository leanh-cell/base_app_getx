import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/carousel/carousel_select.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/repository_widget_config.dart';

import '../../config_controller.dart';

class ProductItemConfig extends StatelessWidget {
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSelect(
          height: 220,
          width: 160,
          listWidget: RepositoryWidgetCustomer().LIST_ITEM_PRODUCT_WIDGET,
          indexSelected: configController.configApp.productItemType,
          initPage: configController.configApp.productItemType,
          onChange: (index) {
            configController.configApp.productItemType = index;
          },
        )
      ],
    );
  }
}
