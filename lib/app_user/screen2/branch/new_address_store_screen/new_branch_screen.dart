import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/divide/divide.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/const/type_address.dart';
import 'package:com.ikitech.store/app_user/model/branch.dart';
import 'package:com.ikitech.store/app_user/model/location_address.dart';
import 'package:com.ikitech.store/app_user/screen2/choose_address/choose_address_screen.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'new_branch_controller.dart';

class NewStoreStoreScreen extends StatefulWidget {
  Branch? branchInput;
  bool? isWatch;
  Function? callBack;
  NewStoreStoreScreen({
    this.branchInput,
    this.isWatch,
    this.callBack,
  });

  @override
  _NewStoreStoreScreenState createState() => _NewStoreStoreScreenState();
}

class _NewStoreStoreScreenState extends State<NewStoreStoreScreen> {
  late NewStoreController newStoreController;
  @override
  void initState() {
    newStoreController = NewStoreController(
        branchInput: widget.branchInput, callBack: widget.callBack);
    super.initState();
  }

  String cast(String address) {
    var addressCast = address.replaceAll(" ", "+");
    return addressCast;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isWatch == true
              ? "Chi nhánh"
              : widget.branchInput == null
                  ? "Tạo chi nhánh mới"
                  : "Sửa chi nhánh"),
        ),
        body: Obx(
          () => Stack(
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      SahaDivide(),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Tên chi nhánh"),
                            Container(
                              width: Get.width * 0.5,
                              child: TextFormField(
                                controller: newStoreController
                                    .nameTextEditingController,
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.end,
                                validator: (value) {
                                  if (value!.length < 1) {
                                    return 'chưa nhập tên chi nhánh';
                                  }
                                  return null;
                                },
                                onChanged: (v) {
                                  newStoreController.branchRequest.value.name =
                                      v;
                                },
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    hintText: "Nhập tên chi nhánh"),
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
                                controller: newStoreController
                                    .phoneTextEditingController,
                                keyboardType: TextInputType.phone,
                                onChanged: (v) {
                                  newStoreController.branchRequest.value.phone =
                                      v;
                                },
                                validator: (value) {
                                  if (value!.length < 10) {
                                    return 'Số điện thoại không hợp lệ';
                                  }
                                  return null;
                                },
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
                      InkWell(
                        onTap: () {
                          Get.to(() => ChooseAddressScreen(
                                typeAddress: TypeAddress.Province,
                                callback: (LocationAddress location) {
                                  newStoreController.locationProvince.value =
                                      location;
                                  newStoreController.locationDistrict.value =
                                      new LocationAddress();
                                  newStoreController.locationWard.value =
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
                                      "${newStoreController.locationProvince.value.name ?? "Chọn Tỉnh/Thành phố"}")),
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
                                    idProvince: newStoreController
                                        .locationProvince.value.id,
                                    callback: (LocationAddress location) {
                                      newStoreController
                                          .locationDistrict.value = location;
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
                                          "${newStoreController.locationDistrict.value.name ?? "Chưa chọn Quận/Huyện"}")),
                                      Icon(Icons.arrow_forward_ios_rounded),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (newStoreController.locationProvince.value.id ==
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
                                    idDistrict: newStoreController
                                        .locationDistrict.value.id,
                                    callback: (LocationAddress location) {
                                      newStoreController.locationWard.value =
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
                                            "${newStoreController.locationWard.value.name ?? "Chưa chọn Phường/Xã"}"),
                                      ),
                                      Icon(Icons.arrow_forward_ios_rounded),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (newStoreController.locationDistrict.value.id ==
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
                                    controller: newStoreController
                                        .textEditingControllerAddressDetail,
                                    onFieldSubmitted: (v) {
                                      newStoreController.branchRequest.value
                                          .addressDetail = v;
                                    },
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
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text("Chi nhánh mặc định nhận hàng online"),
                            ),
                            Obx(
                              () => CupertinoSwitch(
                                value: newStoreController.branchRequest.value
                                        .isDefaultOrderOnline ??
                                    false,
                                onChanged: (bool value) {
                                  newStoreController.branchRequest.value
                                          .isDefaultOrderOnline =
                                      !(newStoreController.branchRequest.value
                                              .isDefaultOrderOnline ??
                                          false);
                                  newStoreController.branchRequest.refresh();
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
              newStoreController.isLoadingCreate.value
                  ? SahaLoadingFullScreen()
                  : Container(),
              if (widget.isWatch == true)
                Positioned.fill(
                    child: Container(
                  height: Get.height,
                  width: Get.width,
                  color: Colors.transparent,
                )),
            ],
          ),
        ),
        bottomNavigationBar: widget.isWatch == true
            ? Container(
                height: 0,
              )
            : Container(
                height: 65,
                color: Colors.white,
                child: Column(
                  children: [
                    SahaButtonFullParent(
                      text: widget.branchInput == null ? "TẠO" : "SỬA",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          if (widget.branchInput == null) {
                            newStoreController.addStore();
                          } else {
                            print("ssss");
                            newStoreController
                                .updateStore(widget.branchInput!.id ?? 0);
                          }
                        }
                      },
                      color: SahaColorUtils()
                          .colorPrimaryTextWithWhiteBackground(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
