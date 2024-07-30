import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/model/revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/screen2/report/choose_time/choose_time_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/saha_user/dialog/dialog.dart';
import '../../report_controller.dart';
import 'revenue_expenditure_report_controller.dart';

class RevenueExpenditureReportScreen extends StatelessWidget {
  RefreshController refreshController = RefreshController();
  ReportController reportController = Get.find();
  RevenueExpenditureReportController revenueExpenditureReportController =
      RevenueExpenditureReportController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sổ quỹ"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => ChooseTimeScreen(
                            isCompare: reportController.isCompare.value,
                            initTab: reportController.indexTabTime,
                            initChoose: reportController.indexChooseTime,
                            fromDayInput: reportController.fromDay.value,
                            toDayInput: reportController.toDay.value,
                            hideCompare: true,
                            callback: (DateTime fromDate,
                                DateTime toDay,
                                DateTime fromDateCP,
                                DateTime toDayCP,
                                bool isCompare,
                                int index,
                                int indexChoose) {
                              reportController.fromDay.value = fromDate;
                              reportController.toDay.value = toDay;
                              reportController.fromDayCP.value = fromDateCP;
                              reportController.toDayCP.value = toDayCP;
                              reportController.isCompare.value = isCompare;
                              reportController.indexTabTime = index;
                              reportController.indexChooseTime = indexChoose;
                            },
                          ))!
                      .then((value) => {
                            revenueExpenditureReportController
                                .getAllRevenueExpenditureReport(
                              isRefresh: true,
                            )
                          });
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
                          "${SahaDateUtils().getDDMMYY2(reportController.fromDay.value)} - ${SahaDateUtils().getDDMMYY2(reportController.toDay.value)}",
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
                            revenueExpenditureReportController.isLoading.value
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
                    await revenueExpenditureReportController
                        .getAllRevenueExpenditureReport(isRefresh: true);
                    refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    await revenueExpenditureReportController
                        .getAllRevenueExpenditureReport();
                    refreshController.loadComplete();
                  },
                  child: SingleChildScrollView(
                    child: Obx(
                      () => revenueExpenditureReportController
                              .listRevenueExpenditure.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100,
                                ),
                                Text("Chưa có phiếu thu chi nào")
                              ],
                            )
                          : Column(children: [
                              SizedBox(
                                height: 40,
                              ),
                              ...revenueExpenditureReportController
                                  .listRevenueExpenditure
                                  .map((e) => revenueExpenditure(e))
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
                      "Tồn cuối kỳ ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        SahaDialogApp.showDialogSuggestion(
                            title: 'Chú giải thông số',
                            contentWidget: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Divider(),
                                Text(
                                  "Tồn cuối kỳ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('= Dư đầu kỳ + Tổng thu - Tổng chi'),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Trong đó:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        'Dư đầu kỳ là lượng tồn quỹ kỳ trước.'),
                                    Text(
                                      '(Ví dụ: Số dư đầu kỳ của ngày hôm nay = Tồn quỹ tính đến thời điểm cuối ngày hôm qua).',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Divider(),
                                    Text(
                                        'Tổng thu = Tổng các giá trị phiếu thu trong khoảng thời gian lựa chọn.'),
                                    Divider(),
                                    Text(
                                        'Tổng chi = Tổng các giá trị phiếu chi trong khoảng thời gian lựa chọn.'),
                                  ],
                                )
                              ],
                            ));
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            color: Colors.blue,
                            size: 20,
                          ),
                          Text(
                            'i',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${SahaStringUtils().convertToMoney(revenueExpenditureReportController.allRevenueExpenditureReport.value.reserve ?? 0)}",
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

  Widget revenueExpenditure(RevenueExpenditure revenueExpenditure) {
    return InkWell(
      onTap: () {
        // Get.to(() => RevenueExpenditureScreen(
        //   isRevenue: true,
        //   revenueExpenditure: revenueExpenditure,
        //   changeMoney: suppliersProfileController.supplierShow.value.debt,
        //   recipientGroup: RECIPIENT_GROUP_SUPPLIER,
        //   recipientReferencesId:
        //   suppliersProfileController.supplierShow.value.id,
        // ));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${revenueExpenditure.code ?? ""}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${revenueExpenditure.staff?.name ?? ""}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${SahaDateUtils().getDDMMYY(revenueExpenditure.createdAt ?? DateTime.now())} - ${SahaDateUtils().getHHMM(revenueExpenditure.createdAt ?? DateTime.now())}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${SahaStringUtils().convertToMoney(revenueExpenditure.currentMoney ?? 0)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children: [
                        revenueExpenditure.isRevenue == true
                            ? Icon(
                                Icons.arrow_drop_up,
                                color: Colors.blue,
                              )
                            : Icon(
                                Icons.arrow_drop_down,
                                color: Colors.red,
                              ),
                        Text(
                          "${SahaStringUtils().convertToMoney(revenueExpenditure.changeMoney ?? 0)}",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    Text(
                      "${revenueExpenditure.typeActionName ?? ""}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
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
      ),
    );
  }
}
