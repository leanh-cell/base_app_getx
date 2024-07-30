import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/text_field_input_otp.dart';
import 'package:com.ikitech.store/app_user/utils/keyboard.dart';
import 'package:com.ikitech.store/app_user/utils/phone_number.dart';

import 'reset_password_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<ResetPasswordScreen> {
  ResetPasswordController resetPasswordController = ResetPasswordController();
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (resetPasswordController.newPassInputting.value == true) {
        return buildNewPasswordInputScreen();
      }
      return buildNumInputScreen();
    });
  }

  Widget buildNumInputScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lấy lại mật khẩu"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                SahaTextField(
                  controller: resetPasswordController
                      .textEditingControllerEmailOrNumberPhone,
                  onChanged: (value) {},
                  autoFocus: true,
                  withAsterisk: true,
                  validator: (value) {
                    if (value!.length < 1) {
                      return 'Bạn chưa nhập Email hoặc số điện thoại';
                    } else {
                      if (GetUtils.isEmail(value)) {
                        return null;
                      } else {
                        return PhoneNumberValid.validateMobile(value);
                      }
                    }
                  },
                  textInputType: TextInputType.emailAddress,
                  obscureText: false,
                  labelText: "Email hoặc Số điện thoại",
                  hintText: "Nhập Email hoặc số điện thoại",
                  icon: Icon(Icons.person,color: Colors.pink,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SahaButtonSizeChild(
                    width: 200,
                    text: "Tiếp tục",
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        KeyboardUtil.hideKeyboard(context);
                        if (GetUtils.isEmail(resetPasswordController
                            .textEditingControllerEmailOrNumberPhone.text)) {
                          resetPasswordController.checkHasEmail(onHas: () {
                            resetPasswordController.newPassInputting.value =
                                true;
                          });
                        } else {
                          resetPasswordController.checkHasPhoneNumber(
                              onHas: () {
                            resetPasswordController.newPassInputting.value =
                                true;
                          });
                        }
                      }
                    }),
                Spacer(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          resetPasswordController.resting.value ||
                  resetPasswordController.checkingHasPhone.value
              ? Container(
                  width: Get.width,
                  height: Get.height,
                  child: SahaLoadingWidget(),
                )
              : Container()
        ],
      ),
    );
  }

  Widget buildNewPasswordInputScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lấy lại mật khẩu"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            resetPasswordController.newPassInputting.value = false;
          },
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              Container(
                width: Get.width,
                height: Get.height - AppBar().preferredSize.height - 100,
                child: Stack(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                                "Nhập mã OTP và nhập mật khẩu mới để lấy lại mật khẩu"),
                            decoration: BoxDecoration(color: Colors.grey[300]),
                            padding: EdgeInsets.all(20),
                          ),
                          TextFieldInputOtp(
                            numberPhone: resetPasswordController
                                .textEditingControllerEmailOrNumberPhone.text,
                            email: resetPasswordController
                                .textEditingControllerEmailOrNumberPhone.text,
                            isPhoneValidate: GetUtils.isEmail(resetPasswordController
                                .textEditingControllerEmailOrNumberPhone.text) == true ? false : true,
                            isCustomer: false,
                            autoFocus: true,
                            onChanged: (va) {
                              resetPasswordController.otp = va;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SahaTextField(
                            controller: resetPasswordController
                                .textEditingControllerNewPass,
                            onChanged: (value) {},
                            autoFocus: true,
                            validator: (value) {
                              if (value!.length < 6) {
                                return 'Mật khẩu mới phải lớn hơn 6 ký tự';
                              }
                              return null;
                            },
                            textInputType: TextInputType.emailAddress,
                            obscureText: true,
                            withAsterisk: true,
                            labelText: "Mật khẩu mới",
                            hintText: "Nhập mật khẩu mới",
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SahaButtonSizeChild(
                              width: 200,
                              text: "Tiếp tục",
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  KeyboardUtil.hideKeyboard(context);
                                  resetPasswordController.onReset(
                                    isPhoneValidate: GetUtils.isEmail(
                                        resetPasswordController
                                            .textEditingControllerEmailOrNumberPhone
                                            .text) ==
                                        true
                                        ? false
                                        : true,
                                  );
                                }
                              }),
                          Spacer(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    resetPasswordController.resting.value
                        ? Container(
                            width: Get.width,
                            height: Get.height,
                            child: SahaLoadingWidget(),
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
