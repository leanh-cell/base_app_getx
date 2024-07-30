import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_user/screen2/home/home_controller.dart';
import 'app_user/screen2/login/login_screen.dart';
import 'app_user/screen2/navigator/navigator_controller.dart';
import 'app_user/screen2/order/order_controller.dart';
import 'app_user/utils/showcase.dart';
import 'app_user/utils/user_info.dart';
import 'saha_data_controller.dart';

class SahaMainScreen extends StatefulWidget {
  @override
  _SahaMainScreenState createState() => _SahaMainScreenState();
}

class _SahaMainScreenState extends State<SahaMainScreen> {
  SahaDataController sahaDataController = Get.find();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadInit(context);
    ShowCase().getStateShowCase();
  }

  void loadInit(BuildContext context) {
    
    checkLogin(context);
  }

  Future<void> checkLogin(BuildContext context) async {
    if (await UserInfo().hasLogged()) {
      hasLogged(context);
    } else {
      noLogin(context);
    }
  }

  hasLogged(BuildContext context) async {
    Get.put(NavigatorController());
    Get.put(HomeController());
    Get.put(OrderController());
    if (UserInfo().getToken() != null) {
      await sahaDataController.getUser();
      sahaDataController.getBadge();
    }

  }

  noLogin(BuildContext context) {
    Get.offAll(() => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  child: Image.asset(
                    "assets/logo.png",
                    height: 150,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
