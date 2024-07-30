import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/const/const_revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/model/payment_history.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';

import 'payment_history_controller.dart';

class PaymentHistoryScreen extends StatelessWidget {
  String orderCode;

  late PaymentHistoryController paymentHistoryController;

  PaymentHistoryScreen({required this.orderCode}) {
    paymentHistoryController = PaymentHistoryController(orderCode: orderCode);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch sử thanh toán"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: paymentHistoryController.listPaymentHistory
                .map((e) => itemHistory(e))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget itemHistory(PaymentHistory paymentHistory) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Tiền trả:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text(
                "${SahaStringUtils().convertToMoney(paymentHistory.money ?? 0)}",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text("Phương thức thanh toán:"),
              Spacer(),
              Text("${namePayment(paymentHistory.paymentMethod ?? 0)}"),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "${SahaDateUtils().getDDMMYY(paymentHistory.createdAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(paymentHistory.createdAt ?? DateTime.now())}",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
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
