import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/const/const_revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/model/revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/screen2/home/choose_address/new_customer_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/revenue_expanditure/revenue_expenditure_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/navigator/navigator_controller.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/step_bonus.dart';

import '../../../../components/saha_user/call/call.dart';
import '../../../../data/remote/response-request/sale/over_view_sale_res.dart';
import '../../../../model/info_customer.dart';
import '../../../info_customer/history_order/order_detail_manage/order_detail_manage_screen.dart';
import '../../../info_customer/info_customer_screen.dart';
import '../../../staff/choose_customer/choose_customer_screen.dart';
import '../../../staff/customer_for_sale/customer_for_sale_screen.dart';
import 'sale_detail_controller.dart';

class SaleDetailScreen extends StatefulWidget {
  Staff staffInput;
  SaleDetailScreen({required this.staffInput});

  @override
  State<SaleDetailScreen> createState() => _SaleDetailScreenState();
}

class _SaleDetailScreenState extends State<SaleDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late SaleDetailController controller;
  SahaDataController sahaDataController = Get.find();
  RefreshController refreshController = RefreshController();

  RefreshController refreshController2 = RefreshController();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    controller = SaleDetailController(staffInput: widget.staffInput);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin"),
      ),
      body: Obx(
        () => Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.amber),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.staff.value.name ?? ""}",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Call.call(
                                "${controller.staff.value.phoneNumber ?? ""}");
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.blue,
                                size: 18,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${controller.staff.value.phoneNumber ?? ""}",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 13),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
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
                          child: Text('Thống kê',
                              style: TextStyle(color: Colors.black))),
                      Tab(
                          child: Text(
                              'Khách hàng (${widget.staffInput.totalCustomer ?? 0})',
                              style: TextStyle(color: Colors.black))),
                      Tab(
                          child: Text('Đơn hàng',
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
                report(),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                    !controller.isDoneLoadMore.value
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
                            await controller.getAllCustomer(isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await controller.getAllCustomer();
                            refreshController.loadComplete();
                          },
                          child: Obx(
                            () => controller.listInfoCustomer.isEmpty
                                ? Center(child: Text("Chưa có khách hàng"))
                                : SingleChildScrollView(
                                    child: Column(
                                      children: controller.listInfoCustomer
                                          .map((e) => itemCustomer(e))
                                          .toList(),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SahaButtonFullParent(
                        text: "Phân công sale",
                        onPressed: () {
                          if (sahaDataController.badgeUser.value.isSale ==
                              true) {
                            if ((sahaDataController.badgeUser.value
                                        .decentralization?.customerList ??
                                    false) ==
                                true) {
                              Get.to(() => ChooseCustomerSaleScreen(
                                        staffInput: widget.staffInput,
                                      ))!
                                  .then((value) => {
                                        controller.getAllCustomer(
                                            isRefresh: true)
                                      });
                            } else {
                              SahaAlert.showError(
                                  message: "Bạn không có quyền truy cập");
                            }
                          } else {
                            Get.to(() => ChooseCustomerSaleScreen(
                                      staffInput: widget.staffInput,
                                    ))!
                                .then((value) => {
                                      controller.getAllCustomer(isRefresh: true)
                                    });
                          }
                        },
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                    !controller.isDoneLoadMore2.value
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
                            await controller.loadMoreOrder(isRefresh: true);
                            refreshController2.refreshCompleted();
                          },
                          onLoading: () async {
                            await controller.loadMoreOrder();
                            refreshController2.loadComplete();
                          },
                          child: Obx(
                            () => controller.listOrder.isEmpty
                                ? Center(
                                    child: Text("Chưa có lịch sử mua hàng"))
                                : SingleChildScrollView(
                                    child: Column(
                                      children: controller.listOrder
                                          .map((e) => historyOrder(e))
                                          .toList(),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget report() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.type.value = 0;
                      },
                      child: Container(
                        width: Get.width / 4.5,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Center(
                          child: Obx(
                            () => Text(
                              'Tháng',
                              style: TextStyle(
                                color: controller.type.value == 0
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                                fontSize: controller.type.value == 0 ? 17 : 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.type.value = 1;
                      },
                      child: Container(
                        width: Get.width / 4.5,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Center(
                          child: Obx(
                            () => Text(
                              'Tuần',
                              style: TextStyle(
                                color: controller.type.value == 1
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey,
                                fontSize: controller.type.value == 1 ? 17 : 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.type.value = 2;
                      },
                      child: Container(
                        width: Get.width / 4.5,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Center(
                            child: Obx(
                          () => Text(
                            'Quý',
                            style: TextStyle(
                              color: controller.type.value == 2
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              fontSize: controller.type.value == 2 ? 17 : 14,
                            ),
                          ),
                        )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.type.value = 3;
                      },
                      child: Container(
                        width: Get.width / 4.5,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Center(
                            child: Obx(
                          () => Text(
                            'Năm',
                            style: TextStyle(
                              color: controller.type.value == 3
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              fontSize: controller.type.value == 3 ? 17 : 14,
                            ),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Obx(
                    () => SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              itemReport(
                                  title: 'Tổng doanh số',
                                  icon: Icon(
                                    Icons.bar_chart,
                                    color: Colors.red,
                                  ),
                                  number: (controller
                                              .overViewSale.value.totalFinal ??
                                          0)
                                      .toString()),
                              itemReport(
                                  title: 'Tổng đơn',
                                  icon: Icon(
                                    Icons.list_alt_rounded,
                                    color: Colors.red,
                                  ),
                                  number: (controller
                                              .overViewSale.value.totalOrder ??
                                          0)
                                      .toString()),
                            ],
                          ),
                          Row(
                            children: [
                              itemReport(
                                  title: 'Doanh thu ngày',
                                  icon: Icon(
                                    Icons.bar_chart,
                                    color: Colors.blue,
                                  ),
                                  number: (controller.overViewSale.value
                                              .totalFinalInDay ??
                                          0)
                                      .toString()),
                              itemReport(
                                  title: 'Tổng đơn ngày',
                                  icon: Icon(
                                    Icons.list_alt_rounded,
                                    color: Colors.teal,
                                  ),
                                  number: (controller
                                              .overViewSale.value.countInDay ??
                                          0)
                                      .toString()),
                            ],
                          ),
                          if (controller.type.value == 0)
                            Row(
                              children: [
                                itemReport(
                                    title: 'Doanh thu tháng',
                                    icon: Icon(
                                      Icons.bar_chart,
                                      color: Colors.blue,
                                    ),
                                    number: (controller.overViewSale.value
                                                .totalFinalInMonth ??
                                            0)
                                        .toString()),
                                itemReport(
                                    title: 'Tổng đơn tháng',
                                    icon: Icon(
                                      Icons.list_alt_rounded,
                                      color: Colors.teal,
                                    ),
                                    number: (controller.overViewSale.value
                                                .countInMonth ??
                                            0)
                                        .toString()),
                              ],
                            ),
                          if (controller.type.value == 1)
                            Row(
                              children: [
                                itemReport(
                                    title: 'Doanh thu tuần',
                                    icon: Icon(
                                      Icons.bar_chart,
                                      color: Colors.blue,
                                    ),
                                    number: (controller.overViewSale.value
                                                .totalFinalInWeek ??
                                            0)
                                        .toString()),
                                itemReport(
                                    title: 'Tổng đơn tuần',
                                    icon: Icon(
                                      Icons.list_alt_rounded,
                                      color: Colors.teal,
                                    ),
                                    number: (controller.overViewSale.value
                                                .countInWeek ??
                                            0)
                                        .toString()),
                              ],
                            ),
                          if (controller.type.value == 2)
                            Row(
                              children: [
                                itemReport(
                                    title: 'Doanh thu quý',
                                    icon: Icon(
                                      Icons.bar_chart,
                                      color: Colors.blue,
                                    ),
                                    number: (controller.overViewSale.value
                                                .totalFinalInQuarter ??
                                            0)
                                        .toString()),
                                itemReport(
                                    title: 'Tổng đơn quý',
                                    icon: Icon(
                                      Icons.list_alt_rounded,
                                      color: Colors.teal,
                                    ),
                                    number: (controller.overViewSale.value
                                                .countInQuarter ??
                                            0)
                                        .toString()),
                              ],
                            ),
                          if (controller.type.value == 3)
                            Row(
                              children: [
                                itemReport(
                                    title: 'Doanh thu năm',
                                    icon: Icon(
                                      Icons.bar_chart,
                                      color: Colors.blue,
                                    ),
                                    number: (controller.overViewSale.value
                                                .totalFinalInYear ??
                                            0)
                                        .toString()),
                                itemReport(
                                    title: 'Tổng đơn năm',
                                    icon: Icon(
                                      Icons.list_alt_rounded,
                                      color: Colors.teal,
                                    ),
                                    number: (controller.overViewSale.value
                                                .countInYear ??
                                            0)
                                        .toString()),
                              ],
                            ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F6F9),
                                        shape: BoxShape.circle,
                                      ),
                                      child: SvgPicture.asset(
                                        "packages/sahashop_customer/assets/icons/gift_fill.svg",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "THƯỞNG THEO MỨC DOANH THU ${getText(controller.overViewSale.value.saleConfig?.typeBonusPeriod ?? 0).toUpperCase()}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(height: 1),
                                Column(
                                  children: [
                                    ...List.generate(
                                      controller.overViewSale.value.stepsBonus
                                              ?.length ??
                                          0,
                                      (index) => boxGiftBonus(
                                          svgAsset:
                                              "packages/sahashop_customer/assets/icons/point.svg",
                                          svgAssetCheck:
                                              "packages/sahashop_customer/assets/icons/checked.svg",
                                          stepsBonus: controller.overViewSale
                                              .value.stepsBonus![index],
                                          overViewSale:
                                              controller.overViewSale.value),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  // Widget revenueExpenditure(RevenueExpenditure revenueExpenditure) {
  //   return InkWell(
  //     onTap: () {
  //       Get.to(() => RevenueExpenditureScreen(
  //             isRevenue: true,
  //             revenueExpenditure: revenueExpenditure,
  //             changeMoney: controller.infoCustomer.value.debt,
  //             recipientGroup: RECIPIENT_GROUP_CUSTOMER,
  //             recipientReferencesId:
  //                 controller.infoCustomer.value.id,
  //           ));
  //     },
  //     child: Column(
  //       children: [
  //         Container(
  //           padding: EdgeInsets.all(10),
  //           child: Row(
  //             children: [
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     "${revenueExpenditure.code ?? ""}",
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.w500,
  //                       fontSize: 15,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 5,
  //                   ),
  //                   Text(
  //                     "${revenueExpenditure.staff?.name ?? ""}",
  //                     style: TextStyle(color: Colors.grey, fontSize: 12),
  //                   ),
  //                   SizedBox(
  //                     height: 5,
  //                   ),
  //                   Text(
  //                     "${SahaDateUtils().getDDMMYY(revenueExpenditure.createdAt ?? DateTime.now())} - ${SahaDateUtils().getHHMM(revenueExpenditure.createdAt ?? DateTime.now())}",
  //                     style: TextStyle(color: Colors.grey, fontSize: 12),
  //                   ),
  //                 ],
  //               ),
  //               Spacer(),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       revenueExpenditure.isRevenue == true
  //                           ? Icon(
  //                               Icons.arrow_drop_down,
  //                               color: Colors.blue,
  //                             )
  //                           : Icon(
  //                               Icons.arrow_drop_up,
  //                               color: Colors.red,
  //                             ),
  //                       Text(
  //                         "${SahaStringUtils().convertToMoney(revenueExpenditure.changeMoney ?? 0)}",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                           fontSize: 15,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   Text(
  //                     "${revenueExpenditure.typeActionName ?? ""}",
  //                     style: TextStyle(color: Colors.grey, fontSize: 12),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         Divider(
  //           height: 1,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget historyOrder(Order order) {
    return InkWell(
      onTap: () {
        Get.to(() => OrderDetailScreen(
              order: order,
            ));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${order.orderCode ?? ""}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 5.0, top: 5, bottom: 5),
                          child: Icon(
                            Icons.phone,
                            size: 12,
                          ),
                        ),
                        Text(
                          "${order.infoCustomer?.phoneNumber ?? ""}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${SahaDateUtils().getDDMMYY(order.createdAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(order.createdAt ?? DateTime.now())}',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${SahaStringUtils().convertToMoney(order.totalFinal ?? 0)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${order.orderStatusName}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 12),
                    )
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

  String getText(int? type) {
    if (type == 0) return "Theo tháng";
    if (type == 1) return "Theo tuần";
    if (type == 2) return "Theo quý";
    if (type == 3) return "Theo năm";
    return "Chọn kỳ";
  }

  Widget boxGiftBonus({
    required String svgAsset,
    required String svgAssetCheck,
    required StepsBonus stepsBonus,
    required OverViewSale overViewSale,
  }) {
    double getTotal() {
      var t = overViewSale.saleConfig?.typeBonusPeriod;
      if (t == 0) {
        return overViewSale.totalFinalInMonth ?? 0;
      }
      if (t == 1) {
        return overViewSale.totalFinalInWeek ?? 0;
      }
      if (t == 2) {
        return overViewSale.totalFinalInQuarter ?? 0;
      }
      if (t == 3) {
        return overViewSale.totalFinalInYear ?? 0;
      }
      return 0;
    }

    return Container(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 8, bottom: 8),
      margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8, bottom: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(
              color: getTotal() >= stepsBonus.limit!
                  ? Colors.amber
                  : Colors.grey[200]!,
              width: 1.5)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SvgPicture.asset(
              getTotal() >= stepsBonus.limit! ? svgAssetCheck : svgAsset,
              height: 25,
              width: 25,
            ),
          ),
          Text(
            "Đạt: ${SahaStringUtils().convertToMoney(stepsBonus.limit)}₫",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Text(
            "Thưởng: ${SahaStringUtils().convertToMoney(stepsBonus.bonus)}₫",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget itemReport(
      {required String title, required Icon icon, required String? number}) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      width: (Get.width - 40) / 2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              icon,
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ],
          ),
          Divider(),
          Text(
            SahaStringUtils().convertToMoney(number),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget itemCustomer(InfoCustomer infoCustomer) {
    return InkWell(
      onTap: () {
        Get.to(() => InfoCustomerScreen(
              infoCustomerId: infoCustomer.id!,
            ));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5, right: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${infoCustomer.name}"),
                    SizedBox(
                      height: 5,
                    ),
                    if (infoCustomer.phoneNumber != null)
                      Text(
                        "${infoCustomer.phoneNumber}",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${infoCustomer.isAgency == true ? "Đại lý" : infoCustomer.isCollaborator == true ? "Cộng tác viên" : "Khách hàng"}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    if (infoCustomer.saleStaff != null)
                      SizedBox(
                        height: 5,
                      ),
                    if (infoCustomer.saleStaff != null)
                      Text(
                        "Sale: ${infoCustomer.saleStaff?.name ?? ''}",
                        style: TextStyle(color: Colors.blue, fontSize: 13),
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
