import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../saha_data_controller.dart';
import 'choose_time/choose_time_screen.dart';
import 'finance/customer_debt/customer_debt_report_screen.dart';
import 'finance/profit_loss/profit_loss_report_screen.dart';
import 'finance/revenue_expenditure/revenue_expenditure_report_screen.dart';
import 'finance/supplier_debt/supplier_debt_report_screen.dart';
import 'inventory/import_stock/import_stock_report_screen.dart';
import 'inventory/inventory_history/inventory_history_report_screen.dart';
import 'inventory/product_ie_stock/product_ie_stock_screen.dart';
import 'report_controller.dart';
import 'sale/sale_report_screen.dart';
import 'widget/widget_report.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  ReportController reportController = Get.put(ReportController());
  RefreshController refreshControllerInventory = RefreshController();
  RefreshController refreshControllerFinance = RefreshController();
  SahaDataController sahaDataController = Get.find();
  @override
  void initState() {
    _tabController = TabController(length: checkDecent(), vsync: this);
    super.initState();
  }

  int checkDecent() {
    var length = 0;
    if (sahaDataController.badgeUser.value.decentralization?.reportOverview ==
        true) {
      length = length + 1;
    }

    if (sahaDataController.badgeUser.value.decentralization?.reportInventory ==
        true) {
      length = length + 1;
    }

    if (sahaDataController.badgeUser.value.decentralization?.reportFinance ==
        true) {
      length = length + 1;
    }

    return length;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Báo cáo"),
      ),
      body: Column(
        children: [
          Divider(
            height: 1,
          ),
          Row(
            children: [
              SizedBox(
                height: 45,
                width: Get.width,
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    if (sahaDataController
                            .badgeUser.value.decentralization?.reportOverview ==
                        true)
                      Tab(
                          child: Text('BÁN HÀNG',
                              style: TextStyle(color: Colors.black))),
                    if (sahaDataController.badgeUser.value.decentralization
                            ?.reportInventory ==
                        true)
                      Tab(
                          child: Text('KHO',
                              style: TextStyle(color: Colors.black))),
                    if (sahaDataController
                            .badgeUser.value.decentralization?.reportFinance ==
                        true)
                      Tab(
                          child: Text('TÀI CHÍNH',
                              style: TextStyle(color: Colors.black))),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              if (sahaDataController
                      .badgeUser.value.decentralization?.reportOverview ==
                  true)
                SaleReportScreen(
                  fromDate: reportController.fromDay.value,
                  toDate: reportController.toDay.value,
                ),
              if (sahaDataController
                      .badgeUser.value.decentralization?.reportInventory ==
                  true)
                inventory(),
              if (sahaDataController
                      .badgeUser.value.decentralization?.reportFinance ==
                  true)
                finance(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget inventory() {
    reportController.getProductIEStock(isRefresh: true);
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: MaterialClassicHeader(),
      footer: CustomFooter(
        builder: (
          BuildContext context,
          LoadStatus? mode,
        ) {
          Widget body = Container();
          if (mode == LoadStatus.idle) {
            body = Obx(() => reportController.isLoading.value
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
      controller: refreshControllerInventory,
      onRefresh: () async {
        reportController.fromDay.value = DateTime.now();
        reportController.toDay.value = DateTime.now();
        await reportController.getProductIEStock(isRefresh: true);
        refreshControllerInventory.refreshCompleted();
      },
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            reportController.getProductIEStock(isRefresh: true),
                          });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Obx(
                    () => Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${SahaDateUtils().getDDMMYY2(reportController.fromDay.value)} - ${SahaDateUtils().getDDMMYY2(reportController.toDay.value)}",
                              style: TextStyle(fontSize: 12),
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded)
                          ],
                        ),
                        Spacer(),
                        Text("${sahaDataController.branchCurrent.value.name}")
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Obx(
                () => Container(
                  height: (Get.height / 2) - 15,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Icon(
                          Icons.inventory,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "TỒN KHO CUỐI KỲ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${SahaStringUtils().convertToMoney(reportController.allProductIEStock.value.totalAmountEnd ?? 0)}",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "SL: ${SahaStringUtils().convertToMoney(reportController.allProductIEStock.value.stockCountEnd ?? 0)}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "* Số liệu bao gồm các sản phẩm đang giao dịch",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nhập trong kỳ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${SahaStringUtils().convertToMoney((reportController.allProductIEStock.value.importTotalAmount ?? 0))}",
                              )
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Xuất trong kỳ",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${SahaStringUtils().convertToMoney((reportController.allProductIEStock.value.exportTotalAmount ?? 0))}",
                              )
                            ],
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Giá trị tồn kho = Số lượng * Giá vốn",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Giá vốn (MAC) là bình quân giá sản phẩm được tính sau mỗi lần nhập hàng",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
                child: Text(
                  "XEM BÁO CÁO CHI TIẾT",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              ItemDetailReport(
                asset: "assets/icons/box.svg",
                title: "Báo cáo tồn kho",
                sub: "Tổng hợp giá trị và số lượng sản phẩm tồn kho",
                onTap: () {
                  Get.to(() => ImportStockReportScreen());
                },
              ),
              ItemDetailReport(
                asset: "assets/icons/accounting.svg",
                title: "Sổ kho",
                sub: "Quản lý luồng xuất kho, nhập kho",
                onTap: () {
                  Get.to(() => InventoryHistoryReportScreen());
                },
              ),
              ItemDetailReport(
                asset: "assets/icons/inventory.svg",
                title: "Xuất nhập tồn",
                sub: "Quản lý giá trị xuất nhập, tồn kho theo sản phẩm",
                onTap: () {
                  Get.to(() => ProductIEStockScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget finance() {
    Widget itemChart() {
      reportController.getProfitAndLoss();
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(
              () => Row(
                children: [
                  Text("LỢI NHUẬN"),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.to(() => ProfitLossReportScreen());
                    },
                    child: Text(
                      "${SahaStringUtils().convertToMoney(reportController.profitLoss.value.profit ?? 0)}",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(
              () => Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Tỷ suất LN : ${(((reportController.profitLoss.value.profit ?? 0) / (reportController.profitLoss.value.salesRevenue == null || reportController.profitLoss.value.salesRevenue == 0 ? 1 : reportController.profitLoss.value.salesRevenue!)) * 100).toStringAsFixed(1)}%",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(
                      () => Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: Colors.green,
                          ),
                          if (reportController.listProfitLoss.length == 2)
                            Text(
                              " ${SahaStringUtils().convertToUnit(reportController.profitUp.value)}%",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => Container(
                  padding: const EdgeInsets.all(5.0),
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                        isInversed: true,
                        labelIntersectAction: AxisLabelIntersectAction.wrap,
                        maximumLabelWidth: 200),
                    primaryYAxis: NumericAxis(
                      numberFormat: NumberFormat.compact(),
                    ),
                    tooltipBehavior: TooltipBehavior(
                      enable: true,
                      header: "Lợi nhuận",
                    ),
                    series: <ColumnSeries<FinanceReport, String>>[
                      ColumnSeries<FinanceReport, String>(
                        width: 0.4,
                        markerSettings: MarkerSettings(
                            isVisible: true,
                            height: 4,
                            width: 4,
                            shape: DataMarkerType.circle,
                            borderWidth: 2,
                            borderColor: Theme.of(context).primaryColor),
                        dataSource: <FinanceReport>[
                          ...List.generate(
                            reportController.listProfitLoss.length,
                            (index) => FinanceReport(
                              reportController.listXAxisString[index],
                              reportController.listProfitLoss[index].profit ??
                                  0,
                            ),
                          ),
                        ],
                        xValueMapper: (FinanceReport sales, _) => sales.x,
                        yValueMapper: (FinanceReport sales, _) => sales.y,
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
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lợi nhuận = Doanh thu bán hàng - Chi phí bán hàng + Lợi nhuận khác",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "*Các số liệu được lấy từ báo cáo lãi lỗ của cửa hàng",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    }

    Widget itemRevenueExpenditure() {
      reportController.getAllRevenueExpenditureReport();
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: Icon(
                Icons.monetization_on,
                color: Colors.white,
              ),
            ),
            Text(
              "TỒN QUỸ CUỐI KỲ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Obx(
              () => Text(
                "${SahaStringUtils().convertToMoney(reportController.allRevenueExpenditureReport.value.reserve ?? 0)}",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10.0),
              child: Obx(
                () => Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tổng thu",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${SahaStringUtils().convertToMoney(reportController.allRevenueExpenditureReport.value.renvenure ?? 0)}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Tổng chi",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${SahaStringUtils().convertToMoney(reportController.allRevenueExpenditureReport.value.expenditure ?? 0)}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Tồn quỹ cuối kỳ = Tồn quỹ đầu kỳ + Tổng thu + Tổng chi",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Tổng thu: Tổng giá trị các phiếu thu trong kỳ",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "Tổng chi: Tổng giá trị các phiếu chi trong kỳ",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }

    Widget itemDebt() {
      reportController.getAllSupplierDebtReport();
      reportController.getAllCustomerDebtReport();
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "CÔNG NỢ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/inventory.svg",
                        height: 50,
                        width: 50,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "PHẢI THU",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 13,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Obx(
                        () => Text(
                          "${SahaStringUtils().convertToMoney(reportController.allCustomerDebtReport.value.debt ?? 0)}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 100,
                  color: Colors.grey[300],
                ),
                Expanded(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/inventory.svg",
                        height: 50,
                        width: 50,
                        color: Colors.green,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "PHẢI TRẢ",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 13,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Obx(
                        () => Text(
                          "${SahaStringUtils().convertToMoney(reportController.allSupplierDebtReport.value.debt ?? 0)}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Công nợ trên là công nợ của toàn hệ thống được tính đến ngày ${SahaDateUtils().getDDMMYY(reportController.toDay.value)}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Phải thu: Công nợ phải thu của khách hàng",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "Phải chi: Công nợ phải trả nhà cung cấp",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      );
    }

    var listWidget = [itemChart(), itemRevenueExpenditure(), itemDebt()];
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: MaterialClassicHeader(),
      footer: CustomFooter(
        builder: (
          BuildContext context,
          LoadStatus? mode,
        ) {
          Widget body = Container();
          if (mode == LoadStatus.idle) {
            body = Obx(() => reportController.isLoading.value
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
      controller: refreshControllerFinance,
      onRefresh: () async {
        reportController.fromDay.value = DateTime.now();
        reportController.toDay.value = DateTime.now();
        reportController.getAllSupplierDebtReport();
        reportController.getAllCustomerDebtReport();
        reportController.getProfitAndLoss();
        refreshControllerFinance.refreshCompleted();
      },
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      .then((value) {
                    reportController.getProfitAndLoss();
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Obx(
                    () => Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${SahaDateUtils().getDDMMYY2(reportController.fromDay.value)} - ${SahaDateUtils().getDDMMYY2(reportController.toDay.value)}",
                              style: TextStyle(fontSize: 12),
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded)
                          ],
                        ),
                        Spacer(),
                        Text("${sahaDataController.branchCurrent.value.name}")
                      ],
                    ),
                  ),
                ),
              ),
              CarouselSlider(
                  items: listWidget
                      .map((e) => Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 5),
                            width: Get.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: e,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: Get.height / 2,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: (va, reason) {
                      reportController.page.value = va;
                    },
                    scrollDirection: Axis.horizontal,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: listWidget.map((url) {
                  int index = listWidget.indexOf(url);
                  return Obx(
                    () => Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: reportController.page.value == index
                            ? Color.fromRGBO(0, 0, 0, 0.6)
                            : Color.fromRGBO(0, 0, 0, 0.2),
                      ),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0, right: 20, left: 20),
                child: Text(
                  "XEM BÁO CÁO CHI TIẾT",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              ItemDetailReport(
                asset: "assets/icons/box.svg",
                title: "Báo cáo lãi lỗ",
                sub:
                    "Hiển thị doanh thu, chi phí và lãi lỗ của cửa hàng trong kỳ",
                onTap: () {
                  Get.to(() => ProfitLossReportScreen());
                },
              ),
              ItemDetailReport(
                asset: "assets/icons/accounting.svg",
                title: "Sổ quỹ",
                sub: "Quản lý luồng tiền ra, vào cửa hàng",
                onTap: () {
                  Get.to(() => RevenueExpenditureReportScreen());
                },
              ),
              ItemDetailReport(
                asset: "assets/icons/inventory.svg",
                title: "Công nợ phải thu",
                sub: "Tổng hợp công nợ phải thu của khách hàng",
                onTap: () {
                  Get.to(() => CustomerDebtReportScreen());
                },
              ),
              ItemDetailReport(
                asset: "assets/icons/inventory.svg",
                title: "Công nợ phải trả",
                sub: "Tổng hợp công nợ phải trả nhà cung cấp",
                onTap: () {
                  Get.to(() => SupplierDebtReportScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FinanceReport {
  FinanceReport(this.x, this.y);
  final String x;
  final double y;
}
