import 'package:badges/badges.dart' as b;
import 'package:com.ikitech.store/app_user/screen2/sale_market/sale_market_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/button/button_home.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/model/decentralization.dart';
import 'package:com.ikitech.store/app_user/model/filter_order.dart';
import 'package:com.ikitech.store/app_user/screen2/bill/bill_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/home/choose_customer/choose_customer_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/list_cart/list_cart_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/widget/special_offers.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/check_inventory/check_inventory_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/import_stock/import_stock_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/navigator/navigator_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/notification/notification_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/order/order_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/order_manage/order_manage_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/product_menu/product_menu_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/widget/map_button_function.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

import '../home/home_controller.dart';
import '../inventory/inventory_product/inventory_product_screen.dart';
import '../sale/overview_detail_sale/overview_detail_sale_screen.dart';
import '../staff/staff_screen.dart';
import '../staff_sale/customer_sale/add_customer/new_customer_sale_screen.dart';
import '../staff_sale/customer_sale/customer_sale_screen.dart';

class OverViewScreen extends StatelessWidget {
  SahaDataController sahaDataController = Get.find();
  NavigatorController navigatorController = Get.find();
  RefreshController refreshController = RefreshController();
  HomeController homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Image(
          image: AssetImage('assets/images/background_appbar.jpg'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Icon(Icons.location_on_rounded),
            SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                SahaDialogApp.showDialogBranch();
              },
              child: Obx(
                () => Text(
                  "${sahaDataController.branchCurrent.value.name ?? ""}",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (sahaDataController
                      .badgeUser.value.decentralization?.notificationToStote ==
                  false) {
                SahaAlert.showToastMiddle(
                    message: "Chức năng thông báo bị chặn");
              } else {
                Get.to(() => NotificationUserScreen())!
                    .then((value) => {sahaDataController.getBadge()});
              }
            },
            icon: Obx(
              () => b.Badge(
                badgeStyle: b.BadgeStyle(
                  padding: EdgeInsets.all(3),
                ),
                position: b.BadgePosition.custom(end: -2, top: -7),
                showBadge:
                    (sahaDataController.badgeUser.value.notificationUnread ??
                                0) ==
                            0
                        ? false
                        : true,
                badgeContent: Text(
                  "${sahaDataController.badgeUser.value.notificationUnread ?? 0}",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                child: Icon(
                  Icons.notifications,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: MaterialClassicHeader(),
        footer: CustomFooter(
          builder: (
            BuildContext context,
            LoadStatus? mode,
          ) {
            Widget body = Container();
            if (mode == LoadStatus.idle) {
              body =
                  Obx(() => true ? CupertinoActivityIndicator() : Container());
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
          await sahaDataController.getBadge();
          refreshController.refreshCompleted();
        },
        child: Stack(
          children: [
            Positioned(
              top: -665,
              left: -100,
              right: -100,
              child: Container(
                height: 1000,
                width: 1000,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  sahaDataController.badgeUser.value.isSale == true
                      ? boxSale()
                      : boxRevenue(),
                  boxButton(),
                  Obx(() => homeController.isShowBanner.value
                      ? homeController.homeData.value.banner != null &&
                              homeController.homeData.value.banner!.length > 0
                          ? SpecialOffers(
                              listBanner: homeController.homeData.value.banner!,
                              onClear: () {
                                homeController.isShowBanner.value = false;
                              })
                          : Container()
                      : Container()),
                  boxProcessing(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget boxRevenue() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("DOANH THU NGÀY"),
              Spacer(),
              InkWell(
                onTap: () {
                  navigatorController.indexNav.value = 3;
                },
                child: Row(
                  children: [
                    Text(
                      "Xem chi tiết",
                      style: TextStyle(
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 17,
                      color: Theme.of(Get.context!).primaryColor,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => Text(
              "${SahaStringUtils().convertToMoney(sahaDataController.badgeUser.value.totalFinalInDay ?? 0)}",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (sahaDataController
                            .badgeUser.value.decentralization?.orderList ==
                        false) {
                      SahaAlert.showToastMiddle(
                          message: 'Chức năng hoá đơn bị chặn');
                    } else {
                      OrderController orderController = Get.find();
                      orderController.filterOrder.value = FilterOrder(
                          name: "filter_order",
                          dateFrom: SahaDateUtils().getDate(DateTime.now()),
                          dateTo: SahaDateUtils().getDate(DateTime.now()),
                          listSource: [],
                          listPaymentStt: [],
                          listOrderStt: [WAITING_FOR_PROGRESSING],
                          listBranch: [sahaDataController.branchCurrent.value]);
                      navigatorController.indexNav.value = 1;
                      orderController.loadMoreOrder(isRefresh: true);
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        "Chờ xử lý",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(() => Text(
                          "${SahaStringUtils().convertToMoney(sahaDataController.badgeUser.value.ordersWaitingForProgressing ?? 0)}"))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (sahaDataController
                            .badgeUser.value.decentralization?.orderList ==
                        false) {
                      SahaAlert.showToastMiddle(
                          message: 'Chức năng hoá đơn bị chặn');
                    } else {
                      OrderController orderController = Get.find();
                      orderController.filterOrder.value = FilterOrder(
                          name: "filter_order",
                          dateFrom: SahaDateUtils().getDate(DateTime.now()),
                          dateTo: SahaDateUtils().getDate(DateTime.now()),
                          listSource: [],
                          listPaymentStt: [],
                          listOrderStt: ["SHIPPING"],
                          listBranch: [sahaDataController.branchCurrent.value]);
                      navigatorController.indexNav.value = 1;
                      orderController.loadMoreOrder(isRefresh: true);
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        "Đang giao",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => Text(
                            "${SahaStringUtils().convertToMoney(sahaDataController.badgeUser.value.ordersShipping ?? 0)}"),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (sahaDataController
                            .badgeUser.value.decentralization?.orderList ==
                        false) {
                      SahaAlert.showToastMiddle(
                          message: 'Chức năng hoá đơn bị chặn');
                    } else {
                      OrderController orderController = Get.find();
                      orderController.filterOrder.value = FilterOrder(
                          name: "filter_order",
                          dateFrom: SahaDateUtils().getDate(DateTime.now()),
                          dateTo: SahaDateUtils().getDate(DateTime.now()),
                          listSource: [],
                          listPaymentStt: [],
                          listOrderStt: ["COMPLETED"],
                          listBranch: [sahaDataController.branchCurrent.value]);
                      navigatorController.indexNav.value = 1;
                      orderController.loadMoreOrder(isRefresh: true);
                    }
                  },
                  child: Column(
                    children: [
                      Text(
                        "Hoàn thành",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          "${SahaStringUtils().convertToMoney(sahaDataController.badgeUser.value.ordersCompleted ?? 0)}")
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget boxSale() {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Doanh thu hôm nay",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Obx(
                () => Row(
                  children: [
                    Text(
                      "${SahaStringUtils().convertToMoney(sahaDataController.overViewSale.value.totalFinalInDay ?? 0)} VNĐ",
                      style: TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text('Số đơn'),
                    ),
                    Row(
                      children: [
                        Text(
                          "${SahaStringUtils().convertToMoney(sahaDataController.overViewSale.value.countInDay ?? 0)}",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
               Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text('Khách hàng'),
                    ),
                    Row(
                      children: [
                        Text(
                          "${sahaDataController.user.value.totalCustomer ?? 0}",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.to(() => CustomerSaleScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.people_alt_rounded,
                              color: Theme.of(Get.context!).primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: Text("Khách hàng")),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        OrderController orderController = Get.find();
                        orderController.filterOrder.value = FilterOrder(
                            name: "filter_order",
                            listSource: [],
                            listBranch: [],
                            listOrderStt: [],
                            listPaymentStt: [],
                            staff: Get.find<SahaDataController>().user.value);

                        orderController.loadMoreOrder(isRefresh: true);
                        navigatorController.indexNav.value = 1;
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.reorder_rounded,
                              color: Theme.of(Get.context!).primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: Text("Đơn hàng")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                          Get.to(() => OverViewDetailSaleScreen(
              overViewSale: sahaDataController.overViewSale.value,
            ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.read_more,
                              color: Theme.of(Get.context!).primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: Text("Bác cáo sale")),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                         Get.to(() => SaleMarketScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check,
                              color: Theme.of(Get.context!).primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: Text("Checkin đại lý")),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Positioned(
        //     right: 20,
        //     child: Icon(
        //       Icons.navigate_next_rounded,
        //       size: 30,
        //     )),
      ],
    );
  }

  Widget boxButton() {
    return Container(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Obx(
            () => sahaDataController.isRefresh.value == true
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        ...UserInfo()
                            .getListFunctionHome()!
                            .map((e) => SizedBox(
                                  width: (Get.width - 20) / 4,
                                  child: MapButtonFunction(
                                    typeFunction: e,
                                  ),
                                ))
                            .toList(),
                        SizedBox(
                          width: (Get.width - 20) / 4,
                          child: MapButtonFunction(
                            typeFunction: "m",
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget boxProcessing() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "  PHÍM TẮT",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 6,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController
                            .badgeUser.value.decentralization?.productList ??
                        false,
                    child: itemProcess(
                      onTap: () {
                        if (sahaDataController.badgeUser.value.decentralization
                                ?.createOrderPos ==
                            false) {
                          SahaAlert.showToastMiddle(
                              message: "Chức năng tạo đơn bị chặn");
                        } else {
                          Get.to(() => ListCartScreen())!.then((res) {
                            if (res['has_click'] == true) {
                              HomeController homeController = Get.find();
                              homeController.isShowBill.value = true;
                              navigatorController.indexNav.value = 0;
                              homeController.cartCurrent.value =
                                  res['cart_info'];
                              homeController.getCart();
                            }
                          });
                        }
                      },
                      asset: 'assets/icons/list_order.svg',
                      title: 'Đơn lưu tạm',
                      sub:
                          "${SahaStringUtils().convertToMoney(sahaDataController.badgeUser.value.temporaryOrder ?? 0)}",
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController
                            .badgeUser.value.decentralization?.productList ??
                        false,
                    child: itemProcess(
                      onTap: () {
                        Get.to(InventoryProductScreen(isNearOutOfStock: true));
                      },
                      asset: 'assets/icons/products.svg',
                      title: 'Sản phẩm sắp hết hàng',
                      sub:
                          "${SahaStringUtils().convertToMoney(sahaDataController.badgeUser.value.totalProductOrDiscountNearlyOutStock ?? 0)}",
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController.badgeUser.value.decentralization
                            ?.inventoryTallySheet ??
                        false,
                    child: itemProcess(
                        asset: 'assets/icons/check_inventory.svg',
                        title: 'Đơn kiểm cần xử lý',
                        sub:
                            "${SahaStringUtils().convertToMoney(sahaDataController.badgeUser.value.totalTallySheetChecked ?? 0)}",
                        onTap: () {
                          Get.to(CheckInventoryScreen(
                            isNeedHanding: true,
                          ));
                        }),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController.badgeUser.value.decentralization
                            ?.inventoryImport ??
                        false,
                    child: itemProcess(
                        asset: 'assets/icons/import_home.svg',
                        title: 'Đơn nhập cần xử lý',
                        sub:
                            "${SahaStringUtils().convertToMoney(sahaDataController.badgeUser.value.totalImportNotCompleted ?? 0)}",
                        onTap: () {
                          Get.to(ImportStockScreen(
                            isNeedHanding: true,
                          ));
                        }),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Obx(
                  () => DecentralizationWidget(
                    decent: sahaDataController
                            .badgeUser.value.decentralization?.staffList ??
                        false,
                    child: itemProcess(
                        asset: 'assets/icons/customer.svg',
                        title: 'Nhân viên đang làm việc',
                        sub:
                            "${SahaStringUtils().convertToMoney(sahaDataController.badgeUser.value.totalStaffOnline ?? 0)}",
                        onTap: () {
                          Get.to(() => StaffScreen(
                                isStaffOnline: true,
                              ));
                        }),
                  ),
                ),
                Divider(
                  height: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemProcess(
      {required String asset,
      required String title,
      String? sub,
      Function? onTap}) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: onTap != null
          ? () {
              onTap();
            }
          : null,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            SvgPicture.asset(
              asset,
              height: 20,
              width: 20,
              color: Theme.of(Get.context!).primaryColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Spacer(),
            if (sub != null)
              Text(
                sub,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 17,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
