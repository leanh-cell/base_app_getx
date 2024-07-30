import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/screen2/report/report_ctv_agency/report_controller.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../utils/date_utils.dart';
import '../../../../utils/string_utils.dart';

class ChartProduct extends StatefulWidget {
  @override
  _ChartProductState createState() => _ChartProductState();
}

class _ChartProductState extends State<ChartProduct> {
  ReportControllerCtvAgency reportController = Get.find();
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var checkLandscape = context.isLandscape;
    return Obx(
      () => Column(
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
                      height: 130,
                      width: Get.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              reportController.changeChooseChartProduct(index);
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
                                                        .listChooseChartProduct[
                                                    index]
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey[500])!),
                                        borderRadius: BorderRadius.circular(2)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "${reportController.listNameChartProduct[index]}"),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "${reportController.listNameProductTop[index]}",
                                          maxLines: 1,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                            "${SahaStringUtils().convertToMoney(reportController.listPropertiesTop[index].toDouble())}"),
                                      ],
                                    ),
                                  ),
                                  reportController
                                          .listChooseChartProduct[index]
                                      ? Positioned(
                                          height: 30,
                                          width: 30,
                                          top: 4,
                                          right: 4,
                                          child: SvgPicture.asset(
                                            "assets/icons/levels.svg",
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        )
                                      : Container(),
                                  reportController
                                          .listChooseChartProduct[index]
                                      ? Positioned(
                                          height: 15,
                                          width: 15,
                                          top: 4,
                                          right: 4,
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
          Container(
            padding: const EdgeInsets.all(5.0),
            height: 500,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                  labelIntersectAction: AxisLabelIntersectAction.wrap, maximumLabelWidth: 200),
              primaryYAxis: NumericAxis(numberFormat: NumberFormat.simpleCurrency(name: "",decimalDigits: 0)),
              title: ChartTitle(
                  text:
                      '${reportController.listTotalItemPr.isNotEmpty ? "" : "Lượt xem sản phẩm"}'),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                header: "Hôm nay",
              ),
              series: reportController.listTotalItemPr.isNotEmpty
                  ? <ColumnSeries<ProductReport, String>>[
                      ColumnSeries<ProductReport, String>(
                        width: 0.4,
                        markerSettings: MarkerSettings(
                            isVisible: true,
                            height: 4,
                            width: 4,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: Theme.of(context).primaryColor),
                        dataSource: <ProductReport>[
                          ...List.generate(
                            reportController.indexTypeChart.value == 0
                                ? reportController.listTotalItemPr.length
                                : reportController.indexTypeChart.value == 1
                                    ? reportController.listNumberOrderPr.length
                                    : reportController.indexTypeChart.value ==
                                            2
                                        ? reportController.listPricePr.length
                                        : reportController.listViewPr.length,
                            (index) => ProductReport(
                              '${reportController.indexTypeChart.value == 0 ? reportController.listTotalItemPr[index].product!.name : reportController.indexTypeChart.value == 1 ? reportController.listNumberOrderPr[index].product!.name : reportController.indexTypeChart.value == 2 ? reportController.listPricePr[index].product!.name : reportController.listViewPr[index].product!.name}',
                              reportController.indexTypeChart.value == 0
                                  ? reportController
                                      .listTotalItemPr[index].totalItems!
                                  : reportController.indexTypeChart.value == 1
                                      ? reportController
                                          .listNumberOrderPr[index]
                                          .numberOfOrders!
                                      : reportController
                                                  .indexTypeChart.value ==
                                              2
                                          ? reportController
                                              .listPricePr[index].totalPrice!
                                              .toInt()
                                          : reportController
                                              .listViewPr[index].view!,
                            ),
                          ),
                        ],
                        xValueMapper: (ProductReport sales, _) => sales.year,
                        yValueMapper: (ProductReport sales, _) => sales.sales,
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            textStyle: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                      ),
                    ]
                  : <ColumnSeries<ProductReport, String>>[
                      ColumnSeries<ProductReport, String>(
                        legendItemText:
                            "${SahaDateUtils().getDDMM(reportController.fromDay.value)} Đến ${SahaDateUtils().getDDMM(reportController.toDay.value)}",
                        markerSettings: MarkerSettings(
                            isVisible: true,
                            height: 4,
                            width: 4,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: Theme.of(context).primaryColor),
                        dataSource: <ProductReport>[
                          ...List.generate(
                            reportController.listViewPr.length,
                            (index) => ProductReport(
                              '${reportController.listViewPr[index].product!.name}',
                              reportController.listViewPr[index].view!,
                            ),
                          ),
                        ],
                        xValueMapper: (ProductReport sales, _) => sales.year,
                        yValueMapper: (ProductReport sales, _) => sales.sales,
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
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class ProductReport {
  ProductReport(this.year, this.sales);
  final String year;
  final int sales;
}
