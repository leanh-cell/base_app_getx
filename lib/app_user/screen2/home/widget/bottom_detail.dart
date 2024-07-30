import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

import '../../order_manage/edit_order/edit_order_controller.dart';

class OrderDetailBottomDetail {
  static void show(HomeController homeController) {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: Get.context!,
        builder: (BuildContext context) {
          return Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Chi tiết đơn hàng",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tạm tính"),
                        Text(
                            "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.totalBeforeDiscount ?? 0)} đ"),
                      ],
                    ),
                  ),
                  if ((homeController.cartCurrent.value.cartData
                              ?.productDiscountAmount ??
                          0) !=
                      0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá Sản phẩm"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.productDiscountAmount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if ((homeController.cartCurrent.value.cartData
                              ?.voucherDiscountAmount ??
                          0) !=
                      0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá Voucher"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.voucherDiscountAmount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if ((homeController.cartCurrent.value.cartData
                              ?.comboDiscountAmount ??
                          0) !=
                      0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá Combo"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.comboDiscountAmount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if ((homeController.cartCurrent.value.cartData?.discount ??
                          0) !=
                      0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Chiết khấu"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.discount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if ((homeController.cartCurrent.value.cartData
                              ?.bonusPointsAmountUsed ??
                          0) !=
                      0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá xu"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.bonusPointsAmountUsed ?? 0)} đ"),
                        ],
                      ),
                    ),
                  Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tổng tiền"),
                        Text(
                            "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.totalFinal ?? 0)} đ"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 8,
                    color: Colors.grey[200],
                  ),
                  SahaButtonFullParent(
                    text: "Đóng",
                    textColor:
                        Theme.of(context).primaryTextTheme.headline6!.color,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Container(
                    height: 8,
                    color: Colors.grey[200],
                  ),
                ],
              ),
              Positioned(
                  height: 45,
                  width: 45,
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  ))
            ],
          );
        });
  }

  static void showOrder(Order order) {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: Get.context!,
        builder: (BuildContext context) {
          return Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Chi tiết đơn hàng",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tạm tính"),
                        Text(
                            "${SahaStringUtils().convertToMoney(order.totalBeforeDiscount ?? 0)} đ"),
                      ],
                    ),
                  ),
                  if ((order.productDiscountAmount ?? 0) != 0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá Sản phẩm"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(order.productDiscountAmount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if ((order.voucherDiscountAmount ?? 0) != 0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá Voucher"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(order.voucherDiscountAmount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if ((order.comboDiscountAmount ?? 0) != 0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá Combo"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(order.comboDiscountAmount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if ((order.discount ?? 0) != 0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Chiết khấu"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(order.discount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  Divider(
                    height: 1,
                  ),
                  if ((order.bonusPointsAmountUsed ?? 0) != 0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá xu"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(order.bonusPointsAmountUsed ?? 0)} đ"),
                        ],
                      ),
                    ),
                  Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tổng tiền"),
                        Text(
                            "${SahaStringUtils().convertToMoney(order.totalFinal ?? 0)} đ"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 8,
                    color: Colors.grey[200],
                  ),
                  SahaButtonFullParent(
                    text: "Đóng",
                    textColor:
                        Theme.of(context).primaryTextTheme.headline6!.color,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Container(
                    height: 8,
                    color: Colors.grey[200],
                  ),
                ],
              ),
              Positioned(
                  height: 45,
                  width: 45,
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  ))
            ],
          );
        });
  }

  static void showOrderEdit(EditOrderController homeController) {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        context: Get.context!,
        builder: (BuildContext context) {
          return Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Chi tiết đơn hàng",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tạm tính"),
                        Text(
                            "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.totalBeforeDiscount ?? 0)} đ"),
                      ],
                    ),
                  ),
                  if ((homeController.cartCurrent.value.cartData
                      ?.productDiscountAmount ??
                      0) !=
                      0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá Sản phẩm"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.productDiscountAmount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if ((homeController.cartCurrent.value.cartData
                      ?.voucherDiscountAmount ??
                      0) !=
                      0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá Voucher"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.voucherDiscountAmount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if ((homeController.cartCurrent.value.cartData
                      ?.comboDiscountAmount ??
                      0) !=
                      0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá Combo"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.comboDiscountAmount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if ((homeController.cartCurrent.value.cartData?.discount ??
                      0) !=
                      0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Chiết khấu"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.discount ?? 0)} đ"),
                        ],
                      ),
                    ),
                  if ((homeController.cartCurrent.value.cartData
                      ?.bonusPointsAmountUsed ??
                      0) !=
                      0)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giảm giá xu"),
                          Text(
                              "- ${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.bonusPointsAmountUsed ?? 0)} đ"),
                        ],
                      ),
                    ),
                  Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Tổng tiền"),
                        Text(
                            "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.cartData?.totalFinal ?? 0)} đ"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 8,
                    color: Colors.grey[200],
                  ),
                  SahaButtonFullParent(
                    text: "Đóng",
                    textColor:
                    Theme.of(context).primaryTextTheme.headline6!.color,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Container(
                    height: 8,
                    color: Colors.grey[200],
                  ),
                ],
              ),
              Positioned(
                  height: 45,
                  width: 45,
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  ))
            ],
          );
        });
  }
}
