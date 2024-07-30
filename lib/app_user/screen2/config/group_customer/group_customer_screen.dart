import 'package:com.ikitech.store/app_user/data/remote/response-request/customer/all_group_customer_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:screenshot/screenshot.dart';

import '../../../components/saha_user/button/saha_button.dart';
import '../../../components/saha_user/loading/loading_full_screen.dart';
import 'add_group_customer/add_group_customer_screen.dart';
import 'group_customer_controller.dart';

class GroupCustomerScreen extends StatelessWidget {
  GroupCustomerController controller = GroupCustomerController();
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Nhóm khách hàng'),
      ),
      body: Obx(
        () => controller.loadInit.value
            ? SahaLoadingFullScreen()
            :  controller.listGroup.isEmpty
                ? const Center(
                    child: Text('Không có toà nhà nào'),
                  )
                : SmartRefresher(
                    footer: CustomFooter(
                      builder: (
                        BuildContext context,
                        LoadStatus? mode,
                      ) {
                        Widget body = Container();
                        if (mode == LoadStatus.idle) {
                          body = Obx(() => controller.isLoading.value
                              ? const CupertinoActivityIndicator()
                              : Container());
                        } else if (mode == LoadStatus.loading) {
                          body = const CupertinoActivityIndicator();
                        }
                        return SizedBox(
                          height: 100,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const MaterialClassicHeader(),
                    onRefresh: () async {
                      await controller.getAllGroupCustomer(isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await controller.getAllGroupCustomer();
                      refreshController.loadComplete();
                    },
                    child: ListView.builder(
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemCount: controller.listGroup.length,
                        itemBuilder: (BuildContext context, int index) {
                          return itemGroup(controller.listGroup[index]);
                        }),
                  ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Thêm nhóm khách hàng",
              onPressed: () {
                Get.to(() => AddGroupCustomerScreen())!
                    .then((value) => {controller.getAllGroupCustomer()});
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemGroup(GroupCustomer groupCustomer) {
    return InkWell(
      onTap: () {
        Get.to(() => AddGroupCustomerScreen(
                  groupCustomerInput: groupCustomer,
                ))!
            .then((value) => {controller.getAllGroupCustomer()});
      },
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(child: Text('${groupCustomer.name ?? ''}')),
                  IconButton(
                      onPressed: () {
                        controller.deleteGroupCustomer(groupCustomer.id!);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey,
                      )),
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
