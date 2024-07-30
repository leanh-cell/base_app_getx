import 'package:com.ikitech.store/app_user/model/box_chat_customer.dart';
import 'package:com.ikitech.store/app_user/screen2/chat/chat_user_screen/chat_user_screen.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../components/saha_user/call/call.dart';
import '../../components/saha_user/decentralization/decentralization_widget.dart';
import '../../model/staff.dart';
import '../report/choose_time/choose_time_screen.dart';
import '../sale/list_sale/list_sale_screen.dart';
import 'history_order/order_detail_manage/order_detail_manage_screen.dart';
import 'history_points/history_points_screen.dart';
import 'info_customer_controller.dart';

class InfoCustomerScreen extends StatefulWidget {
  int infoCustomerId;
  bool? isCancel;
  bool? isWatch;
  bool? isInPayScreen;
  InfoCustomerScreen(
      {required this.infoCustomerId,
      this.isCancel,
      this.isInPayScreen,
      this.isWatch});

  @override
  State<InfoCustomerScreen> createState() => _InfoCustomerScreenState();
}

class _InfoCustomerScreenState extends State<InfoCustomerScreen>
    with SingleTickerProviderStateMixin {
  HomeController homeController = Get.find();
  NavigatorController navigatorController = Get.find();
  late TabController _tabController;
  late InfoCustomerController infoCustomerController;
  SahaDataController sahaDataController = Get.find();
  RefreshController refreshController = RefreshController();

  RefreshController refreshController2 = RefreshController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    infoCustomerController =
        InfoCustomerController(infoCustomerId: widget.infoCustomerId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin"),
        actions: [
          IconButton(onPressed: (){
            Get.to(()=>ChatUserScreen(boxChatCustomerInput: BoxChatCustomer(customer: infoCustomerController.infoCustomer.value,customerId: infoCustomerController.infoCustomer.value.id),));
          }, icon: Icon(Icons.chat))
        ],
      ),
      body: Obx(
        () => Column(
          children: [
            if (widget.isWatch != true)
              GestureDetector(
                onTap: () {
                  if (widget.isCancel == true) {
                    homeController.cartCurrent.value.customerId = null;
                    homeController.cartCurrent.value.customerName = null;
                    homeController.cartCurrent.value.customerPhone = null;
                    homeController.cartCurrent.value.province = null;
                    homeController.cartCurrent.value.district = null;
                    homeController.cartCurrent.value.wards = null;
                    homeController.cartCurrent.value.addressDetail = null;
                    homeController.updateInfoCart();
                    if (widget.isInPayScreen == true) {
                      Get.until(
                        (route) => route.settings.name == "pay_screen",
                      );
                    } else if (widget.isInPayScreen == false) {
                      Get.until(
                        (route) => route.settings.name == "home_screen",
                      );
                    } else {
                      Get.back();
                    }
                  } else {
                    var info = infoCustomerController.infoCustomer.value;
                    homeController.cartCurrent.value.customerId = info.id;
                    homeController.cartCurrent.value.customerName = info.name;
                    homeController.cartCurrent.value.customerPhone =
                        info.phoneNumber;
                    homeController.cartCurrent.value.province = info.province;
                    homeController.cartCurrent.value.district = info.district;
                    homeController.cartCurrent.value.wards = info.wards;
                    homeController.cartCurrent.value.addressDetail =
                        info.addressDetail;
                    homeController.updateInfoCart();
                    if (widget.isInPayScreen == true) {
                      Get.until(
                        (route) => route.settings.name == "pay_screen",
                      );
                    } else if (widget.isInPayScreen == false) {
                      homeController.isShowBill.value = true;
                      navigatorController.indexNav.value = 0;
                      Get.until(
                        (route) => route.settings.name == "home_screen",
                      );
                    } else {
                      Get.back();
                      Get.back();
                    }
                  }
                },
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      "${widget.isCancel == true ? "XOÁ KHỎI HOÁ ĐƠN" : "THÊM VÀO HOÁ ĐƠN"}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            Divider(
              height: 1,
            ),
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
                          "${infoCustomerController.infoCustomer.value.name ?? ""}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Call.call(
                                "${infoCustomerController.infoCustomer.value.phoneNumber ?? ""}");
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
                                "${infoCustomerController.infoCustomer.value.phoneNumber ?? ""}",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              color: Colors.blue,
                              size: 18,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${infoCustomerController.infoCustomer.value.email ?? ""}",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 13),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => HistoryPointScreen(
                                  customerId: infoCustomerController
                                      .infoCustomer.value.id!,
                                ));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.monetization_on,
                                color: Colors.blue,
                                size: 18,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Xu: ${SahaStringUtils().convertToMoney(infoCustomerController.infoCustomer.value.point ?? 0)}",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            if (infoCustomerController
                                    .infoCustomer.value.saleStaff?.name !=
                                null) {
                              Get.to(() => HistoryPointScreen(
                                    customerId: infoCustomerController
                                        .infoCustomer.value.id!,
                                  ));
                            } else {
                              Get.to(() => ListSaleScreen(
                                    isChooseOne: true,
                                    onDone: (List<Staff> v) {
                                      infoCustomerController.addCustomerToSale(
                                          staffId: v[0].id!);
                                    },
                                  ));
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: infoCustomerController.infoCustomer.value
                                            .saleStaff?.name !=
                                        null
                                    ? Colors.blue
                                    : Colors.red,
                                size: 18,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                infoCustomerController.infoCustomer.value
                                            .saleStaff?.name !=
                                        null
                                    ? "Nhân viên Sale: ${infoCustomerController.infoCustomer.value.saleStaff?.name ?? ''}"
                                    : 'Chưa có sale phụ trách',
                                style: TextStyle(
                                    color: infoCustomerController.infoCustomer
                                                .value.saleStaff?.name !=
                                            null
                                        ? Colors.blue
                                        : Colors.red,
                                    fontSize: 13),
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
                          child: Text('Công nợ',
                              style: TextStyle(color: Colors.black))),
                      Tab(
                          child: Text('Lịch sử',
                              style: TextStyle(color: Colors.black))),
                      Tab(
                          child: Text('Thông tin',
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
                Obx(
                  () => Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "Nợ hiện tại: ${SahaStringUtils().convertToMoney(infoCustomerController.infoCustomer.value.debt ?? 0)}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
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
                                  body = Obx(() =>
                                      infoCustomerController.isLoading.value
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
                              await infoCustomerController
                                  .getAllRevenueExpenditure(isRefresh: true);
                              refreshController.refreshCompleted();
                            },
                            onLoading: () async {
                              await infoCustomerController
                                  .getAllRevenueExpenditure();
                              refreshController.loadComplete();
                            },
                            child: SingleChildScrollView(
                              child: Obx(
                                () => infoCustomerController
                                        .listRevenueExpenditure.isEmpty
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 100,
                                          ),
                                          Text("Chưa có phiếu thu chi nào")
                                        ],
                                      )
                                    : Column(
                                        children: infoCustomerController
                                            .listRevenueExpenditure
                                            .map((e) => revenueExpenditure(e))
                                            .toList(),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        SahaButtonFullParent(
                          text: "Điều chỉnh công nợ",
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                ),
                                builder: (context) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      DecentralizationWidget(
                                        decent: sahaDataController
                                                .badgeUser
                                                .value
                                                .decentralization
                                                ?.addRevenue ??
                                            false,
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.monetization_on,
                                            color: Colors.blue,
                                          ),
                                          title: Text(
                                            'Tạo phiếu thu',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                          onTap: () {
                                            Get.back();
                                            Get.to(() =>
                                                    RevenueExpenditureScreen(
                                                      isRevenue: true,
                                                      changeMoney:
                                                          (infoCustomerController
                                                                      .infoCustomer
                                                                      .value
                                                                      .debt ??
                                                                  0)
                                                              .abs(),
                                                      recipientGroup:
                                                          RECIPIENT_GROUP_CUSTOMER,
                                                      recipientReferencesId:
                                                          infoCustomerController
                                                              .infoCustomer
                                                              .value
                                                              .id,
                                                      nameRecipientReferencesIdInput:
                                                          infoCustomerController
                                                              .infoCustomer
                                                              .value
                                                              .name,
                                                    ))!
                                                .then((value) => {
                                                      if (value == true)
                                                        {
                                                          infoCustomerController
                                                              .getAllRevenueExpenditure(
                                                                  isRefresh:
                                                                      true),
                                                          infoCustomerController
                                                              .getInfoCustomer(),
                                                        }
                                                    });
                                          },
                                        ),
                                      ),
                                      DecentralizationWidget(
                                        decent: sahaDataController
                                                .badgeUser
                                                .value
                                                .decentralization
                                                ?.addExpenditure ??
                                            false,
                                        child: ListTile(
                                          leading: Icon(Icons.monetization_on,
                                              color: Colors.red),
                                          title: Text(
                                            'Tạo phiếu chi',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onTap: () {
                                            Get.back();
                                            Get.to(() =>
                                                    RevenueExpenditureScreen(
                                                      isRevenue: false,
                                                      changeMoney:
                                                          infoCustomerController
                                                              .infoCustomer
                                                              .value
                                                              .debt,
                                                      recipientGroup:
                                                          RECIPIENT_GROUP_CUSTOMER,
                                                      recipientReferencesId:
                                                          infoCustomerController
                                                              .infoCustomer
                                                              .value
                                                              .id,
                                                      nameRecipientReferencesIdInput:
                                                          infoCustomerController
                                                              .infoCustomer
                                                              .value
                                                              .name,
                                                    ))!
                                                .then((value) => {
                                                      if (value == true)
                                                        {
                                                          infoCustomerController
                                                              .getAllRevenueExpenditure(
                                                                  isRefresh:
                                                                      true),
                                                          infoCustomerController
                                                              .getInfoCustomer(),
                                                        }
                                                    });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  );
                                });
                          },
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Obx(
                            () => Text(
                              "Nợ hiện tại: ${SahaStringUtils().convertToMoney(infoCustomerController.infoCustomer.value.debt ?? 0)}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Container(
                                    width: Get.width * 0.9,
                                    height: Get.height * 0.5,
                                    child: SfDateRangePicker(
                                      onCancel: () {
                                        Get.back();
                                      },
                                      onSubmit: (v) {
                                        infoCustomerController.dateFrom.value =
                                            startDate;
                                        infoCustomerController.dateTo.value =
                                            endDate;
                                        print(infoCustomerController
                                            .dateFrom.value);
                                        print(infoCustomerController
                                            .dateTo.value);
                                        infoCustomerController.loadMoreOrder(isRefresh: true);
                                        Get.back();
                                      },
                                      showActionButtons: true,
                                      onSelectionChanged:
                                          (DateRangePickerSelectionChangedArgs
                                              args) {
                                        if (args.value is PickerDateRange) {
                                          startDate = args.value.startDate;
                                          endDate = args.value.endDate ??
                                              args.value.startDate;
                                        }
                                      },
                                      selectionMode:
                                          DateRangePickerSelectionMode.range,
                                      initialSelectedRange: PickerDateRange(
                                        infoCustomerController.dateFrom.value,
                                        infoCustomerController.dateTo.value,
                                      ),
                                      initialSelectedDate:
                                          infoCustomerController.dateFrom.value,
                                      initialDisplayDate:
                                          infoCustomerController.dateFrom.value,
                                      maxDate: DateTime.now(),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Text('Lọc đơn hàng:'),
                              Expanded(
                                child: Obx(
                                  () => Text(
                                    '${SahaDateUtils().getDDMMYY(infoCustomerController.dateFrom.value)} đến ${SahaDateUtils().getDDMMYY(infoCustomerController.dateTo.value)}',
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ),
                              Icon(Icons.navigate_next)
                            ],
                          ),
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
                                body = Obx(() =>
                                    !infoCustomerController.isDoneLoadMore.value
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
                            await infoCustomerController.loadMoreOrder(
                                isRefresh: true);
                            refreshController2.refreshCompleted();
                          },
                          onLoading: () async {
                            await infoCustomerController.loadMoreOrder();
                            refreshController2.loadComplete();
                          },
                          child: Obx(
                            () => infoCustomerController.listOrder.isEmpty
                                ? Center(
                                    child: Text("Chưa có lịch sử mua hàng"))
                                : SingleChildScrollView(
                                    child: Column(
                                    children: infoCustomerController.listOrder
                                        .map((e) => historyOrder(e))
                                        .toList(),
                                  )),
                          ),
                        ),
                      ),
                      SahaButtonFullParent(
                        text: "Điều chỉnh công nợ",
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                              ),
                              builder: (context) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(
                                        Icons.monetization_on,
                                        color: Colors.blue,
                                      ),
                                      title: Text(
                                        'Tạo phiếu thu',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onTap: () {
                                        Get.back();
                                        Get.to(() => RevenueExpenditureScreen(
                                                  isRevenue: true,
                                                  changeMoney:
                                                      (infoCustomerController
                                                                  .infoCustomer
                                                                  .value
                                                                  .debt ??
                                                              0)
                                                          .abs(),
                                                  recipientGroup:
                                                      RECIPIENT_GROUP_CUSTOMER,
                                                  recipientReferencesId:
                                                      infoCustomerController
                                                          .infoCustomer
                                                          .value
                                                          .id,
                                                  nameRecipientReferencesIdInput:
                                                      infoCustomerController
                                                          .infoCustomer
                                                          .value
                                                          .name,
                                                ))!
                                            .then((value) => {
                                                  if (value == true)
                                                    {
                                                      infoCustomerController
                                                          .getAllRevenueExpenditure(
                                                              isRefresh: true),
                                                      infoCustomerController
                                                          .getInfoCustomer(),
                                                    }
                                                });
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.monetization_on,
                                          color: Colors.red),
                                      title: Text(
                                        'Tạo phiếu chi',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      onTap: () {
                                        Get.back();
                                        Get.to(() => RevenueExpenditureScreen(
                                                  isRevenue: false,
                                                  changeMoney:
                                                      infoCustomerController
                                                          .infoCustomer
                                                          .value
                                                          .debt,
                                                  recipientGroup:
                                                      RECIPIENT_GROUP_CUSTOMER,
                                                  recipientReferencesId:
                                                      infoCustomerController
                                                          .infoCustomer
                                                          .value
                                                          .id,
                                                  nameRecipientReferencesIdInput:
                                                      infoCustomerController
                                                          .infoCustomer
                                                          .value
                                                          .name,
                                                ))!
                                            .then((value) => {
                                                  if (value == true)
                                                    {
                                                      infoCustomerController
                                                          .getAllRevenueExpenditure(
                                                              isRefresh: true),
                                                      infoCustomerController
                                                          .getInfoCustomer(),
                                                    }
                                                });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                );
                              });
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
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Obx(
                            () => Text(
                              "Nợ hiện tại: ${SahaStringUtils().convertToMoney(infoCustomerController.infoCustomer.value.debt ?? 0)}",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      Container(
                        color: Colors.white,
                        width: Get.width,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Địa chỉ:"),
                            SizedBox(
                              height: 10,
                            ),
                            if (infoCustomerController
                                    .infoCustomer.value.addressDetail !=
                                null)
                              Text(
                                "${infoCustomerController.infoCustomer.value.addressDetail ?? ""}",
                              ),
                            if (infoCustomerController
                                    .infoCustomer.value.wardsName !=
                                null)
                              Text(
                                "${infoCustomerController.infoCustomer.value.wardsName ?? ""}${infoCustomerController.infoCustomer.value.wardsName != null ? "," : ""} ${infoCustomerController.infoCustomer.value.districtName ?? ""}${infoCustomerController.infoCustomer.value.districtName != null ? "," : ""} ${infoCustomerController.infoCustomer.value.provinceName ?? ""}",
                              ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => NewCustomerScreen(
                                    infoCustomer: infoCustomerController
                                        .infoCustomer.value,
                                  ))!
                              .then((value) => {
                                    if (value == "reload")
                                      {
                                        infoCustomerController
                                            .getInfoCustomer(),
                                      }
                                  });
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Chỉnh sửa",
                                style: TextStyle(color: Colors.blue),
                              ),
                              Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ),
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

  Widget revenueExpenditure(RevenueExpenditure revenueExpenditure) {
    return InkWell(
      onTap: () {
        Get.to(() => RevenueExpenditureScreen(
              isRevenue: true,
              revenueExpenditure: revenueExpenditure,
              changeMoney: infoCustomerController.infoCustomer.value.debt,
              recipientGroup: RECIPIENT_GROUP_CUSTOMER,
              recipientReferencesId:
                  infoCustomerController.infoCustomer.value.id,
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
                      "${revenueExpenditure.code ?? ""}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${revenueExpenditure.staff?.name ?? ""}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${SahaDateUtils().getDDMMYY(revenueExpenditure.createdAt ?? DateTime.now())} - ${SahaDateUtils().getHHMM(revenueExpenditure.createdAt ?? DateTime.now())}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        revenueExpenditure.isRevenue == true
                            ? Icon(
                                Icons.arrow_drop_down,
                                color: Colors.blue,
                              )
                            : Icon(
                                Icons.arrow_drop_up,
                                color: Colors.red,
                              ),
                        Text(
                          "${SahaStringUtils().convertToMoney(revenueExpenditure.changeMoney ?? 0)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${revenueExpenditure.typeActionName ?? ""}",
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
}
