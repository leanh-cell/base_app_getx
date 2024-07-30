import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/drop_down_custom/drop_down_button.dart';
import '../../config_controller.dart';
import 'font_data.dart';

class FontConfig extends StatefulWidget {
  @override
  _FontConfigState createState() => _FontConfigState();
}

class _FontConfigState extends State<FontConfig> {
  String? fontTitle;

  ConfigController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    fontTitle = controller.configApp.fontFamily;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Font chữ",
            ),
            DropDownButtonCustom(
              value: fontTitle,
              item: FONT_DATA.keys.toList(),
              title: "Chọn cỡ chữ",
              onChange: (value) {
                setState(() {
                  fontTitle = value;
                  controller.configApp.fontFamily = value;
                });
              },
            )
          ],
        ),
      ],
    );
  }
}
