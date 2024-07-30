import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/model/location_address.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';
import 'choose_address_customer_screen/choose_address_customer_controller.dart';
import 'choose_address_customer_screen/choose_address_customer_screen.dart';
import 'new_customer_sale_controller.dart';

class NewCustomerSaleScreen extends StatefulWidget {
  InfoCustomer? infoCustomer;
  String? infoSearch;
  NewCustomerSaleScreen({this.infoCustomer, this.infoSearch});

  @override
  _NewCustomerSaleScreenState createState() => _NewCustomerSaleScreenState();
}

class _NewCustomerSaleScreenState extends State<NewCustomerSaleScreen> {
  HomeController homeController = Get.find();
  late NewCustomerSaleController newCustomerController;
  final _formKey = GlobalKey<FormState>();
  FocusNode nodeName = FocusNode();
  FocusNode nodeNumber = FocusNode();

  @override
  void initState() {
    newCustomerController =
        new NewCustomerSaleController(infoCustomerInput: widget.infoCustomer);
    if (widget.infoSearch != null) {
      if (int.tryParse(widget.infoSearch!) != null) {
        newCustomerController.phoneTextEditingController.text =
            widget.infoSearch!.toString();
        nodeNumber.requestFocus();
      } else {
        newCustomerController.nameTextEditingController.text =
            widget.infoSearch!;
        nodeName.requestFocus();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Khách hàng"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Số điện thoại"),
                      Expanded(
                        child: TextFormField(
                          focusNode: nodeNumber,
                          controller:
                              newCustomerController.phoneTextEditingController,
                          validator: (value) {
                            if (value!.length != 10) {
                              return 'Số điện thoại không hợp lệ';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Nhập Số điện thoại"),
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
                      Text("Họ và tên"),
                      Expanded(
                        child: TextFormField(
                          focusNode: nodeName,
                          controller:
                              newCustomerController.nameTextEditingController,
                          style: TextStyle(fontSize: 14),
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
                              hintText: "Nhập Họ và tên"),
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
                      Text("Email"),
                      Expanded(
                        child: TextFormField(
                          controller:
                              newCustomerController.emailTextEditingController,
                          validator: (value) {
                            if ((value?.length ?? 0) == 0) {
                              return null;
                            } else {
                              if (GetUtils.isEmail(value ?? "")) {
                                return null;
                              } else {
                                return 'Email không hợp lệ';
                              }
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Nhập Email"),
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
                Obx(() => newCustomerController.isShowAddress.value
                    ? Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => ChooseAddressCustomerScreen(
                                    typeAddress: TypeAddress.Province,
                                    callback: (LocationAddress location) {
                                      newCustomerController
                                          .locationProvince.value = location;
                                      newCustomerController.locationDistrict
                                          .value = new LocationAddress();
                                      newCustomerController.locationWard.value =
                                          new LocationAddress();
                                    },
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Tỉnh/Thành phố"),
                                  Row(
                                    children: [
                                      Obx(() => Text(
                                          "${newCustomerController.locationProvince.value.name ?? "Chọn Tỉnh/Thành phố"}")),
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
                          Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => ChooseAddressCustomerScreen(
                                        typeAddress: TypeAddress.District,
                                        idProvince: newCustomerController
                                                .locationProvince.value.id ??
                                            0,
                                        callback: (LocationAddress location) {
                                          newCustomerController.locationDistrict
                                              .value = location;
                                          newCustomerController.locationWard
                                              .value = new LocationAddress();
                                        },
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Quận/Huyện"),
                                      Row(
                                        children: [
                                          Obx(() => Text(
                                              "${newCustomerController.locationDistrict.value.name ?? "Chưa chọn Quận/Huyện"}")),
                                          Icon(Icons.arrow_forward_ios_rounded),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (newCustomerController
                                      .locationProvince.value.id ==
                                  null)
                                Positioned.fill(
                                    child: Container(
                                  color: Colors.grey[200]!.withOpacity(0.5),
                                ))
                            ],
                          ),
                          Divider(
                            height: 1,
                          ),
                          Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => ChooseAddressCustomerScreen(
                                        typeAddress: TypeAddress.Wards,
                                        idDistrict: newCustomerController
                                                .locationDistrict.value.id ??
                                            0,
                                        callback: (LocationAddress location) {
                                          newCustomerController
                                              .locationWard.value = location;
                                        },
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Phường/Xã"),
                                      Row(
                                        children: [
                                          Obx(
                                            () => Text(
                                                "${newCustomerController.locationWard.value.name ?? "Chưa chọn Phường/Xã"}"),
                                          ),
                                          Icon(Icons.arrow_forward_ios_rounded),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (newCustomerController
                                      .locationDistrict.value.id ==
                                  null)
                                Positioned.fill(
                                    child: Container(
                                  color: Colors.grey[200]!.withOpacity(0.5),
                                ))
                            ],
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
                                      "(Số nhà, tên tòa nhà, tên đường, tên khu vực)",
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
                                        controller: newCustomerController
                                            .addressDetailTextEditingController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "Nhập địa chỉ cụ thể",
                                        ),
                                        validator: (value) {
                                          if (value!.length <= 0) {
                                            return 'Chưa nhập địa chỉ cụ thể';
                                          }
                                          return null;
                                        },
                                        minLines: 1,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              newCustomerController.isShowAddress.value = false;
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    "Thu gọn",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_up_rounded,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    : InkWell(
                        onTap: () {
                          newCustomerController.isShowAddress.value = true;
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text(
                                "Thêm thông tin địa chỉ",
                                style: TextStyle(color: Colors.blue),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "LƯU",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.infoCustomer != null) {
                      await newCustomerController.updateCustomer();
                    } else {
                      await newCustomerController.addCustomer();
                    }
                  }
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
