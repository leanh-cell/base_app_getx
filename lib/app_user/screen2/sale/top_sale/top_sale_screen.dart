import 'package:com.ikitech.store/app_user/model/filter_top_sale.dart';
import 'package:com.ikitech.store/app_user/screen2/order/filter_order/filter_order_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/sale/top_sale/top_sale_controller.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/saha_user/loading/loading_full_screen.dart';
import '../../../model/staff.dart';
import '../../../utils/date_utils.dart';
import '../list_sale/list_customer_time/list_customer_time_screen.dart';
import '../list_sale/sale_detail/sale_detail_screen.dart';
import 'filter_top_sale/filter_top_sale_screen.dart';

class TopSaleScreen extends StatelessWidget {
  TopSaleController topSaleController = TopSaleController();
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Top sale'),
        actions: [
          IconButton(
              onPressed: () {
                var filter = topSaleController.filterOrder.value;
                Get.to(() => filterTopSaleScreen(
                      filterOrderInput: new FilterTopSale(
                        dateFrom: filter.dateFrom,
                        dateTo: filter.dateTo,
                        staffs: filter.staffs,
                        type: filter.type,
                        provinceIds: filter.provinceIds,
                      ),
                      onFilter: (FilterTopSale filterOrder) {
                        print(filterOrder.staffs);
                        topSaleController.filterOrder.value = filterOrder;
                        if (topSaleController.filterOrder.value.dateFrom ==
                            null) {
                          topSaleController.filterOrder.value.dateFrom =
                              SahaDateUtils().getFirstDayOfMonthDATETIME();

                        }
                        if (topSaleController.filterOrder.value.dateTo ==
                            null) {
                          topSaleController.filterOrder.value.dateTo =
                              SahaDateUtils().getEndDayOfMonthDateTime();
                        }
                        topSaleController.filterOrder.refresh();
                        topSaleController.getTopSale(isRefresh: true);
                        Get.back();
                      },
                    ));
              },
              icon: Icon(
                Icons.filter_alt,
                color: topSaleController.filterOrder.value.dateTo != null ||
                        topSaleController.filterOrder.value.dateFrom != null ||
                        topSaleController.filterOrder.value.staffs != null ||
                        topSaleController.filterOrder.value.type != null
                    ? Colors.blue
                    : null,
              ))
        ],
      ),
      body: Obx(
        () => topSaleController.loadInit.value
            ? SahaLoadingFullScreen()
            : topSaleController.listSale.isEmpty
                ? Center(child: Text('Không có sale nào'))
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
                          body = Obx(() => topSaleController.isLoading.value
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
                      await topSaleController.getTopSale(isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await topSaleController.getTopSale();
                      refreshController.loadComplete();
                    },
                    child: ListView.builder(
                      itemCount: topSaleController.listSale.length,
                      itemBuilder: (context, index) {
                        return itemStaff(topSaleController.listSale[index]);
                      },
                    ),
                  ),
      ),
    );
  }

  Widget itemStaff(Staff staff) {
    return InkWell(
      onTap: () {
        Get.to(() => SaleDetailScreen(
                  staffInput: staff,
                ))!
            .then((value) => {
                  //staffController.getListStaff(),
                });
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Theme.of(Get.context!).primaryColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${staff.name ?? ""}",
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Get.to(() => ListCustomerTimeScreen(
                                    dateFrom: topSaleController
                                        .filterOrder.value.dateFrom,
                                    dateTo: topSaleController
                                        .filterOrder.value.dateTo,
                                    type: topSaleController
                                        .filterOrder.value.type,
                                    staffId: staff.id!.toString(),
                                    provinceIds: topSaleController
                                        .filterOrder.value.provinceIds,
                                  ));
                            },
                            child: Text(
                              "Số khách hàng: ${staff.totalCustomerInFiler ?? 0}",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text("Số đơn: ${staff.orderCount ?? 0}"),
                Spacer(),
                Text(
                    "Doanh thu: ${SahaStringUtils().convertToMoney(staff.sumTotalAfterDiscountNoUseBonus ?? 0)}"),
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
