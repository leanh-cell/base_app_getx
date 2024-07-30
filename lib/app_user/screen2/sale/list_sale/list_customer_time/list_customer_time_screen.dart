import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../components/saha_user/loading/loading_full_screen.dart';
import '../../../../model/info_customer.dart';
import '../../../../model/location_address.dart';
import '../../../info_customer/info_customer_screen.dart';
import 'list_customer_time_controller.dart';

class ListCustomerTimeScreen extends StatelessWidget {
  DateTime? dateFrom;
  DateTime? dateTo;
  int? type;
  String staffId;
  List<LocationAddress>? provinceIds;
  ListCustomerTimeScreen({
     this.dateFrom,
     this.dateTo,
    this.type,
    required this.staffId,
    this.provinceIds,
  }) {
    controller = ListCustomerTimeController(
        dateTo: dateTo,
        dateFrom: dateFrom,
        type: type,
        staffId: staffId,
        provinceIds: provinceIds);
  }

  late ListCustomerTimeController controller;
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách khách hàng"),
      ),
      body: Obx(
        () => controller.loadInit.value
            ? SahaLoadingFullScreen()
            : SmartRefresher(
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
                      body = Obx(() => controller.isLoading.value
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
                  await controller.getAllInfoCustomer(isRefresh: true);
                  refreshController.refreshCompleted();
                },
                onLoading: () async {
                  await controller.getAllInfoCustomer();
                  refreshController.loadComplete();
                },
                child: ListView.builder(
                  itemCount: controller.listCustomer.length,
                  itemBuilder: (context, index) {
                    return itemCustomer(controller.listCustomer[index]);
                  },
                ),
              ),
      ),
    );
  }
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
