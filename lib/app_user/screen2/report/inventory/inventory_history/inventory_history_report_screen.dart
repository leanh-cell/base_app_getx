import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/const/const_revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/model/history_inventory.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/check_inventory/tally_sheet/tally_sheet_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/import_stock/import_stock/import_stock_detail_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/report/choose_time/choose_time_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/report/report_controller.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/saha_user/dialog/dialog.dart';
import 'inventory_history_report_controller.dart';

class InventoryHistoryReportScreen extends StatelessWidget {
  InventoryHistoryReportController inventoryHistoryReportController =
      InventoryHistoryReportController();
  RefreshController refreshController = RefreshController();

  ReportController reportController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sổ kho"),
      ),
      body: Column(
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
                        inventoryHistoryReportController.getAllHistoryInventory(
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
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 10, right: 10),
                width: Get.width,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/import.svg",
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Giá trị nhập kho",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Obx(
                            () => Text(
                              "${SahaStringUtils().convertToMoney(inventoryHistoryReportController.allHistoryInventory.value.importValue ?? 0)}",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              "SL: ${SahaStringUtils().convertToMoney(inventoryHistoryReportController.allHistoryInventory.value.countImport ?? 0)}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 1,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/export.svg",
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Giá trị xuất kho",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Obx(
                            () => Text(
                              "${SahaStringUtils().convertToMoney(inventoryHistoryReportController.allHistoryInventory.value.exportValue ?? 0)}",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              "SL: ${SahaStringUtils().convertToMoney(inventoryHistoryReportController.allHistoryInventory.value.countExport ?? 0)}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 20,
                top: 5,
                child: InkWell(
                  onTap: () {
                    SahaDialogApp.showDialogSuggestion(
                        title: 'Chú giải thông số',
                        contentWidget: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Divider(),
                            Text(
                              "Giá trị nhập kho",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.blue),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('= Số lượng nhập kho x Giá nhập'),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Trong đó:',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Số lượng nhập kho: Số lượng sản phẩm nhập vào kho theo tiêu chí chọn lên báo cáo'),
                                Divider(),
                                Text(
                                    'Giá nhập: Đã bao gồm chiết khấu, chi phí khi nhập hàng'),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Giá trị xuất kho",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.red),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('= Số lượng xuất kho x Giá nhập'),
                            SizedBox(
                              height: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Trong đó:',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Số lượng xuất kho: Số lượng sản phẩm xuất kho theo tiêu chí chọn lên báo cáo'),
                                Divider(),
                                Text('Giá vốn: Giá vốn tại thời điểm xuất kho'),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Lưu ý: ',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Giá trị tồn kho và số lượng tồn kho trong báo cáo sổ quỹ được ghi nhận tại thời điểm hiện tại',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                            ),
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
              )
            ],
          ),
          SizedBox(
            height: 10,
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
                        inventoryHistoryReportController.isLoading.value
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
                await inventoryHistoryReportController.getAllHistoryInventory(
                  isRefresh: true,
                );
                refreshController.refreshCompleted();
              },
              onLoading: () async {
                await inventoryHistoryReportController.getAllHistoryInventory();
                refreshController.loadComplete();
              },
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: inventoryHistoryReportController
                        .listHistoryInventory
                        .map((e) => itemHistoryInventory(e))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemHistoryInventory(HistoryInventory historyInventory) {
    int checkStock() {
      return (historyInventory.change ?? 0);
    }

    return InkWell(
      onTap: () {
        // const TYPE_TALLY_SHEET_STOCK = 1; //Cân bằng kiểm kho
        // const TYPE_IMPORT_STOCK
        if (TYPE_EDIT_STOCK == historyInventory.type) {
          Get.to(() => TallySheetScreen(
                tallySheetInputId: historyInventory.referencesId ?? 0,
              ));
        } else if (TYPE_TALLY_SHEET_STOCK == historyInventory.type) {
          Get.to(() => TallySheetScreen(
                tallySheetInputId: historyInventory.referencesId ?? 0,
              ));
        } else if (TYPE_IMPORT_STOCK == historyInventory.type) {
          Get.to(() => ImportStockDetailScreen(
                importStockInputId: historyInventory.referencesId ?? 0,
              ));
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${historyInventory.product?.name ?? ""}${historyInventory.elementDistribute?.name != null ? " - " : ""}${historyInventory.elementDistribute?.name ?? ""}${historyInventory.subElementDistribute?.name != null ? ", " : ""}${historyInventory.subElementDistribute?.name ?? ""}",
                        style: TextStyle(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${SahaDateUtils().getDDMMYY(historyInventory.createdAt ?? DateTime.now())}",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${historyInventory.referencesValue ?? ""}",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${SahaStringUtils().convertToMoney((historyInventory.changeMoney ?? 0))}",
                      style: TextStyle(
                          color: checkStock() < 0 ? Colors.red : Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "SL: ${(historyInventory.change ?? 0) > 0 ? "+" : ""}${historyInventory.change ?? 0}",
                      style: TextStyle(
                          color: checkStock() < 0 ? Colors.red : Colors.blue),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${historyInventory.typeName ?? ""}",
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
