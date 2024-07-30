import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/suppliers/suppliers_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'import_stock/import_stock_detail_screen.dart';
import 'import_stock_controller.dart';

class ImportStockScreen extends StatelessWidget {
  TextEditingController searchEditingController = TextEditingController();
  var timeInputSearch = DateTime.now();
  bool? isNeedHanding;

  ImportStockScreen({this.isNeedHanding}) {
    importStockController = ImportStockController(isNeedHanding: isNeedHanding);
  }
  late ImportStockController importStockController;
  RefreshController refreshController = RefreshController();
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Đơn nhập hàng"),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (sahaDataController
                        .badgeUser.value.decentralization?.supplier ==
                    false) {
                  SahaAlert.showError(message: "Chức năng NCC bị chặn");
                } else {
                  Get.to(() => SuppliersScreen(
                            isChoose: true,
                          ))!
                      .then((value) => {
                            if (value == "reload")
                              {
                                importStockController.getAllImportStock(
                                    isRefresh: true)
                              },
                            if (value["import_stock"] != null)
                              {
                                importStockController.getAllImportStock(
                                    isRefresh: true),
                                Get.to(() => ImportStockDetailScreen(
                                          importStockInputId:
                                              (value["import_stock"]
                                                          as ImportStock)
                                                      .id ??
                                                  0,
                                        ))!
                                    .then((value) => {
                                          importStockController
                                              .getAllImportStock(
                                                  isRefresh: true)
                                        })
                              }
                          });
                }
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 8, right: 15, bottom: 8),
                  child: Icon(Icons.search),
                ),
                Expanded(
                  child: TextFormField(
                    controller: searchEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          left: 0, right: 15, top: 15, bottom: 0),
                      border: InputBorder.none,
                      hintText: "Nhập mã đơn",
                      hintStyle: TextStyle(fontSize: 15),
                      suffixIcon: IconButton(
                        onPressed: () {
                          importStockController.textSearch = "";
                          importStockController.getAllImportStock(
                              isRefresh: true);
                          searchEditingController.clear();
                        },
                        icon: Icon(Icons.clear),
                      ),
                    ),
                    onChanged: (v) async {
                      importStockController.textSearch = v;
                      importStockController.getAllImportStock(isRefresh: true);
                    },
                    style: TextStyle(fontSize: 14),
                    minLines: 1,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: Obx(
              () => importStockController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : SmartRefresher(
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
                                importStockController.isLoading.value
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
                        await importStockController.getAllImportStock(
                            isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await importStockController.getAllImportStock();
                        refreshController.loadComplete();
                      },
                      child: ListView.builder(
                        itemCount: importStockController.listImportStock.length,
                        itemBuilder: (context, index) {
                          return itemImportStock(
                              importStockController.listImportStock[index]);
                        },
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget itemImportStock(ImportStock importStock) {
    String? getStatus(int status) {
      if (status == 0) {
        return "Đặt hàng";
      }
      if (status == 1) {
        return "Duyệt";
      }
      if (status == 2) {
        return "Nhập kho";
      }
      if (status == 3) {
        return "Hoàn thành";
      }
      if (status == 4) {
        return "Đã huỷ";
      }
      if (status == 5) {
        return "Kết thúc";
      }
      if (status == 6) {
        return "Đơn hoàn trả NCC";
      }
      if (status == 7) {
        return "Đã hoàn hết";
      }
      return "";
    }

    return InkWell(
      onTap: () {
        Get.to(() => ImportStockDetailScreen(
                  importStockInputId: importStock.id ?? 0,
                ))!
            .then((value) =>
                {importStockController.getAllImportStock(isRefresh: true)});
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${importStock.code ?? ""}"),
                    Text(
                      "${importStock.supplier?.name ?? ""}",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Text(
                      "${SahaDateUtils().getDDMM(importStock.updatedAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(importStock.updatedAt ?? DateTime.now())}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "${SahaStringUtils().convertToMoney(importStock.totalFinal ?? 0)}₫",
                      style: TextStyle(
                        color: importStock.status == 1
                            ? Theme.of(Get.context!).primaryColor
                            : null,
                      ),
                    ),
                    Text(
                      "${getStatus(importStock.status ?? 0)}",
                      style: TextStyle(
                          color: importStock.status == 0
                              ? Colors.blue
                              : importStock.status == 1
                                  ? Theme.of(Get.context!).primaryColor
                                  : importStock.status == 4
                                      ? Colors.red
                                      : importStock.status == 3
                                          ? Colors.green
                                          : importStock.status == 6
                                              ? Colors.red
                                              : Colors.grey,
                          fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
