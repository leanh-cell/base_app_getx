import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import 'package:com.ikitech.store/app_user/model/home_button_config.dart';
import 'package:sahashop_customer/app_customer/config_controller.dart';
import 'package:sahashop_customer/app_customer/model/button_home.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/home_buttons/list_home_button.dart';
import 'package:switcher_button/switcher_button.dart';
import '../../config_controller.dart';
import 'home_button_screen.dart';

class ButtonHomeConfig extends StatefulWidget {
  @override
  _ButtonHomeConfigState createState() => _ButtonHomeConfigState();
}

class _ButtonHomeConfigState extends State<ButtonHomeConfig> {
  ConfigController controller = Get.find();
  CustomerConfigController customerConfigController = Get.find();

  @override
  Widget build(BuildContext context) {
    customerConfigController.configApp.isScrollButton =
        controller.configApp.isScrollButton;
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 20,
              child: Row(
                children: [
                  controller.configApp.isScrollButton == true
                      ? Text(
                          "Dạng cuộn",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          "Tất cả",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  SizedBox(
                    width: 5,
                  ),
                  CupertinoSwitch(
                    value: controller.configApp.isScrollButton ?? true,
                    onChanged: (value) {
                      setState(() {
                        controller.configApp.isScrollButton =
                            !controller.configApp.isScrollButton!;
                        customerConfigController.configApp.isScrollButton =
                            controller.configApp.isScrollButton;
                        print(controller.configApp.isScrollButton);
                      });
                    },
                  ),
                ],
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Get.to(ButtonHomeConfigScreen())!.then((value) {
                    controller.getAppTheme(refresh: true);
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
                        Icons.settings_outlined,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Tùy chỉnh"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        controller.configApp.isScrollButton == true
            ? ListHomeButtonWidget()
            : ListHomeButtonWidget(),
      ],
    );
  }
}

class ButtonEditWidget extends StatelessWidget {
  const ButtonEditWidget(
      {Key? key,
      this.homeButton,
      this.onTap,
      this.isShow = false,
      this.added = false,
      this.onRemove,
      this.onAdd})
      : super(key: key);

  final HomeButtonCf? homeButton;
  final Function? onTap;
  final Function? onRemove;
  final Function? onAdd;

  final bool? added;
  final bool? isShow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) onTap!();
        },
        child: SizedBox(
          width: 60,
          child: Stack(
            alignment: Alignment.bottomLeft,
            clipBehavior: Clip.none,
            children: [
              HomeButtonWidget(HomeButton(
                  title: homeButton!.title,
                  value: homeButton!.value,
                  typeAction: homeButton!.typeAction,
                  imageUrl: homeButton!.imageUrl)),
              Positioned(
                top: -2,
                right: 0,
                child: isShow!
                    ? InkWell(
                        onTap: () {
                          if (onRemove != null) onRemove!();
                        },
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.clear,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          if (onAdd != null) onAdd!();
                        },
                        child: (added! == true
                            ? CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.lightGreen,
                                child: Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.lightBlue,
                                child: Icon(
                                  Icons.add,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
