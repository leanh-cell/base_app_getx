import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/model/revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/screen2/report/choose_time/choose_time_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../inventory/revenue_expanditure/revenue_expenditure_screen.dart';
import 'accountant_controller.dart';

class AccountantScreen extends StatefulWidget {
  @override
  State<AccountantScreen> createState() => _AccountantScreenState();
}

class _AccountantScreenState extends State<AccountantScreen>
    with SingleTickerProviderStateMixin {
  RefreshController refreshController = RefreshController(initialRefresh: true);
  RefreshController refreshController2 = RefreshController(initialRefresh: true);

  AccountantController accountantController = AccountantController();

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
        title: Text("Kế toán"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => ChooseTimeScreen(
                            isCompare: accountantController.isCompare.value,
                            initTab: accountantController.indexTabTime,
                            initChoose: accountantController.indexChooseTime,
                            fromDayInput: accountantController.fromDay.value,
                            toDayInput: accountantController.toDay.value,
                            hideCompare: true,
                            callback: (DateTime fromDate,
                                DateTime toDay,
                                DateTime fromDateCP,
                                DateTime toDayCP,
                                bool isCompare,
                                int index,
                                int indexChoose) {
                              accountantController.fromDay.value = fromDate;
                              accountantController.toDay.value = toDay;
                              accountantController.fromDayCP.value = fromDateCP;
                              accountantController.toDayCP.value = toDayCP;
                              accountantController.isCompare.value = isCompare;
                              accountantController.indexTabTime = index;
                              accountantController.indexChooseTime =
                                  indexChoose;
                            },
                          ))!
                      .then((value) => {
                            accountantController.getAllRevenueExpenditureReport(
                              isRefresh: true,
                              isRevenue: _tabController.index == 0 ? true : false,
                            )
                          });
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Obx(
                        () => Text(
                          "${SahaDateUtils().getDDMMYY2(accountantController.fromDay.value)} - ${SahaDateUtils().getDDMMYY2(accountantController.toDay.value)}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded)
                    ],
                  ),
                ),
              ),
              Divider(height: 1,),
              Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: Get.width,
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(
                            child: Text('THU',
                                style: TextStyle(color: Colors.black))),
                        Tab(
                            child: Text('CHI',
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
                  revenue(),
                  expenditure(),
                ]),
              ),
            ],
          ),
          Positioned(
            bottom: 35,
            child: Container(
              width: Get.width - 20,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Obx(
                () => Row(
                  children: [
                    Text(
                      "Tồn cuối kỳ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(
                      "${SahaStringUtils().convertToMoney(accountantController.allRevenueExpenditureReport.value.reserve ?? 0)}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget revenue() {
    return Column(
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
                  body = Obx(() => accountantController.isLoading.value
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
              await accountantController.getAllRevenueExpenditureReport(
                  isRefresh: true, isRevenue: true);
              refreshController.refreshCompleted();
            },
            onLoading: () async {
              await accountantController.getAllRevenueExpenditureReport(
                  isRevenue: true);
              refreshController.loadComplete();
            },
            child: SingleChildScrollView(
              child: Obx(
                () => accountantController.listRevenue.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Text("Chưa có phiếu thu chi nào")
                        ],
                      )
                    : Column(children: [
                        ...accountantController.listRevenue
                            .map((e) => revenueExpenditure(e))
                            .toList(),
                      ]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget expenditure() {
    return Column(
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
                  body = Obx(() => accountantController.isLoading.value
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
              await accountantController.getAllRevenueExpenditureReport(
                  isRefresh: true, isRevenue: false);
              refreshController2.refreshCompleted();
            },
            onLoading: () async {
              await accountantController.getAllRevenueExpenditureReport(
                  isRevenue: false);
              refreshController2.loadComplete();
            },
            child: SingleChildScrollView(
              child: Obx(
                () => accountantController.listExpenditure.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Text("Chưa có phiếu thu chi nào")
                        ],
                      )
                    : Column(children: [
                        ...accountantController.listExpenditure
                            .map((e) => revenueExpenditure(e))
                            .toList(),
                      ]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget revenueExpenditure(RevenueExpenditure revenueExpenditure) {
    return InkWell(
      onTap: () {

        Get.to(() => RevenueExpenditureScreen(
          isRevenue: revenueExpenditure.isRevenue!,
          revenueExpenditure: revenueExpenditure,
          changeMoney: revenueExpenditure.changeMoney,
          recipientGroup: revenueExpenditure.recipientGroup,
          recipientReferencesId: revenueExpenditure.recipientReferencesId,
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
                    Text(
                      "${SahaStringUtils().convertToMoney(revenueExpenditure.currentMoney ?? 0)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
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
                          style: TextStyle(color: Colors.grey, fontSize: 12),
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
}
