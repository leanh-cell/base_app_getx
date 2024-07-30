import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

class DialogChoosePaymentStatus {
  static void showChoosePayment(Function onReturn, String codeInput) {
    showModalBottomSheet<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        Widget buttonStatus(
            {required String text,
            String? code,
            Function? onTap,
            Color? color,
            codeInput}) {
          return InkWell(
            onTap: () {
              onTap!(code);
            },
            child: Stack(
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 65,
                    width: Get.width / 2 - 8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                            width: 1, color: color ?? Colors.grey[600]!)),
                    child: Center(
                        child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: color ?? Colors.grey[600],
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
                if (codeInput == code)
                  Positioned(
                    height: 30,
                    width: 30,
                    top: 5,
                    right: 5.5,
                    child: SvgPicture.asset(
                      "assets/icons/levels.svg",
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                if (codeInput == code)
                  Positioned(
                    height: 15,
                    width: 15,
                    top: 5,
                    right: 7,
                    child: Icon(
                      Icons.check,
                      size: 15,
                      color:
                          Theme.of(context).primaryTextTheme.headline6!.color,
                    ),
                  ),
              ],
            ),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Chuyển trạng thái",
                style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ),
            Row(
              children: [
                buttonStatus(
                  code: UNPAID,
                  text: ORDER_PAYMENT_DEFINE[UNPAID]!,
                  codeInput: codeInput,
                  onTap: (code) {
                    onReturn(code);
                  },
                  color: Colors.red,
                ),
                buttonStatus(
                  code: PAID,
                  text: ORDER_PAYMENT_DEFINE[PAID]!,
                  codeInput: codeInput,
                  onTap: (code) {
                    onReturn(code);
                  },
                  color: Colors.green,
                ),
              ],
            ),
            Row(
              children: [
                buttonStatus(
                    code: PARTIALLY_PAID,
                    text: ORDER_PAYMENT_DEFINE[PARTIALLY_PAID]!,
                    codeInput: codeInput,
                    onTap: (code) {
                      onReturn(code);
                    }),
                buttonStatus(
                    code: REFUNDS,
                    text: ORDER_PAYMENT_DEFINE[REFUNDS]!,
                    codeInput: codeInput,
                    onTap: (code) {
                      onReturn(code);
                    }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SahaButtonFullParent(
                text: "Thoát",
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }
}
