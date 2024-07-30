import 'package:flutter/material.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:com.ikitech.store/app_user/utils/keyboard.dart';
import 'package:com.ikitech.store/app_user/utils/valid_text.dart';

import 'change_password_controller.dart';

class ChangePassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  ChangePasswordController changePasswordController =
      new ChangePasswordController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        KeyboardUtil.hideKeyboard(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thay đổi mật khẩu"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              SahaTextField(
                controller: changePasswordController.textEditingControllerOldPass,
                onChanged: (value) {},
                autoFocus: true,
                validator: (value) {
    
                  return null;
                },
                textInputType: TextInputType.text,
                obscureText: true,
                withAsterisk: true,
                labelText: "Mật khẩu cũ",
                hintText: "Nhập mật khẩu cũ",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
    
              SahaTextField(
                controller: changePasswordController.textEditingControllerNewPass,
                onChanged: (value) {},
                autoFocus: true,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Mật khẩu phải từ 6 ký tự';
                  }
                  return null;
                },
                textInputType: TextInputType.text,
                obscureText: true,
    
                withAsterisk: true,
                labelText: "Mật khẩu mới",
                hintText: "Nhập mật khẩu mới",
              ),
    
              SahaButtonSizeChild(
                  width: 200,
                  text: "Thay đổi",
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      KeyboardUtil.hideKeyboard(context);
                      changePasswordController.onChange();
                    }
                  }),
              Spacer(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
