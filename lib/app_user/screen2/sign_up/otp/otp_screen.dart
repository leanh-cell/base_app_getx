import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/text_field_input_otp.dart';

import '../sign_up_screen_controller.dart';

class OtpScreen extends StatelessWidget {
  final formKey3 = GlobalKey<FormState>();
  final bool isPhoneValidate;

  OtpScreen({required this.isPhoneValidate});

  SignUpController signUpController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Đăng ký"),
      ),
      body: Form(
        key: formKey3,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFieldInputOtp(
                  email: signUpController.textEditingControllerEmail.text,
                  isCustomer: false,
                  isPhoneValidate: isPhoneValidate,
                  numberPhone: signUpController.textEditingControllerPhone.text,
                  onChanged: (va) {
                    signUpController.otp = va;
                  },
                ),
                SizedBox(height: 15),
                Center(
                  child: SahaButtonSizeChild(
                    text: "Hoàn thành",
                    width: 200,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (formKey3.currentState!.validate()) {
                        signUpController.onSignUp(
                            isPhoneValidate: isPhoneValidate);
                      }
                    },
                  ),
                ),
              ],
            ),
            signUpController.signUpping.value
                ? Container(
                    height: Get.height,
                    width: Get.width,
                    child: Center(
                      child: SahaLoadingWidget(),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
