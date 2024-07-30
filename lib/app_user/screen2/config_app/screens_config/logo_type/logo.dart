import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config_controller.dart';
import 'select_logo_image.dart';

class MainConfigLogo extends StatefulWidget {
  const MainConfigLogo({Key? key}) : super(key: key);

  @override
  _MainConfigLogoState createState() => _MainConfigLogoState();
}

class _MainConfigLogoState extends State<MainConfigLogo> {
  final ConfigController controller = Get.find();

  bool isShowHotline = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Logo",
            ),
            SelectLogoImage(
              linkLogo: controller.configApp.logoUrl,
              onChange: (link) {
                controller.configApp.logoUrl = link;
              },
            )
          ],
        ),
      ],
    );
  }
}
