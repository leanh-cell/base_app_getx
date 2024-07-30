import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';

class ToEmailScreen extends StatelessWidget {
  String orderCode;
  String? email;

  ToEmailScreen(this.orderCode, this.email) {
    emailEditingController = TextEditingController(text: email);
  }

  late TextEditingController emailEditingController;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Gửi hoá đơn đến email"),
          actions: [
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    sendOrderEmail();
                    Get.until(
                      (route) => route.settings.name == "home_screen",
                    );
                  }
                },
                child: Text(
                  "Gửi",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                decoration: InputDecoration(hintText: "Email"),
                controller: emailEditingController,
                validator: (value) {
                  if (value!.length < 1) {
                    return 'Bạn chưa nhập Email';
                  } else {
                    if (GetUtils.isEmail(value)) {
                      return null;
                    } else {
                      return 'Email không hợp lệ';
                    }
                  }
                },
                onChanged: (v) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendOrderEmail() async {
    try {
      var data = await RepositoryManager.orderRepository
          .sendOrderEmail(emailEditingController.text, orderCode);
      SahaAlert.showSuccess(message: "Thành công");
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }
}
