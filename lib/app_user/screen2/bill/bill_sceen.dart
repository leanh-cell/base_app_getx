import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:com.ikitech.store/app_user/screen2/report/choose_time/choose_time_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

import 'bill_controller.dart';
import 'bill_detail/bill_detail_screen.dart';

class BillScreen extends StatefulWidget {
  bool? isReturn;
  DateTime? dateFrom;
  DateTime? dateTo;
  BillScreen({this.isReturn, this.dateFrom, this.dateTo});
  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  BillController billController = Get.find();
  ScrollController _scrollController = ScrollController();
  TextEditingController searchEditingController = TextEditingController();
  var timeInputSearch = DateTime.now();

  @override
  void initState() {
    super.initState();
    billController.loadMoreOrder(isRefresh: true);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          billController.isDoneLoadMore.value == true) {
        billController.loadMoreOrder();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hoá đơn"),
        ),
        body: Column(
          children: [
            head(),
            Divider(
              height: 1,
            ),
            Row(
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
                      hintText: "Tìm kiếm",
                      hintStyle: TextStyle(fontSize: 15),
                      suffixIcon: IconButton(
                        onPressed: () {
                          billController.textSearch = "";
                          billController.loadMoreOrder(isSearch: true);
                          searchEditingController.clear();
                        },
                        icon: Icon(Icons.clear),
                      ),
                    ),
                    onChanged: (v) async {
                      billController.textSearch = v;
                      billController.loadMoreOrder(isSearch: true);
                    },
                    style: TextStyle(fontSize: 14),
                    minLines: 1,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Divider(
              height: 1,
            ),
            Expanded(
              child: Obx(
                () => billController.isLoadInit.value
                    ? Container()
                    : Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          RefreshIndicator(
                            onRefresh: () async {
                              await billController.loadMoreOrder(
                                  isRefresh: true);
                            },
                            child: GroupedListView<Order, DateTime>(
                              controller: _scrollController,
                              elements: billController.listOrder,
                              groupBy: (e) => DateTime(
                                (e.createdAt ?? DateTime.now()).year,
                                (e.createdAt ?? DateTime.now()).month,
                                (e.createdAt ?? DateTime.now()).day,
                              ),
                              order: GroupedListOrder.DESC,
                              useStickyGroupSeparators: true,
                              sort: false,
                              groupSeparatorBuilder: (DateTime value) =>
                                  Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey[400]!, width: 0.5)),
                                child: Row(
                                  children: [
                                    Text(
                                      "${SahaDateUtils().convertDateToWeekDate(value)}, ${value.day} tháng ${value.month} ${value.year}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              itemBuilder: (c, e) {
                                return InkWell(
                                  onTap: () {
                                    Get.to(() => BillDetailScreen(
                                              orderCode: e.orderCode ?? "",
                                            ))!
                                        .then((value) => {
                                              if (value == "reload")
                                                {
                                                  billController.loadMoreOrder(
                                                      isRefresh: true)
                                                }
                                            });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.list_alt_outlined,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      "${SahaStringUtils().convertToMoney(e.totalFinal ?? 0)}₫"),
                                                  Spacer(),
                                                  Text(
                                                    "#${e.orderCode}",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${SahaDateUtils().getHHMM(e.createdAt ?? DateTime.now())}",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12),
                                                  ),
                                                  Spacer(),
                                                  if (e.orderStatusCode ==
                                                      "CUSTOMER_HAS_RETURNS")
                                                    Text(
                                                      "Đơn hoàn tiền",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 12),
                                                    ),
                                                  if (e.orderStatusCode ==
                                                      "WAIT_FOR_PAYMENT")
                                                    Text(
                                                      "Đợi thanh toán",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          !billController.isDoneLoadMore.value
                              ? Positioned(
                                  bottom: 20,
                                  child: Container(
                                    child: Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
              ),
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
              initTab: billController.indexTabTime,
              fromDayInput: billController.fromDay.value,
              toDayInput: billController.toDay.value,
              initChoose: billController.indexChooseTime,
              callback: (DateTime fromDate,
                  DateTime toDay,
                  DateTime fromDateCP,
                  DateTime toDayCP,
                  bool isCompare,
                  int? indexTab,
                  int? indexChoose) {
                billController.fromDay.value = fromDate;
                billController.toDay.value = toDay;
                billController.indexTabTime = indexTab ?? 0;
                billController.indexChooseTime = indexChoose ?? 0;
                billController.isAll.value = false;
                billController.loadMoreOrder(isRefresh: true);
              },
            ));
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => billController.isAll.value
              ? Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Theme.of(Get.context!).primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Tất cả hoá đơn",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                )
              : Row(
                  children: [
                    !billController.fromDay.value
                            .isAtSameMomentAs(billController.toDay.value)
                        ? Expanded(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Theme.of(Get.context!).primaryColor,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Từ: ",
                                                style: TextStyle(
                                                    color:
                                                        Theme.of(Get.context!)
                                                            .primaryColor),
                                              ),
                                              Text(
                                                  "${SahaDateUtils().getDDMMYY(billController.fromDay.value)} "),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Đến: ",
                                                style: TextStyle(
                                                    color:
                                                        Theme.of(Get.context!)
                                                            .primaryColor),
                                              ),
                                              Text(
                                                  "${SahaDateUtils().getDDMMYY(billController.toDay.value)}"),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Expanded(
                            child: Row(
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
                                              color: Theme.of(Get.context!)
                                                  .primaryColor),
                                        ),
                                        Text(
                                            "${getDate(billController.fromDay.value).isAtSameMomentAs(getDate(DateTime.now())) ? "Hôm nay" : SahaDateUtils().getDDMMYY(billController.fromDay.value)} "),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                    InkWell(
                      onTap: () {
                        billController.isAll.value = true;
                        billController.loadMoreOrder(isRefresh: true);
                      },
                      child: Text(
                        "Tất cả hoá đơn",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ))),
    );
  }

  DateTime getDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
