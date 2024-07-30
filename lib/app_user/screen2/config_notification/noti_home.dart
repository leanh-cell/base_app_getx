import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../saha_data_controller.dart';
import 'popup/popup.dart';
import 'schedule_notification/schedule_noti_screen.dart';

class NotiHome extends StatelessWidget {
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Lên lịch thông báo"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            itemTypeNotification(
                assets: "assets/icons/history.svg",
                title: "Lịch thông báo đẩy",
                onTap: () {
                  Get.to(() => ScheduleNotiScreen());
                }),
            itemTypeNotification(
                assets: "assets/icons/popup.svg",
                title: "Popup Quảng cáo",
                onTap: () {
                  Get.to(() => PopupConfig());
                }),
          ],
        ),
      ),
    );
  }

  Widget itemTypeNotification(
      {required String assets,
      required String title,
      required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  assets,
                  height: 30,
                  width: 30,
                ),
              ),
              Text(title),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
              )
            ],
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
