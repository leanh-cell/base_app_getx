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

import '../../../model/info_customer.dart';
import 'add_customer/new_customer_sale_screen.dart';
import 'customer_sale_controller.dart';

class CustomerSaleScreen extends StatefulWidget {
  CustomerSaleScreen({this.isCreateNow});

  bool? isCreateNow;
  @override
  State<CustomerSaleScreen> createState() => _CustomerSaleScreenState();
}

class _CustomerSaleScreenState extends State<CustomerSaleScreen> {
  TextEditingController nameEditingController = TextEditingController();

  HomeController homeController = Get.find();

  NavigatorController navigatorController = Get.find();

  CustomerSaleController chooseCustomerController = CustomerSaleController();

  RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    if (widget.isCreateNow == true) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => Get.to(() => NewCustomerSaleScreen(
                    infoSearch: nameEditingController.text,
                  ))!
              .then((value) => {
                    if (value == "reload")
                      {
                        chooseCustomerController.getAllInfoCustomerSale(
                            isRefresh: true)
                      }
                  }));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Khách hàng"),
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
                        chooseCustomerController.getAllInfoCustomerSale(
                            isRefresh: true);
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  onChanged: (v) {
                    chooseCustomerController.search = v;
                    chooseCustomerController.getAllInfoCustomerSale(
                        isRefresh: true);
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
              Get.to(() => NewCustomerSaleScreen(
                        infoSearch: nameEditingController.text,
                      ))!
                  .then((value) => {
                        if (value == "reload")
                          {
                            chooseCustomerController.getAllInfoCustomerSale(
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
                await chooseCustomerController.getAllInfoCustomerSale(
                    isRefresh: true);
                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                if (chooseCustomerController.isDoneLoadMore.value) {
                  await chooseCustomerController.getAllInfoCustomerSale();
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
    );
  }

  Widget itemCustomer(InfoCustomer infoCustomer) {
    return InkWell(
      onTap: () {
        Get.to(() => InfoCustomerScreen(
                  infoCustomerId: infoCustomer.id!,
                ))!
            .then((value) => {
                  chooseCustomerController.getAllInfoCustomerSale(
                      isRefresh: true)
                });
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
                Spacer(),
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
