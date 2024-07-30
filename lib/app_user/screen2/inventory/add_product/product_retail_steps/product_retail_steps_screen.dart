import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/text_field_with_border.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/add_product/product_retail_steps/product_retail_steps_controller.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

class ProductRetailStepsScreen extends StatelessWidget {
  ProductRetailStepsScreen(
      {Key? key,
      required this.onSubmit,
      required this.listProductRetailStep,
      required this.priceProduct})
      : super(key: key) {
    controller = ProductRetailStepsController(
        listProductRetailInput: listProductRetailStep);
  }
  final _formKey = GlobalKey<FormState>();
  List<ProductRetailStep> listProductRetailStep;
  Function onSubmit;
  final double priceProduct;

  late final ProductRetailStepsController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cài đặt mua nhiều giảm giá"),
      ),
      body: Obx(
        () => Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...controller.listProductRetailStep.map((e) =>
                    itemProductRetailStep(
                        e, controller.listProductRetailStep.indexOf(e)))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            controller.listProductRetailStep.add(ProductRetailStep());
          } else {
            SahaAlert.showError(message: "Có giá trị nhập chưa hợp lệ");
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  onSubmit(controller.listProductRetailStep.value);
                  Get.back();
                } else {
                  SahaAlert.showError(message: "Mời bạn nhập đủ thông tin");
                }
              },
              text: "Lưu",
            )
          ],
        ),
      ),
    );
  }

  Widget itemProductRetailStep(ProductRetailStep productRetailStep, int index) {
    if (index != 0) {
      controller.listProductRetailStep[index].fromQuantity =
          (controller.listProductRetailStep[index - 1].toQuantity ?? 0) + 1;
    }
    var fromQuantity = TextEditingController(
        text: controller.listProductRetailStep[index].fromQuantity == null
            ? ""
            : controller.listProductRetailStep[index].fromQuantity.toString());
    var toQuantity = TextEditingController(
        text: controller.listProductRetailStep[index].toQuantity == null
            ? ""
            : controller.listProductRetailStep[index].toQuantity.toString());
    var price = TextEditingController(
        text: controller.listProductRetailStep[index].price == null
            ? ""
            : controller.listProductRetailStep[index].price.toString());
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Khoảng giá ${index + 1}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    controller.listProductRetailStep.removeAt(index);
                  },
                  icon: Icon(
                    Icons.clear,
                    color: Colors.red,
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Từ:"),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  width: Get.width * 2 / 3,
                  child: TextFieldWithBorder(
                    labelText: "Số sản phẩm",
                    enabled: index == 0 ? true : false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: fromQuantity,
                    hintText: "Nhập số sản phẩm",
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Không được để trống';
                      }
                      if ((int.tryParse(v) ?? 0) <= 1 && index == 0) {
                        return 'Bạn phải nhập lớn hơn 1';
                      }
                      if (index != 0 &&
                          (int.tryParse(v) ?? 0) <=
                              (controller.listProductRetailStep[index - 1]
                                      .toQuantity ??
                                  0)) {
                        return 'Giá trị nhập không hợp lệ';
                      }
                      return null;
                    },
                    textInputType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (v) {
                      controller.listProductRetailStep[index].fromQuantity =
                          int.tryParse(v!);
                    },
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Đến:"),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  width: Get.width * 2 / 3,
                  child: TextFieldWithBorder(
                    labelText: "Số sản phẩm",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    hintText: "Nhập số sản phẩm",
                    controller: toQuantity,
                    textInputType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (v) {
                      controller.listProductRetailStep[index].toQuantity =
                          int.tryParse(v!);
                      controller.listProductRetailStep.refresh();
                    },
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Không được để trống';
                      }

                      if ((int.tryParse(v) ?? 0) <
                          (controller
                                  .listProductRetailStep[index].fromQuantity ??
                              0)) {
                        return 'Giá trị nhập không hợp lệ';
                      }
                      return null;
                    },
                  ))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Đơn giá:"),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                  width: Get.width * 2 / 3,
                  child: TextFieldWithBorder(
                    labelText: "Đơn giá",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Không được để trống';
                      }
                      if (index == 0 &&
                          (double.tryParse(v) ?? 0) >= priceProduct) {
                        return "Giá phải nhỏ hơn giá lẻ";
                      }

                      if (index != 0 &&
                          (double.tryParse(v) ?? 0) >=
                              (controller
                                      .listProductRetailStep[index - 1].price ??
                                  0)) {
                        return 'Giá trị nhập không hợp lệ';
                      }
                      return null;
                    },
                    controller: price,
                    hintText: "Nhập đơn giá",
                    inputFormatters: [ThousandsFormatter()],
                    textInputType:
                        TextInputType.number,
                    onChanged: (v) {
                      controller.listProductRetailStep[index].price =
                          double.tryParse(
                              SahaStringUtils().convertFormatText(v));
                    },
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
