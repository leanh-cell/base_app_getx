import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_customer/app_customer/model/attribute_search.dart';
import '../../../../../saha_data_controller.dart';
import '../../../config_app/screens_config/logo_type/select_logo_image.dart';
import 'add_attribute_search_controller.dart';

class AddAttributeSearchScreen extends StatelessWidget {
  late AddAttributeSearchController controller;
  final _formKey = GlobalKey<FormState>();

  AttributeSearch? attributeSearch;

  SahaDataController sahaDataController = Get.find();

  AddAttributeSearchScreen({this.attributeSearch}) {
    controller =
        new AddAttributeSearchController(attributeSearch: attributeSearch);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText:
            "${attributeSearch != null ? "Sửa thuộc tính" : "Thêm thuộc tính"}",
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SahaTextField(
                          controller: controller.textEditingControllerName,
                          onChanged: (value) {
                            controller.name = value;
                          },
                          validator: (value) {
                            if (value!.length == 0) {
                              return 'Không được để trống';
                            }
                            return null;
                          },
                          labelText: "Tên thuộc tính",
                          hintText: "Mời nhập tên thuộc tính",
                        ),
                        Divider(height: 1,),
                      ],
                    ),
                  ),
                ),
                SahaButtonFullParent(
                  text: "${attributeSearch != null ? "Sửa" : "Thêm"}",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.createAttributeSearch(
                        attributeSearchId: attributeSearch != null
                            ? attributeSearch!.id
                            : null,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Obx(() {
            return controller.isLoadingAdd.value
                ? SahaLoadingFullScreen()
                : Container();
          })
        ],
      ),
    );
  }
}
