import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/screen2/info_customer/info_customer_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/model/info_customer.dart';

import 'customer_debt_report_controller.dart';

class CustomerDebtReportScreen extends StatelessWidget {
  CustomerDebtReportController customerDebtReportController =
      CustomerDebtReportController();
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Công nợ phải thu Khách hàng"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  dp.DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1999, 1, 1),
                      maxTime: DateTime.now(),
                      theme: dp.DatePickerTheme(
                          headerColor: Colors.white,
                          backgroundColor: Colors.white,
                          itemStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.black, fontSize: 16)),
                      onChanged: (date) {}, onConfirm: (date) {
                    customerDebtReportController.date.value = date;
                    customerDebtReportController.getAllCustomerDebtReport(
                        isRefresh: true);
                  },
                      currentTime: customerDebtReportController.date.value,
                      locale: dp.LocaleType.vi);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Obx(
                        () => Text(
                          "${SahaDateUtils().getDDMMYY(customerDebtReportController.date.value)}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded)
                    ],
                  ),
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
                      Widget body = Container();
                      if (mode == LoadStatus.idle) {
                        body = Obx(() =>
                            customerDebtReportController.isLoading.value
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
                    await customerDebtReportController.getAllCustomerDebtReport(
                        isRefresh: true);
                    refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    await customerDebtReportController
                        .getAllCustomerDebtReport();
                    refreshController.loadComplete();
                  },
                  child: SingleChildScrollView(
                    child: Obx(
                      () => customerDebtReportController.listCustomer.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100,
                                ),
                                Text("Chưa có phiếu công nợ nào")
                              ],
                            )
                          : Column(children: [
                              SizedBox(
                                height: 40,
                              ),
                              ...customerDebtReportController.listCustomer
                                  .map((e) => itemCustomer(
                                        onTap: () {
                                          Get.to(() => InfoCustomerScreen(
                                                infoCustomerId: e.id!,
                                                isWatch: true,
                                              ));
                                        },
                                        infoCustomer: e,
                                      ))
                                  .toList(),
                            ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 35,
            child: Container(
              width: Get.width - 20,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Obx(
                () => Row(
                  children: [
                    Text(
                      "Tổng khách hàng nợ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      "${SahaStringUtils().convertToMoney(customerDebtReportController.allCustomerDebtReport.value.debt ?? 0)}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemCustomer(
      {required InfoCustomer infoCustomer, required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(infoCustomer.name ?? ""),
                    Text(
                      "${infoCustomer.phoneNumber ?? ""}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  "${SahaStringUtils().convertToMoney(infoCustomer.debt ?? 0)}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
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
