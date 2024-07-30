import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/screen2/report/report_ctv_agency/report_controller.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../components/saha_user/text/text_money.dart';
import '../../../../utils/date_utils.dart';

// ignore: must_be_immutable
class BusinessChart extends StatefulWidget {
  bool? isCtv;
  bool? isAgency;
  BusinessChart({this.isCtv, this.isAgency});

  @override
  _BusinessChartState createState() => _BusinessChartState();
}

class _BusinessChartState extends State<BusinessChart> {
  ReportControllerCtvAgency reportController = Get.find();

  late List<Widget> listChart;

  @override
  void initState() {
    if (widget.isCtv == true) {
      listChart = [
        chart(
            chartTitle: "Doanh thu",
            typeChart: reportController.reportPrimeTime.value.charts!
                .map((e) => e!.totalFinal)
                .toList(),
            typeChartCP: reportController.reportCompareTime.value.charts!
                .map((e) => e!.totalFinal)
                .toList()),
        chart(
            chartTitle: "Số đơn",
            typeChart: reportController.reportPrimeTime.value.charts!
                .map((e) => e!.totalOrderCount)
                .toList(),
            typeChartCP: reportController.reportCompareTime.value.charts!
                .map((e) => e!.totalOrderCount)
                .toList()),
        chart(
            chartTitle: "Số CTV",
            typeChart: reportController.reportPrimeTime.value.charts!
                .map((e) => e!.totalReferralOfCustomerCount!.toDouble())
                .toList(),
            typeChartCP: reportController.reportCompareTime.value.charts!
                .map((e) => e!.totalReferralOfCustomerCount!.toDouble())
                .toList()),
      ];
    } else {
      listChart = [
        chart(
            chartTitle: "Doanh thu",
            typeChart: reportController.reportPrimeTime.value.charts!
                .map((e) => e!.totalFinal)
                .toList(),
            typeChartCP: reportController.reportCompareTime.value.charts!
                .map((e) => e!.totalFinal)
                .toList()),
        chart(
            chartTitle: "Số đơn",
            typeChart: reportController.reportPrimeTime.value.charts!
                .map((e) => e!.totalOrderCount)
                .toList(),
            typeChartCP: reportController.reportCompareTime.value.charts!
                .map((e) => e!.totalOrderCount)
                .toList()),
        chart(
            chartTitle: "Số CTV",
            typeChart: reportController.reportPrimeTime.value.charts!
                .map((e) => e!.totalCollaboratorRegCount!.toDouble())
                .toList(),
            typeChartCP: reportController.reportCompareTime.value.charts!
                .map((e) => e!.totalCollaboratorRegCount!.toDouble())
                .toList()),
      ];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var checkLandscape = context.isLandscape;
    return Column(
      children: [
        checkLandscape == true
            ? Container()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Spacer(),
                        Icon(
                          Icons.read_more_outlined,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 115,
                    width: Get.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.all(8),
                      itemCount: widget.isAgency == true ? 2 : 3,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            reportController.changeTypeChart(index);
                          },
                          child: Obx(
                            () => Stack(
                              children: [
                                Container(
                                  height: 77,
                                  margin: EdgeInsets.all(4.0),
                                  padding: EdgeInsets.all(4.0),
                                  width: (Get.width - 60) / 2,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: (reportController
                                                      .indexChart.value ==
                                                  index
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey[500])!),
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      reportController.isCompare.value
                                          ? index == 0
                                              ? Text(
                                                  "${reportController.listNameChartType[index]} ${reportController.reportPrimeTime.value.totalFinal! != 0 ? reportController.differenceTotalFinal.value > 0 ? ' tăng ${reportController.percentTotalFinal.value.toInt()}%' : ' giảm ${reportController.percentTotalFinal.value.toInt()}%' : ""}",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )
                                              : index == 1
                                                  ? Text(
                                                      "${reportController.listNameChartType[index]} ${reportController.reportPrimeTime.value.totalFinal! != 0 ? reportController.differenceOrder.value > 0 ? ' tăng ${reportController.percentOrder.value.toInt()}%' : ' giảm ${reportController.percentOrder.value.toInt()}%' : ""}",
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    )
                                                  : widget.isCtv != true
                                                      ? Text(
                                                          "${reportController.listNameChartType[index]} ${reportController.reportPrimeTime.value.totalCollaboratorRegCount! != 0 ? reportController.differenceCTV.value > 0 ? ' tăng ${reportController.percentCTV.value.toInt()}%' : ' giảm ${reportController.percentCTV.value.toInt()}%' : ""}",
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        )
                                                      : Text(
                                                          "${reportController.listNameChartType[index]} ${reportController.reportPrimeTime.value.totalReferralOfCustomerCount! != 0 ? reportController.differenceRefCTV.value > 0 ? ' tăng ${reportController.percentRefCTV.value.toInt()}%' : ' giảm ${reportController.percentRefCTV.value.toInt()}%' : ""}",
                                                          style: TextStyle(
                                                              fontSize: 13),
                                                        )
                                          : Text(
                                              "${reportController.listNameChartType[index]}",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      index == 1
                                          ? Text(
                                              "${reportController.reportPrimeTime.value.totalOrderCount!.toInt()}",
                                              style: TextStyle(fontSize: 13),
                                            )
                                          : index == 0
                                              ? SahaMoneyText(
                                                  price: reportController
                                                      .reportPrimeTime
                                                      .value
                                                      .totalFinal,
                                                  fontWeight: FontWeight.w400,
                                                  sizeVND: 12,
                                                  sizeText: 13,
                                                )
                                              : widget.isCtv != true
                                                  ? Text(
                                                      "${reportController.reportPrimeTime.value.totalCollaboratorRegCount!.toInt()}",
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    )
                                                  : Text(
                                                      "${reportController.reportPrimeTime.value.totalReferralOfCustomerCount!.toInt()}",
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      reportController.isCompare.value
                                          ? index == 1
                                              ? Text(
                                                  "${reportController.differenceOrder.value > 0 ? '+ ${reportController.differenceOrder.value.toInt().abs()}' : '- ${reportController.differenceOrder.value.toInt().abs()}'}",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )
                                              : index == 0
                                                  ? reportController
                                                              .differenceTotalFinal
                                                              .value >
                                                          0
                                                      ? Row(
                                                          children: [
                                                            Text(
                                                              "+ ",
                                                              style: TextStyle(
                                                                  fontSize: 13),
                                                            ),
                                                            SahaMoneyText(
                                                              price: reportController
                                                                  .differenceTotalFinal
                                                                  .value,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              sizeVND: 12,
                                                              sizeText: 13,
                                                            ),
                                                          ],
                                                        )
                                                      : Row(
                                                          children: [
                                                            Text(
                                                              "- ",
                                                              style: TextStyle(
                                                                  fontSize: 13),
                                                            ),
                                                            SahaMoneyText(
                                                              price: reportController
                                                                  .differenceTotalFinal
                                                                  .value
                                                                  .abs(),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              sizeVND: 12,
                                                              sizeText: 13,
                                                            ),
                                                          ],
                                                        )
                                                  : Text(
                                                      "${reportController.differenceCTV.value > 0 ? '+ ${reportController.differenceCTV.value.toInt().abs()}' : '- ${reportController.differenceCTV.value.toInt().abs()}'}",
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    )
                                          : Container(),
                                    ],
                                  ),
                                ),
                                reportController.indexChart.value == index
                                    ? Positioned(
                                        height: 30,
                                        width: 30,
                                        top: 5,
                                        right: 5,
                                        child: SvgPicture.asset(
                                          "assets/icons/levels.svg",
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      )
                                    : Container(),
                                reportController.indexChart.value == index
                                    ? Positioned(
                                        height: 15,
                                        width: 15,
                                        top: 5,
                                        right: 5,
                                        child: Icon(
                                          Icons.check,
                                          size: 15,
                                          color: Theme.of(context)
                                              .primaryTextTheme
                                              .headline6!
                                              .color,
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
        Obx(
          () => listChart[reportController.indexChart.value],
        ),
      ],
    );
  }

  Widget chart({
    required String chartTitle,
    required List<double?> typeChartCP,
    required List<double?> typeChart,
  }) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: 500,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        // Chart title
        onTrackballPositionChanging: (TrackballArgs args) {
          args.chartPointInfo.header =
              DateFormat('H:m').format(args.chartPointInfo.chartDataPoint!.x);
        },
        title: ChartTitle(
            text:
                '${reportController.isCompare.value ? "So sánh chênh lệch $chartTitle" : chartTitle}'),
        // Enable legend
        legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            toggleSeriesVisibility: true),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(
          enable: true,
        ),
        onTooltipRender: (TooltipArgs args) {
          var pointIndex = args.seriesIndex;
          if (pointIndex == 0) {
            args.header = '';
          } else {
            args.header = '';
          }
          // args.text = args.da taPoints[pointIndex].x.toString() +
          //     ' has value of: ' +
          //     args.dataPoints[pointIndex].y.toString();
        },
        primaryYAxis: NumericAxis(
            numberFormat:
                NumberFormat.simpleCurrency(name: "", decimalDigits: 0)),
        series: reportController.isCompare.value
            ? <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                  legendItemText:
                      "${SahaDateUtils().getDDMM(reportController.fromDayCP.value)} Đến ${SahaDateUtils().getDDMM(reportController.toDayCP.value)}",
                  enableTooltip: true,
                  color: Colors.red,
                  markerSettings: MarkerSettings(
                      isVisible: true,
                      height: 4,
                      width: 4,
                      shape: DataMarkerType.circle,
                      borderWidth: 2,
                      borderColor: Colors.red),
                  dataSource: <SalesData>[
                    ...List.generate(
                      typeChartCP.length,
                      (index) => SalesData(
                        '${reportController.reportCompareTime.value.charts![index]!.time == null ? reportController.listMonth[index] : reportController.fromDay.value.day == DateTime.now().day || reportController.fromDay.value.day == DateTime.now().subtract(Duration(days: 1)).day ? "${reportController.reportCompareTime.value.charts![index]!.time!.hour}h" : "${SahaDateUtils().getDDMM(reportController.reportCompareTime.value.charts![index]!.time!)}"}',
                        typeChartCP[index]!,
                      ),
                    )
                  ],
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,

                  // Enable data label
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ),
                LineSeries<SalesData, String>(
                  color: Colors.blue,
                  enableTooltip: true,
                  legendItemText:
                      "${SahaDateUtils().getDDMM(reportController.fromDay.value)} Đến ${SahaDateUtils().getDDMM(reportController.toDay.value)}",
                  markerSettings: MarkerSettings(
                      isVisible: true,
                      height: 4,
                      width: 4,
                      shape: DataMarkerType.circle,
                      borderWidth: 2,
                      borderColor: Colors.blue),
                  dataSource: <SalesData>[
                    ...List.generate(
                      typeChart.length,
                      (index) => SalesData(
                          '${reportController.reportPrimeTime.value.charts![index]!.time == null ? reportController.listMonth[index] : reportController.fromDay.value.day == DateTime.now().day || reportController.fromDay.value.day == DateTime.now().subtract(Duration(days: 1)).day ? "${reportController.reportPrimeTime.value.charts![index]!.time!.hour}h" : "${SahaDateUtils().getDDMM(reportController.reportPrimeTime.value.charts![index]!.time!)}"}',
                          typeChart[index]!),
                    )
                  ],
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ),
              ]
            : <LineSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                  legendItemText:
                      "${SahaDateUtils().getDDMM(reportController.fromDay.value)} Đến ${SahaDateUtils().getDDMM(reportController.toDay.value)}",
                  markerSettings: MarkerSettings(
                      isVisible: true,
                      height: 4,
                      width: 4,
                      shape: DataMarkerType.circle,
                      borderWidth: 2,
                      borderColor: Colors.green),
                  dataSource: <SalesData>[
                    ...List.generate(
                      typeChart.length,
                      (index) => SalesData(
                          '${reportController.reportPrimeTime.value.typeChart == "month" ? reportController.listMonth[index] : reportController.reportPrimeTime.value.typeChart == "hour" ? "${reportController.reportPrimeTime.value.charts![index]!.time!.hour}h" : "${SahaDateUtils().getDDMM(reportController.reportPrimeTime.value.charts![index]!.time!)}"}',
                          typeChart[index]!),
                    )
                  ],
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle: TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ),
              ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
