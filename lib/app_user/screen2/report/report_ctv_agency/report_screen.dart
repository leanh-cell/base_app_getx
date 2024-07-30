import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/screen2/report/report_ctv_agency/option_report/chart_business.dart';
import 'package:com.ikitech.store/app_user/screen2/report/report_ctv_agency/option_report/report_order.dart';
import 'package:com.ikitech.store/app_user/screen2/report/report_ctv_agency/report_controller.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../saha_data_controller.dart';
import '../../../components/saha_user/loading/loading_shimmer.dart';
import '../../../utils/date_utils.dart';
import '../choose_time/choose_time_screen.dart';

// ignore: must_be_immutable
class ReportScreen extends StatelessWidget {
  int? collaboratorByCustomerId;
  int? agencyByCustomerId;
  DateTime? fromDate;
  DateTime? toDate;
  bool? isCtv;

  ReportScreen({
    this.collaboratorByCustomerId,
    this.agencyByCustomerId,
    this.fromDate,
    this.toDate,
    this.isCtv,
  }) {
    reportController = Get.put(ReportControllerCtvAgency(
        collaboratorByCustomerId: collaboratorByCustomerId,
        agencyByCustomerId: agencyByCustomerId,
        fromDateInput: fromDate,
        toDateInput: toDate,
        isCtv: isCtv,
    ));
  }
  late ReportControllerCtvAgency reportController;
  RefreshController _refreshController = RefreshController();
  SahaDataController sahaDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tổng quan"),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: MaterialClassicHeader(),
        controller: _refreshController,
        onRefresh: () async {
          await reportController.refresh();
          _refreshController.refreshCompleted();
        },
        child: SingleChildScrollView(
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
              Obx(() => reportController.isLoading.value
                  ? SahaSimmer(
                      isLoading: true,
                      child: Container(
                        width: Get.width,
                        height: Get.height,
                        color: Colors.black,
                      ))
                  : Column(
                      children: [
                        BusinessChart(
                          isCtv: collaboratorByCustomerId != null,
                          isAgency: agencyByCustomerId != null,
                        ),
                      ],
                    ))
            ],
          ),
        ),
      ),
    );
  }

  Widget head() {
    return InkWell(
      onTap: () {
        print(agencyByCustomerId != null || collaboratorByCustomerId != null);
        Get.to(() => ChooseTimeScreen(
                  isCompare: true,
                  hideCompare: false,
                  initTab: reportController.indexTabTimeSave,
                  fromDayInput: reportController.fromDay.value,
                  toDayInput: reportController.toDay.value,
                  initChoose: reportController.indexChooseSave,
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
                    reportController.indexTabTimeSave = indexTab;
                    reportController.indexChooseSave = indexChoose;
                    reportController.isCompare.value = isCompare;
                  },
                ))!
            .then((value) => {
                  reportController.getReport(),
                });
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => reportController.fromDay.value != reportController.toDay.value
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
                : reportController.fromDay.value.day == DateTime.now().day
                    ? Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Theme.of(Get.context!).primaryColor,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Hôm nay: ",
                                    style: TextStyle(
                                        color: Theme.of(Get.context!)
                                            .primaryColor),
                                  ),
                                  Text(
                                      "${SahaDateUtils().getDDMMYY(reportController.fromDay.value)} "),
                                ],
                              ),
                              SizedBox(
                                height:
                                    reportController.isCompare.value ? 10 : 0,
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
                                                reportController
                                                    .toDayCP.value.day
                                            ? Text(
                                                "Đến: ",
                                                style: TextStyle(
                                                    color:
                                                        Theme.of(Get.context!)
                                                            .primaryColor),
                                              )
                                            : Container(),
                                        reportController.fromDayCP.value.day !=
                                                reportController
                                                    .toDayCP.value.day
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
                                        color: Theme.of(Get.context!)
                                            .primaryColor),
                                  ),
                                  Text(
                                      "${SahaDateUtils().getDDMMYY(reportController.fromDay.value)} "),
                                ],
                              ),
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
