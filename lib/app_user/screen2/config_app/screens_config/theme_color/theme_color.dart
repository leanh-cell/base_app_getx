import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import 'package:com.ikitech.store/app_user/utils/color.dart';
import 'package:sahashop_customer/app_customer/components/button/pickerColorButton.dart';
import '../../config_controller.dart';

class MainConfigThemeColor extends StatefulWidget {
  @override
  _MainConfigThemeColorState createState() => _MainConfigThemeColorState();
}

class _MainConfigThemeColorState extends State<MainConfigThemeColor> {
  final ConfigController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              "Màu",
            ),
            PickerColorButton(
                currentColor: checkColor(),
                onChange: (Color color) {
                  setState(() {
                    controller.configApp.colorMain1 = color.toHex();
                  });
                })
          ],
        ),
      ],
    );
  }

  Color checkColor() {
    try {
      var color = HexColor(controller.configApp.colorMain1 ?? "#FF88120D");
      return color;
    } catch (err) {
      return SahaPrimaryColor;
    }
  }
}
