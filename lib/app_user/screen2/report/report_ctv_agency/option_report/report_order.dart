import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/screen2/report/report_ctv_agency/report_controller.dart';

import '../../sale/widget/item_report_order.dart';

// ignore: must_be_immutable
class ReportOrder extends StatelessWidget {
  bool? isAll;

  ReportOrder({this.isAll});

  ReportControllerCtvAgency reportController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              reportController.openAndCloseOrderDetail();
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    child: SvgPicture.asset(
                      "assets/icons/check_list.svg",
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    " Hoá đơn: ",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "Chi tiết",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 21,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          Obx(
            () => AnimatedContainer(
              height: reportController.isOpenOrderDetail.value
                  ? isAll != false
                      ? 435
                      : 240
                  : 0,
              duration: Duration(milliseconds: 300),
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: [
                      if (isAll != false)
                        ItemReportOrder(
                          text: "Đơn đã cọc: ",
                          totalOrder: reportController
                              .orderPartiallyPaid.value.totalOrderCount!
                              .toInt(),
                          totalPrice: reportController
                              .orderPartiallyPaid.value.totalFinal!,
                        ),
                      if (isAll != false)
                        ItemReportOrder(
                          text: "Chưa thanh toán: ",
                          totalOrder: reportController
                              .orderUnPaid.value.totalOrderCount!
                              .toInt(),
                          totalPrice:
                              reportController.orderUnPaid.value.totalFinal!,
                        ),
                      ItemReportOrder(
                        text: "Chờ xử lý: ",
                        totalOrder: reportController
                            .orderWaitingProcess.value.totalOrderCount!
                            .toInt(),
                        totalPrice: reportController
                            .orderWaitingProcess.value.totalFinal!,
                      ),
                      ItemReportOrder(
                        text: "Đang giao hàng: ",
                        totalOrder: reportController
                            .orderShipping.value.totalOrderCount!
                            .toInt(),
                        totalPrice:
                            reportController.orderShipping.value.totalFinal!,
                      ),
                      ItemReportOrder(
                        text: "Đã hoàn thành: ",
                        totalOrder: reportController
                            .orderCompleted.value.totalOrderCount!
                            .toInt(),
                        totalPrice:
                            reportController.orderCompleted.value.totalFinal!,
                      ),
                      ItemReportOrder(
                        text: "Khách huỷ: ",
                        totalOrder: reportController
                            .orderCustomerCancel.value.totalOrderCount!
                            .toInt(),
                        totalPrice: reportController
                            .orderCustomerCancel.value.totalFinal!,
                      ),
                      ItemReportOrder(
                        text: "Shop huỷ: ",
                        totalOrder: reportController
                            .orderUserCancel.value.totalOrderCount!
                            .toInt(),
                        totalPrice:
                            reportController.orderUserCancel.value.totalFinal!,
                      ),
                      if (isAll != false)
                        ItemReportOrder(
                          text: "Chờ trả hàng: ",
                          totalOrder: reportController
                              .orderWaitingReturn.value.totalOrderCount!
                              .toInt(),
                          totalPrice: reportController
                              .orderWaitingReturn.value.totalFinal!,
                        ),
                      if (isAll != false)
                        ItemReportOrder(
                          text: "Đã hoàn tiền : ",
                          totalOrder: reportController
                              .orderWaitingRefunds.value.totalOrderCount!
                              .toInt(),
                          totalPrice: reportController
                              .orderWaitingRefunds.value.totalFinal!,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 3,
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }
}
