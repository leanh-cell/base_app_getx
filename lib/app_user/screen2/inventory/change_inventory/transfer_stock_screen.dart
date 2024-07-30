import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/model/transfer_stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../utils/date_utils.dart';
import 'add_transfer_stock/add_transfer_stock_screen.dart';
import 'transfer_stock_controller.dart';
import 'transfer_stock_detail/transfer_stock_detail_screen.dart';

class TransferStockScreen extends StatefulWidget {
  @override
  State<TransferStockScreen> createState() => _TransferStockScreenState();
}

class _TransferStockScreenState extends State<TransferStockScreen>
    with SingleTickerProviderStateMixin {
  RefreshController refreshController = RefreshController();
  RefreshController refreshController2 = RefreshController();

  TransferStockController transferStockController = TransferStockController();

  late TabController _tabController;

  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chuyển kho"),
      ),
      body: Obx(
        () => transferStockController.isLoadingInit.value
            ? SahaLoadingFullScreen()
            : Column(
                children: [
                  Divider(
                    height: 1,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        width: Get.width,
                        child: TabBar(
                          controller: _tabController,
                          tabs: [
                            Tab(
                                child: Text('CHUYỂN',
                                    style: TextStyle(color: Colors.black))),
                            Tab(
                                child: Text('NHẬN',
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
                      tabSender(),
                      tabRCV(),
                    ]),
                  ),
                ],
              ),
      ),
    );
  }

  Widget tabRCV() {
    TextEditingController searchEditingController = TextEditingController();
    return Column(
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
                    contentPadding:
                        EdgeInsets.only(left: 0, right: 15, top: 15, bottom: 0),
                    border: InputBorder.none,
                    hintText: "Nhập mã phiếu",
                    hintStyle: TextStyle(fontSize: 15),
                    suffixIcon: IconButton(
                      onPressed: () {
                        transferStockController.textSearch = "";
                        transferStockController.getAllTransferStocksRCV(
                            isRefresh: true);
                        searchEditingController.clear();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  onChanged: (v) async {
                    transferStockController.textSearch = v;
                    transferStockController.getAllTransferStocksRCV(
                        isRefresh: true);
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
                  body = Obx(() => transferStockController.isLoading.value
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
              await transferStockController.getAllTransferStocksRCV(
                  isRefresh: true);
              refreshController.refreshCompleted();
            },
            onLoading: () async {
              await transferStockController.getAllTransferStocksRCV();
              refreshController.loadComplete();
            },
            child: SingleChildScrollView(
              child: Obx(
                () => transferStockController.listTransferStock.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Text("Không có phiếu nhận nào")
                        ],
                      )
                    : Column(children: [
                        ...transferStockController.listTransferStock
                            .map((e) => itemTransferStock(e, false))
                            .toList(),
                      ]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tabSender() {
    TextEditingController searchEditingController = TextEditingController();

    return Column(
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
                    contentPadding:
                        EdgeInsets.only(left: 0, right: 15, top: 15, bottom: 0),
                    border: InputBorder.none,
                    hintText: "Nhập mã phiếu",
                    hintStyle: TextStyle(fontSize: 15),
                    suffixIcon: IconButton(
                      onPressed: () {
                        transferStockController.textSearchSender = "";
                        transferStockController.getAllTransferStocksSender(
                            isRefresh: true);
                        searchEditingController.clear();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  onChanged: (v) async {
                    transferStockController.textSearchSender = v;
                    transferStockController.getAllTransferStocksSender(
                        isRefresh: true);
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
                  body = Obx(() => transferStockController.isLoadingSender.value
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
            controller: refreshController2,
            onRefresh: () async {
              await transferStockController.getAllTransferStocksSender(
                  isRefresh: true);
              refreshController2.refreshCompleted();
            },
            onLoading: () async {
              await transferStockController.getAllTransferStocksSender();
              refreshController2.loadComplete();
            },
            child: SingleChildScrollView(
              child: Obx(
                () => transferStockController.listTransferStockSender.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Text("Không có phiếu chuyển nào")
                        ],
                      )
                    : Column(children: [
                        ...transferStockController.listTransferStockSender
                            .map((e) => itemTransferStock(e, true))
                            .toList(),
                      ]),
              ),
            ),
          ),
        ),
        SahaButtonFullParent(
          text: "Tạo phiếu chuyển",
          onPressed: () {
            Get.to(() => AddTransferStockScreen())!.then((value) => {
                  if (value == 'reload')
                    {
                      transferStockController.getAllTransferStocksSender(
                          isRefresh: true)
                    }
                });
          },
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget itemTransferStock(TransferStock transferStock, bool isSender) {
    String? getStatus(int status) {
      if (status == 0) {
        return "Chờ nhận hàng";
      }
      if (status == 1) {
        return "Huỷ";
      }
      if (status == 2) {
        return "Đã nhận hàng";
      }

      return "";
    }

    return InkWell(
      onTap: () {
        Get.to(() => TransferStockDetailScreen(
                  isSender: isSender,
                  transferStockId: transferStock.id ?? 0,
                ))!
            .then((value) => {
                  if (isSender == true)
                    {
                      transferStockController.getAllTransferStocksSender(
                          isRefresh: true)
                    }
                  else
                    {
                      transferStockController.getAllTransferStocksRCV(
                          isRefresh: true)
                    }
                });
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
                    Text("${transferStock.code ?? ""}"),
                    Row(
                      children: [
                        Text(
                          "${transferStock.fromBranch?.name ?? ""}",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 12,
                          color: Colors.blue,
                        ),
                        Text(
                          "${transferStock.toBranch?.name ?? ""}",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                    Text(
                      "${SahaDateUtils().getDDMM(transferStock.updatedAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(transferStock.updatedAt ?? DateTime.now())}",
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
                      "${getStatus(transferStock.status ?? 0)}",
                      style: TextStyle(
                          color: transferStock.status == 0
                              ? Colors.blue
                              : transferStock.status == 1
                                  ? Theme.of(Get.context!).primaryColor
                                  : transferStock.status == 4
                                      ? Colors.red
                                      : transferStock.status == 3
                                          ? Colors.green
                                          : transferStock.status == 6
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
