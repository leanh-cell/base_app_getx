import 'package:com.ikitech.store/app_user/screen2/config_store_address/login_shipping_company/login_shipping_company_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/switch_button/switch_button.dart';
import 'package:com.ikitech.store/app_user/model/shipment.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import '../../../saha_data_controller.dart';
import 'all_store_address/all_address_store_screen.dart';
import 'config_store_address_controller.dart';
import 'input_token_shipment_screen/add_token_shipment_screen.dart';
import 'list_urban_provice/list_urban_province_screen.dart';

class ConfigStoreAddressScreen extends StatelessWidget {
  ConfigStoreAddressController configStoreAddressController =
      ConfigStoreAddressController();
  SahaDataController sahaDataController = Get.find();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("Cài đặt vận chuyển shop"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DecentralizationWidget(
                    decent: sahaDataController.badgeUser.value.decentralization
                            ?.deliveryPickAddressList ??
                        false,
                    child: InkWell(
                      onTap: () {
                        Get.to(() => AllAddressStoreScreen())!.then((value) =>
                            {configStoreAddressController.refreshData()});
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SahaSimmer(
                              isLoading: configStoreAddressController
                                  .isLoadingAddress.value,
                              child: Container(
                                width: Get.width * 0.8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Địa chỉ lấy hàng',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      configStoreAddressController
                                              .listAddressStore
                                              .value
                                              .addressDetail ??
                                          "Chưa có địa chỉ chi tiết",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      configStoreAddressController
                                              .listAddressStore
                                              .value
                                              .districtName ??
                                          "Chưa có Quận/Huyện",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      configStoreAddressController
                                              .listAddressStore
                                              .value
                                              .wardsName ??
                                          "Chưa có Phường/Xã",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      configStoreAddressController
                                              .listAddressStore
                                              .value
                                              .provinceName ??
                                          "Chưa có Tỉnh/Thành phố",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 13,
                              width: 13,
                              child: SvgPicture.asset(
                                "assets/icons/right_arrow.svg",
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            height: 13,
                            width: 13,
                            child: SvgPicture.asset(
                              "assets/icons/bell.svg",
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                                "Vui lòng lựa chọn đơn vị vận chuyển mà bạn muốn kích hoạt cho Shop."),
                          )
                        ],
                      ),
                    ),
                  ),
                  ...List.generate(
                      configStoreAddressController.listShipmentStore.length,
                      (index) {
                    return itemShipment(index);
                  }),
                  Container(
                    height: 8,
                    color: Colors.grey[200],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Cài đặt phí ship",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text("Cho phép tính ship khi mua hàng"),
                        ),
                        Obx(
                          () => CupertinoSwitch(
                            value: configStoreAddressController
                                    .shipConfig.value.isCalculateShip ??
                                false,
                            onChanged: (bool value) {
                              configStoreAddressController
                                      .shipConfig.value.isCalculateShip =
                                  !(configStoreAddressController
                                          .shipConfig.value.isCalculateShip ??
                                      false);
                              configStoreAddressController.shipConfig.refresh();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Obx(
                    () => configStoreAddressController
                                .shipConfig.value.isCalculateShip ??
                            false
                        ? Column(
                            children: [
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(10),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "Sử dụng phí vận chuyển từ đv vận chuyển"),
                                    ),
                                    Obx(
                                      () => CupertinoSwitch(
                                        value: configStoreAddressController
                                                .shipConfig
                                                .value
                                                .useFeeFromPartnership ??
                                            false,
                                        onChanged: (bool value) {
                                          configStoreAddressController
                                                  .shipConfig
                                                  .value
                                                  .useFeeFromPartnership =
                                              !(configStoreAddressController
                                                      .shipConfig
                                                      .value
                                                      .useFeeFromPartnership ??
                                                  false);
                                          configStoreAddressController
                                              .shipConfig
                                              .refresh();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                              ),
                            ],
                          )
                        : Container(),
                  ),
                  Obx(
                    () => configStoreAddressController
                                .shipConfig.value.isCalculateShip ??
                            false
                        ? Column(
                            children: [
                              Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(10),
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text("Sử dụng phí ship mặc định"),
                                    ),
                                    Obx(
                                      () => CupertinoSwitch(
                                        value: configStoreAddressController
                                                .shipConfig
                                                .value
                                                .useFeeFromDefault ??
                                            false,
                                        onChanged: (bool value) {
                                          configStoreAddressController
                                                  .shipConfig
                                                  .value
                                                  .useFeeFromDefault =
                                              !(configStoreAddressController
                                                      .shipConfig
                                                      .value
                                                      .useFeeFromDefault ??
                                                  false);
                                          configStoreAddressController
                                              .shipConfig
                                              .refresh();
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                              ),
                              Obx(
                                () => (configStoreAddressController.shipConfig
                                            .value.useFeeFromDefault ??
                                        false)
                                    ? Column(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: Get.width,
                                                color: Colors.white,
                                                padding: const EdgeInsets.only(
                                                    top: 10.0,
                                                    left: 10,
                                                    right: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        "Phí cố định nội thành (${configStoreAddressController.shipConfig.value.urbanListIdProvince?.length ?? "Chưa chọn"} Tỉnh)"),
                                                    Spacer(),
                                                    InkWell(
                                                      onTap: () {
                                                        Get.to(() =>
                                                                ListUrbanProvinceScreen(
                                                                  listInput:
                                                                      configStoreAddressController
                                                                          .listLocationAddress,
                                                                ))!
                                                            .then((value) => {
                                                                  if (value !=
                                                                      null)
                                                                    {
                                                                      configStoreAddressController
                                                                              .listLocationAddress =
                                                                          value,
                                                                      configStoreAddressController
                                                                          .updateConfigShip(),
                                                                    }
                                                                });
                                                      },
                                                      child: Text(
                                                        "Danh sách các tỉnh",
                                                        style: TextStyle(
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: 10,
                                                    right: 10,
                                                    bottom: 10),
                                                color: Colors.white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          left: 10,
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10,
                                                                top: 5,
                                                                bottom: 5),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey[
                                                                        400]!),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2)),
                                                        child: TextFormField(
                                                          controller:
                                                              configStoreAddressController
                                                                  .urbanTextEditingController,
                                                          inputFormatters: [
                                                            ThousandsFormatter()
                                                          ],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          validator: (v) {
                                                            if (v!.length < 1) {
                                                              return "Chưa nhập số tiền";
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                          textAlign:
                                                              TextAlign.end,
                                                          decoration: InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(2),
                                                              counterText: "",
                                                              isDense: true,
                                                              border: InputBorder
                                                                  .none,
                                                              hintText:
                                                                  "Nhập phí nội thành",
                                                              suffixText: "VNĐ",
                                                              suffixStyle: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                          minLines: 1,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: Get.width,
                                                color: Colors.white,
                                                padding: const EdgeInsets.only(
                                                    top: 10.0,
                                                    left: 10,
                                                    right: 10),
                                                child: Text(
                                                    "Phí cố định ngoại thành"),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: 10,
                                                    right: 10,
                                                    bottom: 10),
                                                color: Colors.white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          left: 10,
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10,
                                                                top: 5,
                                                                bottom: 5),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey[
                                                                        400]!),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2)),
                                                        child: TextFormField(
                                                          controller:
                                                              configStoreAddressController
                                                                  .suburbanTextEditingController,
                                                          inputFormatters: [
                                                            ThousandsFormatter()
                                                          ],
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          validator: (v) {
                                                            if (v!.length < 1) {
                                                              return "Chưa nhập số tiền";
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                          textAlign:
                                                              TextAlign.end,
                                                          decoration: InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(2),
                                                              counterText: "",
                                                              isDense: true,
                                                              border: InputBorder
                                                                  .none,
                                                              hintText:
                                                                  "Nhập phí ngoại thành",
                                                              suffixText: "VNĐ",
                                                              suffixStyle: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                          minLines: 1,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: Get.width,
                                                color: Colors.white,
                                                padding: const EdgeInsets.only(
                                                    top: 10.0,
                                                    left: 10,
                                                    right: 10),
                                                child: Text(
                                                    "Mô tả cho khách hàng"),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: 10,
                                                    right: 10,
                                                    bottom: 10),
                                                color: Colors.white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          left: 10,
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 10,
                                                                top: 5,
                                                                bottom: 5),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    Colors.grey[
                                                                        400]!),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2)),
                                                        child: TextFormField(
                                                          controller:
                                                              configStoreAddressController
                                                                  .desTextEditingController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          style: TextStyle(
                                                              fontSize: 14),
                                                          textAlign:
                                                              TextAlign.end,
                                                          decoration: InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(2),
                                                              counterText: "",
                                                              isDense: true,
                                                              border: InputBorder
                                                                  .none,
                                                              hintText:
                                                                  "Mô tả cho khách hàng",
                                                              suffixStyle: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                          minLines: 1,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Lưu",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    configStoreAddressController.updateConfigShip();
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

  Widget itemShipment(int index) {
    return DecentralizationWidget(
      decent: sahaDataController
              .badgeUser.value.decentralization?.deliveryProviderUpdate ??
          false,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            height: 50,
            child: InkWell(
              onTap: () {
                if (configStoreAddressController.listShipmentStore[index].id ==
                        0 ||
                    configStoreAddressController.listShipmentStore[index].id ==
                        1) {
                  Get.to(() => InputTokenShipmentScreen(
                            shipment: configStoreAddressController
                                .listShipmentStore[index],
                          ))!
                      .then((value) =>
                          {configStoreAddressController.refreshData()});
                } else {
                  if (configStoreAddressController
                          .listShipmentStore[index].shipperConfig?.token ==
                      null) {
                    Get.to(() => LoginShippingCompanyScreen(
                          shipment: configStoreAddressController
                              .listShipmentStore[index],
                        ))!.then((value) =>
                          {configStoreAddressController.refreshData()});;
                  }else{
                     Get.to(() => InputTokenShipmentScreen(
                            shipment: configStoreAddressController
                                .listShipmentStore[index],
                          ))!
                      .then((value) =>
                          {configStoreAddressController.refreshData()});
                  }
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(configStoreAddressController
                        .listShipmentStore[index].name!),
                  ),
                  Text(
                    configStoreAddressController.listShipmentStore[index].id ==
                                0 ||
                            configStoreAddressController
                                    .listShipmentStore[index].id ==
                                1
                        ? "Sửa"
                        : "Đăng nhập",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.blue),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Obx(
                    () => CupertinoSwitch(
                      value: configStoreAddressController
                              .listShipmentStore[index].shipperConfig?.use ??
                          false,
                      onChanged: (bool value) {
                        if (configStoreAddressController
                                .listShipmentStore[index]
                                .shipperConfig
                                ?.token !=
                            null) {
                          configStoreAddressController.addTokenShipment(
                              configStoreAddressController
                                  .listShipmentStore[index].id,
                              ShipperConfig(
                                token: configStoreAddressController
                                    .listShipmentStore[index]
                                    .shipperConfig
                                    ?.token,
                                use: value,
                                cod: false,
                              ));
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
