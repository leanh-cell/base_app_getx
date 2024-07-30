import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/saha_user/button/saha_button.dart';
import '../../../components/saha_user/call/call.dart';
import '../../../components/saha_user/decentralization/decentralization_widget.dart';
import '../../../components/saha_user/dialog/dialog.dart';
import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../model/info_customer.dart';
import '../../../model/location_address.dart';
import '../../../utils/string_utils.dart';
import '../../home/choose_address/choose_address_customer_screen/choose_address_customer_controller.dart';
import '../../home/choose_address/choose_address_customer_screen/choose_address_customer_screen.dart';
import '../../home/choose_customer/choose_customer_controller.dart';
import '../../home/confirm_screen/choose_address_receiver/receiver_address_controller.dart';
import '../../home/confirm_screen/confirm_controller.dart';
import '../../info_customer/history_order/order_detail_manage/order_detail_manage_screen.dart';
import '../../info_customer/history_points/history_points_screen.dart';
import '../../info_customer/info_customer_controller.dart';
import '../../widget/item_product.dart';
import 'edit_order_controller.dart';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_keyboard.dart';
import 'package:com.ikitech.store/app_user/screen2/choose_voucher/choose_voucher_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/choose_address/new_customer_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/widget/bottom_detail.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:com.ikitech.store/app_user/const/const_revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/model/revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/revenue_expanditure/revenue_expenditure_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/navigator/navigator_controller.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty_widget/saha_empty_customer_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:com.ikitech.store/app_user/const/order_constant.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/screen_default/confirm_screen/widget/widget_animate_check.dart';
import 'package:sahashop_customer/app_customer/utils/store_info.dart';
import '../../shipment/shipment_choose_screen.dart';

class EditOrderScreen extends StatelessWidget {
  String oderCode;
  EditOrderScreen({required this.oderCode});

  late EditOrderController controller =
      Get.put(EditOrderController(orderCode: oderCode));
  RefreshController _refreshController2 = RefreshController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa đơn hàng'),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: CustomFooter(
          builder: (
            BuildContext context,
            LoadStatus? mode,
          ) {
            Widget body = Container();
            if (mode == LoadStatus.idle) {
              body = Obx(() => controller.isLoadingProductMore.value
                  ? CupertinoActivityIndicator()
                  : Container());
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            }
            return Container(
              height: 100,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController2,
        onRefresh: () async {
          controller.getCart();
          _refreshController2.refreshCompleted();
        },
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Obx(
              () => Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                      itemCount: controller.listOrder.length,
                      itemBuilder: (context, index) {
                        print(controller.listOrder[index].quantity);
                        return ItemProductInCartWidget(
                          lineItem: controller.listOrder[index],
                          onDismissed: () async {
                            if (controller
                                        .listOrder[index].distributesSelected !=
                                    null &&
                                controller.listOrder[index].distributesSelected!
                                    .isNotEmpty) {
                              controller.listQuantityProduct.removeAt(index);
                              controller.updateItemCart(
                                lineItemId: controller.listOrder[index].id!,
                                productId:
                                    controller.listOrder[index].product!.id!,
                                quantity: 0,
                                distributeName: controller.listOrder[index]
                                    .distributesSelected![0].name,
                                elementDistributeName: controller
                                    .listOrder[index]
                                    .distributesSelected![0]
                                    .value,
                                subElementDistributeName: controller
                                    .listOrder[index]
                                    .distributesSelected![0]
                                    .subElement,
                              );
                            } else {
                              controller.updateItemCart(
                                lineItemId: controller.listOrder[index].id!,
                                productId:
                                    controller.listOrder[index].product!.id!,
                                quantity: 0,
                              );
                            }

                            controller.listOrder.removeAt(index);
                          },
                          onDecreaseItem: () {
                            if (controller
                                        .listOrder[index].distributesSelected !=
                                    null &&
                                controller.listOrder[index].distributesSelected!
                                    .isNotEmpty) {
                              controller.decreaseItem(
                                index: index,
                                distributeName: controller.listOrder[index]
                                    .distributesSelected![0].name,
                                elementDistributeName: controller
                                    .listOrder[index]
                                    .distributesSelected![0]
                                    .value,
                                subElementDistributeName: controller
                                    .listOrder[index]
                                    .distributesSelected![0]
                                    .subElement,
                              );
                            } else {
                              controller.decreaseItem(
                                index: index,
                              );
                            }
                          },
                          onIncreaseItem: () {
                            if (controller
                                        .listOrder[index].distributesSelected !=
                                    null &&
                                controller.listOrder[index].distributesSelected!
                                    .isNotEmpty) {
                              controller.increaseItem(
                                index: index,
                                distributeName: controller.listOrder[index]
                                    .distributesSelected![0].name,
                                elementDistributeName: controller
                                    .listOrder[index]
                                    .distributesSelected![0]
                                    .value,
                                subElementDistributeName: controller
                                    .listOrder[index]
                                    .distributesSelected![0]
                                    .subElement,
                              );
                            } else {
                              controller.increaseItem(
                                index: index,
                              );
                            }
                          },
                          onUpdateProduct: (quantity, distributesSelected) {
                            if (distributesSelected.isNotEmpty) {
                              controller.updateItemCart(
                                lineItemId: controller.listOrder[index].id!,
                                productId:
                                    controller.listOrder[index].product!.id!,
                                quantity: quantity,
                                distributeName: distributesSelected[0].name,
                                elementDistributeName:
                                    distributesSelected[0].value,
                                subElementDistributeName:
                                    distributesSelected[0].subElement,
                              );
                            } else {
                              controller.updateItemCart(
                                lineItemId: controller.listOrder[index].id!,
                                productId:
                                    controller.listOrder[index].product!.id!,
                                quantity: quantity,
                              );
                            }
                          },
                          quantity: controller.listQuantityProduct[index],
                        );
                      }),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tiền hàng",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18),
                        ),
                        Spacer(),
                        Obx(
                          () => Text(
                            "${SahaStringUtils().convertToMoney(controller.cartCurrent.value.cartData?.totalBeforeDiscount ?? 0)}₫",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Row(
                    children: [
                      if (controller.cartCurrent.value.isDefault == true)
                        Expanded(
                          child: SahaButtonFullParent(
                            text: "LƯU TẠM",
                            textColor: Theme.of(context).primaryColor,
                            onPressed: () async {
                              // SahaDialogApp.showDialogInput(
                              //     title: "Nhập đơn lưu tạm",
                              //     onInput: (v) {
                              //       controller.createCartSave(v);
                              //       Get.back();
                              //       controller.isShowBill.value = false;
                              //     },
                              //     onCancel: () {
                              //       Get.back();
                              //     });
                            },
                            color: Colors.white,
                          ),
                        ),
                      Expanded(
                        child: SahaButtonFullParent(
                          text: "THANH TOÁN",
                          onPressed: () async {
                            if ((controller.cartCurrent.value.cartData
                                        ?.totalBeforeDiscount ??
                                    0) >
                                0) {
                              Get.to(() => PayScreen());
                            }
                          },
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PayScreen extends StatefulWidget {
  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  EditOrderController homeController = Get.find();

  late TextEditingController moneyEditingController;
  bool checkEnough = true;
  List<int> listMoneySuggestions = [];

  SahaDataController sahaDataController = Get.find();

  @override
  void initState() {
    moneyEditingController = TextEditingController(
        text:
            "${SahaStringUtils().convertToUnit(homeController.cartCurrent.value.cartData?.totalAfterDiscount ?? 0)}");
    super.initState();
  }

  void suggestionMoney() {
    if (moneyEditingController.text.length == 0) {
      listMoneySuggestions = [
        100000,
        200000,
        500000,
      ];
    } else if (moneyEditingController.text.length <= 5) {
      listMoneySuggestions = [
        int.parse(SahaStringUtils()
                .convertFormatText(moneyEditingController.text)) *
            10,
        int.parse(SahaStringUtils()
                .convertFormatText(moneyEditingController.text)) *
            100,
        int.parse(SahaStringUtils()
                .convertFormatText(moneyEditingController.text)) *
            1000
      ];
    } else if (moneyEditingController.text.length == 6) {
      listMoneySuggestions = [
        int.parse(SahaStringUtils()
                .convertFormatText(moneyEditingController.text)) *
            10,
        int.parse(SahaStringUtils()
                .convertFormatText(moneyEditingController.text)) *
            100,
      ];
    } else {
      listMoneySuggestions = [
        int.parse(SahaStringUtils()
                .convertFormatText(moneyEditingController.text)) *
            10,
      ];
    }
  }

  late Timer _timer;
  bool _visible = true;
  int _start = 30;

  void startAnimation() {
    _start = 4;
    const oneSec = const Duration(seconds: 1);
    _timer = _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _visible = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _visible = !_visible;
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Thanh toán"),
            Spacer(),
            Text(
              "Giao hàng",
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Obx(
              () => CupertinoSwitch(
                value: homeController.isShipment.value,
                trackColor: Colors.white70,
                onChanged: (bool value) {
                  homeController.isShipment.value =
                      !homeController.isShipment.value;
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Obx(
            () => homeController.cartCurrent.value.infoCustomer == null
                ? InkWell(
                    onTap: () {
                      if (homeController.cartCurrent.value.infoCustomer !=
                          null) {
                        Get.to(() => InfoCustomerScreen(
                              isInPayScreen: true,
                              infoCustomerId:
                                  homeController.cartCurrent.value.customerId!,
                              isCancel: true,
                            ));
                      } else {
                        Get.to(() => ChooseCustomerScreen(
                              isInPayScreen: true,
                            ));
                      }
                    },
                    child: AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 1000),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 2, right: 2),
                        decoration: BoxDecoration(
                            color: _visible == false
                                ? Colors.red.withOpacity(0.5)
                                : null,
                            border: Border.all(
                                color: _visible == true
                                    ? Colors.white
                                    : Colors.red,
                                width: 2)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Chọn khách hàng"),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      if (homeController.cartCurrent.value.infoCustomer !=
                          null) {
                        Get.to(() => InfoCustomerScreen(
                              infoCustomerId: homeController
                                  .cartCurrent.value.infoCustomer!.id!,
                              isCancel: true,
                              isInPayScreen: true,
                            ));
                      } else {
                        Get.to(() => ChooseCustomerScreen());
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Khách hàng:"),
                              Spacer(),
                              Text(
                                  "${homeController.cartCurrent.value.infoCustomer?.name ?? ""}")
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text("SĐT:"),
                              Spacer(),
                              Text(
                                  "${homeController.cartCurrent.value.infoCustomer?.phoneNumber ?? ""}")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "HOÁ ĐƠN: ",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                InkWell(
                    onTap: () {
                      OrderDetailBottomDetail.showOrderEdit(homeController);
                    },
                    child: Text(
                      "Chi tiết",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w500),
                    )),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: homeController.listOrder.length,
                itemBuilder: (context, index) {
                  return itemProduct(homeController.listOrder[index], index);
                }),
          ),
          SizedBox(
            height: 20,
          ),
          if (_keyboardIsVisible())
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Wrap(
                spacing: 5,
                children:
                    listMoneySuggestions.map((e) => itemMoney(e)).toList(),
              ),
            ),
          SizedBox(
            height: 15,
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Tổng tiền hàng: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Spacer(),
                  Obx(
                    () => Text(
                      "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.totalBeforeDiscount ?? 0)}₫",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Obx(
              () => homeController.cartCurrent.value.infoCustomer != null &&
                      (homeController.cartCurrent.value.cartData
                                  ?.totalPointsCanUse ??
                              0) !=
                          0
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.monetization_on,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Obx(
                                () => Text(
                                  "Dùng ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.totalPointsCanUse ?? 0)} xu ",
                                  style: TextStyle(fontSize: 13),
                                ),
                              ),
                              Spacer(),
                              Obx(
                                () => Text(
                                    "[-${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.bonusPointsAmountUsed ?? 0)}₫] "),
                              ),
                              Obx(
                                () => CupertinoSwitch(
                                  value: homeController
                                          .cartCurrent.value.isUsePoints ??
                                      false,
                                  onChanged: (bool value) {
                                    homeController.cartCurrent.value
                                        .isUsePoints = !(homeController
                                            .cartCurrent.value.isUsePoints ??
                                        false);
                                    homeController.cartCurrent.refresh();
                                    homeController.updateInfoCart();
                                  },
                                ),
                              ),
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
              () => homeController.isShipment.value == false
                  ? InkWell(
                      onTap: () {
                        Get.to(() => ChooseVoucherScreen(
                                  voucherCodeChooseInput: homeController
                                      .cartCurrent.value.codeVoucher,
                                ))!
                            .then((value) => {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.sticky_note_2_rounded,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Voucher"),
                            Spacer(),
                            Obx(() {
                              if (homeController.cartCurrent.value.cartData
                                      ?.voucherDiscountAmount !=
                                  0) {
                                moneyEditingController.text =
                                    "${SahaStringUtils().convertToUnit(homeController.cartCurrent.value.cartData?.totalAfterDiscount ?? 0)}";
                              }
                              return homeController
                                              .cartCurrent.value.codeVoucher ==
                                          "" ||
                                      homeController.cartCurrent.value.cartData
                                              ?.voucherDiscountAmount ==
                                          0
                                  ? Text("Chọn hoặc nhập mã")
                                  : Text(
                                      "Mã: ${homeController.cartCurrent.value.codeVoucher} - đ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.voucherDiscountAmount ?? 0)}",
                                      style: TextStyle(fontSize: 13),
                                    );
                            }),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ),
            Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {
                PopupKeyboard().showDialogInputKeyboard(
                  numberInput:
                      "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.discount ?? 0)}",
                  title: "Chiết khấu",
                  confirm: (number, isPercent) {
                    if (isPercent == true) {
                      homeController.cartCurrent.value.discount =
                          ((homeController.cartCurrent.value.cartData
                                          ?.totalAfterDiscount ??
                                      0) *
                                  number) /
                              100;
                    } else {
                      homeController.cartCurrent.value.discount = number;
                    }
                    homeController.cartCurrent.refresh();
                    homeController.updateInfoCart();
                  },
                  isPercentInput: homeController.isPercentInput,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_circle_down_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Chiết khấu",
                    ),
                    Spacer(),
                    Obx(
                      () => Text(
                        "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.discount ?? 0)}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "TẠM TÍNH:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      OrderDetailBottomDetail.showOrderEdit(homeController);
                    },
                    child: Row(
                      children: [
                        Obx(
                          () => Text(
                            "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.totalFinal ?? 0)}₫",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                                fontSize: 17),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SahaButtonFullParent(
                    text: "THANH TOÁN",
                    onPressed: () async {
                      if (homeController.isShipment.value == true) {
                        if (homeController.cartCurrent.value.infoCustomer?.id !=
                            null) {
                          if (homeController.cartCurrent.value.infoCustomer
                                      ?.province ==
                                  null ||
                              homeController.cartCurrent.value.infoCustomer
                                      ?.addressDetail ==
                                  null) {
                            SahaDialogApp.showDialogYesNo(
                                mess:
                                    "Khách hàng chưa có địa chỉ!\nThiết lập địa chỉ ?",
                                onOK: () {
                                  Get.to(() => NewCustomerScreen(
                                            infoCustomer: homeController
                                                .cartCurrent.value.infoCustomer,
                                            isShowAll: true,
                                          ))!
                                      .then((value) => {
                                            homeController.getCart(),
                                          });
                                });
                          } else {
                            Get.to(() => ConfirmUserScreen());
                          }
                        } else {
                          startAnimation();
                          SahaAlert.showToastMiddle(
                              message: "Giao hàng chưa chọn khách hàng");
                        }
                      } else {
                        Get.to(() => PaySuccessScreen(
                              moneyMustPay: homeController
                                      .cartCurrent.value.cartData?.totalFinal ??
                                  0,
                            ));
                      }
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemMoney(int money) {
    return InkWell(
      onTap: () {
        moneyEditingController.text =
            "${SahaStringUtils().convertToUnit(money)}";
        moneyEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: moneyEditingController.text.length));
      },
      child: Container(
        width: (Get.width - 30) / 3,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
        child: Center(child: Text("${SahaStringUtils().convertToUnit(money)}")),
      ),
    );
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  Widget itemProduct(LineItem order, int index) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    imageUrl: order.product?.images != null &&
                            order.product!.images!.isNotEmpty
                        ? (order.product!.images![0].imageUrl ?? "")
                        : "",
                    placeholder: (context, url) => new SahaLoadingWidget(
                      size: 20,
                    ),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${order.product?.name ?? ""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (order.distributesSelected != null &&
                        order.distributesSelected!.isNotEmpty)
                      Text(
                        'Phân loại: ${order.distributesSelected![0].value ?? ""}${order.distributesSelected![0].subElement == null ? "" : ","} ${order.distributesSelected![0].subElement ?? ""}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    Text(
                      "SL: ${(homeController.listQuantityProduct[index])}",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  order.product?.productDiscount == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Text(
                            "${SahaStringUtils().convertToMoney(order.beforeDiscountPrice ?? 0)}₫",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: order.product?.productDiscount == null
                                    ? Theme.of(Get.context!).primaryColor
                                    : Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: order.product?.productDiscount == null
                                    ? 14
                                    : 10),
                          ),
                        ),
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      order.isBonus == true
                          ? 'Hàng tặng'
                          : "${SahaStringUtils().convertToMoney(order.itemPrice ?? 0)}₫",
                      style: TextStyle(
                          color: order.isBonus == true
                              ? Colors.red
                              : SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}

class InfoCustomerScreen extends StatefulWidget {
  int infoCustomerId;
  bool? isCancel;
  bool? isWatch;
  bool? isInPayScreen;
  InfoCustomerScreen(
      {required this.infoCustomerId,
      this.isCancel,
      this.isInPayScreen,
      this.isWatch});

  @override
  State<InfoCustomerScreen> createState() => _InfoCustomerScreenState();
}

class _InfoCustomerScreenState extends State<InfoCustomerScreen>
    with SingleTickerProviderStateMixin {
  EditOrderController homeController = Get.find();
  NavigatorController navigatorController = Get.find();
  late TabController _tabController;
  late InfoCustomerController infoCustomerController;
  SahaDataController sahaDataController = Get.find();
  RefreshController refreshController = RefreshController();

  RefreshController refreshController2 = RefreshController();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    infoCustomerController =
        InfoCustomerController(infoCustomerId: widget.infoCustomerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin"),
      ),
      body: Obx(
        () => Column(
          children: [
            if (widget.isWatch != true)
              GestureDetector(
                onTap: () {
                  if (widget.isCancel == true) {
                    homeController.cartCurrent.value.customerId = null;
                    homeController.cartCurrent.value.customerName = null;
                    homeController.cartCurrent.value.customerPhone = null;
                    homeController.cartCurrent.value.province = null;
                    homeController.cartCurrent.value.district = null;
                    homeController.cartCurrent.value.wards = null;
                    homeController.cartCurrent.value.addressDetail = null;
                    homeController.updateInfoCart();
                    Get.back();
                  } else {
                    var info = infoCustomerController.infoCustomer.value;
                    homeController.cartCurrent.value.customerId = info.id;
                    homeController.cartCurrent.value.customerName = info.name;
                    homeController.cartCurrent.value.customerPhone =
                        info.phoneNumber;
                    homeController.cartCurrent.value.province = info.province;
                    homeController.cartCurrent.value.district = info.district;
                    homeController.cartCurrent.value.wards = info.wards;
                    homeController.cartCurrent.value.addressDetail =
                        info.addressDetail;
                    homeController.updateInfoCart();
                    Get.back();
                  }
                },
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "${widget.isCancel == true ? "XOÁ KHỎI HOÁ ĐƠN" : "THÊM VÀO HOÁ ĐƠN"}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            Divider(
              height: 1,
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.amber),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${infoCustomerController.infoCustomer.value.name ?? ""}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Call.call(
                                "${infoCustomerController.infoCustomer.value.phoneNumber ?? ""}");
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.blue,
                                size: 18,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${infoCustomerController.infoCustomer.value.phoneNumber ?? ""}",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              color: Colors.blue,
                              size: 18,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${infoCustomerController.infoCustomer.value.email ?? ""}",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 13),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => HistoryPointScreen(
                                  customerId: infoCustomerController
                                      .infoCustomer.value.id!,
                                ));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.monetization_on,
                                color: Colors.blue,
                                size: 18,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Xu: ${SahaStringUtils().convertToMoney(infoCustomerController.infoCustomer.value.point ?? 0)}",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Row(
              children: [
                SizedBox(
                  height: 40,
                  width: Get.width,
                  child: TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(
                          child: Text('Công nợ',
                              style: TextStyle(color: Colors.black))),
                      Tab(
                          child: Text('Lịch sử',
                              style: TextStyle(color: Colors.black))),
                      Tab(
                          child: Text('Thông tin',
                              style: TextStyle(color: Colors.black))),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                Obx(
                  () => Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "Nợ hiện tại: ${SahaStringUtils().convertToMoney(infoCustomerController.infoCustomer.value.debt ?? 0)}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Expanded(
                          child: SmartRefresher(
                            enablePullDown: true,
                            enablePullUp: true,
                            header: MaterialClassicHeader(),
                            footer: CustomFooter(
                              builder: (
                                BuildContext context,
                                LoadStatus? mode,
                              ) {
                                Widget body = Container();
                                if (mode == LoadStatus.idle) {
                                  body = Obx(() =>
                                      infoCustomerController.isLoading.value
                                          ? CupertinoActivityIndicator()
                                          : Container());
                                } else if (mode == LoadStatus.loading) {
                                  body = CupertinoActivityIndicator();
                                }
                                return Container(
                                  height: 100,
                                  child: Center(child: body),
                                );
                              },
                            ),
                            controller: refreshController,
                            onRefresh: () async {
                              await infoCustomerController
                                  .getAllRevenueExpenditure(isRefresh: true);
                              refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              await infoCustomerController
                                  .getAllRevenueExpenditure();
                              refreshController.loadComplete();
                            },
                            child: SingleChildScrollView(
                              child: Obx(
                                () => infoCustomerController
                                        .listRevenueExpenditure.isEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 100,
                                          ),
                                          Text("Chưa có phiếu thu chi nào")
                                        ],
                                      )
                                    : Column(
                                        children: infoCustomerController
                                            .listRevenueExpenditure
                                            .map((e) => revenueExpenditure(e))
                                            .toList(),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        SahaButtonFullParent(
                          text: "Điều chỉnh công nợ",
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                ),
                                builder: (context) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      DecentralizationWidget(
                                        decent: sahaDataController
                                                .badgeUser
                                                .value
                                                .decentralization
                                                ?.addRevenue ??
                                            false,
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.monetization_on,
                                            color: Colors.blue,
                                          ),
                                          title: Text(
                                            'Tạo phiếu thu',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          onTap: () {
                                            Get.back();
                                            Get.to(() =>
                                                    RevenueExpenditureScreen(
                                                      isRevenue: true,
                                                      changeMoney:
                                                          (infoCustomerController
                                                                      .infoCustomer
                                                                      .value
                                                                      .debt ??
                                                                  0)
                                                              .abs(),
                                                      recipientGroup:
                                                          RECIPIENT_GROUP_CUSTOMER,
                                                      recipientReferencesId:
                                                          infoCustomerController
                                                              .infoCustomer
                                                              .value
                                                              .id,
                                                      nameRecipientReferencesIdInput:
                                                          infoCustomerController
                                                              .infoCustomer
                                                              .value
                                                              .name,
                                                    ))!
                                                .then((value) => {
                                                      if (value == true)
                                                        {
                                                          infoCustomerController
                                                              .getAllRevenueExpenditure(
                                                                  isRefresh:
                                                                      true),
                                                          infoCustomerController
                                                              .getInfoCustomer(),
                                                        }
                                                    });
                                          },
                                        ),
                                      ),
                                      DecentralizationWidget(
                                        decent: sahaDataController
                                                .badgeUser
                                                .value
                                                .decentralization
                                                ?.addExpenditure ??
                                            false,
                                        child: ListTile(
                                          leading: Icon(Icons.monetization_on,
                                              color: Colors.red),
                                          title: Text(
                                            'Tạo phiếu chi',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onTap: () {
                                            Get.back();
                                            Get.to(() =>
                                                    RevenueExpenditureScreen(
                                                      isRevenue: false,
                                                      changeMoney:
                                                          infoCustomerController
                                                              .infoCustomer
                                                              .value
                                                              .debt,
                                                      recipientGroup:
                                                          RECIPIENT_GROUP_CUSTOMER,
                                                      recipientReferencesId:
                                                          infoCustomerController
                                                              .infoCustomer
                                                              .value
                                                              .id,
                                                      nameRecipientReferencesIdInput:
                                                          infoCustomerController
                                                              .infoCustomer
                                                              .value
                                                              .name,
                                                    ))!
                                                .then((value) => {
                                                      if (value == true)
                                                        {
                                                          infoCustomerController
                                                              .getAllRevenueExpenditure(
                                                                  isRefresh:
                                                                      true),
                                                          infoCustomerController
                                                              .getInfoCustomer(),
                                                        }
                                                    });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  );
                                });
                          },
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Obx(
                            () => Text(
                              "Nợ hiện tại: ${SahaStringUtils().convertToMoney(infoCustomerController.infoCustomer.value.debt ?? 0)}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      Expanded(
                        child: SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          header: MaterialClassicHeader(),
                          footer: CustomFooter(
                            builder: (
                              BuildContext context,
                              LoadStatus? mode,
                            ) {
                              Widget body = Container();
                              if (mode == LoadStatus.idle) {
                                body = Obx(() =>
                                    !infoCustomerController.isDoneLoadMore.value
                                        ? CupertinoActivityIndicator()
                                        : Container());
                              } else if (mode == LoadStatus.loading) {
                                body = CupertinoActivityIndicator();
                              }
                              return Container(
                                height: 100,
                                child: Center(child: body),
                              );
                            },
                          ),
                          controller: refreshController2,
                          onRefresh: () async {
                            await infoCustomerController.loadMoreOrder(
                                isRefresh: true);
                            refreshController2.refreshCompleted();
                          },
                          onLoading: () async {
                            await infoCustomerController.loadMoreOrder();
                            refreshController2.loadComplete();
                          },
                          child: SingleChildScrollView(
                            child: Obx(
                                () => infoCustomerController.listOrder.isEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 100,
                                          ),
                                          Text("Chưa có lịch sử mua hàng")
                                        ],
                                      )
                                    : Column(
                                        children: infoCustomerController
                                            .listOrder
                                            .map((e) => historyOrder(e))
                                            .toList(),
                                      )),
                          ),
                        ),
                      ),
                      SahaButtonFullParent(
                        text: "Điều chỉnh công nợ",
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                              ),
                              builder: (context) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(
                                        Icons.monetization_on,
                                        color: Colors.blue,
                                      ),
                                      title: Text(
                                        'Tạo phiếu thu',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onTap: () {
                                        Get.back();
                                        Get.to(() => RevenueExpenditureScreen(
                                                  isRevenue: true,
                                                  changeMoney:
                                                      (infoCustomerController
                                                                  .infoCustomer
                                                                  .value
                                                                  .debt ??
                                                              0)
                                                          .abs(),
                                                  recipientGroup:
                                                      RECIPIENT_GROUP_CUSTOMER,
                                                  recipientReferencesId:
                                                      infoCustomerController
                                                          .infoCustomer
                                                          .value
                                                          .id,
                                                  nameRecipientReferencesIdInput:
                                                      infoCustomerController
                                                          .infoCustomer
                                                          .value
                                                          .name,
                                                ))!
                                            .then((value) => {
                                                  if (value == true)
                                                    {
                                                      infoCustomerController
                                                          .getAllRevenueExpenditure(
                                                              isRefresh: true),
                                                      infoCustomerController
                                                          .getInfoCustomer(),
                                                    }
                                                });
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.monetization_on,
                                          color: Colors.red),
                                      title: Text(
                                        'Tạo phiếu chi',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onTap: () {
                                        Get.back();
                                        Get.to(() => RevenueExpenditureScreen(
                                                  isRevenue: false,
                                                  changeMoney:
                                                      infoCustomerController
                                                          .infoCustomer
                                                          .value
                                                          .debt,
                                                  recipientGroup:
                                                      RECIPIENT_GROUP_CUSTOMER,
                                                  recipientReferencesId:
                                                      infoCustomerController
                                                          .infoCustomer
                                                          .value
                                                          .id,
                                                  nameRecipientReferencesIdInput:
                                                      infoCustomerController
                                                          .infoCustomer
                                                          .value
                                                          .name,
                                                ))!
                                            .then((value) => {
                                                  if (value == true)
                                                    {
                                                      infoCustomerController
                                                          .getAllRevenueExpenditure(
                                                              isRefresh: true),
                                                      infoCustomerController
                                                          .getInfoCustomer(),
                                                    }
                                                });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                );
                              });
                        },
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Obx(
                            () => Text(
                              "Nợ hiện tại: ${SahaStringUtils().convertToMoney(infoCustomerController.infoCustomer.value.debt ?? 0)}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      Container(
                        color: Colors.white,
                        width: Get.width,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Địa chỉ:"),
                            SizedBox(
                              height: 10,
                            ),
                            if (infoCustomerController
                                    .infoCustomer.value.addressDetail !=
                                null)
                              Text(
                                "${infoCustomerController.infoCustomer.value.addressDetail ?? ""}",
                              ),
                            if (infoCustomerController
                                    .infoCustomer.value.wardsName !=
                                null)
                              Text(
                                "${infoCustomerController.infoCustomer.value.wardsName ?? ""}${infoCustomerController.infoCustomer.value.wardsName != null ? "," : ""} ${infoCustomerController.infoCustomer.value.districtName ?? ""}${infoCustomerController.infoCustomer.value.districtName != null ? "," : ""} ${infoCustomerController.infoCustomer.value.provinceName ?? ""}",
                              ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => NewCustomerScreen(
                                    infoCustomer: infoCustomerController
                                        .infoCustomer.value,
                                  ))!
                              .then((value) => {
                                    if (value == "reload")
                                      {
                                        infoCustomerController
                                            .getInfoCustomer(),
                                      }
                                  });
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Chỉnh sửa",
                                style: TextStyle(color: Colors.blue),
                              ),
                              Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget revenueExpenditure(RevenueExpenditure revenueExpenditure) {
    return InkWell(
      onTap: () {
        Get.to(() => RevenueExpenditureScreen(
              isRevenue: true,
              revenueExpenditure: revenueExpenditure,
              changeMoney: infoCustomerController.infoCustomer.value.debt,
              recipientGroup: RECIPIENT_GROUP_CUSTOMER,
              recipientReferencesId:
                  infoCustomerController.infoCustomer.value.id,
            ));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${revenueExpenditure.code ?? ""}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${revenueExpenditure.staff?.name ?? ""}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${SahaDateUtils().getDDMMYY(revenueExpenditure.createdAt ?? DateTime.now())} - ${SahaDateUtils().getHHMM(revenueExpenditure.createdAt ?? DateTime.now())}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        revenueExpenditure.isRevenue == true
                            ? Icon(
                                Icons.arrow_drop_down,
                                color: Colors.blue,
                              )
                            : Icon(
                                Icons.arrow_drop_up,
                                color: Colors.red,
                              ),
                        Text(
                          "${SahaStringUtils().convertToMoney(revenueExpenditure.changeMoney ?? 0)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${revenueExpenditure.typeActionName ?? ""}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
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

  Widget historyOrder(Order order) {
    return InkWell(
      onTap: () {
        Get.to(() => OrderDetailScreen(
              order: order,
            ));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order.orderCode ?? ""}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${SahaStringUtils().convertToMoney(order.totalFinal ?? 0)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${order.orderStatusName}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 12),
                    )
                  ],
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

class ChooseCustomerScreen extends StatelessWidget {
  TextEditingController nameEditingController = TextEditingController();
  EditOrderController homeController = Get.find();
  NavigatorController navigatorController = Get.find();
  ChooseCustomerController chooseCustomerController =
      ChooseCustomerController();
  RefreshController _refreshController = RefreshController();

  ChooseCustomerScreen({this.isInPayScreen});

  bool? isInPayScreen;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Khách hàng"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: nameEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "Tìm kiếm",
                    contentPadding:
                        EdgeInsets.only(right: 15, top: 15, bottom: 15),
                    suffixIcon: IconButton(
                      onPressed: () {
                        nameEditingController.clear();
                        homeController.isSearch.value = false;
                        chooseCustomerController.search = "";
                        chooseCustomerController.getAllCustomer(
                            isRefresh: true);
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  onChanged: (v) {
                    chooseCustomerController.search = v;
                    chooseCustomerController.getAllCustomer(isRefresh: true);
                  },
                  style: TextStyle(fontSize: 14),
                  minLines: 1,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 15, left: 15),
            child: Text(
              "Khách hàng gần đây",
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: MaterialClassicHeader(),
              footer: CustomFooter(
                builder: (
                  BuildContext context,
                  LoadStatus? mode,
                ) {
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Obx(() =>
                        !chooseCustomerController.isDoneLoadMore.value
                            ? CupertinoActivityIndicator()
                            : Container());
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else {
                    body = Container();
                  }
                  return Container(
                    height: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        body,
                      ],
                    ),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: () async {
                await chooseCustomerController.getAllCustomer(isRefresh: true);
                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                if (chooseCustomerController.isDoneLoadMore.value) {
                  await chooseCustomerController.getAllCustomer();
                }
                _refreshController.loadComplete();
              },
              child: Obx(
                () => chooseCustomerController.isLoadInit.value
                    ? SahaLoadingFullScreen()
                    : chooseCustomerController.listInfoCustomer.isEmpty
                        ? SahaEmptyCustomerWidget(
                            width: 50,
                            height: 50,
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: chooseCustomerController
                                  .listInfoCustomer
                                  .map((e) => itemCustomer(e))
                                  .toList(),
                            ),
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemCustomer(InfoCustomer infoCustomer) {
    return InkWell(
      onTap: () {
        if (isInPayScreen == true) {
          Get.to(() => InfoCustomerScreen(
                    infoCustomerId: infoCustomer.id!,
                    isInPayScreen: true,
                  ))!
              .then((value) =>
                  {chooseCustomerController.getAllCustomer(isRefresh: true)});
        } else if (isInPayScreen == false) {
          Get.to(() => InfoCustomerScreen(
                    infoCustomerId: infoCustomer.id!,
                    isInPayScreen: false,
                  ))!
              .then((value) =>
                  {chooseCustomerController.getAllCustomer(isRefresh: true)});
        } else {
          Get.to(() => InfoCustomerScreen(
                    infoCustomerId: infoCustomer.id!,
                  ))!
              .then((value) =>
                  {chooseCustomerController.getAllCustomer(isRefresh: true)});
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5, right: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${infoCustomer.name}"),
                    SizedBox(
                      height: 5,
                    ),
                    if (infoCustomer.phoneNumber != null)
                      Text(
                        "${infoCustomer.phoneNumber}",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${infoCustomer.isAgency == true ? "Đại lý" : infoCustomer.isCollaborator == true ? "Cộng tác viên" : "Khách hàng"}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      var info = infoCustomer;
                      homeController.cartCurrent.value.customerId = info.id;
                      homeController.cartCurrent.value.customerName = info.name;
                      homeController.cartCurrent.value.customerPhone =
                          info.phoneNumber;
                      homeController.cartCurrent.value.province = info.province;
                      homeController.cartCurrent.value.district = info.district;
                      homeController.cartCurrent.value.wards = info.wards;
                      homeController.cartCurrent.value.addressDetail =
                          info.addressDetail;
                      homeController.updateInfoCart();
                      Get.back();
                    },
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(Get.context!).primaryColor,
                    ))
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

class PaySuccessScreen extends StatefulWidget {
  double moneyMustPay;

  PaySuccessScreen({
    required this.moneyMustPay,
  });

  @override
  State<PaySuccessScreen> createState() => _PaySuccessScreenState();
}

class _PaySuccessScreenState extends State<PaySuccessScreen> {
  EditOrderController homeController = Get.find();

  TextEditingController emailEditingController = TextEditingController();
  late TextEditingController textEditingController;
  late TextEditingController noteEditingController;
  final _formKey = GlobalKey<FormState>();
  int paymentMethod = 0;
  List<int> listMoneySuggestions = [];
  bool checkTapEmail = false;

  @override
  void initState() {
    noteEditingController = TextEditingController(
      text: homeController.cartCurrent.value.customerNote ?? "",
    );

    emailEditingController.text =
        homeController.cartCurrent.value.infoCustomer?.email ?? "";

    textEditingController = TextEditingController(
        text:
            "${SahaStringUtils().convertToUnit(homeController.cartCurrent.value.cartData?.totalFinal ?? 0)}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Thanh toán'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: Get.width,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                            color: Colors.grey[200]),
                        child: Column(
                          children: [
                            Text(
                              "Khách hàng cần thanh toán",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${SahaStringUtils().convertToMoney(widget.moneyMustPay)}₫",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Khách hàng đưa",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                    context: Get.context!,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0)),
                                    ),
                                    builder: (context) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Chọn hình thức thanh toán",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          ListTile(
                                            leading: SvgPicture.asset(
                                              "assets/icons/credit_card.svg",
                                              height: 40,
                                              width: 40,
                                            ),
                                            title: Text(
                                              'Chuyển khoản',
                                            ),
                                            onTap: () {
                                              Get.back();
                                              setState(() {
                                                paymentMethod = 3;
                                                textEditingController.text =
                                                    "${SahaStringUtils().convertToUnit(homeController.cartCurrent.value.cartData?.totalFinal ?? 0)}";
                                              });
                                            },
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          ListTile(
                                            leading: SvgPicture.asset(
                                              "assets/icons/transfer_money.svg",
                                              height: 40,
                                              width: 40,
                                            ),
                                            title: Text(
                                              "Tiền mặt",
                                            ),
                                            onTap: () {
                                              Get.back();
                                              setState(() {
                                                paymentMethod = 0;
                                              });
                                            },
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          ListTile(
                                            leading: SvgPicture.asset(
                                              "assets/icons/atm.svg",
                                              height: 40,
                                              width: 40,
                                            ),
                                            title: Text(
                                              "Quẹt thẻ",
                                            ),
                                            onTap: () {
                                              Get.back();
                                              setState(() {
                                                paymentMethod = 1;
                                                textEditingController.text =
                                                    "${SahaStringUtils().convertToUnit(homeController.cartCurrent.value.cartData?.totalFinal ?? 0)}";
                                              });
                                            },
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          ListTile(
                                            leading: SvgPicture.asset(
                                              "assets/icons/cod.svg",
                                              height: 40,
                                              width: 40,
                                            ),
                                            title: Text(
                                              "COD",
                                            ),
                                            onTap: () {
                                              Get.back();
                                              setState(() {
                                                paymentMethod = 2;
                                                textEditingController.text =
                                                    "${SahaStringUtils().convertToUnit(homeController.cartCurrent.value.cartData?.totalFinal ?? 0)}";
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                height: 50,
                                width: Get.width / 2,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      namePayment(paymentMethod),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Icon(Icons.keyboard_arrow_down_rounded)
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: textEditingController,
                                autofocus: false,
                                onTap: () {
                                  checkTapEmail = false;
                                  textEditingController.text = "";
                                },
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                inputFormatters: [ThousandsFormatter()],
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 15, top: 0, right: 15, bottom: 0),
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Tiền khách trả",
                                ),
                                keyboardType: TextInputType.number,
                                maxLines: null,
                                onChanged: (v) async {
                                  setState(() {
                                    suggestionMoney();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: Get.width / 2,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: double.parse(SahaStringUtils()
                                                .convertFormatText(
                                                    textEditingController
                                                                .text ==
                                                            ""
                                                        ? "0"
                                                        : textEditingController
                                                            .text)) -
                                            (homeController.cartCurrent.value
                                                    .cartData?.totalFinal ??
                                                0) <
                                        0
                                    ? Colors.red
                                    : Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${double.parse(SahaStringUtils().convertFormatText(textEditingController.text == "" ? "0" : textEditingController.text)) - (homeController.cartCurrent.value.cartData?.totalFinal ?? 0) < 0 ? "KHÁCH HÀNG NỢ" : "TIỀN THỪA"}',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  "${SahaStringUtils().convertToMoney(double.parse(SahaStringUtils().convertFormatText(textEditingController.text == "" ? "0" : textEditingController.text)) - (homeController.cartCurrent.value.cartData?.totalFinal ?? 0))}₫",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          maxLines: null,
                          decoration: InputDecoration(labelText: "Ghi chú"),
                          controller: noteEditingController,
                          keyboardType: TextInputType.multiline,
                          onTap: () {
                            PopupInput().showDialogInputNote(
                                confirm: (v) {
                                  homeController
                                      .cartCurrent.value.customerNote = v;
                                  noteEditingController.text = v;
                                  homeController.updateInfoCart();
                                },
                                title: "Ghi chú",
                                textInput:
                                    "${homeController.cartCurrent.value.customerNote ?? ""}");
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          onChanged: (v) {},
                        ),
                      ),
                      if (homeController.infoCustomer.value.email == null ||
                          homeController.infoCustomer.value.email == "")
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Gửi đơn qua email'),
                            controller: emailEditingController,
                            onTap: () {
                              checkTapEmail = true;
                            },
                            validator: (value) {
                              if (value!.length == 0) return null;
                              if (value.length < 1) {
                                return 'Bạn chưa nhập Email';
                              } else {
                                if (GetUtils.isEmail(value)) {
                                  return null;
                                } else {
                                  return 'Email không hợp lệ';
                                }
                              }
                            },
                            onChanged: (v) {},
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (_keyboardIsVisible() && checkTapEmail == false)
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Wrap(
                    spacing: 5,
                    children:
                        listMoneySuggestions.map((e) => itemMoney(e)).toList(),
                  ),
                ),
              SizedBox(
                height: 15,
              )
            ],
          ),
          bottomNavigationBar: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("In hoá đơn:"),
                      CupertinoSwitch(
                        value: UserInfo().getIsPrint() ?? false,
                        onChanged: (bool value) async {
                          setState(() {
                            UserInfo()
                                .setPrint(!(UserInfo().getIsPrint() ?? false));
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SahaButtonFullParent(
                  text: "THANH TOÁN",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (homeController.cartCurrent.value.infoCustomer ==
                              null &&
                          double.parse(SahaStringUtils().convertFormatText(
                                      textEditingController.text == ""
                                          ? "0"
                                          : textEditingController.text)) -
                                  (homeController.cartCurrent.value.cartData
                                          ?.totalFinal ??
                                      0) <
                              0) {
                        SahaAlert.showToastMiddle(
                            message: "Không có khách hàng để cho nợ");
                        Get.back();
                      } else {
                        Get.until(
                          (route) => route.settings.name == "home_screen",
                        );
                        if (homeController.listOrder.isNotEmpty) {
                          homeController.isShowBill.value = false;
                          await homeController.orderCart(
                              paymentMethod: paymentMethod,
                              amountMoney: double.parse(SahaStringUtils()
                                  .convertFormatText(
                                      textEditingController.text == ""
                                          ? "0"
                                          : textEditingController.text)));
                          homeController.isShowBill.value = false;
                        }
                      }
                    }
                  },
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void suggestionMoney() {
    if (textEditingController.text.length == 0) {
      listMoneySuggestions = [
        100000,
        200000,
        500000,
      ];
    } else if (textEditingController.text.length <= 5) {
      listMoneySuggestions = [
        int.parse(SahaStringUtils()
                .convertFormatText(textEditingController.text)) *
            10,
        int.parse(SahaStringUtils()
                .convertFormatText(textEditingController.text)) *
            100,
        int.parse(SahaStringUtils()
                .convertFormatText(textEditingController.text)) *
            1000
      ];
    } else if (textEditingController.text.length == 6) {
      listMoneySuggestions = [
        int.parse(SahaStringUtils()
                .convertFormatText(textEditingController.text)) *
            10,
        int.parse(SahaStringUtils()
                .convertFormatText(textEditingController.text)) *
            100,
      ];
    } else {
      listMoneySuggestions = [
        int.parse(SahaStringUtils()
                .convertFormatText(textEditingController.text)) *
            10,
      ];
    }
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  Widget itemProduct(
    LineItem order,
  ) {
    String? textMoney() {
      if (order.product?.minPrice == 0) {
        if (order.product?.productDiscount == null) {
          return "${order.product!.price == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(order.product?.price)}₫"}";
        } else {
          return "${order.product!.productDiscount!.discountPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(order.product!.productDiscount!.discountPrice)}₫"}";
        }
      } else {
        if (order.product!.productDiscount == null) {
          return "${order.product!.minPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(order.product!.minPrice)}₫"}";
        } else {
          return "${order.product!.minPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(order.product!.minPrice! - ((order.product!.minPrice! * order.product!.productDiscount!.value!) / 100))}₫"}";
        }
      }
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    imageUrl: order.product?.images != null &&
                            order.product!.images!.isNotEmpty
                        ? (order.product!.images![0].imageUrl ?? "")
                        : "",
                    placeholder: (context, url) => new SahaLoadingWidget(
                      size: 20,
                    ),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${order.product?.name ?? ""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "SL: ${order.quantity ?? "0"}",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  order.product?.productDiscount == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Text(
                            order.product?.minPrice == 0
                                ? "${order.product?.price == 0 ? "Giảm" : "${SahaStringUtils().convertToMoney(order.product?.price ?? 0)}₫"}"
                                : "${SahaStringUtils().convertToMoney(order.product?.minPrice ?? 0)}₫",
                            style: TextStyle(
                                decoration: order.product?.price == 0
                                    ? null
                                    : TextDecoration.lineThrough,
                                color: order.product?.productDiscount == null
                                    ? Theme.of(Get.context!).primaryColor
                                    : Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: order.product?.productDiscount == null
                                    ? 14
                                    : 10),
                          ),
                        ),
                  Container(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      textMoney()!,
                      style: TextStyle(
                          color: SahaColorUtils()
                              .colorPrimaryTextWithWhiteBackground(),
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }

  Widget itemMoney(int money) {
    return InkWell(
      onTap: () {
        textEditingController.text =
            "${SahaStringUtils().convertToUnit(money)}";
        textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: textEditingController.text.length));
        setState(() {});
      },
      child: Container(
        width: (Get.width - 30) / 3,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
        child: Center(child: Text("${SahaStringUtils().convertToUnit(money)}")),
      ),
    );
  }

  String namePayment(int paymentMethod) {
    if (PAYMENT_TYPE_SWIPE == paymentMethod) {
      return "QUẸT THẺ";
    }
    if (PAYMENT_TYPE_CASH == paymentMethod) {
      return "TIỀN MẶT";
    }
    if (PAYMENT_TYPE_COD == paymentMethod) {
      return "COD";
    }
    if (PAYMENT_TYPE_TRANSFER == paymentMethod) {
      return "CHUYỂN KHOẢN";
    }
    return "";
  }
}

// ignore: must_be_immutable
class ConfirmUserScreen extends StatelessWidget {
  ConfirmUserController confirmController = Get.put(ConfirmUserController());
  final dataKey = new GlobalKey();
  final dataKeyPayment = new GlobalKey();
  EditOrderController homeController = Get.find();

  late TextEditingController noteEditingController;

  ConfirmUserScreen() {
    noteEditingController = TextEditingController(
      text: homeController.cartCurrent.value.customerNote ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Xác nhận đơn hàng"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                key: dataKey,
                height: 5,
              ),
              Obx(
                () => Column(
                  children: [
                    homeController.cartCurrent.value.infoCustomer != null
                        ? Card(
                            child: InkWell(
                              onTap: () {
                                Get.to(() => ConfigAddressCustomerScreen(
                                          phoneCustomer: homeController
                                                  .cartCurrent
                                                  .value
                                                  .customerPhone ??
                                              "",
                                        ))!
                                    .then(
                                        (value) => {homeController.getCart()});
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(6),
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            shape: BoxShape.circle,
                                          ),
                                          child: SvgPicture.asset(
                                            "packages/sahashop_customer/assets/icons/location.svg",
                                            color: SahaColorUtils()
                                                .colorPrimaryTextWithWhiteBackground(),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Địa chỉ nhận hàng :"),
                                            Container(
                                              width: Get.width * 0.7,
                                              child: Text(
                                                "${homeController.cartCurrent.value.customerName ?? "Chưa có tên"}  | ${homeController.cartCurrent.value.customerPhone ?? "Chưa có số điện thoại"}",
                                                maxLines: 2,
                                              ),
                                            ),
                                            Container(
                                              width: Get.width * 0.7,
                                              child: Text(
                                                "${homeController.cartCurrent.value.addressDetail ?? "Chưa có địa chỉ chi tiết"}",
                                                maxLines: 2,
                                              ),
                                            ),
                                            Container(
                                              width: Get.width * 0.7,
                                              child: Text(
                                                "${homeController.cartCurrent.value.wardsName ?? "Chưa có Phường/Xã"}, ${homeController.cartCurrent.value.districtName ?? "Chưa có Quận/Huyện"}, ${homeController.cartCurrent.value.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 13),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 14,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Obx(
                            () => AnimateCheck(
                              opacity: confirmController.opacityCurrent.value,
                              color:
                                  confirmController.colorAnimateAddress.value,
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    if (homeController
                                            .cartCurrent.value.infoCustomer !=
                                        null) {
                                      Get.to(() => InfoCustomerScreen(
                                            infoCustomerId: homeController
                                                .cartCurrent.value.customerId!,
                                            isCancel: true,
                                          ));
                                    } else {
                                      Get.to(() => ChooseCustomerScreen());
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(6),
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF5F6F9),
                                                shape: BoxShape.circle,
                                              ),
                                              child: SvgPicture.asset(
                                                  "packages/sahashop_customer/assets/icons/location.svg",
                                                  color: SahaColorUtils()
                                                      .colorPrimaryTextWithWhiteBackground()),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Địa chỉ nhận hàng :"),
                                                Container(
                                                  width: Get.width * 0.7,
                                                  child: Text(
                                                    "Chưa chọn địa chỉ nhận hàng (nhấn để chọn)",
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 14,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "packages/sahashop_customer/assets/icons/cart_icon.svg",
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Các mặt hàng đã đặt :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              ...homeController.listOrder.map((e) => itemProduct(e)).toList(),
              Divider(
                height: 1,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng số tiền (${homeController.listOrder.length} sản phẩm) : ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Obx(
                      () => Text(
                          "${SahaStringUtils().convertToMoney((homeController.cartCurrent.value.cartData?.totalBeforeDiscount ?? 0))}"),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.description_rounded,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Ghi chú',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      child: TextFormField(
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Nhập để ghi chú",
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.black87),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          suffixIcon: Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                          ),
                          suffixIconConstraints: BoxConstraints(
                            minWidth: 10,
                            minHeight: 30,
                          ),
                          border: InputBorder.none,
                        ),
                        controller: noteEditingController,
                        keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.end,
                        onTap: () {
                          PopupInput().showDialogInputNote(
                              confirm: (v) {
                                homeController.cartCurrent.value.customerNote =
                                    v;
                                noteEditingController.text = v;
                                homeController.updateInfoCart();
                              },
                              title: "Ghi chú",
                              textInput:
                                  "${homeController.cartCurrent.value.customerNote ?? ""}");
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ShipmentChooseScreen());
                },
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.local_shipping,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Phí vận chuyển : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacer(),
                      Obx(
                        () =>
                            homeController.cartCurrent.value.totalShippingFee ==
                                        null ||
                                    homeController.cartCurrent.value
                                            .totalShippingFee ==
                                        0
                                ? Text("Chọn hoặc miễn phí")
                                : Text(
                                    "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.totalShippingFee ?? 0)}",
                                    style: TextStyle(fontSize: 13),
                                  ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: SahaColorUtils()
                            .colorPrimaryTextWithWhiteBackground(),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              InkWell(
                onTap: () {
                  Get.to(() => ChooseVoucherScreen(
                            voucherCodeChooseInput:
                                homeController.cartCurrent.value.codeVoucher,
                          ))!
                      .then((value) => {});
                },
                child: Container(
                  key: dataKeyPayment,
                  height: 55,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "packages/sahashop_customer/assets/icons/receipt.svg",
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Shop Voucher : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Spacer(),
                      Obx(
                        () => homeController.cartCurrent.value.codeVoucher ==
                                    null ||
                                homeController.cartCurrent.value.codeVoucher ==
                                    ""
                            ? Text("Chọn hoặc nhập mã")
                            : Text(
                                "Mã: ${homeController.cartCurrent.value.codeVoucher}",
                                style: TextStyle(fontSize: 13),
                              ),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: SahaColorUtils()
                            .colorPrimaryTextWithWhiteBackground(),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              confirmController.paymentMethodName.value != ""
                  ? Container(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () {
                          // Get.to(() => PaymentMethodCustomerScreen(
                          //       idPaymentCurrent:
                          //           confirmController.idPaymentCurrent.value,
                          //       callback: (String paymentMethodName,
                          //           int idPaymentCurrent) {
                          //         confirmController.paymentMethodName.value =
                          //             paymentMethodName;
                          //         confirmController.idPaymentCurrent.value =
                          //             idPaymentCurrent;
                          //       },
                          //     ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF5F6F9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    "packages/sahashop_customer/assets/icons/money.svg",
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Phương thức thanh toán',
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            Spacer(),
                            Obx(
                              () => InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: Get.context!,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            topRight: Radius.circular(15.0)),
                                      ),
                                      builder: (context) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Chọn hình thức thanh toán",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Divider(
                                              height: 1,
                                            ),
                                            ListTile(
                                              leading: SvgPicture.asset(
                                                "assets/icons/credit_card.svg",
                                                height: 40,
                                                width: 40,
                                              ),
                                              title: Text(
                                                'Chuyển khoản',
                                              ),
                                              onTap: () {
                                                Get.back();
                                                confirmController
                                                    .paymentMethod.value = 3;
                                              },
                                            ),
                                            Divider(
                                              height: 1,
                                            ),
                                            ListTile(
                                              leading: SvgPicture.asset(
                                                "assets/icons/cod.svg",
                                                height: 40,
                                                width: 40,
                                              ),
                                              title: Text(
                                                "Thanh toán khi nhận hàng",
                                              ),
                                              onTap: () {
                                                Get.back();
                                                confirmController
                                                    .paymentMethod.value = 2;
                                              },
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  width: 120,
                                  child: Text(
                                    "${namePayment(confirmController.paymentMethod.value)}",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Obx(
                      () => AnimateCheck(
                        opacity: confirmController.opacityPaymentCurrent.value,
                        color: confirmController.colorAnimatePayment.value,
                        child: InkWell(
                          onTap: () {
                            // Get.to(() => PaymentMethodCustomerScreen(
                            //       idPaymentCurrent:
                            //           confirmController.idPaymentCurrent.value,
                            //       callback: (String paymentMethodName,
                            //           int idPaymentCurrent) {
                            //         confirmController.paymentMethodName.value =
                            //             paymentMethodName;
                            //         confirmController.idPaymentCurrent.value =
                            //             idPaymentCurrent;
                            //       },
                            //     ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5F6F9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                      "packages/sahashop_customer/assets/icons/money.svg",
                                      color: SahaColorUtils()
                                          .colorPrimaryTextWithWhiteBackground(),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Phương thức thanh toán',
                                    maxLines: 2,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Obx(
                                () => Container(
                                  width: 120,
                                  child: confirmController
                                              .paymentMethodName.value ==
                                          ""
                                      ? Text(
                                          "Chọn phương thức thanh toán",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: SahaColorUtils()
                                                  .colorPrimaryTextWithWhiteBackground()),
                                        )
                                      : Text(
                                          "${confirmController.paymentMethodName.value}",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: SahaColorUtils()
                                                  .colorPrimaryTextWithWhiteBackground()),
                                        ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              Divider(
                height: 1,
              ),
              Obx(
                () => (homeController.cartCurrent.value.cartData
                                ?.balanceCollaboratorCanUse ??
                            0) >
                        0
                    ? Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/fair_trade.svg",
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Dùng số dư cộng tác viên ",
                            style: TextStyle(fontSize: 13),
                          ),
                          Spacer(),
                          Text(
                              "[-${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.balanceCollaboratorCanUse ?? 0)}₫] "),
                          CupertinoSwitch(
                            value: homeController.cartCurrent.value
                                    .isUseBalanceCollaborator ??
                                false,
                            onChanged: (bool value) {
                              homeController.cartCurrent.value
                                  .isUseBalanceCollaborator = !(homeController
                                      .cartCurrent
                                      .value
                                      .isUseBalanceCollaborator ??
                                  false);
                              homeController.cartCurrent.refresh();
                              homeController.updateInfoCart();
                            },
                          ),
                        ],
                      )
                    : Container(),
              ),
              Divider(
                height: 1,
              ),
              Obx(
                () => Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tạm tính :',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700])),
                            Text(
                                "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.totalBeforeDiscount ?? 0)}",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800])),
                          ],
                        ),
                      ),
                      homeController.cartCurrent.value.cartData
                                  ?.productDiscountAmount ==
                              0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Giảm giá sản phẩm :',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                  Text(
                                      "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.productDiscountAmount ?? 0)}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800])),
                                ],
                              ),
                            ),
                      homeController.cartCurrent.value.cartData
                                  ?.voucherDiscountAmount ==
                              0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Giảm giá voucher :',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                  Text(
                                      "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.voucherDiscountAmount ?? 0)}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800])),
                                ],
                              ),
                            ),
                      homeController.cartCurrent.value.cartData
                                  ?.comboDiscountAmount ==
                              0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Giảm giá combo :',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                  Text(
                                      "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.comboDiscountAmount ?? 0)}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800])),
                                ],
                              ),
                            ),
                      homeController.cartCurrent.value.cartData?.discount == 0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Chiết khấu :',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                  Text(
                                      "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.discount ?? 0)}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800])),
                                ],
                              ),
                            ),
                      homeController.cartCurrent.value.cartData?.isUsePoints ==
                              false
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Giảm giá Xu :',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[700])),
                                  Text(
                                      "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.bonusPointsAmountUsed)}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[800])),
                                ],
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tổng tiền vận chuyển :',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700])),
                            Text(
                                "+ ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.totalShippingFee ?? 0)}",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800])),
                          ],
                        ),
                      ),
                      if ((homeController.cartCurrent.value.cartData
                                  ?.shipDiscountAmount ??
                              0) >
                          0)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Miễn phí vận chuyển :',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[700])),
                              Text(
                                  "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.shipDiscountAmount ?? 0)}",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[800])),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tổng thanh toán :',
                            ),
                            Text(
                                "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.totalFinal ?? 0)}",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800])),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.grey[200],
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F6F9),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            "packages/sahashop_customer/assets/icons/doc.svg",
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
                          ),
                        ),
                        Expanded(
                          child: Text(
                              "Nhấn 'Đặt hàng' đồng nghĩa với việc bạn đồng ý tuân theo Điều khoản ${StoreInfo().name} "),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 8,
                color: Colors.grey[200],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
            height: 100,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
                offset: Offset(0, 0.1), // Shadow position
              ),
            ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    PopupKeyboard().showDialogInputKeyboard(
                      numberInput:
                          "${SahaStringUtils().convertToMoney(confirmController.amountMoney.value)}",
                      title: "Số tiền trả trước",
                      confirm: (number) {
                        confirmController.amountMoney.value = number;
                        if (confirmController.amountMoney.value >
                            (homeController
                                    .cartCurrent.value.cartData?.totalFinal ??
                                0)) {
                          confirmController.amountMoney.value = (homeController
                                  .cartCurrent.value.cartData?.totalFinal ??
                              0);
                        }
                        confirmController.amountMoney.refresh();
                      },
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      if (confirmController.amountMoney.value != 0)
                        Text(
                          "Đã trả trước: ${SahaStringUtils().convertToMoney(confirmController.amountMoney.value)}",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.blue,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Tổng thanh toán",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Text(
                        "${SahaStringUtils().convertToMoney((homeController.cartCurrent.value.cartData?.totalFinal ?? 0) - confirmController.amountMoney.value)}",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () async {
                    if (homeController.cartCurrent.value.infoCustomer == null) {
                      Scrollable.ensureVisible(dataKey.currentContext!,
                          duration: Duration(milliseconds: 500));
                      confirmController.colorAnimateAddress.value = Colors.red;
                      confirmController.opacityCurrent.value = 0;
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        confirmController.opacityCurrent.value = 1;
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          confirmController.opacityCurrent.value = 0;
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            confirmController.opacityCurrent.value = 1;
                          });
                        });
                      });
                    } else {
                      if (homeController
                              .cartCurrent.value.infoCustomer?.province ==
                          null) {
                        SahaDialogApp.showDialogYesNo(
                            mess:
                                "Khách hàng chưa có địa chỉ!\nThiết lập địa chỉ ?",
                            onOK: () {
                              Get.to(() => NewCustomerScreen(
                                        infoCustomer: homeController
                                            .cartCurrent.value.infoCustomer,
                                        isShowAll: true,
                                      ))!
                                  .then((value) => {
                                        homeController.getCart(),
                                      });
                            });
                      } else {
                        Get.until(
                          (route) => route.settings.name == "home_screen",
                        );
                        if (homeController.isLoadingOrder.value == false) {
                          if (homeController.listOrder.isNotEmpty) {
                            homeController.isShowBill.value = false;
                            await homeController.orderCart(
                                paymentMethod:
                                    confirmController.paymentMethod.value,
                                amountMoney:
                                    confirmController.amountMoney.value,
                                orderFrom: ORDER_FROM_POS_DELIVERY);
                            confirmController.amountMoney.value = 0;
                            homeController.isShowBill.value = false;
                            homeController.cartCurrent.value.id = 0;
                            homeController.getCart();
                          }
                        }
                      }
                    }
                  },
                  child: Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        border: Border.all(color: Colors.grey[200]!)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Lên đơn",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6!
                                  .color,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget itemProduct(LineItem lineItem) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: lineItem.product!.images!.length == 0
                            ? ""
                            : lineItem.product!.images![0].imageUrl!,
                        errorWidget: (context, url, error) => SahaEmptyImage(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lineItem.product!.name ?? "Loi san pham",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        maxLines: 2,
                      ),
                      if (lineItem.distributesSelected != null &&
                          lineItem.distributesSelected!.isNotEmpty)
                        SizedBox(
                          height: 5,
                        ),
                      if (lineItem.distributesSelected != null &&
                          lineItem.distributesSelected!.isNotEmpty)
                        Text(
                          'Phân loại: ${lineItem.distributesSelected![0].value ?? ""}${lineItem.distributesSelected![0].subElement == null ? "" : ","} ${lineItem.distributesSelected![0].subElement ?? ""}',
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${SahaStringUtils().convertToMoney(lineItem.itemPrice ?? 0)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: SahaColorUtils()
                                      .colorPrimaryTextWithWhiteBackground()),
                            ),
                          ),
                          Text(" x${lineItem.quantity}   ",
                              style:
                                  Theme.of(Get.context!).textTheme.bodyText1),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }

  String namePayment(int paymentMethod) {
    if (PAYMENT_TYPE_SWIPE == paymentMethod) {
      return "QUẸT THẺ";
    }
    if (PAYMENT_TYPE_CASH == paymentMethod) {
      return "TIỀN MẶT";
    }
    if (PAYMENT_TYPE_COD == paymentMethod) {
      return "Thanh toán khi nhận hàng";
    }
    if (PAYMENT_TYPE_TRANSFER == paymentMethod) {
      return "Chuyển khoản";
    }
    return "";
  }
}



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

