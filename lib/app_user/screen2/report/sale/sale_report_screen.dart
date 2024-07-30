import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:com.ikitech.store/app_user/screen2/report/choose_time/choose_time_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/report/report_controller.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../saha_data_controller.dart';
import 'option_report/chart_business.dart';
import 'option_report/chart_product.dart';
import 'sale_report_controller.dart';

// ignore: must_be_immutable
class SaleReportScreen extends StatelessWidget {
  int? collaboratorByCustomerId;
  int? agencyByCustomerId;
  DateTime? fromDate;
  DateTime? toDate;

  SaleReportScreen({
    this.collaboratorByCustomerId,
    this.agencyByCustomerId,
    this.fromDate,
    this.toDate,
  }) {
    saleReportController = Get.put(SaleReportController(
        collaboratorByCustomerId: collaboratorByCustomerId,
        agencyByCustomerId: agencyByCustomerId,
        fromDateInput: fromDate,
        toDateInput: toDate));
    saleReportController.getReports();
  }

  ReportController reportController = Get.find();

  RefreshController _refreshController = RefreshController();

  SahaDataController sahaDataController = Get.find();
  late SaleReportController saleReportController;
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: MaterialClassicHeader(),
      controller: _refreshController,
      onRefresh: () async {
        await saleReportController.refresh();
        _refreshController.refreshCompleted();
      },
      child: Obx(
        () => saleReportController.isLoading.value
            ? SahaLoadingFullScreen()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 4,
                      color: Colors.grey[200],
                    ),
                    head(),
                    Container(
                      height: 4,
                      color: Colors.grey[200],
                    ),
                    Column(
                      children: [
                        BusinessChart(
                          isCtv: collaboratorByCustomerId != null,
                          isAgency: agencyByCustomerId != null,
                        ),
                        ChartProduct(),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget head() {
    return InkWell(
      onTap: () {
        Get.to(() => ChooseTimeScreen(
                  isCompare: reportController.isCompare.value,
                  hideCompare: agencyByCustomerId != null ||
                      collaboratorByCustomerId != null,
                  initTab: reportController.indexTabTime,
                  fromDayInput: reportController.fromDay.value,
                  toDayInput: reportController.toDay.value,
                  fromDayCpInput: reportController.fromDayCP.value,
                  toDayCpInput: reportController.toDayCP.value,
                  initChoose: reportController.indexChooseTime,
                  callback: (DateTime fromDate,
                      DateTime toDay,
                      DateTime fromDateCP,
                      DateTime toDayCP,
                      bool isCompare,
                      int? indexTab,
                      int? indexChoose) {
                    reportController.fromDay.value = fromDate;
                    reportController.toDay.value = toDay;
                    reportController.fromDayCP.value = fromDateCP;
                    reportController.toDayCP.value = toDayCP;
                    reportController.indexTabTime = indexTab ?? 0;
                    reportController.indexChooseTime = indexChoose ?? 0;
                    reportController.isCompare.value = isCompare;
                  },
                ))!
            .then((value) => {
                  saleReportController.getReports(),
                });
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => !SahaDateUtils()
                    .getDate(reportController.fromDay.value)
                    .isAtSameMomentAs(
                        SahaDateUtils().getDate(reportController.toDay.value))
                ? Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Từ: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  "${SahaDateUtils().getDDMMYY(reportController.fromDay.value)} "),
                              Text(
                                "Đến: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  "${SahaDateUtils().getDDMMYY(reportController.toDay.value)}"),
                            ],
                          ),
                          reportController.isCompare.value
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Vs: ",
                                          style: TextStyle(
                                              color: Theme.of(Get.context!)
                                                  .primaryColor),
                                        ),
                                        Text(
                                            "${SahaDateUtils().getDDMMYY(reportController.fromDayCP.value)} "),
                                        Text(
                                          "Đến: ",
                                          style: TextStyle(
                                              color: Theme.of(Get.context!)
                                                  .primaryColor),
                                        ),
                                        Text(
                                            "${SahaDateUtils().getDDMMYY(reportController.toDayCP.value)}"),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 21,
                        color: Theme.of(Get.context!).primaryColor,
                      )
                    ],
                  )
                : Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Ngày: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  "${SahaDateUtils().getDDMMYY(reportController.fromDay.value)} "),
                            ],
                          ),
                          if (reportController.isCompare.value)
                            SizedBox(
                              height: 10,
                            ),
                          reportController.isCompare.value
                              ? Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Vs: ",
                                      style: TextStyle(
                                          color: Theme.of(Get.context!)
                                              .primaryColor),
                                    ),
                                    Text(
                                        "${SahaDateUtils().getDDMMYY(reportController.fromDayCP.value)} "),
                                    reportController.fromDayCP.value.day !=
                                            reportController.toDayCP.value.day
                                        ? Text(
                                            "Đến: ",
                                            style: TextStyle(
                                                color: Theme.of(Get.context!)
                                                    .primaryColor),
                                          )
                                        : Container(),
                                    reportController.fromDayCP.value.day !=
                                            reportController.toDayCP.value.day
                                        ? Text(
                                            "${SahaDateUtils().getDDMMYY(reportController.toDayCP.value)}")
                                        : Container(),
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 21,
                        color: Theme.of(Get.context!).primaryColor,
                      )
                    ],
                  ),
          )),
    );
  }
}
