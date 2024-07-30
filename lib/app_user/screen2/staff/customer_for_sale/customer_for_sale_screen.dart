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
import '../../../components/saha_user/button/saha_button.dart';
import '../../../model/info_customer.dart';
import '../../../model/staff.dart';
import '../choose_customer/choose_customer_screen.dart';
import 'customer_for_sale_controller.dart';

class CustomerForSaleScreen extends StatelessWidget {
  Staff saleStaff;
  TextEditingController nameEditingController = TextEditingController();
  HomeController homeController = Get.find();
  NavigatorController navigatorController = Get.find();
  late CustomerForSaleController chooseCustomerController;
  RefreshController _refreshController = RefreshController();

  CustomerForSaleScreen({this.isInPayScreen, required this.saleStaff}) {
    chooseCustomerController = CustomerForSaleController(saleStaff: saleStaff);
  }

  bool? isInPayScreen;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Khách hàng Sale"),
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
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Thêm khách hàng",
              onPressed: () {
                Get.to(() => ChooseCustomerSaleScreen(staffInput: saleStaff))!
                    .then((value) => chooseCustomerController.getAllCustomer(
                    isRefresh: true));
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemCustomer(InfoCustomer infoCustomer) {
    return InkWell(
      onTap: () {
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
