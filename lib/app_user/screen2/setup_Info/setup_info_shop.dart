import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/store/type_store_respones.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/sign_up/sign_up_screen_controller.dart';
import 'package:com.ikitech.store/app_user/utils/keyboard.dart';
import 'setup_info_shop_controller.dart';

class SetUpInfoShop extends StatefulWidget {
  @override
  _SetUpInfoShopState createState() => _SetUpInfoShopState();
}

class _SetUpInfoShopState extends State<SetUpInfoShop> {
  TextEditingController textEditingControllerNameShop =
      new TextEditingController();
  TextEditingController textEditingControllerAddress =
      new TextEditingController();

  SetUpInfoShopController setUpInfoShopController = SetUpInfoShopController();

  final _formKey = GlobalKey<FormState>();

  int? _chosenValue;
  List<DataTypeShop>? listTypeShop;
  List<String> nameTypeShop = [];
  Map<String, String?>? chooseDropDownValue;
  // ignore: cancel_subscriptions
  StreamSubscription? sub;
  final signUpController = Get.put(SignUpController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpInfoShopController.getAllShopType();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    sub ??= setUpInfoShopController.stateCreate.listen((state) {
      if (state != "success") {
        SahaDialogApp.showDialogError(context: context, errorMess: state);

      }

      if (state == "success") {
        Get.offAll(HomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.grey,
          onPressed: () {
            Get.back();
          },
        ),
        titleText: "Sign In",
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
              ),
              Text(
                "Thông tin cửa hàng",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "Xin quý khách nhập thông tin cửa hàng \nđể khởi tạo",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              SahaTextField(
                controller: textEditingControllerNameShop,
                onChanged: (value) {},
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Bạn chưa nhập số điện thoại';
                  }
                  return null;
                },
                textInputType: TextInputType.name,
                obscureText: false,
                labelText: "Tên cửa hàng",
                hintText: "Nhập tên cửa hàng",
                icon: Icon(Icons.lock),
              ),
              SahaTextField(
                controller: textEditingControllerAddress,
                onChanged: (value) {},
                validator: (value) {
                  if (value!.length < 6) {
                    return 'mật khẩu chứa hơn 6 kí tự';
                  }
                  return null;
                },
                textInputType: TextInputType.emailAddress,
                obscureText: false,
                labelText: "Địa chỉ cửa hàng",
                hintText: "Nhập địa chỉ cửa hàng",
                icon: Icon(Icons.lock),
              ),
              Obx(
                () => DropdownButton<Map<String, String?>>(
                  focusColor: Colors.white,
                  value: chooseDropDownValue,
                  //elevation: 5,
                  style: TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  items: setUpInfoShopController.mapTypeShop
                      .map<DropdownMenuItem<Map<String, String?>>>(
                          (Map<String, String?> value) {
                    return DropdownMenuItem<Map<String, String?>>(
                      value: value,
                      child: Text(
                        "${value.values.first}",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Chọn loại cửa hàng kinh doanh",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (Map<String, String?>? value) {
                    setState(() {
                      chooseDropDownValue = value;
                      _chosenValue = int.parse(value!.keys.first);
                    });
                  },
                ),
              ),
              TextButton(
                // signUpController.shopPhones.toString()
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    KeyboardUtil.hideKeyboard(context);

                    setUpInfoShopController.createShop(
                        textEditingControllerNameShop.text,
                        textEditingControllerAddress.text,
                        _chosenValue,
                        textEditingControllerNameShop.text +
                            signUpController.shopPhones.toString());

                  }
                },
                style: ButtonStyle(),
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}
