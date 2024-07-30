
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/screen2/notification/notification_screen.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';

class SahaNotificationAlert {
  static const String NEW_ORDER = "NEW_ORDER";

  static void alertNotification(RemoteMessage messages) {
    var message = messages.data;
    if (message['type'] != null) {
      showFlash(
        context: Get.context!,
        duration: const Duration(seconds: 2),
        persistent: true,
        builder: (_, controller) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: FlashBar(
              content: Text(''),
              controller: controller,
              // borderRadius: BorderRadius.circular(8.0),
              // borderColor: SahaPrimaryColor,
              // boxShadows: kElevationToShadow[8],
              position: FlashPosition.top,
              behavior: FlashBehavior.floating,
              // backgroundGradient: RadialGradient(
              //   colors: [Colors.white, Colors.white],
              //   center: Alignment.topLeft,
              //   radius: 2,
              // ),
              // onTap: () => {
              //   controller.dismiss(),
              // },
              forwardAnimationCurve: Curves.easeInCirc,
              reverseAnimationCurve: Curves.bounceIn,
              builder : (context, child) =>  InkWell(
                onTap: () {
                  SahaDataController sahaDataController = Get.find();
                  if (sahaDataController.badgeUser.value.decentralization
                          ?.notificationScheduleList ==
                      false) {
                    SahaAlert.showToastMiddle(
                        message: "Chức năng thông báo bị chặn");
                  } else {
                    Get.to(() => NotificationUserScreen())!
                        .then((value) => {sahaDataController.getBadge()});
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${messages.notification?.title}"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${messages.notification?.body}',
                              style: TextStyle(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
