import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_keyboard.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/screen2/choose_voucher/choose_voucher_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/choose_address/new_customer_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/choose_customer/choose_customer_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/confirm_screen/confirm_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/widget/bottom_detail.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/info_customer/info_customer_screen.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'pay_success_screen.dart';

class PayScreen extends StatefulWidget {
  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  HomeController homeController = Get.find();

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
                              hideSale: true,
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
                              null &&
                          homeController.cartCurrent.value.customerId != null) {
                        Get.to(() => InfoCustomerScreen(
                              infoCustomerId:
                                  homeController.cartCurrent.value.customerId!,
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
                      OrderDetailBottomDetail.show(homeController);
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
              Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "VAT: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Spacer(),
                  Obx(
                    () => Text(
                      "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.vat ?? 0)}₫",
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
                if(sahaDataController.badgeUser.value.decentralization?.changeDiscountPos != true){
                  SahaAlert.showError(message: "Bạn không có quyền chỉnh sửa chiết khấu");
                  return;
                }
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
                      OrderDetailBottomDetail.show(homeController);
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
                if (homeController.cartCurrent.value.isDefault == true)
                  Expanded(
                    child: SahaButtonFullParent(
                      text: "LƯU TẠM",
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () async {
                        SahaDialogApp.showDialogInput(
                            title: "Nhập đơn lưu tạm",
                            onInput: (v) {
                              homeController.createCartSave(v);
                              Get.back();
                              Get.back();
                            },
                            onCancel: () {
                              Get.back();
                            });
                      },
                      color: Colors.white,
                    ),
                  ),
                Expanded(
                  child: SahaButtonFullParent(
                    text: "THANH TOÁN",
                    onPressed: () async {
                      if (homeController.isShipment.value == true) {
                        if (homeController.cartCurrent.value.customerId !=
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
                    Text(
                      "Ghi chú: ${order.note ?? ""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
