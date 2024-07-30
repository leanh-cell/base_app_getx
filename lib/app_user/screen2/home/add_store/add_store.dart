import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/screen2/sign_up/sign_up_screen_controller.dart';
import 'package:com.ikitech.store/app_user/utils/keyboard.dart';

import 'add_store_controller.dart';

class AddStore extends StatefulWidget {
  @override
  _AddStoreState createState() => _AddStoreState();
}

class _AddStoreState extends State<AddStore> {
  TextEditingController textEditingControllerNameShop =
      new TextEditingController();
  TextEditingController textEditingControllerAddress =
      new TextEditingController();
  TextEditingController textEditingControllerStoreCode =
      new TextEditingController();

  AddStoreController addStoreController = AddStoreController();

  final _formKey = GlobalKey<FormState>();

  int? _chosenValue;
  Map<String, String?>? chooseDropDownValue;

  int? _chosenValueChild;
  Map<String, String?>? chooseDropDownValueChild;

  final signUpController = Get.put(SignUpController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addStoreController.getAllShopType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        titleText: "Thêm cửa hàng",
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.4),
          ],
        )),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                ),
                Center(
                  child: Text(
                    "Thông tin cửa hàng",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Xin quý khách nhập thông tin cửa hàng \nđể khởi tạo",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("Tên cửa hàng"),
                    )),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    autofocus: false,
                    controller: textEditingControllerNameShop,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    validator: (value) {
                      if (value!.length == 0) {
                        return 'Tên cửa hàng không được để trống';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      errorStyle: TextStyle(color: Colors.white),
                      hintText: 'Mời nhập tên cửa hàng',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("Mã cửa hàng"),
                    )),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    autofocus: false,
                    controller: textEditingControllerStoreCode,
                    textCapitalization: TextCapitalization.none,
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    validator: (value) {
                      if (value!.length < 2) {
                        return 'Mã cửa hàng chứa 2 kí tự trở lên';
                      }
                      if (GetUtils.isAlphabetOnly(value.substring(0, 1)) ==
                          false) {
                        return 'Phải bắt đầu bằng chữ';
                      }

                      if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]')
                          .hasMatch(value)) {
                        return 'Không được chứa ký tự đặc biệt';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      suffix: Text(".myiki.vn        "),
                      errorStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      hintText: 'Mời nhập mã cửa hàng',
                      filled: true,
                      fillColor: Colors.white,
                      helperText:
                          "Mã này là tên miền truy cập trang web bán hàng",
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text("Chọn ngành"),
                    )),
                Obx(
                  () => Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(left: 10),
                    child: DropdownButton<Map<String, String?>>(
                      focusColor: Colors.white,
                      value: chooseDropDownValueChild,
                      //elevation: 5,
                      underline: SizedBox(),
                      style: TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.black,
                      items: addStoreController.mapTypeChild
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
                        "Chọn ngành kinh doanh",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      onChanged: (Map<String, String?>? value) {
                        setState(() {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          chooseDropDownValueChild = value;
                          _chosenValueChild = int.parse(value!.keys.first);
                          print(_chosenValueChild);
                        });
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      KeyboardUtil.hideKeyboard(context);
                      if (addStoreController.creating.value == false) {
                        addStoreController.createShop(
                            textEditingControllerNameShop.text,
                            textEditingControllerAddress.text,
                            _chosenValueChild,
                            textEditingControllerStoreCode.text);
                      }
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 40,
                    child: Center(
                      child: Text(
                        "Tạo",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
