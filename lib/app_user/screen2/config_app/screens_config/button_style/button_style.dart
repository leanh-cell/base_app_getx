import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/carousel/carousel_select.dart';
import 'package:sahashop_customer/app_customer/data/example/home_button.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/home_buttons/home_buttons_style_1/home_button_style_1.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/home_buttons/home_buttons_style_2/home_button_style_2.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/home_buttons/home_buttons_style_3/home_button_style_3.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/home_buttons/home_buttons_style_4/home_button_style_4.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/home_buttons/home_buttons_style_5/home_button_style_5.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/repository_widget_config.dart';
import '../../config_controller.dart';

class ButtonTypeConfig extends StatelessWidget {
  final ConfigController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    List<Widget> LIST_BUTTON_WIDGET2 = [
      HomeButtonStyle1Widget(
        homeButton: LIST_HOME_BUTTON_EXAMPLE[1],
      ),
      HomeButtonStyle2Widget(
        homeButton: LIST_HOME_BUTTON_EXAMPLE[1],
      ),
      HomeButtonStyle3Widget(
        homeButton: LIST_HOME_BUTTON_EXAMPLE[1],
      ),
      HomeButtonStyle4Widget(
        homeButton: LIST_HOME_BUTTON_EXAMPLE[1],
      ),
      HomeButtonStyle5Widget(
        homeButton: LIST_HOME_BUTTON_EXAMPLE[1],
      ),
    ];
    var i = -1;
    var list = RepositoryWidgetCustomer().LIST_BUTTON_WIDGET.map((e) {
      var button = e;
      i++;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [e, LIST_BUTTON_WIDGET2[i]],
      );
    }).toList();

    return Column(
      children: [
        CarouselSelect(
          listWidget: list,
          height: 150,
          isNotUserFake: true,
          width: 200,
          indexSelected: controller.configApp.typeButton ?? 0,
          initPage: controller.configApp.typeButton ?? 0,
          onChange: (index) {
            controller.configApp.typeButton = index;
          },
        )
      ],
    );
  }
}
