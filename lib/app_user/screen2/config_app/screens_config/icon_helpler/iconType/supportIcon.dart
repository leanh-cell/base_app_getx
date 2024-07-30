import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/config_controller.dart';

import '../../../config_controller.dart';

class SupportIcon extends StatefulWidget {
  @override
  _SupportIconState createState() => _SupportIconState();
}

class _SupportIconState extends State<SupportIcon> {
  final ConfigController controller = Get.find();
  final CustomerConfigController controllerCustomer = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Thêm hotline :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.phone,
              color: Theme.of(context).primaryColor,
            ),
            Spacer(),
            Checkbox(
              tristate: false,
              value: controller.configApp.isShowIconHotline,
              onChanged: (bool? choose) {
                setState(() {
                  controller.configApp.isShowIconHotline = choose;
                  controllerCustomer.configApp.isShowIconHotline = choose;
                });
              },
              activeColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Số điện thoại: ",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Spacer(),
            Expanded(
              child: TextField(
                controller: TextEditingController(
                    text: controller.configApp.phoneNumberHotline),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.configApp.phoneNumberHotline =
                      value == "" ? null : value;
                  controllerCustomer.configApp.phoneNumberHotline =
                      value == "" ? null : value;
                },
              ),
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Thêm email: ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.email,
              color: Theme.of(context).primaryColor,
            ),
            Spacer(),
            Checkbox(
              tristate: false,
              value: controller.configApp.isShowIconEmail,
              onChanged: (bool? choose) {
                setState(() {
                  controller.configApp.isShowIconEmail = choose;
                  controllerCustomer.configApp.isShowIconEmail = choose;
                });
              },
              activeColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Email: ",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Spacer(),
            Expanded(
              child: TextField(
                controller: TextEditingController(
                  text: controller.configApp.contactEmail,
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  controller.configApp.contactEmail =
                      value == "" ? null : value;
                  controllerCustomer.configApp.contactEmail =
                      value == "" ? null : value;
                },
              ),
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Thêm Facebook: ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.all(12),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                  "packages/sahashop_customer/assets/icons/facebook-2.svg"),
            ),
            Spacer(),
            Checkbox(
              tristate: false,
              value: controller.configApp.isShowIconFacebook,
              onChanged: (bool? choose) {
                setState(() {
                  controller.configApp.isShowIconFacebook = choose;
                  controllerCustomer.configApp.isShowIconFacebook = choose;
                });
              },
              activeColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "ID Messenger: ",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Spacer(),
            Expanded(
              child: TextField(
                controller: TextEditingController(
                  text: controller.configApp.idFacebook,
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  controller.configApp.idFacebook = value == "" ? null : value;
                  controllerCustomer.configApp.idFacebook =
                      value == "" ? null : value;
                },
              ),
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Thêm Zalo: ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                  "packages/sahashop_customer/assets/icons/zalo.svg"),
            ),
            Spacer(),
            Checkbox(
              tristate: false,
              value: controller.configApp.isShowIconZalo,
              onChanged: (bool? choose) {
                setState(() {
                  controller.configApp.isShowIconZalo = choose;
                  controllerCustomer.configApp.isShowIconZalo = choose;
                });
              },
              activeColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Zalo: ",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: TextEditingController(
                  text: controller.configApp.idZalo,
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  controller.configApp.idZalo = value == "" ? null : value;
                  controllerCustomer.configApp.idZalo =
                      value == "" ? null : value;
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
