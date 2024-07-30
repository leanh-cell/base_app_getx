import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../config_controller.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ConfigController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Số điện thoại: ",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: TextEditingController(
                  text: controller.configApp.contactPhoneNumber == null
                      ? ""
                      : controller.configApp.contactPhoneNumber!.toString(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.configApp.contactPhoneNumber =
                      value == "" ? null : value;
                },
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Email: ",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: TextEditingController(
                  text: controller.configApp.contactEmail == null
                      ? ""
                      : controller.configApp.contactEmail!.toString(),
                ),
                decoration: InputDecoration(),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  controller.configApp.contactEmail =
                      value == "" ? null : value;
                },
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Thời gian làm việc: ",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: TextEditingController(
                  text: controller.configApp.contactTimeWork == null
                      ? ""
                      : controller.configApp.contactTimeWork!.toString(),
                ),
                decoration: InputDecoration(
                  helperText: "8:00 - 20:00 (Thứ 2 đến Thứ 7)",
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  controller.configApp.contactTimeWork =
                      value == "" ? null : value;
                },
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Địa chỉ: ",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: TextEditingController(
                  text: controller.configApp.contactAddress == null
                      ? ""
                      : controller.configApp.contactAddress!.toString(),
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  if (value != "") {
                    controller.configApp.contactAddress =
                        value == "" ? null : value;
                  }
                },
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Fanpage: ",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextField(
                controller: TextEditingController(
                  text: controller.configApp.contactFanpage == null
                      ? ""
                      : controller.configApp.contactFanpage!.toString(),
                ),
                decoration: InputDecoration(
                  helperText: "https://www.facebook.com/ikitechvietnam",
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  if (value != "") {
                    controller.configApp.contactFanpage =
                        value == "" ? null : value;
                  }
                },
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
