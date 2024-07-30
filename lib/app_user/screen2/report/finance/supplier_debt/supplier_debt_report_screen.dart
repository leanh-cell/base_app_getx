import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/model/supplier.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/suppliers/suppliers_profile/suppliers_profile_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'supplier_debt_report_controller.dart';

class SupplierDebtReportScreen extends StatelessWidget {
  SupplierDebtReportController supplierDebtReportController =
      SupplierDebtReportController();
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Công nợ phải trả NCC"),
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
                    supplierDebtReportController.date.value = date;
                    supplierDebtReportController.getAllSupplierDebtReport(
                        isRefresh: true);
                  },
                      currentTime: supplierDebtReportController.date.value,
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
                          "${SahaDateUtils().getDDMMYY(supplierDebtReportController.date.value)}",
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
                            supplierDebtReportController.isLoading.value
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
                    await supplierDebtReportController.getAllSupplierDebtReport(
                        isRefresh: true);
                    refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    await supplierDebtReportController
                        .getAllSupplierDebtReport();
                    refreshController.loadComplete();
                  },
                  child: SingleChildScrollView(
                    child: Obx(
                      () => supplierDebtReportController.listSupplier.isEmpty
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
                              ...supplierDebtReportController.listSupplier
                                  .map((e) => itemSupplier(
                                        onTap: () {
                                          Get.to(() => SuppliersProfileScreen(
                                              supplier: e));
                                        },
                                        supplier: e,
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
                      "Phải trả",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      "${SahaStringUtils().convertToMoney(supplierDebtReportController.allSupplierDebtReport.value.debt ?? 0)}",
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

  Widget itemSupplier({required Supplier supplier, required Function onTap}) {
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
                    Text(supplier.name ?? ""),
                    Text(
                      "${supplier.phone ?? ""}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  "${SahaStringUtils().convertToMoney(supplier.debt ?? 0)}",
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
