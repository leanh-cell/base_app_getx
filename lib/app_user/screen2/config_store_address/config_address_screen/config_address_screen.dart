import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/switch_button/switch_button.dart';
import 'package:com.ikitech.store/app_user/const/type_address.dart';
import 'package:com.ikitech.store/app_user/model/info_address.dart';
import 'package:com.ikitech.store/app_user/screen2/choose_address/choose_address_screen.dart';

import '../../../model/location_address.dart';
import 'config_address_controller.dart';

class ConfigAddressStoreScreen extends StatelessWidget {
  final InfoAddress? infoAddress;

  ConfigAddressStoreScreen({this.infoAddress}){
    configAddressController = new ConfigAddressController(infoAddress);
  }

  late ConfigAddressController configAddressController;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sửa địa chỉ"),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: _formKey,
            child: Column(
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
                          controller:
                              configAddressController.nameTextEditingController,
                          textAlign: TextAlign.end,
                          validator: (value) {
                            if (value!.length <= 0) {
                              return 'Chưa nhập Họ và tên';
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
                          controller: configAddressController
                              .phoneTextEditingController,
                          textAlign: TextAlign.end,
                          validator: (value) {
                            if (value!.length != 10) {
                              return 'Số điện thoại không hợp lệ';
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
                InkWell(
                  onTap: () {
                    Get.to(() => ChooseAddressScreen(
                          typeAddress: TypeAddress.Province,
                          callback: (LocationAddress location) {
                            configAddressController.locationProvince.value =
                                location;
                            configAddressController.locationDistrict.value =
                                new LocationAddress();
                            configAddressController.locationWard.value =
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
                                "${configAddressController.locationProvince.value.name ?? "Chưa chọn Tỉnh/Thành phố"}")),
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
                          Get.to(() => ChooseAddressScreen(
                                typeAddress: TypeAddress.District,
                                idProvince: configAddressController
                                    .locationProvince.value.id,
                                callback: (LocationAddress location) {
                                  configAddressController
                                      .locationDistrict.value = location;
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
                                  Obx(() => Text(
                                      "${configAddressController.locationDistrict.value.name ?? "Chưa chọn Quận/Huyện"}")),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (configAddressController.locationProvince.value.id ==
                          null)
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
                          Get.to(() => ChooseAddressScreen(
                                typeAddress: TypeAddress.Wards,
                                idDistrict: configAddressController
                                    .locationDistrict.value.id,
                                callback: (LocationAddress location) {
                                  configAddressController.locationWard.value =
                                      location;
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
                                        "${configAddressController.locationWard.value.name ?? "Chưa chọn Phường/Xã"}"),
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (configAddressController.locationDistrict.value.id ==
                          null)
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
                              controller: configAddressController
                                  .addressDetailTextEditingController,
                              validator: (value) {
                                if (value!.length <= 0) {
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
                  height: 12,
                  color: Colors.grey[200],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Đặt làm địa chỉ lấy hàng"),
                      Obx(
                        () => CustomSwitch(
                          value: configAddressController.isDefaultPickup.value,
                          onChanged: (bool val) {
                            configAddressController.isDefaultPickup.value = val;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Đặt làm địa chỉ trả hàng"),
                      Obx(
                        () => CustomSwitch(
                          value: configAddressController.isDefaultReturn.value,
                          onChanged: (bool val) {
                            configAddressController.isDefaultReturn.value = val;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                // Container(
                //   height: 12,
                //   color: Colors.grey[200],
                // ),
                // InkWell(
                //   onTap: () {},
                //   child: Container(
                //     padding: EdgeInsets.all(10),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Row(
                //           children: [
                //             Container(
                //               padding: EdgeInsets.all(6),
                //               height: 40,
                //               width: 40,
                //               child: SvgPicture.asset("assets/icons/pin.svg",
                //                   color: Theme.of(context).primaryColor),
                //             ),
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Chọn vị trí trên bản đồ"),
                //                 SizedBox(
                //                   height: 3,
                //                 ),
                //                 Text(
                //                   "Giúp đơn hàng được giao nhanh nhất",
                //                   style: TextStyle(
                //                     color: Colors.grey[700],
                //                     fontSize: 12,
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ],
                //         ),
                //         Icon(Icons.arrow_forward_ios_rounded),
                //       ],
                //     ),
                //   ),
                // ),
                Container(
                  height: 12,
                  color: Colors.grey[200],
                ),
                InkWell(
                  onTap: () {
                    configAddressController.deleteAddressStore();
                  },
                  child: Container(
                    padding: EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Xóa Địa chỉ",
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
        bottomNavigationBar: Container(
          height: 80,
          color: Colors.white,
          child: Column(
            children: [
              Obx(
                () => configAddressController.isLoadingUpdate.value == false
                    ? SahaButtonFullParent(
                        text: "LƯU",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            configAddressController.updateAddressStore();
                          }
                        },
                        color: Theme.of(context).primaryColor,
                      )
                    : IgnorePointer(
                        child: SahaButtonFullParent(
                          text: "Lưu",
                          textColor: Colors.grey[600],
                          onPressed: () {},
                          color: Colors.grey[300],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
