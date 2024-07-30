import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_noti.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_ios_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/const/const_type_message.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/notification/all_notification_response.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'notification_controller.dart';

class NotificationUserScreen extends StatelessWidget {
  NotificationController notificationController = NotificationController();
  RefreshController _refreshController = RefreshController();
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        notificationController.readAllNotification();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thông báo"),
        ),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: MaterialClassicHeader(),
          footer: CustomFooter(
            loadStyle: LoadStyle.ShowAlways,
            builder: (context, mode) {
              if (mode == LoadStatus.loading) {
                return Container(
                  height: 60.0,
                  child: Container(
                    height: 20.0,
                    width: 20.0,
                    child: CupertinoActivityIndicator(),
                  ),
                );
              } else
                return Container();
            },
          ),
          controller: _refreshController,
          onRefresh: () async {
            await notificationController.historyNotification(isRefresh: true);
            _refreshController.refreshCompleted();
          },
          onLoading: () async {
            await notificationController.historyNotification();
            _refreshController.loadComplete();
          },
          child: Obx(
            () => notificationController.isLoadRefresh.value == true
                ? SahaLoadingFullScreen()
                : SingleChildScrollView(
                    child: notificationController.listNotificationUser.isEmpty
                        ? SahaEmptyNoti(
                            width: 50,
                            height: 50,
                          )
                        : Column(
                            children: notificationController
                                .listNotificationUser
                                .map((element) => boxNotification(element))
                                .toList(),
                          ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget boxNotification(NotificationUser notificationUser) {
    return InkWell(
      onTap: () {
        if (sahaDataController.badgeUser.value.decentralization?.orderList ==
            false) {
          SahaAlert.showToastMiddle(message: "Chức năng hoá đơn bị chặn");
        } else {
          notificationController.navigator(notificationUser);
          var index = notificationController.listNotificationUser
              .indexOf(notificationUser);
          notificationController.listNotificationUser[index].unread = false;
          notificationController.listNotificationUser.refresh();
          
        }
      },
      child: Container(
        color: notificationUser.unread == true
            ? SahaPrimaryColor.withOpacity(0.05)
            : Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  icon(notificationUser),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notificationUser.title ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          notificationUser.content ?? "",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          SahaDateUtils().getDDMMYY3(
                              notificationUser.createdAt ?? DateTime.now()),
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget icon(NotificationUser notificationUser) {
    if (notificationUser.type == NEW_ORDER)
      return SvgPicture.asset(
        'assets/icons/check_list_new.svg',
        height: 45,
        width: 45,
      );
    if (notificationUser.type == NEW_MESSAGE)
      return SvgPicture.asset(
        'assets/icons/chat2.svg',
        height: 45,
        width: 45,
      );
    if (notificationUser.type == NEW_POST)
      return SvgPicture.asset(
        'assets/icons/newspaper.svg',
        height: 45,
        width: 45,
      );
    if (notificationUser.type == NEW_PERIODIC_SETTLEMENT)
      return SvgPicture.asset(
        'assets/icons/audit.svg',
        height: 45,
        width: 45,
      );
    if (notificationUser.type == ORDER_STATUS)
      return SvgPicture.asset(
        'assets/icons/tracking.svg',
        height: 45,
        width: 45,
      );
    if (notificationUser.type == CUSTOMER_CANCELLED_ORDER)
      return SvgPicture.asset(
        'assets/icons/cancel.svg',
        height: 45,
        width: 45,
      );
    if (notificationUser.type == CUSTOMER_PAID)
      return SvgPicture.asset(
        'assets/icons/debit-card.svg',
        height: 45,
        width: 45,
      );
    if (notificationUser.type == SEND_ALL)
      return SvgPicture.asset(
        'assets/icons/all.svg',
        height: 45,
        width: 45,
      );
    if (notificationUser.type == TO_ADMIN)
      return SvgPicture.asset(
        'assets/icons/admin.svg',
        height: 45,
        width: 45,
      );

    return Icon(
      Icons.circle,
      color: Colors.blue,
      size: 10,
    );
  }
}
