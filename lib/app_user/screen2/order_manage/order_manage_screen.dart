import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:com.ikitech.store/app_user/screen2/report/choose_time/choose_time_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_order.dart';
import 'package:sahashop_customer/app_customer/screen_default/order_history/order_status_page/widget/order_loading_item_widget.dart';
import 'order_detail_manage/order_detail_manage_screen.dart';
import 'order_manage_controller.dart';
import 'widget/order_item_widget.dart';

class OrderManageScreen extends StatefulWidget {
  int? initPageOrder;
  int? initPagePayment;
  int? stateManager;
  int? agencyId;
  int? ctvId;
  String? phoneNumber;
  DateTime? fromDate;
  DateTime? toDate;
  OrderManageScreen({
    this.initPageOrder,
    this.initPagePayment,
    this.phoneNumber,
    this.stateManager,
    this.agencyId,
    this.ctvId,
    this.fromDate,
    this.toDate,
  });

  @override
  _OrderManageScreenState createState() => _OrderManageScreenState();
}

class _OrderManageScreenState extends State<OrderManageScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  TabController? tabControllerPayment;

  OrderManageController? orderManageController;

  late List<Widget> listStateWidget;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listStateWidget = [stateOrder(), statePayment()];
    orderManageController = Get.put(OrderManageController(
      agencyId: widget.agencyId,
      ctvId: widget.ctvId,
      fromDateInput: widget.fromDate,
      toDateInput: widget.toDate,
      phoneNumber: widget.phoneNumber,
    ));
    orderManageController!.indexStateWatch.value = widget.stateManager ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => listStateWidget[orderManageController!.indexStateWatch.value]);
  }

  Widget buildStateOrder(int indexState) {
    RefreshController _refreshController = RefreshController(
        initialRefresh: orderManageController!.listCheckRefresh[indexState] == 1
            ? true
            : false);

    return SmartRefresher(
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
            body = Obx(() => !orderManageController!.isDoneLoadMore.value
                ? CupertinoActivityIndicator()
                : Container());
          } else if (mode == LoadStatus.loading) {
            body = Obx(() => !orderManageController!.isDoneLoadMore.value
                ? CupertinoActivityIndicator()
                : Container());
          }
          return Container(
            height: 0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: () async {
        await orderManageController!.refreshData(
          orderManageController!.indexStateWatch.value == 0
              ? "order_status_code"
              : "payment_status_code",
          orderManageController!.indexStateWatch.value == 0
              ? orderManageController!.listStatusCode[indexState]
              : orderManageController!.listStatusCodePayment[indexState],
          indexState,
        );
        _refreshController.refreshCompleted();
      },
      onLoading: () async {
        if (orderManageController!.isDoneLoadMore.value) {
          await orderManageController!.loadMoreOrder(
            orderManageController!.indexStateWatch.value == 0
                ? "order_status_code"
                : "payment_status_code",
            orderManageController!.indexStateWatch.value == 0
                ? orderManageController!.listStatusCode[indexState]
                : orderManageController!.listStatusCodePayment[indexState],
            indexState,
          );
        }
        _refreshController.loadComplete();
      },
      child: Obx(
        () => orderManageController!.isLoadInit.value
            ? ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) => OrderLoadingItemWidget())
            : Column(
                children: [
                  head(),
                  Divider(
                    height: 1,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: orderManageController!.listCheckIsEmpty[indexState]
                          ? SahaEmptyOrder()
                          : Column(
                              children: [
                                ...List.generate(
                                  orderManageController!
                                      .listAllOrder[indexState].length,
                                  (index) => OrderItemWidget(
                                    order: orderManageController!
                                        .listAllOrder[indexState][index],
                                    onTap: () {
                                      Get.to(() => OrderDetailScreen(
                                                order: orderManageController!
                                                        .listAllOrder[
                                                    indexState][index],
                                                indexListOrder: index,
                                                indexStateOrder: indexState,
                                              ))!
                                          .then((value) => {
                                                orderManageController!
                                                    .refreshData(
                                                  orderManageController!
                                                              .indexStateWatch
                                                              .value ==
                                                          0
                                                      ? "order_status_code"
                                                      : "payment_status_code",
                                                  orderManageController!
                                                              .indexStateWatch
                                                              .value ==
                                                          0
                                                      ? orderManageController!
                                                              .listStatusCode[
                                                          indexState]
                                                      : orderManageController!
                                                              .listStatusCodePayment[
                                                          indexState],
                                                  indexState,
                                                )
                                              });
                                    },
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget stateOrder() {
    tabController = TabController(
        length: 10, vsync: this, initialIndex: widget.initPageOrder ?? 0);
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        appBar: AppBar(
          title: Obx(
            () => orderManageController!.isSearch.value == true
                ? SahaTextFieldSearch(
                    onSubmitted: (va) {
                      orderManageController!.textSearch = va;
                      orderManageController!.loadInitOrder(
                        orderManageController!.indexStateWatch.value == 0
                            ? "order_status_code"
                            : "payment_status_code",
                        orderManageController!.indexStateWatch.value == 0
                            ? orderManageController!
                                .listStatusCode[tabController!.index]
                            : orderManageController!
                                .listStatusCodePayment[tabController!.index],
                        tabController!.index,
                      );
                    },
                    onClose: () {
                      orderManageController!.textSearch = null;
                      orderManageController!.isSearch.value = false;
                    },
                  )
                : Text(
                    'Trạng thái đơn hàng',
                    style: TextStyle(fontSize: 18),
                  ),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search_outlined),
                onPressed: () {
                  orderManageController!.isSearch.value = true;
                }),
            IconButton(
              onPressed: () {
                sheetButton();
              },
              icon: Icon(Icons.settings),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            controller: tabController,
            tabs: [
              Tab(text: "Chờ xác nhận"),
              Tab(text: "Đang chuẩn bị hàng"),
              Tab(text: "Đang giao hàng"),
              Tab(text: "Đã hoàn thành"),
              Tab(text: "Hết hàng"),
              Tab(text: "Shop huỷ"),
              Tab(text: "Khách đã huỷ"),
              Tab(text: "Lỗi giao hàng"),
              Tab(text: "Chờ trả hàng"),
              Tab(text: "Đã trả hàng"),
            ],
          ),
        ),
        body: Obx(
          () => TabBarView(
            controller: tabController,
            children: List<Widget>.generate(10, (int index) {
              return buildStateOrder(index);
            }),
          ),
        ),
      ),
    );
  }

  Widget statePayment() {
    tabControllerPayment = TabController(
        length: 6, vsync: this, initialIndex: widget.initPagePayment ?? 0);
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Obx(
            () => orderManageController!.isSearch.value == true
                ? SahaTextFieldSearch(
                    onSubmitted: (va) {
                      orderManageController!.textSearch = va;
                      orderManageController!.loadInitOrder(
                        orderManageController!.indexStateWatch.value == 0
                            ? "order_status_code"
                            : "payment_status_code",
                        orderManageController!.indexStateWatch.value == 0
                            ? orderManageController!
                                .listStatusCode[tabControllerPayment!.index]
                            : orderManageController!.listStatusCodePayment[
                                tabControllerPayment!.index],
                        tabControllerPayment!.index,
                      );
                    },
                    onClose: () {
                      orderManageController!.textSearch = null;
                      orderManageController!.isSearch.value = false;
                    },
                  )
                : Text(
                    'Trạng thái thanh toán',
                    style: TextStyle(fontSize: 18),
                  ),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search_outlined),
                onPressed: () {
                  orderManageController!.isSearch.value = true;
                }),
            IconButton(
              onPressed: () {
                sheetButton();
              },
              icon: Icon(Icons.settings),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            controller: tabControllerPayment,
            tabs: [
              Tab(text: "Chờ xác nhận"),
              Tab(text: "Chưa thanh toán"),
              Tab(text: "Đã thanh toán"),
              Tab(text: "Đã cọc tiền"),
              Tab(text: "Đã huỷ"),
              Tab(text: "Đã hoàn tiền"),
            ],
          ),
        ),
        body: Obx(
          () => TabBarView(
            controller: tabControllerPayment,
            children: List<Widget>.generate(6, (int index) {
              return buildStateOrder(index);
            }),
          ),
        ),
      ),
    );
  }

  void sheetButton() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                orderManageController!.changeState(0);
                Get.back();
              },
              child: Container(
                  padding: EdgeInsets.all(10),
                  height: 50,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.format_list_bulleted),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Trạng thái đơn hàng',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  )),
            ),
            Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {
                orderManageController!.changeState(1);
                Get.back();
              },
              child: Container(
                  height: 50,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.monetization_on_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Trạng thái thanh toán',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  )),
            ),
            Divider(
              height: 1,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget head() {
    return InkWell(
      onTap: () {
        Get.to(() => ChooseTimeScreen(
                  isCompare: false,
                  hideCompare: true,
                  initTab: orderManageController!.indexTabTimeSave,
                  fromDayInput: orderManageController!.dateFrom.value,
                  toDayInput: orderManageController!.dateTo.value,
                  initChoose: orderManageController!.indexChooseSave,
                  callback: (DateTime fromDate,
                      DateTime toDay,
                      DateTime fromDateCP,
                      DateTime toDayCP,
                      bool isCompare,
                      int? indexTab,
                      int? indexChoose) {
                    orderManageController!.dateFrom.value = fromDate;
                    orderManageController!.dateTo.value = toDay;
                    orderManageController!.indexTabTimeSave = indexTab;
                    orderManageController!.indexChooseSave = indexChoose;
                  },
                ))!
            .then((value) => {
                  orderManageController!.chooseTime.value = true,
                  orderManageController!.refreshData(
                    orderManageController!.indexStateWatch.value == 0
                        ? "order_status_code"
                        : "payment_status_code",
                    orderManageController!.indexStateWatch.value == 0
                        ? orderManageController!
                            .listStatusCode[tabController!.index]
                        : orderManageController!
                            .listStatusCodePayment[tabControllerPayment!.index],
                    orderManageController!.indexStateWatch.value == 0
                        ? tabController!.index
                        : tabControllerPayment!.index,
                  )
                });
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => orderManageController!.dateFrom.value !=
                    orderManageController!.dateTo.value
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                      orderManageController!.chooseTime.value != true
                          ? Row(
                              children: [
                                Text("  Tất cả"),
                              ],
                            )
                          : Column(
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
                                          color: Theme.of(Get.context!)
                                              .primaryColor),
                                    ),
                                    Text(
                                        "${SahaDateUtils().getDDMMYY(orderManageController!.dateFrom.value)} "),
                                    Text(
                                      "Đến: ",
                                      style: TextStyle(
                                          color: Theme.of(Get.context!)
                                              .primaryColor),
                                    ),
                                    Text(
                                        "${SahaDateUtils().getDDMMYY(orderManageController!.dateTo.value)}"),
                                  ],
                                ),
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
                : orderManageController!.dateFrom.value.day ==
                        DateTime.now().day
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
                                      "${SahaDateUtils().getDDMMYY(orderManageController!.dateFrom.value)} "),
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
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                    "Ngày: ",
                                    style: TextStyle(
                                        color: Theme.of(Get.context!)
                                            .primaryColor),
                                  ),
                                  Text(
                                      "${SahaDateUtils().getDDMMYY(orderManageController!.dateFrom.value)} "),
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
