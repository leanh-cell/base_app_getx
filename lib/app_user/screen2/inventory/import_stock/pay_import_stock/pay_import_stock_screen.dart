import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_keyboard.dart';
import 'package:com.ikitech.store/app_user/const/const_revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';

import 'pay_import_stock_controller.dart';

class PayImportStockScreen extends StatelessWidget {
  double payMustInput;
  ImportStock importStock;

  PayImportStockScreen(
      {required this.payMustInput, required this.importStock}) {
    payImportStockController = PayImportStockController(
        payMustInput: payMustInput, importStock: importStock);
  }
  late PayImportStockController payImportStockController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn phương thức thanh toán"),
      ),
      body: Obx(
        () => Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Tổng tiền cần trả",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${SahaStringUtils().convertToMoney(payImportStockController.payMust.value)}",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 30,
            ),
            if (payImportStockController.isCash.value == 999)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      payImportStockController.isCash.value =
                          PAYMENT_TYPE_TRANSFER;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(
                          top: 20, left: 30, right: 30, bottom: 20),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/credit_card.svg",
                            height: 100,
                            width: 100,
                          ),
                          Text("Chuyển khoản"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      payImportStockController.isCash.value = PAYMENT_TYPE_CASH;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(
                          top: 20, left: 30, right: 30, bottom: 20),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/transfer_money.svg",
                            height: 100,
                            width: 100,
                          ),
                          Text("Tiền mặt"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            if (payImportStockController.isCash.value != 999)
              Column(
                children: [
                  Divider(
                    height: 1,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thanh toán",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            PopupKeyboard().showDialogInputKeyboard(
                                maxInput:
                                    "${payImportStockController.payMust.value.round()}",
                                numberInput:
                                    "${payImportStockController.payAmount.value.round()}",
                                title: "Tiền thanh toán",
                                confirm: (number) {
                                  payImportStockController.payAmount.value =
                                      number;
                                });
                          },
                          child: Row(
                            children: [
                              Obx(
                                () => SvgPicture.asset(
                                  "${payImportStockController.isCash.value == PAYMENT_TYPE_TRANSFER ? "assets/icons/credit_card.svg" : "assets/icons/transfer_money.svg"}",
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Obx(() => Text(
                                  "${payImportStockController.isCash.value == PAYMENT_TYPE_TRANSFER ? "Chuyển khoản" : "Tiền mặt"}")),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey)),
                                child: Text(
                                  "${SahaStringUtils().convertToMoney(payImportStockController.payAmount.value)}",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  payImportStockController.isCash.value = 999;
                                },
                                child: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Còn lại cần thanh toán"),
                            Spacer(),
                            Text(
                                "${SahaStringUtils().convertToMoney(payImportStockController.payMust.value - payImportStockController.payAmount.value)}"),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
            if (payImportStockController.isCash.value != 999)
              InkWell(
                onTap: () {
                  payImportStockController.isCash.value = 999;
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Đổi phương thức thanh toán",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Xác nhận",
              onPressed: () {
                payImportStockController.paymentImportStock();
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
