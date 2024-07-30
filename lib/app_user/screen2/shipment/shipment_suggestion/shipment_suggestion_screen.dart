import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';

import '../../../components/saha_user/empty/saha_empty_image.dart';
import '../../../components/saha_user/loading/loading_container.dart';
import '../../../components/saha_user/popup/popup_input.dart';
import '../../../components/saha_user/popup/popup_keyboard.dart';
import '../../../data/remote/response-request/address/shipment_calculate_res.dart';
import '../../../utils/string_utils.dart';
import '../../config_store_address/all_store_address/all_address_store_screen.dart';
import '../../config_store_address/new_address_store_screen/new_address_screen.dart';
import '../../home/confirm_screen/confirm_controller.dart';
import 'shipment_suggestion_controller.dart';

class ShipmentSuggestion extends StatelessWidget {
  ShipmentSuggestionController shipmentSuggestionController =
      ShipmentSuggestionController();
  HomeController homeController = Get.find();
   ConfirmUserController confirmController = Get.find();
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Phí dự kiến"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            itemInfo(),
            Obx(
              () =>
                  shipmentSuggestionController.listShipmentCalculate.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              height: 1,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              height: 10,
                              color: Colors.grey[200],
                            ),
                            Text(
                              "   Phí dự kiến trả đối tác",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: shipmentSuggestionController
                                    .listShipmentCalculate
                                    .map((e) => itemShipment(e))
                                    .toList(),
                              ),
                            ),
                          ],
                        )
                      : shipmentSuggestionController.isLoadingCal.value
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                SahaLoadingWidget(
                                  size: 20,
                                ),
                              ],
                            )
                          : Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.red.withOpacity(0.05),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.warning_rounded,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Vui lòng nhập đầy đủ thông tin địa chỉ giao hàng để lựa chọn đơn vị vận chuyển."),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            PopupKeyboard()
                                                .showDialogAddressChoose(
                                              callback: (v) {
                                                shipmentSuggestionController
                                                    .locationProvince.value = v;
                                                Get.back();
                                                PopupKeyboard()
                                                    .showDialogAddressChoose(
                                                  idProvince:
                                                      shipmentSuggestionController
                                                          .locationProvince
                                                          .value
                                                          .id,
                                                  callback: (v) {
                                                    shipmentSuggestionController
                                                        .locationDistrict
                                                        .value = v;
                                                    Get.back();
                                                    PopupKeyboard()
                                                        .showDialogAddressChoose(
                                                      idDistrict:
                                                          shipmentSuggestionController
                                                              .locationDistrict
                                                              .value
                                                              .id,
                                                      callback: (v) {
                                                        shipmentSuggestionController
                                                            .locationWard
                                                            .value = v;
                                                        Get.back();
                                                        PopupInput()
                                                            .showDialogInputNote(
                                                                height: 50,
                                                                confirm: (v) {
                                                                  if (v ==
                                                                          null ||
                                                                      v == "") {
                                                                    SahaAlert.showToastMiddle(
                                                                        message:
                                                                            "Vui lòng nhập địa chỉ chi tiết");
                                                                  } else {
                                                                    shipmentSuggestionController
                                                                        .req
                                                                        .value
                                                                        .receiverAddress = v;
                                                                    shipmentSuggestionController
                                                                        .req
                                                                        .refresh();
                                                                    shipmentSuggestionController
                                                                        .getData();
                                                                  }
                                                                },
                                                                title:
                                                                    "Địa chỉ chi tiết",
                                                                textInput:
                                                                    "${shipmentSuggestionController.req.value.receiverAddress ?? ""}");
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            "Thêm địa chỉ",
                                            style: TextStyle(
                                              color: Colors.blue,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
            )
          ],
        ),
      ),
    );
  }

  Widget itemInfo() {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Thông tin giao hàng",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              if (shipmentSuggestionController
                      .addressStore.value.addressDetail ==
                  null) {
                Get.to(() => NewAddressStoreScreen())!.then((value) => {
                      shipmentSuggestionController
                          .getAllAddressStore()
                          .then((value) => {
                                shipmentSuggestionController
                                    .getAllShipmentStore()
                                    .then((value) => {
                                          if (shipmentSuggestionController
                                                  .req.value.senderAddress !=
                                              null)
                                            {
                                              shipmentSuggestionController
                                                  .getData()
                                            }
                                        })
                              })
                    });
              } else {
                Get.to(() => AllAddressStoreScreen())!.then((value) => {
                      shipmentSuggestionController
                          .getAllAddressStore()
                          .then((value) => {
                                shipmentSuggestionController
                                    .getAllShipmentStore()
                                    .then((value) => {
                                          if (shipmentSuggestionController
                                                  .req.value.senderAddress !=
                                              null)
                                            {
                                              shipmentSuggestionController
                                                  .getData()
                                            }
                                        })
                              })
                    });
              }
            },
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Địa chỉ lấy hàng",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => shipmentSuggestionController
                                  .isLoadingAddress.value
                              ? SahaLoadingWidget(
                                  size: 15,
                                )
                              : shipmentSuggestionController
                                          .addressStore.value.addressDetail ==
                                      null
                                  ? Text(
                                      "Chưa thiết lập địa chỉ lấy hàng",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  : Text(
                                      "${shipmentSuggestionController.addressStore.value.addressDetail ?? ""} ${shipmentSuggestionController.addressStore.value.addressDetail == null ? "" : "-"} ${shipmentSuggestionController.addressStore.value.wardsName} - ${shipmentSuggestionController.addressStore.value.districtName} - ${shipmentSuggestionController.addressStore.value.provinceName}"),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          InkWell(
            onTap: () {
              PopupKeyboard().showDialogAddressChoose(
                callback: (v) {
                  shipmentSuggestionController.locationProvince.value = v;
                  Get.back();
                  PopupKeyboard().showDialogAddressChoose(
                    idProvince:
                        shipmentSuggestionController.locationProvince.value.id,
                    callback: (v) {
                      shipmentSuggestionController.locationDistrict.value = v;
                      Get.back();
                      PopupKeyboard().showDialogAddressChoose(
                        idDistrict: shipmentSuggestionController
                            .locationDistrict.value.id,
                        callback: (v) {
                          shipmentSuggestionController.locationWard.value = v;
                          Get.back();
                          PopupInput().showDialogInputNote(
                              height: 50,
                              confirm: (v) {
                                if (v == null || v == "") {
                                  SahaAlert.showToastMiddle(
                                      message:
                                          "Vui lòng nhập địa chỉ chi tiết");
                                } else {
                                  shipmentSuggestionController
                                      .req.value.receiverAddress = v;
                                  shipmentSuggestionController.req.refresh();
                                  if (shipmentSuggestionController
                                              .req.value.receiverAddress !=
                                          null &&
                                      shipmentSuggestionController
                                              .req.value.receiverAddress !=
                                          "" &&
                                      shipmentSuggestionController
                                              .req.value.length !=
                                          0 &&
                                      shipmentSuggestionController.req.value.width !=
                                          0 &&
                                      shipmentSuggestionController
                                              .req.value.height !=
                                          0 &&
                                      shipmentSuggestionController
                                              .req.value.weight !=
                                          0) {
                                    shipmentSuggestionController.getData();
                                  }
                                }
                              },
                              title: "Địa chỉ chi tiết",
                              textInput:
                                  "${shipmentSuggestionController.req.value.receiverAddress ?? ""}");
                        },
                      );
                    },
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => shipmentSuggestionController
                                      .req.value.receiverAddress ==
                                  null
                              ? Text(
                                  "*Cần nhập địa chỉ cụ thể",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.red,
                                  ),
                                )
                              : Text(
                                  "Địa chỉ giao hàng",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Obx(() {
                          var province =
                              shipmentSuggestionController.locationProvince;
                          var district =
                              shipmentSuggestionController.locationDistrict;
                          var ward = shipmentSuggestionController.locationWard;
                          return shipmentSuggestionController
                                      .req.value.receiverAddress ==
                                  null
                              ? Text(
                                  "Địa chỉ giao hàng",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                )
                              : Text(
                                  "${shipmentSuggestionController.req.value.receiverAddress} - ${ward.value.name} - ${district.value.name} - ${province.value.name}");
                        }),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          InkWell(
            onTap: () {
              PopupKeyboard().showDialogInputKeyboard(
                  numberInput:
                      "${SahaStringUtils().convertToMoney(shipmentSuggestionController.req.value.moneyCollection ?? 0)}",
                  title: "Thu hộ COD",
                  confirm: (number) {
                    shipmentSuggestionController.req.value.moneyCollection =
                        number;
                    confirmController.cod = number;
                    
                    shipmentSuggestionController.req.refresh();
                  });
            },
            child: Container(
              padding: EdgeInsets.only(top: 13, bottom: 13),
              child: Row(
                children: [
                  Text("Thu hộ COD"),
                  Spacer(),
                  Obx(
                    () => Text(
                      "${SahaStringUtils().convertToMoney(shipmentSuggestionController.req.value.moneyCollection ?? 0)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          InkWell(
            onTap: () {
              PopupKeyboard().showDialogInputKeyboard(
                  numberInput:
                      "${SahaStringUtils().convertToMoney(shipmentSuggestionController.req.value.weight ?? 0)}",
                  title: "Khối lượng (g)",
                  confirm: (number) {
                    if (number == 0) {
                      SahaAlert.showToastMiddle(
                          message: "Khối lượng không nhỏ hơn 1");
                    } else {
                      shipmentSuggestionController.req.value.weight = number;
                      shipmentSuggestionController.req.refresh();
                    }

                    if (shipmentSuggestionController
                                .req.value.receiverAddress !=
                            null &&
                        shipmentSuggestionController
                                .req.value.receiverAddress !=
                            "" &&
                        shipmentSuggestionController.req.value.length != 0 &&
                        shipmentSuggestionController.req.value.width != 0 &&
                        shipmentSuggestionController.req.value.height != 0 &&
                        shipmentSuggestionController.req.value.weight != 0) {
                      shipmentSuggestionController.getData();
                    }
                  });
            },
            child: Container(
              padding: EdgeInsets.only(top: 13, bottom: 13),
              child: Row(
                children: [
                  Text("Khối lượng (g)"),
                  Spacer(),
                  Obx(() => Text(
                        "${SahaStringUtils().convertToMoney(shipmentSuggestionController.req.value.weight ?? 0)}",
                      )),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          InkWell(
            onTap: () {
              PopupInput().showDialogInputSizeProduct(
                  length: shipmentSuggestionController.req.value.length,
                  width: shipmentSuggestionController.req.value.width,
                  height: shipmentSuggestionController.req.value.height,
                  confirm: (length, width, height) {
                    print(length);
                    shipmentSuggestionController.req.value.length = length;
                    shipmentSuggestionController.req.value.width = width;
                    shipmentSuggestionController.req.value.height = height;
                    shipmentSuggestionController.req.refresh();
                    if (shipmentSuggestionController
                                .req.value.receiverAddress !=
                            null &&
                        shipmentSuggestionController
                                .req.value.receiverAddress !=
                            "" &&
                        shipmentSuggestionController.req.value.length != 0 &&
                        shipmentSuggestionController.req.value.width != 0 &&
                        shipmentSuggestionController.req.value.height != 0 &&
                        shipmentSuggestionController.req.value.weight != 0) {
                      shipmentSuggestionController.getData();
                    }
                  });
            },
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Kích thước (cm)"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "(dài x rộng x cao)",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      )
                    ],
                  ),
                  Spacer(),
                  Obx(
                    () => Text(
                        "${shipmentSuggestionController.req.value.length ?? 0} x ${shipmentSuggestionController.req.value.width ?? 0} x ${shipmentSuggestionController.req.value.height ?? 0}"),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget itemShipment(ShipmentCalculate shipmentCalculate) {
    return InkWell(
      onTap: () {
        SahaDialogApp.showDialogYesNo(
            mess:
                "Thao tác sẽ thay đổi địa chỉ giao hàng\nBạn vẫn muốn tiếp tục",
            onOK: () {
              homeController.cartCurrent.value.totalShippingFee =
                  shipmentCalculate.fee;
              homeController.cartCurrent.refresh();
              homeController.updateInfoCart();
              var info = shipmentSuggestionController.req.value;
              homeController.cartCurrent.value.province =
                  info.receiverProvinceId;
              homeController.cartCurrent.value.district =
                  info.receiverDistrictId;
              homeController.cartCurrent.value.wards = info.receiverWardsId;
              homeController.cartCurrent.value.addressDetail =
                  info.receiverAddress;
              homeController.updateInfoCart();

              Get.back();
              Get.back();
            });
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Row(
              children: [
                Icon(
                  Icons.circle_outlined,
                  size: 18,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                CachedNetworkImage(
                  width: 60,
                  height: 50,
                  fit: BoxFit.fitWidth,
                  imageUrl: shipmentCalculate.imageUrl ?? "",
                  placeholder: (context, url) => SahaLoadingContainer(),
                  errorWidget: (context, url, error) => SahaEmptyImage(),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${shipmentCalculate.name ?? ""}"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${shipmentCalculate.description ?? ""}",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${SahaStringUtils().convertToMoney(shipmentCalculate.fee ?? 0)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
