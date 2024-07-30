import 'dart:io';
import 'package:flutter/cupertino.dart';
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
import '../../../../components/saha_user/toast/saha_alert.dart';
import 'add_category_controller.dart';

class AddCategoryScreen extends StatelessWidget {
  late AddCategoryController addCategoryController;
  final _formKey = GlobalKey<FormState>();

  Category? category;

  File? imageSelected;

  SahaDataController sahaDataController = Get.find();
  AddCategoryScreen({this.category}) {
    addCategoryController = new AddCategoryController(category: category);
  }

  @override
  Widget build(BuildContext context) {
    if (category != null) {
      addCategoryController.textEditingControllerName.text = category!.name!;
    }

    return Scaffold(
      appBar: SahaAppBar(
        titleText: "${category != null ? "Sửa danh mục" : "Thêm danh mục"}",
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
                                linkImage: category != null &&
                                        category!.imageUrl != null
                                    ? category!.imageUrl!
                                    : "",
                                onChange: (image) {
                                  addCategoryController.image = image;
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
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                "Hiển thị danh mục ở trang chủ giao diện khách hàng",
                                maxLines: 1,
                              )),
                              Obx(
                                () => CupertinoSwitch(
                                  value: addCategoryController.isShowHome.value,
                                  onChanged: (bool value) {
                                    addCategoryController.isShowHome.value =
                                        !addCategoryController.isShowHome.value;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SahaButtonFullParent(
                  text: "${category != null ? "Sửa" : "Thêm"}",
                  onPressed: () {
                    if (sahaDataController.badgeUser.value.decentralization
                                ?.productCategoryUpdate !=
                            true &&
                        category != null) {
                      SahaAlert.showError(
                          message: "Bạn không có quyền sửa danh mục");
                      return;
                    }
                    if (_formKey.currentState!.validate()) {
                      addCategoryController.createCategory(
                        categoryId: category != null ? category!.id : null,
                        imageUrl: category != null ? category!.imageUrl : null,
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
            return addCategoryController.isLoadingAdd.value
                ? SahaLoadingFullScreen()
                : Container();
          })
        ],
      ),
    );
  }
}
