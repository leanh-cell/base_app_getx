import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

class DialogChooseOrderStatus {
  static void showChoose(Function onReturn, String codeInput) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        print(codeInput);
        Widget buttonStatus(
            {required String text,
            String? code,
            Function? onTap,
            double? width,
            Color? color,
            String? codeInput}) {
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
                    width: width ?? (Get.width / 3 - 8),
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

        Color checkStatus(
          String code,
        ) {
          if (code == PACKING) {
            if (codeInput == WAIT_FOR_PAYMENT ||
                codeInput == WAITING_FOR_PROGRESSING ||
                codeInput == PACKING) {
              return Colors.blue;
            } else {
              return Colors.grey;
            }
          }

          if (code == SHIPPING) {
            if (codeInput == WAIT_FOR_PAYMENT ||
                codeInput == WAITING_FOR_PROGRESSING ||
                codeInput == PACKING ||
                codeInput == SHIPPING) {
              return Colors.blue;
            } else {
              return Colors.grey;
            }
          }

          if (code == COMPLETED) {
            if (codeInput == WAIT_FOR_PAYMENT ||
                codeInput == WAITING_FOR_PROGRESSING ||
                codeInput == PACKING ||
                codeInput == SHIPPING ||
                codeInput == COMPLETED) {
              return Colors.blue;
            } else {
              return Colors.grey;
            }
          }

          return Colors.grey;
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
                  code: PACKING,
                  width: Get.width / 3 - 24,
                  text: ORDER_STATUS_DEFINE[PACKING]!,
                  onTap: (code) {
                    if (checkStatus(PACKING) == Colors.grey) {
                      SahaAlert.showToastMiddle(
                          message: "Không thể chuyển về trạng thái cũ");
                    } else {
                      onReturn(code);
                    }
                  },
                  codeInput: codeInput,
                  color: checkStatus(PACKING),
                ),
                Icon(Icons.arrow_forward),
                buttonStatus(
                  code: SHIPPING,
                  width: Get.width / 3 - 24,
                  text: ORDER_STATUS_DEFINE[SHIPPING]!,
                  onTap: (code) {
                    if (checkStatus(SHIPPING) == Colors.grey) {
                      SahaAlert.showToastMiddle(
                          message: "Không thể chuyển về trạng thái cũ");
                    } else {
                      onReturn(code);
                    }
                  },
                  codeInput: codeInput,
                  color: checkStatus(SHIPPING),
                ),
                Icon(Icons.arrow_forward),
                buttonStatus(
                  code: COMPLETED,
                  width: Get.width / 3 - 24,
                  text: ORDER_STATUS_DEFINE[COMPLETED]!,
                  onTap: (code) {
                    if (checkStatus(COMPLETED) == Colors.grey) {
                      SahaAlert.showToastMiddle(
                          message: "Không thể chuyển về trạng thái cũ");
                    } else {
                      onReturn(code);
                    }
                  },
                  codeInput: codeInput,
                  color: checkStatus(COMPLETED),
                ),
              ],
            ),
            Row(
              children: [
                buttonStatus(
                    code: OUT_OF_STOCK,
                    text: ORDER_STATUS_DEFINE[OUT_OF_STOCK]!,
                    codeInput: codeInput,
                    onTap: (code) {
                      if (codeInput == COMPLETED) {
                        SahaAlert.showToastMiddle(
                            message: "Không thể chuyển về trạng thái cũ");
                      } else {
                        onReturn(code);
                      }
                    }),
                buttonStatus(
                    code: USER_CANCELLED,
                    text: ORDER_STATUS_DEFINE[USER_CANCELLED]!,
                    codeInput: codeInput,
                    onTap: (code) {
                      if (codeInput == COMPLETED) {
                        SahaAlert.showToastMiddle(
                            message: "Không thể chuyển về trạng thái cũ");
                      } else {
                        onReturn(code);
                      }
                    }),
                buttonStatus(
                    code: CUSTOMER_CANCELLED,
                    text: ORDER_STATUS_DEFINE[CUSTOMER_CANCELLED]!,
                    codeInput: codeInput,
                    onTap: (code) {
                      if (codeInput == COMPLETED) {
                        SahaAlert.showToastMiddle(
                            message: "Không thể chuyển về trạng thái cũ");
                      } else {
                        onReturn(code);
                      }
                    }),
              ],
            ),
            Row(
              children: [
                buttonStatus(
                    code: DELIVERY_ERROR,
                    text: ORDER_STATUS_DEFINE[DELIVERY_ERROR]!,
                    codeInput: codeInput,
                    onTap: (code) {
                      if (codeInput == COMPLETED) {
                        SahaAlert.showToastMiddle(
                            message: "Không thể chuyển về trạng thái cũ");
                      } else {
                        onReturn(code);
                      }
                    }),
                buttonStatus(
                    code: CUSTOMER_RETURNING,
                    text: ORDER_STATUS_DEFINE[CUSTOMER_RETURNING]!,
                    codeInput: codeInput,
                    onTap: (code) {
                      if (codeInput == COMPLETED) {
                        SahaAlert.showToastMiddle(
                            message: "Không thể chuyển về trạng thái cũ");
                      } else {
                        onReturn(code);
                      }
                    }),
                buttonStatus(
                  code: CUSTOMER_HAS_RETURNS,
                  text: ORDER_STATUS_DEFINE[CUSTOMER_HAS_RETURNS]!,
                  codeInput: codeInput,
                  onTap: (code) {
                    if (codeInput == COMPLETED ||
                        codeInput == SHIPPING ||
                        codeInput == CUSTOMER_CANCELLED) {
                      onReturn(code);
                    } else {
                      SahaAlert.showToastMiddle(
                          message:
                              "Đơn chưa hoàn thành không thể chuyển trạng thái đơn hoàn tiền");
                    }
                  },
                  color: codeInput == COMPLETED ? Colors.blueAccent : null,
                ),
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
