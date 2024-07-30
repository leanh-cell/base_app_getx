import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/screen2/home/confirm_screen/choose_address_receiver/receiver_address_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:sahashop_customer/app_customer/model/info_address_customer.dart';
import '../../../../components/saha_user/button/saha_button.dart';
import '../../../../model/location_address.dart';
import '../../choose_address/choose_address_customer_screen/choose_address_customer_controller.dart';
import '../../choose_address/choose_address_customer_screen/choose_address_customer_screen.dart';

class ConfigAddressCustomerScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String phoneCustomer;
  late TextEditingController nameTextEditingController =
      TextEditingController(text: "");
  late TextEditingController phoneTextEditingController =
      TextEditingController(text: "");
  late TextEditingController addressDetailTextEditingController =
      TextEditingController(text: "");

  HomeController homeController = Get.find();
  late ReceiverAddressCustomerController chooseAddressCustomerController;
  ConfigAddressCustomerScreen({required this.phoneCustomer}) {
    chooseAddressCustomerController =
        ReceiverAddressCustomerController(phone: phoneCustomer);
    nameTextEditingController = TextEditingController(
        text: "${homeController.cartCurrent.value.customerName ?? ""}");
    phoneTextEditingController = TextEditingController(
        text: "${homeController.cartCurrent.value.customerPhone ?? ""}");
    addressDetailTextEditingController = TextEditingController(
        text: "${homeController.cartCurrent.value.addressDetail ?? ""}");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sửa địa chỉ giao hàng"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Họ và tên"),
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(fontSize: 14),
                        controller: nameTextEditingController,
                        textAlign: TextAlign.end,
                        validator: (value) {
                          if (value!.length < 1) {
                            return 'Chưa nhập họ và tên';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        minLines: 1,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Số điện thoại"),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: 14),
                        validator: (value) {
                          if (value!.length != 10) {
                            return 'Số điện thoại không hợp lệ';
                          }
                          return null;
                        },
                        controller: phoneTextEditingController,
                        textAlign: TextAlign.end,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                        minLines: 1,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ChooseAddressCustomerScreen(
                        typeAddress: TypeAddress.Province,
                        callback: (LocationAddress location) {
                          homeController.cartCurrent.value.province =
                              location.id;
                          homeController.cartCurrent.value.provinceName =
                              location.name;
                          homeController.cartCurrent.value.district = null;
                          homeController.cartCurrent.value.districtName = null;
                          homeController.cartCurrent.value.wards = null;
                          homeController.cartCurrent.value.wardsName = null;
                          homeController.cartCurrent.refresh();
                        },
                      ));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tỉnh/Thành phố"),
                      Row(
                        children: [
                          Obx(() => Text(
                              "${homeController.cartCurrent.value.provinceName ?? "Chưa chọn Tỉnh/Thành phố"}")),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1,
              ),
              Obx(
                () => Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => ChooseAddressCustomerScreen(
                              typeAddress: TypeAddress.District,
                              idProvince:
                                  homeController.cartCurrent.value.province ??
                                      0,
                              callback: (LocationAddress location) {
                                homeController.cartCurrent.value.district =
                                    location.id;
                                homeController.cartCurrent.value.districtName =
                                    location.name;
                                homeController.cartCurrent.refresh();
                              },
                            ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Quận/Huyện"),
                            Row(
                              children: [
                                Obx(
                                  () => Text(
                                      "${homeController.cartCurrent.value.districtName ?? "Chưa chọn Quận/Huyện"}"),
                                ),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (homeController.cartCurrent.value.province == null)
                      Positioned.fill(
                          child: Container(
                        color: Colors.grey[200]!.withOpacity(0.5),
                      ))
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Obx(
                () => Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => ChooseAddressCustomerScreen(
                              typeAddress: TypeAddress.Wards,
                              idDistrict:
                                  homeController.cartCurrent.value.district ??
                                      0,
                              callback: (LocationAddress location) {
                                homeController.cartCurrent.value.wards =
                                    location.id;
                                homeController.cartCurrent.value.wardsName =
                                    location.name;
                                homeController.cartCurrent.refresh();
                              },
                            ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Phường/Xã"),
                            Row(
                              children: [
                                Obx(
                                  () => Text(
                                      "${homeController.cartCurrent.value.wardsName ?? "Chưa chọn Phường/Xã"}"),
                                ),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (homeController.cartCurrent.value.district == null)
                      Positioned.fill(
                          child: Container(
                        color: Colors.grey[200]!.withOpacity(0.5),
                      ))
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Địa chỉ cụ thể"),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Số nhà, tên tòa nhà, tên đường, tên khu vực",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: Get.width * 0.9,
                          child: TextFormField(
                            controller: addressDetailTextEditingController,
                            validator: (value) {
                              if (value!.length < 1) {
                                return 'Chưa nhập địa chỉ cụ thể';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Nhập địa chỉ cụ thể",
                            ),
                            minLines: 1,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 80,
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SahaButtonFullParent(
                      text: "LƯU",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (homeController.cartCurrent.value.wards != null) {
                            homeController.cartCurrent.value.customerName =
                                nameTextEditingController.text;
                            homeController.cartCurrent.value.customerPhone =
                                phoneTextEditingController.text;
                            homeController.cartCurrent.value.addressDetail =
                                addressDetailTextEditingController.text;
                            homeController.updateInfoCart();
                            Get.back();
                          }
                        }
                      },
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              Container(
                height: 12,
                color: Colors.grey[200],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
