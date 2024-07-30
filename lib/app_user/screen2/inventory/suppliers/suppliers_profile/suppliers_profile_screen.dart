import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/const/const_revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';
import 'package:com.ikitech.store/app_user/model/revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/model/supplier.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/import_stock/import_stock/import_stock_detail_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/revenue_expanditure/revenue_expenditure_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/suppliers/add_suppliers/add_suppliers_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../components/saha_user/call/call.dart';
import 'suppliers_profile_controller.dart';

class SuppliersProfileScreen extends StatefulWidget {
  Supplier supplier;

  SuppliersProfileScreen({required this.supplier});
  @override
  State<SuppliersProfileScreen> createState() => _SuppliersProfileScreenState();
}

class _SuppliersProfileScreenState extends State<SuppliersProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late SuppliersProfileController suppliersProfileController;
  RefreshController refreshController = RefreshController();
  RefreshController refreshController2 = RefreshController();
  SahaDataController sahaDataController = Get.find();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    suppliersProfileController =
        SuppliersProfileController(supplier: widget.supplier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.store,
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
                      Obx(
                        () => Text(
                          "${suppliersProfileController.supplierShow.value.name ?? ""}",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Call.call(
                              "${suppliersProfileController.supplierShow.value.phone ?? ""}");
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
                            Obx(
                              () => Text(
                                "${suppliersProfileController.supplierShow.value.phone ?? ""}",
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 13),
                              ),
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
                            "Nợ nhà cung cấp: ${SahaStringUtils().convertToMoney(suppliersProfileController.supplierShow.value.debt ?? 0)}",
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
                                    suppliersProfileController.isLoading.value
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
                            await suppliersProfileController
                                .getAllRevenueExpenditure(isRefresh: true);
                            refreshController.refreshCompleted();
                          },
                          onLoading: () async {
                            await suppliersProfileController
                                .getAllRevenueExpenditure();
                            refreshController.loadComplete();
                          },
                          child: SingleChildScrollView(
                            child: Obx(
                              () => suppliersProfileController
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
                                      children: suppliersProfileController
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    DecentralizationWidget(
                                      decent: sahaDataController.badgeUser.value
                                              .decentralization?.addRevenue ??
                                          false,
                                      child: ListTile(
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
                                                        (suppliersProfileController
                                                                    .supplierShow
                                                                    .value
                                                                    .debt ??
                                                                0)
                                                            .abs(),
                                                    recipientGroup:
                                                        RECIPIENT_GROUP_SUPPLIER,
                                                    recipientReferencesId:
                                                        suppliersProfileController
                                                            .supplierShow
                                                            .value
                                                            .id,
                                                    nameRecipientReferencesIdInput:
                                                        suppliersProfileController
                                                            .supplierShow
                                                            .value
                                                            .name,
                                                  ))!
                                              .then((value) => {
                                                    suppliersProfileController
                                                        .getAllRevenueExpenditure(
                                                            isRefresh: true),
                                                    suppliersProfileController
                                                        .getSupplier(),
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
                                          Get.to(() => RevenueExpenditureScreen(
                                                    isRevenue: false,
                                                    changeMoney:
                                                        (suppliersProfileController
                                                                    .supplierShow
                                                                    .value
                                                                    .debt ??
                                                                0)
                                                            .abs(),
                                                    recipientGroup:
                                                        RECIPIENT_GROUP_SUPPLIER,
                                                    recipientReferencesId:
                                                        suppliersProfileController
                                                            .supplierShow
                                                            .value
                                                            .id,
                                                    nameRecipientReferencesIdInput:
                                                        suppliersProfileController
                                                            .supplierShow
                                                            .value
                                                            .name,
                                                  ))!
                                              .then((value) => {
                                                    suppliersProfileController
                                                        .getAllRevenueExpenditure(
                                                            isRefresh: true),
                                                    suppliersProfileController
                                                        .getSupplier()
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
              SmartRefresher(
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
                          suppliersProfileController.isLoading.value
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
                  await suppliersProfileController.getAllImportStock(
                      isRefresh: true);
                  refreshController2.refreshCompleted();
                },
                onLoading: () async {
                  await suppliersProfileController.getAllImportStock();
                  refreshController2.loadComplete();
                },
                child: SingleChildScrollView(
                  child: Obx(
                    () => suppliersProfileController.listImportStock.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              Text("Chưa có lịch sử nhập hàng nào"),
                            ],
                          )
                        : Column(
                            children: suppliersProfileController.listImportStock
                                .map((e) => historyImportStock(e))
                                .toList(),
                          ),
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
                            "Nợ hiện tại: ${SahaStringUtils().convertToMoney(suppliersProfileController.supplierShow.value.debt ?? 0)}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    Obx(
                      () => Container(
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
                            if (suppliersProfileController
                                    .supplierShow.value.addressDetail !=
                                null)
                              Text(
                                "${suppliersProfileController.supplierShow.value.addressDetail}",
                              ),
                            if (suppliersProfileController
                                    .supplierShow.value.wardsName !=
                                null)
                              Text(
                                "${suppliersProfileController.supplierShow.value.wardsName ?? ""}${suppliersProfileController.supplierShow.value.wardsName != null ? "," : ""} ${suppliersProfileController.supplierShow.value.districtName ?? ""}${suppliersProfileController.supplierShow.value.districtName != null ? "," : ""} ${suppliersProfileController.supplierShow.value.provinceName ?? ""}",
                              ),
                          ],
                        ),
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
                        Get.to(() => AddSuppliersScreen(
                                  supplierInput: widget.supplier,
                                ))!
                            .then((value) => {
                                  if (value == "reload")
                                    {
                                      suppliersProfileController.getSupplier(),
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
    );
  }

  Widget revenueExpenditure(RevenueExpenditure revenueExpenditure) {
    return InkWell(
      onTap: () {
        Get.to(() => RevenueExpenditureScreen(
              isRevenue: true,
              revenueExpenditure: revenueExpenditure,
              changeMoney: suppliersProfileController.supplierShow.value.debt,
              recipientGroup: RECIPIENT_GROUP_SUPPLIER,
              recipientReferencesId:
                  suppliersProfileController.supplierShow.value.id,
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

  Widget historyImportStock(ImportStock importStock) {
    String? getStatus(int status) {
      if (status == 0) {
        return "Đặt hàng";
      }
      if (status == 1) {
        return "Duyệt";
      }
      if (status == 2) {
        return "Nhập kho";
      }
      if (status == 3) {
        return "Hoàn thành";
      }
      if (status == 4) {
        return "Đã huỷ";
      }
      if (status == 5) {
        return "Kết thúc";
      }
      if (status == 6) {
        return "Đơn hoàn trả";
      }
      return "";
    }

    return InkWell(
      onTap: () {
        Get.to(() => ImportStockDetailScreen(
                  importStockInputId: importStock.id ?? 0,
                ))!
            .then((value) => {
                  suppliersProfileController.getAllImportStock(isRefresh: true),
                  suppliersProfileController.getSupplier()
                });
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
                      "${importStock.code ?? ""}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${importStock.staff?.name ?? ""}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${importStock.code ?? ""}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${SahaStringUtils().convertToMoney(importStock.totalFinal ?? 0)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "${getStatus(importStock.status ?? 0)}",
                      style: TextStyle(
                          color: importStock.status == 0
                              ? Colors.blue
                              : importStock.status == 1
                                  ? Theme.of(Get.context!).primaryColor
                                  : importStock.status == 4
                                      ? Colors.red
                                      : importStock.status == 3
                                          ? Colors.green
                                          : Colors.grey,
                          fontSize: 12),
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
