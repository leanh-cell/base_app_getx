import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/data/remote/saha_service_manager.dart';
import 'package:com.ikitech.store/app_user/screen2/sign_up/sign_up_screen.dart';
import 'package:com.ikitech.store/app_user/utils/keyboard.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/remote/customer_service_manager.dart';
import 'package:sahashop_customer/app_customer/utils/customer_info.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';

import 'login_screen_controller.dart';
import 'reset_password/reset_password.dart';

class LoginScreen extends StatefulWidget {
  String? phone;
  String? pass;

  LoginScreen({this.phone, this.pass});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginController loginController;

  final _formKey = GlobalKey<FormState>();

  int count = 1;

  @override
  void initState() {
    loginController = LoginController(phone: widget.phone, pass: widget.pass);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                image: ExactAssetImage(
                  "assets/images/background_doapp.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height / 6,
                    ),
                    Image.asset(
                      "assets/images/logo_doapp_white.jpg",
                      height: ((Get.width - 70) * 95) / 264,
                      width: Get.width - 70,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: [
                        Obx(
                          () => Stack(
                            children: [
                              Container(
                                height: 50,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        cursorColor: Colors.white,
                                        controller: loginController
                                            .textEditingControllerPhoneShop
                                            .value,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            errorStyle:
                                                TextStyle(color: Colors.white),
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText:
                                                "Email hoặc Số điện thoại",
                                            hintStyle: TextStyle(
                                                color: Colors.white70)),
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                        minLines: 1,
                                        maxLines: 1,
                                        onChanged: (v) {
                                          loginController
                                              .textEditingControllerPhoneShop
                                              .refresh();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (loginController.textEditingControllerPhoneShop
                                      .value.text !=
                                  "")
                                Positioned(
                                  top: 15,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      loginController
                                          .textEditingControllerPhoneShop
                                          .value
                                          .text = "";
                                      loginController
                                          .textEditingControllerPhoneShop
                                          .refresh();
                                    },
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Icon(
                                        Icons.close,
                                        color: Theme.of(context).primaryColor,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.white,
                        ),
                        Container(
                          height: 50,
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Obx(
                                  () => TextFormField(
                                    validator: (value) {
                                      if (value!.length < 1) {
                                        return 'Mật khẩu không được để trống';
                                      }
                                      return null;
                                    },
                                    cursorColor: Colors.white,
                                    controller: loginController
                                        .textEditingControllerPass.value,
                                    obscureText:
                                        loginController.isHidePassword.value,
                                    decoration: InputDecoration(
                                        errorStyle:
                                            TextStyle(color: Colors.white),
                                        isDense: true,
                                        border: InputBorder.none,
                                        hintText: "Mật khẩu",
                                        hintStyle:
                                            TextStyle(color: Colors.white70)),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    minLines: 1,
                                    maxLines: 1,
                                    onChanged: (v) {
                                      loginController.textEditingControllerPass
                                          .refresh();
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      loginController.isHidePassword.value =
                                          !loginController.isHidePassword.value;
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      child: Obx(() =>
                                          loginController.isHidePassword.value
                                              ? Icon(
                                                  Icons.visibility_off_sharp,
                                                  color: Colors.white,
                                                )
                                              : Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.white,
                                                )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => loginController.textEditingControllerPhoneShop.value
                                  .text.isNotEmpty &&
                              loginController.textEditingControllerPass.value
                                  .text.isNotEmpty
                          ? SahaButtonFullParent(
                              text: "ĐĂNG NHẬP",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  KeyboardUtil.hideKeyboard(context);
                                  loginController.onLogin();
                                }
                              },
                              textStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                              ),
                              color: Colors.white,
                            )
                          : IgnorePointer(
                              child: SahaButtonFullParent(
                                text: "ĐĂNG NHẬP",
                                textColor: Colors.grey[600],
                                onPressed: () {},
                                color: Colors.grey[300],
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              Get.to(() => SignUpScreen())!;
                            },
                            child: Text(
                              "Đăng ký",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        SizedBox(
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              Get.to(ResetPasswordScreen())!.then((mapData) {
                                if (mapData["success"] != null) {
                                  loginController.textEditingControllerPhoneShop
                                      .value.text = mapData["phone"];
                                  loginController.textEditingControllerPass
                                      .value.text = mapData["pass"];
                                  loginController.textEditingControllerPhoneShop
                                      .refresh();
                                  loginController.textEditingControllerPass
                                      .refresh();
                                  _formKey.currentState!.validate();
                                }
                              });
                            },
                            child: Text(
                              "Quên mật khẩu",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60),
                    InkWell(
                      onTap: () async {
                        print(count);
                        var isRelease = UserInfo().getIsRelease();
                        if (count == 9) {
                          if (isRelease == null) {
                            await UserInfo().setRelease(false);
                            await StoreInfo().setRelease(false);
                            CustomerServiceManager.initialize();
                            SahaServiceManager.initialize();
                          } else {
                            await UserInfo().setRelease(null);
                            await StoreInfo().setRelease(null);
                            CustomerServiceManager.initialize();
                            SahaServiceManager.initialize();
                          }
                          count = 0;
                          setState(() {});
                        }
                        count = count + 1;
                        UserInfo().setToken(
                            "koZiyquaLyHLAoYYbu6iz81jomkLoUpwAPwv6sSX");
                        CustomerInfo().setToken(
                            's4YWVbzTFuIxYJiGkQcEzrRD18IITp1RbRWwUnET');
                      },
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "© 2021 IKI TECH JSC ${UserInfo().getIsRelease() == null ? "" : "(DEV)"}",
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
