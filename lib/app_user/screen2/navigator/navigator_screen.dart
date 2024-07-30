import 'dart:io';

import 'package:badges/badges.dart' as b;
import 'package:com.ikitech.store/app_user/load_data/notification/alert_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/screen2/bill/bill_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/config/config_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/order/order_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/order/order_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/overview/orverview_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/product_menu/product_menu_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/report/report_screen.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version_check/version_check.dart';

import '../../../saha_data_controller.dart';
import '../order/type_order_screen.dart';
import 'navigator_controller.dart';

const MENU_HOME = 0;
const MENU_REPORT = 3;
const MENU_OVERVIEW = 2;
const MENU_BILL = 1;
const MENU_CONFIG = 4;
const MENU_PRODUCT = 5;

class NavigatorScreen extends StatefulWidget {
  @override
  NavigatorScreen({this.selectedIndex}) {
    navigatorController = Get.find();
  }
  State<NavigatorScreen> createState() => _NavigatorScreenState();
  int? selectedIndex;
  late NavigatorController navigatorController;
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  HomeController homeController = Get.find();

  SahaDataController sahaDataController = Get.find();

  String? version = '';
  String? storeVersion = '';
  String? storeUrl = '';
  String? packageName = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (widget.selectedIndex != null) return;
        checkVersion();
      });
    });
    super.initState();
  }

  var versionCheck = VersionCheck();

  Future checkVersion() async {
    versionCheck = VersionCheck(
      packageName: sahaDataController.packageInfo.value.packageName,
      packageVersion: sahaDataController.packageInfo.value.version,
      showUpdateDialog: customShowUpdateDialog,
      country: 'vn',
    );
    
    await versionCheck.checkVersion(context);
    print("===========> ${versionCheck.packageVersion}");

    version = versionCheck.packageVersion;
    packageName = versionCheck.packageName;
    storeVersion = versionCheck.storeVersion;
    storeUrl = versionCheck.storeUrl;
  }

  void customShowUpdateDialog(BuildContext context, VersionCheck versionCheck) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Có bản cập nhật mới'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Cập nhật lên phiên bản mới ${versionCheck.storeVersion}?'),
              Text('(phiên bản hiện tại ${versionCheck.packageVersion})'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cập nhật'),
            onPressed: () async {
              if (Platform.isAndroid) {
                final url = Uri.parse(
                    "market://details?id=${sahaDataController.packageInfo.value.packageName}");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch $url';
                }
              } else {
                await versionCheck.launchStore();
              }
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Thoát'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (widget.navigatorController.indexNav.value == MENU_HOME) {
          homeController.idCurrentCombo.value = -1;
          homeController.searchProduct();
          return HomeScreen();
        }
        if (widget.navigatorController.indexNav.value == MENU_REPORT)
          return ReportScreen();
        if (widget.navigatorController.indexNav.value == MENU_OVERVIEW) {
          sahaDataController.getBadge();
          return OverViewScreen();
        }
        if (widget.navigatorController.indexNav.value == MENU_BILL)
          return OrderScreen();
        if (widget.navigatorController.indexNav.value == MENU_CONFIG)
          return ConfigScreen();
        if (widget.navigatorController.indexNav.value == MENU_PRODUCT)
          return ProductMenuScreen();
        return HomeScreen();
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedItemColor:
              SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: b.Badge(
                badgeStyle: b.BadgeStyle(
                  padding: EdgeInsets.all(3),
                ),
                showBadge: false,
                position: b.BadgePosition.custom(end: 5, top: 5),
                child: Icon(Ionicons.reader),
              ),
              label: 'Tạo đơn',
            ),
            BottomNavigationBarItem(
              icon: b.Badge(
                badgeStyle: b.BadgeStyle(
                  padding: EdgeInsets.all(3),
                ),
                showBadge: false,
                position: b.BadgePosition.custom(end: 5, top: 5),
                child: Icon(Ionicons.receipt),
              ),
              label: 'Đơn hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.storefront),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: b.Badge(
                badgeStyle: b.BadgeStyle(
                  padding: EdgeInsets.all(3),
                ),
                showBadge: false,
                position: b.BadgePosition.custom(end: 5, top: 5),
                child: Icon(Ionicons.stats_chart),
              ),
              label: 'Báo cáo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Cài đặt',
            ),
          ],
          currentIndex: widget.navigatorController.indexNav.value,
          onTap: (currentIndex) {
            
            if (currentIndex == MENU_HOME &&
                sahaDataController
                        .badgeUser.value.decentralization?.createOrderPos ==
                    false) {
              SahaAlert.showToastMiddle(message: "Chức năng tạo đơn bị chặn");
              return;
            }

            if (currentIndex == MENU_BILL &&
                sahaDataController
                        .badgeUser.value.decentralization?.orderList ==
                    false) {
              SahaAlert.showToastMiddle(message: "Chức năng hoá đơn bị chặn");
              return;
            }

            if (currentIndex == MENU_BILL) {
              OrderController orderController = Get.find();
              orderController.loadMoreOrder(isRefresh: true);
             
            }

            if (currentIndex == MENU_REPORT &&
                sahaDataController
                        .badgeUser.value.decentralization?.reportOverview ==
                    false &&
                sahaDataController
                        .badgeUser.value.decentralization?.reportInventory ==
                    false &&
                sahaDataController
                        .badgeUser.value.decentralization?.reportFinance ==
                    false) {
              SahaAlert.showToastMiddle(message: "Chức năng báo cáo bị chặn");
              return;
            }

            widget.navigatorController.indexNav.value = currentIndex;
          },
        ),
      ),
    );
  }
}
