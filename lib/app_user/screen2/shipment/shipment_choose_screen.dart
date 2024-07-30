import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';

import '../../components/saha_user/popup/popup_keyboard.dart';
import '../../utils/string_utils.dart';
import 'shipment_suggestion/shipment_suggestion_screen.dart';

class ShipmentChooseScreen extends StatelessWidget {
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Phí giao hàng"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Get.width,
              color: Colors.grey.withOpacity(0.1),
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Text(
                "Đây là phí giao hàng cửa hàng thu của khách hàng",
                style: TextStyle(color: Colors.grey[600]),
              )),
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          homeController.cartCurrent.value.totalShippingFee = 0;
                          homeController.cartCurrent.refresh();
                          homeController.updateInfoCart();
                          Get.back();
                        },
                        child: Container(
                          padding:
                              EdgeInsets.only(right: 10, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Text("Miễn phí giao hàng"),
                              Spacer(),
                              if ((homeController
                                          .cartCurrent.value.totalShippingFee ??
                                      0) ==
                                  0)
                                Icon(
                                  Icons.check,
                                  color: Colors.blue,
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
                                  "${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.totalShippingFee ?? 0)}",
                              title: "Phí vận chuyển",
                              confirm: (number) {
                                homeController.cartCurrent.value
                                    .totalShippingFee = number;
                                homeController.cartCurrent.refresh();
                                homeController.updateInfoCart();
                                Get.back();
                              });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.only(right: 10, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              Text(
                                "Khác ${(homeController.cartCurrent.value.totalShippingFee ?? 0) != 0 ? "(${SahaStringUtils().convertToMoney(homeController.cartCurrent.value.totalShippingFee ?? 0)})" : ""}",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                              Spacer(),
                              if ((homeController
                                          .cartCurrent.value.totalShippingFee ??
                                      0) !=
                                  0)
                                Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {
                Get.to(() => ShipmentSuggestion());
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Phí dự kiến của đối tác vận chuyển",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
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
}
