import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty_widget/saha_empty_customer_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/choose_address/new_customer_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/info_customer/info_customer_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/navigator/navigator_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../saha_data_controller.dart';
import '../../../components/saha_user/button/saha_button.dart';
import '../../../components/saha_user/dialog/dialog.dart';
import '../../../model/agency_type.dart';
import '../../../model/info_customer.dart';
import '../../../model/staff.dart';
import '../../sale/list_sale/list_sale_screen.dart';
import 'choose_customer_controller.dart';

class ChooseCustomerScreen extends StatelessWidget {
  TextEditingController nameEditingController = TextEditingController();
  HomeController homeController = Get.find();
  NavigatorController navigatorController = Get.find();
  ChooseCustomerController chooseCustomerController =
      ChooseCustomerController();
  RefreshController _refreshController = RefreshController();

  ChooseCustomerScreen({this.isInPayScreen, this.hideSale});
  bool? hideSale;

  bool? isInPayScreen;
  SahaDataController sahaDataController = Get.find();
  List<String> choices = [
    "Khách hàng",
    "Cộng tác viên",
    "Đại lý",
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Obx(()=>chooseCustomerController.typeCompare.value == 0 || chooseCustomerController.typeCompare.value == 1 ? Text("Khách hàng") : chooseCustomerController.typeCompare.value == 2 ? Text("Cộng tác viên") : Text("Đại lý")),
        actions: [
          if (hideSale == false)
            TextButton(
              onPressed: () {
                chooseCustomerController.isPutSale.value =
                    !chooseCustomerController.isPutSale.value;
              },
              child: Obx(
                () => Text(
                  !chooseCustomerController.isPutSale.value
                      ? 'Phân sale'
                      : 'Huỷ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Bộ Lọc"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                chooseCustomerController.jsonListFilter = [
                                  chooseCustomerController.queryCustomer("12")
                                ];
                                chooseCustomerController.getAllCustomer(
                                    isRefresh: true);
                                chooseCustomerController.typeCompare.value = 1; 
                                Get.back();
                              },
                              title: Text("Khách hàng"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              onTap: () {
                                chooseCustomerController.jsonListFilter = [
                                  chooseCustomerController.queryCustomer("9")
                                ];
                                chooseCustomerController.getAllCustomer(
                                    isRefresh: true);
                                chooseCustomerController.typeCompare.value = 2; 
                                Get.back();
                              },
                              title: Text("Cộng tác viên"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              onTap: () {
                                chooseCustomerController.jsonListFilter = [
                                  chooseCustomerController.queryCustomer("10")
                                ];
                                chooseCustomerController.getAllCustomer(
                                    isRefresh: true);
                                chooseCustomerController.typeCompare.value = 3; 
                                Get.back();
                              },
                              title: Text("Đại lý"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.filter_alt))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: nameEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "Tìm kiếm",
                    contentPadding:
                        EdgeInsets.only(right: 15, top: 15, bottom: 15),
                    suffixIcon: IconButton(
                      onPressed: () {
                        nameEditingController.clear();
                        homeController.isSearch.value = false;
                        chooseCustomerController.search = "";
                        chooseCustomerController.getAllCustomer(
                            isRefresh: true);
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  onChanged: (v) {
                    chooseCustomerController.search = v;
                    chooseCustomerController.getAllCustomer(isRefresh: true);
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
          InkWell(
            onTap: () {
              Get.to(() => NewCustomerScreen(
                        infoSearch: nameEditingController.text,
                      ))!
                  .then((value) => {
                        if (value == "reload")
                          {
                            chooseCustomerController.getAllCustomer(
                                isRefresh: true)
                          }
                      });
            },
            child: Container(
              width: Get.width,
              padding: EdgeInsets.all(15),
              child: Center(
                child: Text(
                  "THÊM KHÁCH HÀNG MỚI",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, right: 15, left: 15),
            child: Text(
              "Khách hàng gần đây",
              style: TextStyle(color: Colors.black54),
            ),
          ),
          SizedBox(
            height: 5,
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
                  Widget body;
                  if (mode == LoadStatus.idle) {
                    body = Obx(() =>
                        !chooseCustomerController.isDoneLoadMore.value
                            ? CupertinoActivityIndicator()
                            : Container());
                  } else if (mode == LoadStatus.loading) {
                    body = CupertinoActivityIndicator();
                  } else {
                    body = Container();
                  }
                  return Container(
                    height: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        body,
                      ],
                    ),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: () async {
                await chooseCustomerController.getAllCustomer(isRefresh: true);
                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                if (chooseCustomerController.isDoneLoadMore.value) {
                  await chooseCustomerController.getAllCustomer();
                }
                _refreshController.loadComplete();
              },
              child: Obx(
                () => chooseCustomerController.isLoadInit.value
                    ? SahaLoadingFullScreen()
                    : chooseCustomerController.listInfoCustomer.isEmpty
                        ? SahaEmptyCustomerWidget(
                            width: 50,
                            height: 50,
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: chooseCustomerController
                                  .listInfoCustomer
                                  .map((e) => itemCustomer(e))
                                  .toList(),
                            ),
                          ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => chooseCustomerController.listInfoCustomerChoose.isNotEmpty
            ? Container(
                height: 65,
                color: Colors.white,
                child: Column(
                  children: [
                    SahaButtonFullParent(
                      text: "Chọn sale phân công",
                      onPressed: () async {
                        Get.to(() => ListSaleScreen(
                              isChooseOne: true,
                              onDone: (List<Staff> v) {
                                chooseCustomerController.addCustomerToSale(
                                    staffId: v[0].id!);
                              },
                            ));
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              )
            : Container(
                height: 1,
                width: 1,
              ),
      ),
    );
  }

  Widget itemCustomer(InfoCustomer infoCustomer) {
    return InkWell(
      onTap: () {
        if (chooseCustomerController.isPutSale.value == true) {
          if (chooseCustomerController.listInfoCustomerChoose
              .map((e) => e.id)
              .contains(infoCustomer.id)) {
            chooseCustomerController.listInfoCustomerChoose
                .remove(infoCustomer);
          } else {
            chooseCustomerController.listInfoCustomerChoose.add(infoCustomer);
          }
        } else {
          if (isInPayScreen == true) {
            Get.to(() => InfoCustomerScreen(
                      infoCustomerId: infoCustomer.id!,
                      isInPayScreen: true,
                    ))!
                .then((value) =>
                    {chooseCustomerController.getAllCustomer(isRefresh: true)});
          } else if (isInPayScreen == false) {
            Get.to(() => InfoCustomerScreen(
                      infoCustomerId: infoCustomer.id!,
                      isInPayScreen: false,
                    ))!
                .then((value) =>
                    {chooseCustomerController.getAllCustomer(isRefresh: true)});
          } else {
            Get.to(() => InfoCustomerScreen(
                      infoCustomerId: infoCustomer.id!,
                    ))!
                .then((value) =>
                    {chooseCustomerController.getAllCustomer(isRefresh: true)});
          }
        }
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
                    Text("${infoCustomer.name ?? '...'}"),
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
                      "${infoCustomer.isAgency == true ? "Đại lý ${infoCustomer.agencyType?.name ?? ''}" : infoCustomer.isCollaborator == true ? "Cộng tác viên" : "Khách hàng"}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (infoCustomer.saleStaff?.name != null)
                      Text(
                        infoCustomer.saleStaff?.name ?? "",
                        style: TextStyle(color: Colors.blue),
                      ),
                  ],
                ),
                Spacer(),
                Obx(
                  () => chooseCustomerController.isPutSale.value
                      ? Checkbox(
                          value: chooseCustomerController.listInfoCustomerChoose
                              .map((e) => e.id)
                              .contains(infoCustomer.id),
                          onChanged: (v) {
                            if (chooseCustomerController.listInfoCustomerChoose
                                .map((e) => e.id)
                                .contains(infoCustomer.id)) {
                              chooseCustomerController.listInfoCustomerChoose
                                  .remove(infoCustomer);
                            } else {
                              chooseCustomerController.listInfoCustomerChoose
                                  .add(infoCustomer);
                            }
                          })
                      : PopupMenuButton(
                          elevation: 3.2,
                          initialValue: choices[0],
                          onCanceled: () {},
                          icon: Icon(Icons.more_vert),
                          onSelected: (v) async {
                            if(sahaDataController.badgeUser.value.decentralization?.customerRoleEdit != true){
                              SahaAlert.showError(message: "Bạn không có quyền chỉnh sửa");
                              return;
                            }
                            var type = v == "Khách hàng"
                                ? 0
                                : v == "Cộng tác viên"
                                    ? 1
                                    : 2;

                            if (type == 2) {
                              SahaDialogApp.showDialogAgencyType(
                                  onChoose: (v) {
                                    print(v);
                                    chooseCustomerController.saleType(
                                        customerId: infoCustomer.id!,
                                        type: type,
                                        agencyTypeId: v.id!);
                                  },
                                  listAgencyType: chooseCustomerController
                                      .listAgencyType
                                      .toList());
                            } else {
                              chooseCustomerController.saleType(
                                  customerId: infoCustomer.id!, type: type);
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return choices.map((String choice) {
                              return PopupMenuItem(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                        ),
                )
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
