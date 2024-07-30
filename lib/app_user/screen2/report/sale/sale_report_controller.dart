import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/product_report_response.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/report/report_response.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../report_controller.dart';
import '../report_ctv_agency/report_controller.dart';
import 'option_report/chart_business.dart';

class SaleReportController extends GetxController {
  var timeNow = DateTime.now().obs;
  var listChart = RxList<Chart?>();
  var indexOption = 0.obs;
  var isTotalChart = true.obs;

  var reportPrimeTime = DataPrimeTime().obs;
  var reportCompareTime = DataCompareTime().obs;
  var isOpenOrderDetail = false.obs;
  var isLoading = false.obs;

  var differenceTotalFinal = 0.0.obs;
  var differenceOrder = 0.0.obs;
  var differenceCTV = 0.0.obs;
  var differenceRefCTV = 0.0.obs;
  var percentTotalFinal = 0.0.obs;
  var percentOrder = 0.0.obs;
  var percentCTV = 0.0.obs;
  var percentRefCTV = 0.0.obs;

  List<String> listNameChartType = ["Doanh thu:", "Số đơn:", "số CTV:"];
  List<String> listMonth = [
    "Tháng 1",
    "Tháng 2",
    "Tháng 3",
    "Tháng 4",
    "Tháng 5",
    "Tháng 6",
    "Tháng 7",
    "Tháng 8",
    "Tháng 9",
    "Tháng 10",
    "Tháng 11",
    "Tháng 12",
  ];

  var listLineChart = RxList<LineSeries<SalesData?, String>>();

  /// order report_ctv_agency

  var orderPartiallyPaid = Chart().obs;
  var orderWaitingProcess = Chart().obs;
  var orderShipping = Chart().obs;
  var orderCompleted = Chart().obs;
  var orderCustomerCancel = Chart().obs;
  var orderUserCancel = Chart().obs;
  var orderWaitingReturn = Chart().obs;
  var orderWaitingRefunds = Chart().obs;
  var indexChart = 0.obs;
  int? collaboratorByCustomerId;
  int? agencyByCustomerId;
  int? indexTabTimeSave;
  int? indexChooseSave;
  bool? isAll;
  DateTime? fromDateInput;
  DateTime? toDateInput;

  ReportController reportController = Get.find();

  SaleReportController({
    this.collaboratorByCustomerId,
    this.agencyByCustomerId,
    this.fromDateInput,
    this.toDateInput,
  }) {
    if (fromDateInput != null) {
      reportController.fromDay.value = fromDateInput!;
    } else {
      reportController.fromDay.value = timeNow.value;
    }
    if (toDateInput != null) {
      reportController.toDay.value = toDateInput!;
    } else {
      reportController.toDay.value = timeNow.value;
    }
    if (collaboratorByCustomerId != null) {
      listNameChartType = ["Doanh thu:", "Số đơn:", "CTV giới thiệu:"];
    }

    // getReports();
  }

  Future<void> refresh() async {
    reportController. fromDay.value = timeNow.value;
    reportController. toDay.value = timeNow.value;
    getReports();
  }

  void changeTypeChart(int index) {
    indexChart.value = index;
  }

  void openAndCloseOrderDetail() {
    isOpenOrderDetail.value = !isOpenOrderDetail.value;
  }

  Future<void> getReports() async {
    isLoading.value = true;
    try {
      DetailsByPaymentStatus? detailsByPaymentStatus;
      DetailsByOrderStatus? detailsByOrderStatus;
      var res = await RepositoryManager.reportRepository.getReport(
        reportController.fromDay.value.toIso8601String(),
        reportController.toDay.value.toIso8601String(),
        reportController.fromDayCP.value.toIso8601String(),
        reportController.toDayCP.value.toIso8601String(),
        collaboratorByCustomerId,
        agencyByCustomerId,
      );

      reportPrimeTime.value = res!.data!.dataPrimeTime!;
      reportCompareTime.value = res.data!.dataCompareTime ??
          DataCompareTime(totalOrderCount: 1000000);
      differenceTotalFinal.value = reportPrimeTime.value.totalFinal! -
          reportCompareTime.value.totalFinal!;
      differenceOrder.value = reportPrimeTime.value.totalOrderCount! -
          reportCompareTime.value.totalOrderCount!;
      differenceCTV.value =
          reportPrimeTime.value.totalCollaboratorRegCount!.toDouble() -
              reportCompareTime.value.totalCollaboratorRegCount!.toDouble();
      differenceRefCTV.value =
          reportPrimeTime.value.totalReferralOfCustomerCount!.toDouble() -
              reportCompareTime.value.totalReferralOfCustomerCount!.toDouble();
      percentTotalFinal.value = differenceTotalFinal.value.abs() *
          100 /
          (reportPrimeTime.value.totalFinal! + 1);
      percentOrder.value = differenceOrder.value.abs() *
          100 /
          (reportPrimeTime.value.totalOrderCount! + 1);

      percentCTV.value = differenceCTV.value.abs() *
          100 /
          (reportPrimeTime.value.totalCollaboratorRegCount! + 1);

      percentRefCTV.value = differenceRefCTV.value.abs() *
          100 /
          (reportPrimeTime.value.totalReferralOfCustomerCount! + 1);

      detailsByPaymentStatus = res.data!.dataPrimeTime!.detailsByPaymentStatus;
      detailsByOrderStatus = res.data!.dataPrimeTime!.detailsByOrderStatus;
      orderPartiallyPaid.value = detailsByPaymentStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByPaymentStatus!.partiallyPaid!;
      orderWaitingProcess.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!
              .waitingForProgressing!;
      orderShipping.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.shipping!;
      orderCompleted.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.completed!;
      orderCustomerCancel.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.customerCancelled!;
      orderUserCancel.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.userCancelled!;
      orderWaitingReturn.value = detailsByOrderStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByOrderStatus!.customerReturning!;
      orderWaitingRefunds.value = detailsByPaymentStatus == null
          ? Chart(totalOrderCount: 0, totalFinal: 0)
          : res.data!.dataPrimeTime!.detailsByPaymentStatus!.refunds!;
      getProductReport();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  /// chart_product

  var listTotalItemPr = RxList<TotalItem>();
  var listNumberOrderPr = RxList<NumberOfOrder>();
  var listPricePr = RxList<TotalPrice>();
  var listViewPr = RxList<View>();
  var listNameProductTop = RxList<String>();
  var listPropertiesTop = RxList<int>();
  var listProductInChart = RxList<List<dynamic>>();
  var listChooseChartProduct = RxList<bool>([true, false, false, false]);
  var indexTypeChart = 0.obs;

  List<String> listNameChartProduct = [
    "Top Số lượng:",
    "Top Số đơn:",
    "Top Tổng thu:",
    "Top lượt xem:"
  ];

  void changeChooseChartProduct(int index) {
    listChooseChartProduct([false, false, false, false]);
    listChooseChartProduct[index] = true;
    listChooseChartProduct.refresh();
    indexTypeChart.value = index;
  }

  Future<void> getProductReport() async {
    try {
      var res = await RepositoryManager.reportRepository.getProductReport(
        reportController.fromDay.value.toIso8601String(),
        reportController.toDay.value.toIso8601String(),
      );
      listTotalItemPr(res!.data!.totalItems);
      listNumberOrderPr(res.data!.numberOfOrders);
      listPricePr(res.data!.totalPrice);
      listViewPr(res.data!.view);
      listNameProductTop([
        listTotalItemPr.isEmpty ? "" : listTotalItemPr[0].product!.name!,
        listNumberOrderPr.isEmpty ? "" : listNumberOrderPr[0].product!.name!,
        listPricePr.isEmpty ? "" : listPricePr[0].product!.name!,
        listViewPr.isEmpty ? "" : listViewPr[0].product!.name!,
      ]);
      listPropertiesTop([
        listTotalItemPr.isEmpty ? 0 : listTotalItemPr[0].totalItems!,
        listNumberOrderPr.isEmpty ? 0 : listNumberOrderPr[0].numberOfOrders!,
        listPricePr.isEmpty ? 0 : listPricePr[0].totalPrice!.toInt(),
        listViewPr.isEmpty ? 0 : listViewPr[0].view!,
      ]);
      listProductInChart(
          [listTotalItemPr, listNumberOrderPr, listPricePr, listViewPr]);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
    isLoading.refresh();
    print("===============");
  }
}
