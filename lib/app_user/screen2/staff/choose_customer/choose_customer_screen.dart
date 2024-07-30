import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/saha_user/button/saha_button.dart';
import '../../../components/saha_user/empty_widget/saha_empty_customer_widget.dart';
import '../../../model/info_customer.dart';
import 'choose_customer_controller.dart';

class ChooseCustomerSaleScreen extends StatelessWidget {
  Staff staffInput;

  late ChooseCustomerSaleController controller;
  RefreshController _refreshController = RefreshController();

  ChooseCustomerSaleScreen({required this.staffInput}) {
    controller = ChooseCustomerSaleController(staffInput: staffInput);
  }

  TextEditingController nameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Phân sale'),
      ),
      body: Column(
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
                        //controller.isSearch.value = false;
                        controller.search = "";
                        controller.getAllCustomer(isRefresh: true);
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ),
                  onChanged: (v) {
                    controller.search = v;
                    controller.getAllCustomer(isRefresh: true);
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
                    body = Obx(() => !controller.isDoneLoadMore.value
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
                await controller.getAllCustomer(isRefresh: true);
                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                if (controller.isDoneLoadMore.value) {
                  await controller.getAllCustomer();
                }
                _refreshController.loadComplete();
              },
              child: Obx(
                () => controller.isLoadInit.value
                    ? Container()
                    : controller.listInfoCustomer.isEmpty
                        ? SahaEmptyCustomerWidget(
                            width: 50,
                            height: 50,
                          )
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
        ],
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "XÁC NHẬN",
              onPressed: () {
                controller.addCustomerToSale();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemCustomer(InfoCustomer infoCustomer) {
    return InkWell(
      onTap: () {
        if ((controller.listCustomerChoose.map((e) => e.id))
            .contains(infoCustomer.id)) {
          controller.listCustomerChoose.remove(infoCustomer);
        } else {
          controller.listCustomerChoose.add(infoCustomer);
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
                    if (infoCustomer.phoneNumber != null)
                      Text(
                        "${infoCustomer.phoneNumber}",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    Text(
                      infoCustomer.saleStaff == null
                          ? 'Chưa phân sale'
                          : "nhân viên sale: ${infoCustomer.saleStaff?.name ?? ''}",
                      style: TextStyle(
                          color: infoCustomer.saleStaff == null
                              ? Colors.red
                              : Colors.blue,
                          fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                Checkbox(
                    value: (controller.listCustomerChoose.map((e) => e.id))
                        .contains(infoCustomer.id),
                    onChanged: (v) {
                      if (v == false) {
                        controller.listCustomerChoose.remove(infoCustomer);
                      } else {
                        controller.listCustomerChoose.add(infoCustomer);
                      }
                    }),
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
