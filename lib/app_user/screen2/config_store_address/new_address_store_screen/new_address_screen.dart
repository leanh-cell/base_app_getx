import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/switch_button/switch_button.dart';
import 'package:com.ikitech.store/app_user/const/type_address.dart';
import 'package:com.ikitech.store/app_user/screen2/choose_address/choose_address_screen.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';

import '../../../model/location_address.dart';
import 'new_address_controller.dart';

class NewAddressStoreScreen extends StatefulWidget {
  @override
  _NewAddressStoreScreenState createState() => _NewAddressStoreScreenState();
}

class _NewAddressStoreScreenState extends State<NewAddressStoreScreen> {
  late NewAddressController newAddressController;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    newAddressController = new NewAddressController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Địa chỉ mới"),
      ),
      body: Form(
        key: _formKey,
        child: Obx(
          () => Stack(
            children: [
              SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
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
                              controller: newAddressController
                                  .nameTextEditingController,
                              validator: (value) {
                                if (value!.length <= 0) {
                                  return 'Chưa nhập họ và tên';
                                }
                                return null;
                              },
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Điền Họ và tên"),
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
                              validator: (value) {
                                if (value!.length != 10) {
                                  return 'Số điện thoại không hợp lệ';
                                }
                                return null;
                              },
                              controller: newAddressController
                                  .phoneTextEditingController,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Điền Số điện thoại"),
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
                                newAddressController.locationProvince.value =
                                    location;
                                newAddressController.locationDistrict.value =
                                    new LocationAddress();
                                newAddressController.locationWard.value =
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
                                    "${newAddressController.locationProvince.value.name ?? "Điền Tỉnh/Thành phố"}")),
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
                                  idProvince: newAddressController
                                      .locationProvince.value.id,
                                  callback: (LocationAddress location) {
                                    newAddressController
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
                                        "${newAddressController.locationDistrict.value.name ?? "Điền Quận/Huyện"}")),
                                    Icon(Icons.arrow_forward_ios_rounded),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (newAddressController.locationProvince.value.id ==
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
                                  idDistrict: newAddressController
                                      .locationDistrict.value.id,
                                  callback: (LocationAddress location) {
                                    newAddressController.locationWard.value =
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
                                          "${newAddressController.locationWard.value.name ?? "Chưa chọn Phường/Xã"}"),
                                    ),
                                    Icon(Icons.arrow_forward_ios_rounded),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (newAddressController.locationDistrict.value.id ==
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
                                  controller: newAddressController
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
                          Text("Đặt làm địa chỉ mặc định"),
                          Obx(
                            () => CustomSwitch(
                              value: newAddressController.isDefaultPickup.value,
                              onChanged: (bool val) {
                                newAddressController.isDefaultPickup.value =
                                    val;
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
                              value: newAddressController.isDefaultReturn.value,
                              onChanged: (bool val) {
                                newAddressController.isDefaultReturn.value =
                                    val;
                              },
                            ),
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
              newAddressController.isLoadingCreate.value
                  ? SahaLoadingFullScreen()
                  : Container()
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
              text: "CHỌN",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  newAddressController.createAddressStore();
                }
              },
              color: SahaColorUtils().colorPrimaryTextWithWhiteBackground(),
            ),
          ],
        ),
      ),
    );
  }
}
