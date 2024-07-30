import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty_widget/saha_empty_customer_widget.dart';
import 'package:com.ikitech.store/app_user/screen2/home/choose_address/new_customer_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../model/info_customer.dart';
import 'choose_customer_re_controller.dart';

class ChooseCustomerReScreen extends StatelessWidget {
  TextEditingController nameEditingController = TextEditingController();
  ChooseCustomerReController chooseCustomerController =
      ChooseCustomerReController();
  RefreshController _refreshController = RefreshController();

  ChooseCustomerReScreen();

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
              Get.to(() => NewCustomerScreen())!.then((value) => {
                    if (value == "reload")
                      {chooseCustomerController.getAllCustomer(isRefresh: true)}
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
                  await  chooseCustomerController.getAllCustomer();
                }
                _refreshController.loadComplete();
              },
              child: Obx(
                () => chooseCustomerController.isLoadInit.value
                    ? Container()
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
        Get.back(result: infoCustomer);
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
                    if (infoCustomer.phoneNumber != null)
                      Text(
                        "${infoCustomer.phoneNumber}",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                  ],
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      Get.back(result: infoCustomer);
                    },
                    icon: Icon(
                      Icons.add,
                      color: Theme.of(Get.context!).primaryColor,
                    ))
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
