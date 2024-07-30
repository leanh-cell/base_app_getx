import 'dart:convert';

import 'package:com.ikitech.store/app_user/model/e_commerce.dart';
import 'package:com.ikitech.store/app_user/model/order_commerce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../components/saha_user/loading/loading_full_screen.dart';
import '../../../../utils/date_utils.dart';
import '../../../../utils/string_utils.dart';
import '../../../report/choose_time/choose_time_screen.dart';
import 'order_commerce_detail/order_commerce_detail_screen.dart';
import 'order_commerce_filter/order_commerce_filter_screen.dart';
import 'order_shop_commerce_controller.dart';

class OrderShopCommerceScreen extends StatelessWidget {
  OrderShopCommerceScreen(
      {Key? key, required this.shopIds, required this.commerce}) {
    orderShopCommerceController =
        Get.put(OrderShopCommerceController(shopIdsInput: shopIds));
  }

  late OrderShopCommerceController orderShopCommerceController;
  final RefreshController refreshController = RefreshController();
  final List<ECommerce> shopIds;
  final String commerce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách đơn hàng'),
        actions: [
          IconButton(
              onPressed: () async {
                if (orderShopCommerceController.loadInit.value == true) {
                  return;
                }
                orderShopCommerceController.loadInit.value = true;
                orderShopCommerceController.pageCommerce = 1;
                await orderShopCommerceController.syncOrder();
                while (orderShopCommerceController.dataSync.totalInPage != 0) {
                  orderShopCommerceController.pageCommerce =
                      orderShopCommerceController.pageCommerce + 1;
                  await orderShopCommerceController.syncOrder();
                }
                orderShopCommerceController.getAllOrderCommerce(
                    isRefresh: true);
              },
              icon: Icon(Icons.sync)),
          IconButton(
              onPressed: () {
                Get.to(() => OrderCommerceFilterScreen(
                      commerce: commerce,

                    ));
              },
              icon: const Icon(Icons.filter_alt_sharp))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          head(),
          Expanded(
            child: Obx(
              () => orderShopCommerceController.loadInit.value
                  ? SahaLoadingFullScreen()
                  : orderShopCommerceController.listOrderCommerce.isEmpty
                      ? const Center(
                          child: Text('Không có đơn hàng nào'),
                        )
                      : SmartRefresher(
                          enablePullDown: true,
                          enablePullUp: true,
                          header: const MaterialClassicHeader(),
                          footer: CustomFooter(
                            builder: (
                              BuildContext context,
                              LoadStatus? mode,
                            ) {
                              Widget body = Container();
                              if (mode == LoadStatus.idle) {
                                body = Obx(() =>
                                    orderShopCommerceController.isLoading.value
                                        ? const CupertinoActivityIndicator()
                                        : Container());
                              } else if (mode == LoadStatus.loading) {
                                body = const CupertinoActivityIndicator();
                              }
                              return SizedBox(
                                height: 100,
                                child: Center(child: body),
                              );
                            },
                          ),
                          controller: refreshController,
                          onRefresh: () async {
                            await orderShopCommerceController
                                .getAllOrderCommerce(isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await orderShopCommerceController
                                .getAllOrderCommerce();
                            refreshController.loadComplete();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      // [
                                      //   ListView.builder(
                                      //     itemCount: orderShopCommerceController
                                      //         .listOrderCommerce.length,
                                      //     itemBuilder: (context, i) {
                                      //       return Obx(() => itemOrder(
                                      //           orderShopCommerceController
                                      //               .listOrderCommerce[i]));
                                      //     },
                                      //   ),
                                      // ]
                                      [
                                    ...orderShopCommerceController
                                        .listOrderCommerce
                                        .map((e) => itemOrder(e))
                                        .toList(),
                                  ]),
                            ),
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }

  Widget head() {
    return InkWell(
      onTap: () {
        Get.to(() => ChooseTimeScreen(
                  isCompare: false,
                  initTab: orderShopCommerceController.indexTabTime,
                  fromDayInput: orderShopCommerceController.fromDay.value,
                  toDayInput: orderShopCommerceController.toDay.value,
                  fromDayCpInput: orderShopCommerceController.fromDayCP.value,
                  toDayCpInput: orderShopCommerceController.toDayCP.value,
                  initChoose: orderShopCommerceController.indexChooseTime,
                  callback: (DateTime fromDate,
                      DateTime toDay,
                      DateTime fromDateCP,
                      DateTime toDayCP,
                      bool isCompare,
                      int? indexTab,
                      int? indexChoose) {
                    orderShopCommerceController.fromDay.value = fromDate;
                    orderShopCommerceController.toDay.value = toDay;
                    orderShopCommerceController.indexTabTime = indexTab ?? 0;
                    orderShopCommerceController.indexChooseTime =
                        indexChoose ?? 0;
                    orderShopCommerceController.isCompare.value = isCompare;
                  },
                ))!
            .then((value) => {
                  orderShopCommerceController.getAllOrderCommerce(
                      isRefresh: true),
                });
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => !SahaDateUtils()
                    .getDate(orderShopCommerceController.fromDay.value)
                    .isAtSameMomentAs(SahaDateUtils()
                        .getDate(orderShopCommerceController.toDay.value))
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
                                  "${SahaDateUtils().getDDMMYY(orderShopCommerceController.fromDay.value)} "),
                              Text(
                                "Đến: ",
                                style: TextStyle(
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  "${SahaDateUtils().getDDMMYY(orderShopCommerceController.toDay.value)}"),
                            ],
                          ),
                          orderShopCommerceController.isCompare.value
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
                                            "${SahaDateUtils().getDDMMYY(orderShopCommerceController.fromDayCP.value)} "),
                                        Text(
                                          "Đến: ",
                                          style: TextStyle(
                                              color: Theme.of(Get.context!)
                                                  .primaryColor),
                                        ),
                                        Text(
                                            "${SahaDateUtils().getDDMMYY(orderShopCommerceController.toDayCP.value)}"),
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
                                    color: Theme.of(Get.context!).primaryColor),
                              ),
                              Text(
                                  "${SahaDateUtils().getDDMMYY(orderShopCommerceController.fromDay.value)} "),
                            ],
                          ),
                          if (orderShopCommerceController.isCompare.value)
                            SizedBox(
                              height: 10,
                            ),
                          orderShopCommerceController.isCompare.value
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
                                        "${SahaDateUtils().getDDMMYY(orderShopCommerceController.fromDayCP.value)} "),
                                    orderShopCommerceController
                                                .fromDayCP.value.day !=
                                            orderShopCommerceController
                                                .toDayCP.value.day
                                        ? Text(
                                            "Đến: ",
                                            style: TextStyle(
                                                color: Theme.of(Get.context!)
                                                    .primaryColor),
                                          )
                                        : Container(),
                                    orderShopCommerceController
                                                .fromDayCP.value.day !=
                                            orderShopCommerceController
                                                .toDayCP.value.day
                                        ? Text(
                                            "${SahaDateUtils().getDDMMYY(orderShopCommerceController.toDayCP.value)}")
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
                  ),
          )),
    );
  }

  Widget itemOrder(OrderCommerce orderCommerce) {
    return InkWell(
      onTap: () {
        Get.to(() => OrderCommmerceDetailScreen(
              orderCommerce: orderCommerce,
            ));
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
                      "#${orderCommerce.orderCode}",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    Spacer(),
                    if (orderCommerce.orderStatus != null)
                      Container(
                        padding: EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          orderCommerce.orderStatus!,
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
                      "${SahaStringUtils().convertToMoney(orderCommerce.totalFinal ?? 0)}₫",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    Spacer(),
                    if (orderCommerce.paymentStatus != null)
                      Container(
                        padding: EdgeInsets.only(
                            left: 7, right: 7, top: 3, bottom: 3),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          orderCommerce.paymentStatus!,
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
                        "${orderCommerce.customerName ?? ""} - ${orderCommerce.customerPhone ?? "chưa có thông tin"}",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Text(
                      "${SahaDateUtils().getDDMM(orderCommerce.createdAt ?? DateTime.now())} - ${SahaDateUtils().getHHMM(orderCommerce.createdAt ?? DateTime.now())}",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
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
                      child: Text(orderCommerce.customerWardsName == null
                          ? "---"
                          : "${orderCommerce.customerAddressDetail ?? ''} ${orderCommerce.customerWardsName ?? ''} ${orderCommerce.customerDistrictName ?? ''} ${orderCommerce.customerProvinceName ?? ''}"),
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
                    if (orderCommerce.orderCodeRefund == null)
                      Expanded(
                        child: Text(
                          orderCommerce.customerNote == null ||
                                  orderCommerce.customerNote == ""
                              ? "---"
                              : "${orderCommerce.customerNote}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 2,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
