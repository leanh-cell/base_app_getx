import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/sahashopTextField.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/categories/add_category/widget/select_image.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import '../../../../../saha_data_controller.dart';
import 'add_child_category_controller.dart';

class AddCategoryChildScreen extends StatelessWidget {
  Category category;
  Category? categoryChild;

  final _formKey = GlobalKey<FormState>();

  File? imageSelected;

  SahaDataController sahaDataController = Get.find();

  AddCategoryChildScreen({required this.category, this.categoryChild}) {
    addCategoryController = new AddChildCategoryController(
        category: category, categoryChild: categoryChild);
    if (categoryChild != null) {
      addCategoryController.textEditingControllerName.text =
          categoryChild?.name ?? "";
    }
  }

  late AddChildCategoryController addCategoryController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText:
            "${categoryChild != null ? "Sửa danh mục con" : "Thêm danh mục con"}",
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
                          controller:
                              addCategoryController.textEditingControllerName,
                          onChanged: (value) {
                            addCategoryController.name = value;
                          },
                          validator: (value) {
                            if (value!.length == 0) {
                              return 'Không được để trống';
                            }
                            return null;
                          },
                          labelText: "Tên danh mục",
                          hintText: "Mời nhập tên danh mục",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            children: [
                              SelectCategoryImage(
                                linkImage: categoryChild != null &&
                                        categoryChild!.imageUrl != null
                                    ? categoryChild!.imageUrl!
                                    : "",
                                onChange: (image) {
                                  addCategoryController.image = image;
                                  print(image);
                                  imageSelected = image;
                                },
                                fileSelected: imageSelected,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Ảnh danh mục"),
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
                  decent: sahaDataController.badgeUser.value.decentralization
                          ?.productCategoryUpdate ??
                      false,
                  child: SahaButtonFullParent(
                    text: "${categoryChild != null ? "Sửa" : "Thêm"}",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (categoryChild != null) {
                          addCategoryController.updateCategoryChild();
                        } else {
                          addCategoryController.createCategoryChild();
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
            return addCategoryController.isLoadingAdd.value
                ? SahaLoadingFullScreen()
                : Container();
          })
        ],
      ),
    );
  }
}
