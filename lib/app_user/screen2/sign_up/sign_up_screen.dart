import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import 'package:com.ikitech.store/app_user/utils/phone_number.dart';
import 'otp/choose_method_validate.dart';
import 'otp/otp_screen.dart';
import 'sign_up_screen_controller.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpController signUpController = Get.put(SignUpController());

  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  String? phoneShop;
  // ignore: cancel_subscriptions
  StreamSubscription? sub;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        titleText: "Đăng ký",
      ),
      body: Obx(
        () => Stack(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SahaTextField(
                    controller: signUpController.textEditingControllerName,
                    withAsterisk: true,
                    onChanged: (value) {},
                    textCapitalization: TextCapitalization.sentences,
                    autoFocus: true,
                    validator: (value) {
                      if (value!.length < 1) {
                        return 'Tên không được để trống';
                      }
                      return null;
                    },
                    obscureText: false,
                    labelText: "Họ và tên",
                    hintText: "Nhập tên của bạn",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SahaTextField(
                    withAsterisk: true,
                    controller: signUpController.textEditingControllerPhone,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value!.length < 1) {
                        return 'Bạn chưa nhập số điện thoại';
                      }
                      return PhoneNumberValid.validateMobile(value);
                    },
                    textInputType: TextInputType.number,
                    obscureText: false,
                    autoFocus: true,
                    labelText: "Số điện thoại",
                    hintText: "Nhập số điện thoại",
                    icon: Icon(Icons.lock),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SahaTextField(
                    // withAsterisk: true,
                    controller: signUpController.textEditingControllerEmail,
                    onChanged: (value) {},
                    validator: (String? value) {
                      if (value!.length > 1) {
                        return !GetUtils.isEmail(value)
                            ? "Email không hợp lệ"
                            : null;
                      }
                    },
                    textInputType: TextInputType.emailAddress,
                    obscureText: false,
                    labelText: "Email",
                    hintText: "Nhập email của bạn",
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SahaTextField(
                    withAsterisk: true,
                    controller: signUpController.textEditingControllerPass,
                    onChanged: (value) {},
                    maxLines: 1,
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'Mật khẩu phải hơn 6 kí tự';
                      }
                      return null;
                    },
                    textInputType: TextInputType.visiblePassword,
                    obscureText: true,
                    labelText: "Mật khẩu",
                    hintText: "Nhập mật khẩu",
                    icon: Icon(Icons.lock),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: SahaButtonSizeChild(
                      text: "Tiếp tục",
                      width: 200,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (signUpController
                                  .textEditingControllerEmail.text ==
                              "") {
                            signUpController.checkHasPhoneNumber(noHas: () {
                              Get.to(() => OtpScreen(
                                        isPhoneValidate: true,
                                      ))!
                                  .then((res) {
                                if (res['success_register'] != true) {
                                  return;
                                } else {
                                  var phone = res['phone'];
                                  var pass = res['pass'];

                                  Navigator.of(Get.context!).pop({
                                    "success_register": true,
                                    "phone": phone,
                                    "pass": pass
                                  });
                                }
                              });
                            });
                          } else {
                            signUpController.checkHasPhoneNumber(noHas: () {
                              signUpController.checkHasEmail(noHas: () {
                                Get.to(() => ChooseMethodValidate(
                                      title: "CHỌN PHƯƠNG THỨC XÁC THỰC",
                                      phoneNumber: signUpController
                                          .textEditingControllerPhone.text,
                                      email: signUpController
                                          .textEditingControllerEmail.text,
                                    ));
                              });
                            });
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 40)
                ],
              ),
            ),
            signUpController.checkingHasEmail.value
                ? SahaLoadingFullScreen()
                : Container(),
            signUpController.checkingHasPhone.value
                ? SahaLoadingFullScreen()
                : Container()
          ],
        ),
      ),
    );
  }
}
