import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/load_data/load_firebase.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/login/login_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/navigator/navigator_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/order/order_controller.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';

class LoginController extends GetxController {
  var logging = false.obs;
  var loginInputting = false.obs;

  var isHidePassword = true.obs;
  var textEditingControllerPhoneShop = new TextEditingController().obs;
  var textEditingControllerPass = new TextEditingController().obs;

  SahaDataController sahaDataController = Get.find();

  String? phone;
  String? pass;

  LoginController({this.phone, this.pass}) {
    textEditingControllerPass.value.text = pass ?? "";
    textEditingControllerPhoneShop.value.text = phone ?? "";
    if (phone != null && pass != null) {
      onLogin();
    }
  }

  Future<bool> onLogin() async {
    logging.value = true;
    onLoading();
    try {
      var loginData = (await RepositoryManager.loginRepository.login(
          emailOrPhoneNumber: textEditingControllerPhoneShop.value.text,
          pass: textEditingControllerPass.value.text))!;

      await UserInfo().setToken(loginData.token);

      FCMMess().initToken();

      if (UserInfo().getToken() != null) {
        sahaDataController.getUser();
      }

      Get.put(NavigatorController());
      Get.put(HomeController());
      Get.put(OrderController());
      logging.value = false;

      return true;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
      logging.value = false;
      Get.offAll(
              () => LoginScreen(
            phone: textEditingControllerPhoneShop.value.text,
          ),
          transition: Transition.noTransition);
      return false;
    }
  }

  void onLoading() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          clipBehavior: Clip.none,
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: Get.width / 3),
          elevation: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: CupertinoActivityIndicator(),
            ),
          ),
        );
      },
    );
  }
}

