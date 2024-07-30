import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/switch_button/switch_button.dart';
import 'package:com.ikitech.store/app_user/const/type_address.dart';
import 'package:com.ikitech.store/app_user/model/location_address.dart';
import 'package:com.ikitech.store/app_user/model/supplier.dart';
import 'package:com.ikitech.store/app_user/screen2/choose_address/choose_address_screen.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';

import 'add_suppliers_controller.dart';

class AddSuppliersScreen extends StatelessWidget {
  late AddSuppliersController addProviderController;
  Supplier? supplierInput;
  final _formKey = GlobalKey<FormState>();
  AddSuppliersScreen({this.supplierInput}) {
    addProviderController =
        AddSuppliersController(supplierInput: supplierInput);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              "${supplierInput != null ? "Chỉnh sửa nhà cung cấp" : "Thêm nhà cung cấp"}"),
        ),
        body: Obx(
          () => Stack(
            children: [
              SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tên nhà cung cấp"),
                            Container(
                              width: Get.width * 0.5,
                              child: TextFormField(
                                controller: addProviderController
                                    .nameTextEditingController,
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.end,
                                validator: (value) {
                                  if (value!.length < 1) {
                                    return 'chưa nhập tên nhà cung cấp';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "Nhập tên nhà cung cấp"),
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
                            Container(
                              width: Get.width * 0.5,
                              child: TextFormField(
                                controller: addProviderController
                                    .phoneTextEditingController,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.end,
                                validator: (value) {
                                  if (value!.length < 10) {
                                    return 'Số điện thoại không hợp lệ';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "Nhập số điện thoại"),
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
                          Get.to(() => ChooseAddressScreen(
                                typeAddress: TypeAddress.Province,
                                callback: (LocationAddress location) {
                                  addProviderController.locationProvince.value =
                                      location;
                                  addProviderController.locationDistrict.value =
                                      new LocationAddress();
                                  addProviderController.locationWard.value =
                                      new LocationAddress();
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
                                      "${addProviderController.locationProvince.value.name ?? "Chọn Tỉnh/Thành phố"}")),
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
                              Get.to(() => ChooseAddressScreen(
                                    typeAddress: TypeAddress.District,
                                    idProvince: addProviderController
                                        .locationProvince.value.id,
                                    callback: (LocationAddress location) {
                                      addProviderController
                                          .locationDistrict.value = location;
                                      addProviderController.locationWard.value =
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
                                  Text("Quận/Huyện"),
                                  Row(
                                    children: [
                                      Obx(() => Text(
                                          "${addProviderController.locationDistrict.value.name ?? "Chọn Quận/Huyện"}")),
                                      Icon(Icons.arrow_forward_ios_rounded),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (addProviderController.locationProvince.value.id ==
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
                              Get.to(() => ChooseAddressScreen(
                                    typeAddress: TypeAddress.Wards,
                                    idDistrict: addProviderController
                                        .locationDistrict.value.id,
                                    callback: (LocationAddress location) {
                                      addProviderController.locationWard.value =
                                          location;
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
                                            "${addProviderController.locationWard.value.name ?? "Chưa chọn Phường/Xã"}"),
                                      ),
                                      Icon(Icons.arrow_forward_ios_rounded),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (addProviderController.locationDistrict.value.id ==
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
                                  child: TextField(
                                    controller: addProviderController
                                        .addressDetailTextEditingController,
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
                        height: 12,
                        color: Colors.grey[200],
                      ),
                      if (supplierInput != null)
                        InkWell(
                          onTap: () {
                            SahaDialogApp.showDialogYesNo(
                                mess:
                                    "Bạn có chắc chắn muốn xoá nhà cung cấp này ?",
                                onOK: () {
                                  addProviderController.deleteSuppliers();
                                });
                          },
                          child: Container(
                            padding: EdgeInsets.all(13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Xóa nhà cung cấp",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
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
              addProviderController.isLoadingCreate.value
                  ? SahaLoadingFullScreen()
                  : Container()
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "LƯU",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (supplierInput != null) {
                      addProviderController.updateSuppliers();
                    } else {
                      addProviderController.createSuppliers();
                    }
                  }
                },
                color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
