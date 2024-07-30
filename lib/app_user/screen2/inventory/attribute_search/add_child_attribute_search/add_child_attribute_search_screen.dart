import 'dart:io';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:sahashop_customer/app_customer/model/attribute_search.dart';
import '../../../../../saha_data_controller.dart';
import '../../../config_app/screens_config/logo_type/select_logo_image.dart';
import 'add_child_attribute_search_controller.dart';

class AddAttributeChildScreen extends StatelessWidget {
  AttributeSearch attributeSearch;
  AttributeSearch? attributeSearchChild;

  final _formKey = GlobalKey<FormState>();

  File? imageSelected;

  SahaDataController sahaDataController = Get.find();

  AddAttributeChildScreen(
      {required this.attributeSearch, this.attributeSearchChild}) {
    controller = new AddChildAttributeSearchController(
        attributeSearch: attributeSearch,
        attributeSearchChild: attributeSearchChild);
  }

  late AddChildAttributeSearchController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText:
            "${attributeSearchChild != null ? "Sửa thuộc tính con" : "Thêm thuộc tính con"}",
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
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            children: [
                              Obx(
                                () => SelectLogoImage(
                                  linkLogo: controller.image.value,
                                  onChange: (link) {
                                    controller.image.value = link;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Ảnh thuộc tính"),
                                    Text(
                                      "Có thể không chọn",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                DecentralizationWidget(
                  decent: true,
                  child: SahaButtonFullParent(
                    text: "${attributeSearchChild != null ? "Sửa" : "Thêm"}",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (attributeSearchChild != null) {
                          if(sahaDataController.badgeUser.value.decentralization?.productAttributeUpdate != true){
                            SahaAlert.showError(message: "Bạn chưa được phân quyền");
                            return;
                          }
                          controller.updateAttributeSearchChild();
                        } else {
                          controller.createAttributeSearchChild();
                        }
                      }
                    },
                  ),
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
