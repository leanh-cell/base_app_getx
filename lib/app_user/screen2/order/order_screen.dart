import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_order.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_products_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_container.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/const/order_constant.dart';
import 'package:com.ikitech.store/app_user/model/filter_order.dart';
import 'package:com.ikitech.store/app_user/screen2/bill/bill_detail/bill_detail_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/order_manage/order_detail_manage/order_detail_manage_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

import 'filter_order/filter_order_screen.dart';
import 'list_filter_order/list_filter_order_screen.dart';
import 'order_controller.dart';

class OrderScreen extends StatelessWidget {
  TextEditingController searchEditingController = TextEditingController();
  OrderController orderController = Get.find();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
       FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Đơn hàng"),
          actions: [
            Obx(() => !orderController.isChooseAll.value
                ? Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            orderController.isList.value =
                                !orderController.isList.value;
                            UserInfo()
                                .setIsFullOrder(orderController.isList.value);
                          },
                          icon: Obx(() => Icon(!orderController.isList.value
                              ? Icons.list
                              : Icons.apps))),
                      IconButton(
                          onPressed: () {
                            showSheetMoreVert();
                          },
                          icon: Icon(Icons.more_vert_rounded)),
                    ],
                  )
                : TextButton(
                    onPressed: () {
                      orderController.isChooseAll.value = false;
                      orderController.listOrderChoose([]);
                    },
                    child: Text(
                      "Huỷ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ))),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              margin: EdgeInsets.all(10),
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5)),
              child: TextFormField(
                controller: searchEditingController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.only(right: 15, top: 15, bottom: 10),
                  border: InputBorder.none,
                  hintText: "Mã đơn hàng",
                  suffixIcon: IconButton(
                    onPressed: () {
                      orderController.textSearch = "";
                      orderController.loadMoreOrder(isSearch: true);
                      searchEditingController.clear();
                    },
                    icon: Icon(
                      Icons.clear,
                    ),
                  ),
                ),
                onChanged: (v) async {
                  orderController.textSearch = v;
                  orderController.loadMoreOrder(isSearch: true);
                },
                minLines: 1,
                maxLines: 1,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => SingleChildScrollView(
                      
                      scrollDirection: Axis.horizontal,
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Row(
                        children: [
                          boxFilter(FilterOrder(
                              name: "Tất cả",
                              listSource: [],
                              listPaymentStt: [],
                              listOrderStt: [],
                              listBranch: [])),
                          ...orderController.listFilter.map((e) => boxFilter(e))
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Hive.close();
                    var filter = orderController.filterOrder.value;
                    Get.to(() => filterOrderScreen(
                              filterOrderInput: new FilterOrder(
                                dateFrom: filter.dateFrom,
                                dateTo: filter.dateTo,
                                listBranch: filter.listBranch,
                                listOrderStt: filter.listOrderStt,
                                listPaymentStt: filter.listPaymentStt,
                                listSource: filter.listSource,
                                staff: filter.staff,
                              ),
                              onFilter: (FilterOrder filterOrder) {
                                print(filterOrder.staff?.name);
                                orderController.filterOrder.value = filterOrder;
                                orderController.filterOrder.refresh();
                                print(orderController.filterOrder.value.staff?.id);
                                orderController.loadMoreOrder(isRefresh: true);
                                Get.back();
                              },
                            ))!
                        .then((value) => {orderController.getFilters()});
                  },
                  child: Obx(
                    () => Container(
                        padding: EdgeInsets.only(
                            top: 5, left: 10, right: 10, bottom: 5),
                        child: Icon(
                          Icons.filter_alt_sharp,
                          color: orderController.filterOrder.value.name ==
                                  "filter_order"
                              ? Colors.blue
                              : null,
                        )),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            Expanded(
              child: Obx(
                () => SmartRefresher(
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
                        body = Obx(() => !orderController.isDoneLoadMore.value
                            ? CupertinoActivityIndicator()
                            : Container());
                      } else if (mode == LoadStatus.loading) {
                        body = CupertinoActivityIndicator();
                      }
                      return Center(
                        child: Container(
                          child: Center(child: body),
                        ),
                      );
                    },
                  ),
                  controller: refreshController,
                  onRefresh: () async {
                    await orderController.loadMoreOrder(isRefresh: true);
                    refreshController.refreshCompleted();
                  },
                  onLoading: () async {
                    await orderController.loadMoreOrder();
                    refreshController.loadComplete();
                  },
                  child: orderController.loadingRefresh.value
                      ? Stack(
                          children: [
                            ListView.builder(
                              itemCount: orderController.listOrder.length,
                              itemBuilder: (context, i) {
                                return orderController.isList.value
                                    ? boxOrder(orderController.listOrder[i])
                                    : boxOrderExpanded(
                                        orderController.listOrder[i]);
                              },
                            ),
                            if (orderController.loadingRefresh.value)
                              SahaLoadingWidget(),
                          ],
                        )
                      : orderController.isLoadInit.value
                          ? SahaLoadingFullScreen()
                          : orderController.listOrder.isEmpty
                              ? SahaEmptyOrder()
                              : ListView.builder(
                                  itemCount: orderController.listOrder.length,
                                  itemBuilder: (context, i) {
                                    return Obx(() => orderController.isList.value
                                        ? boxOrder(orderController.listOrder[i])
                                        : boxOrderExpanded(
                                            orderController.listOrder[i]));
                                  },
                                ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: Obx(
          () => !orderController.isChooseAll.value
              ? Container(
                  height: 1,
                )
              : Container(
                  height: 50,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            orderController.isChooseAll.value = false;
                            orderController.listOrderChoose([]);
                          },
                          icon: Icon(Icons.clear)),
                      TextButton(
                        onPressed: () {
                          orderController.listOrderChoose.forEach((order) {
                            orderController.printAll(order);
                          });
                        },
                        child: Text(
                          "In hoá đơn",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        "${orderController.listOrderChoose.length}    ",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  )),
        ),
      ),
    );
  }

  Widget boxOrder(Order order) {
    return InkWell(
      onTap: () {
        if (orderController.isChooseAll.value) {
          if (orderController.listOrderChoose
              .map((e) => e.id)
              .contains(order.id)) {
            orderController.listOrderChoose
                .removeWhere((e) => e.id == order.id);
          } else {
            orderController.listOrderChoose.add(order);
          }
        } else {
          if (order.orderFrom == ORDER_FROM_APP ||
              order.orderFrom == ORDER_FROM_WEB ||
              order.orderFrom == ORDER_FROM_POS_DELIVERY) {
            Get.to(() => OrderDetailScreen(
                      order: order,
                    ))!
                .then((value) =>
                    {if (value != null) orderController.getOneOrder(value)});
          } else {
            Get.to(() => BillDetailScreen(
                      orderCode: order.orderCode ?? "",
                    ))!
                .then((value) => {
                      if (value == "reload")
                        {orderController.loadMoreOrder(isRefresh: true)}
                    });
          }
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                if (orderController.isChooseAll.value)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      shape: BoxShape.circle,
                    ),
                    margin: EdgeInsets.only(right: 10),
                    child: Checkbox(
                        value: orderController.listOrderChoose
                            .map((e) => e.id)
                            .contains(order.id),
                        onChanged: (v) {
                          if (orderController.listOrderChoose
                              .map((e) => e.id)
                              .contains(order.id)) {
                            orderController.listOrderChoose
                                .removeWhere((e) => e.id == order.id);
                          } else {
                            orderController.listOrderChoose.add(order);
                          }
                        }),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "#${order.orderCode}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      if (order.infoCustomer != null)
                        SizedBox(
                          height: 5,
                        ),
                      if (order.infoCustomer != null)
                        Text(
                          "${order.infoCustomer?.name ?? ""}",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${SahaDateUtils().getDDMM(order.createdAt ?? DateTime.now())} - ${SahaDateUtils().getHHMM(order.createdAt ?? DateTime.now())}",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.blue[200],
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                order.orderFrom == ORDER_FROM_APP
                                    ? "App"
                                    : order.orderFrom == ORDER_FROM_WEB
                                        ? "Web"
                                        : order.orderFrom ==
                                                ORDER_FROM_POS_DELIVERY
                                            ? "POS giao vận"
                                            : "POS",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${SahaStringUtils().convertToMoney(order.totalFinal ?? 0)}₫",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    if (order.orderStatusCode == "CUSTOMER_HAS_RETURNS")
                      SizedBox(
                        height: 5,
                      ),
                    if (order.orderStatusCode == "CUSTOMER_HAS_RETURNS")
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Đơn hoàn tiền",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    if (order.orderStatusCode == "WAIT_FOR_PAYMENT")
                      SizedBox(
                        height: 5,
                      ),
                    if (order.orderStatusCode == "WAIT_FOR_PAYMENT")
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Đợi thanh toán",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    if (order.orderStatusCode == "WAIT_FOR_PAYMENT")
                      SizedBox(
                        height: 5,
                      ),
                    if (order.orderStatusCode == "COMPLETED")
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Đã hoàn thành",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget boxOrderExpanded(Order order) {
    return InkWell(
      onTap: () {
        if (orderController.isChooseAll.value) {
          if (orderController.listOrderChoose
              .map((e) => e.id)
              .contains(order.id)) {
            orderController.listOrderChoose
                .removeWhere((e) => e.id == order.id);
          } else {
            orderController.listOrderChoose.add(order);
          }
        } else {
          if (order.orderFrom == ORDER_FROM_APP ||
              order.orderFrom == ORDER_FROM_WEB ||
              order.orderFrom == ORDER_FROM_POS_DELIVERY) {
            Get.to(() => OrderDetailScreen(
                      order: order,
                    ))!
                .then((value) =>
                    {if (value != null) orderController.getOneOrder(value)});
          } else {
            Get.to(() => BillDetailScreen(
                      orderCode: order.orderCode ?? "",
                    ))!
                .then((value) => {
                      if (value == "reload")
                        {orderController.loadMoreOrder(isRefresh: true)}
                    });
          }
        }
      },
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "#${order.orderCode}",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Spacer(),
                    if (order.orderStatusCode != null)
                      Container(
                        padding: EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        decoration: BoxDecoration(
                            color: (mapStatusColor[order.orderStatusCode] ??
                                    Colors.blue)
                                .withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "${ORDER_STATUS_DEFINE[order.orderStatusCode]}",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "${SahaStringUtils().convertToMoney(order.totalFinal ?? 0)}₫",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    Spacer(),
                    if (order.paymentStatusCode != null)
                      Container(
                        padding: EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        decoration: BoxDecoration(
                            color: (mapStatusColor[order.paymentStatusCode] ??
                                    Colors.blue)
                                .withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "${ORDER_PAYMENT_DEFINE[order.paymentStatusCode]}",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                if (order.infoCustomer != null)
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.1)),
                          child: Icon(Icons.person, color: Colors.grey)),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          "${order.infoCustomer?.name ?? ""} - ${order.infoCustomer?.phoneNumber ?? ""}",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Text(
                        "${SahaDateUtils().getDDMM(order.createdAt ?? DateTime.now())} - ${SahaDateUtils().getHHMM(order.createdAt ?? DateTime.now())}",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                if (order.branch != null)
                  SizedBox(
                    height: 10,
                  ),
                if (order.branch != null)
                  Row(
                    children: [
                      Icon(Icons.store, color: Colors.grey),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(order.branch?.name ?? ""),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_rounded, color: Colors.grey),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(order.infoCustomer?.wardsName == null
                          ? "---"
                          : "${order.infoCustomer!.addressDetail ?? ""}${order.infoCustomer!.addressDetail == null ? "" : ","} ${order.infoCustomer!.wardsName ?? ""}${order.infoCustomer!.wardsName == null ? "" : ","} ${order.infoCustomer!.districtName ?? ""}${order.infoCustomer!.districtName == null ? "" : ","} ${order.infoCustomer!.provinceName ?? ""}${order.infoCustomer!.provinceName == null ? "" : ""}"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.sticky_note_2_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Ghi chú: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if(order.orderCodeRefund ==
                        null)
                    Expanded(
                      child: Text(
                        order.customerNote == null || order.customerNote == ""
                            ? "---"
                            : "${order.customerNote}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                Divider(),
                InkWell(
                  onTap: () {
                    orderController.printAll(order);
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.print_outlined,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "In đơn hàng",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          if (orderController.isChooseAll.value)
            Positioned(
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  shape: BoxShape.circle,
                ),
                child: Checkbox(
                    value: orderController.listOrderChoose
                        .map((e) => e.id)
                        .contains(order.id),
                    onChanged: (v) {
                      if (orderController.listOrderChoose
                          .map((e) => e.id)
                          .contains(order.id)) {
                        orderController.listOrderChoose
                            .removeWhere((e) => e.id == order.id);
                      } else {
                        orderController.listOrderChoose.add(order);
                      }
                    }),
              ),
            ),
          Positioned(
            right: 20,
            bottom: 20,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  order.orderFrom == ORDER_FROM_APP
                      ? "App"
                      : order.orderFrom == ORDER_FROM_WEB
                          ? "Web"
                          : order.orderFrom == ORDER_FROM_POS_DELIVERY
                              ? "POS giao vận"
                              : "POS",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget boxFilter(FilterOrder filterOrder) {
    return GestureDetector(
      onTap: () {
        orderController.filterOrder.value = filterOrder;
        orderController.loadMoreOrder(isRefresh: true);
      },
      child: Container(
        width: Get.width / 5,
        decoration: BoxDecoration(
          border: orderController.filterOrder.value.name == filterOrder.name
              ? Border(
                  bottom: BorderSide(
                    color: Colors.blue,
                    width: 2.5,
                  ),
                )
              : null,
        ),
        padding: EdgeInsets.all(5),
        child: Center(
          child: Text(
            filterOrder.name ?? "",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: orderController.filterOrder.value.name == filterOrder.name
                  ? Colors.blue
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  void showSheetMoreVert() {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'Chọn nhiều hoá đơn',
                  style: TextStyle(color: Colors.blue),
                ),
                subtitle: Text(
                  'Thực hiện thao tác nhanh với nhiều đơn hàng',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                onTap: () {
                  orderController.isChooseAll.value = true;
                  Get.back();
                },
              ),
              ListTile(
                title: Text(
                  'Bộ lọc được lưu',
                  style: TextStyle(color: Colors.red),
                ),
                subtitle: Text(
                  'Các bộ lọc tìm kiếm được lưu trong danh sách',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                onTap: () {
                  Get.back();
                  Get.to(() => ListFilterOrderScreen())!
                      .then((value) => {orderController.getFilters()});
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }
}
