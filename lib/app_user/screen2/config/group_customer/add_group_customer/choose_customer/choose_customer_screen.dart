import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../components/saha_user/loading/loading_full_screen.dart';
import '../../../../../model/info_customer.dart';
import '../../../../../utils/debounce.dart';
import 'choose_customer_controller.dart';

class ChooseCustomerScreen extends StatelessWidget {
  ChooseCustomerScreen(
      {Key? key,
      required this.onChooseCustomer,
      required this.listCustomerInput})
      : super(key: key) {
    controller = ChooseCustomerController(listCustomerInput: listCustomerInput);
  }
  late ChooseCustomerController controller;
  RefreshController refreshController = RefreshController();
  Function onChooseCustomer;
  List<InfoCustomer> listCustomerInput;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn khách hàng"),
      ),
      body: Obx(
        () => controller.loadInit.value
            ? SahaLoadingFullScreen()
            : Column(
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
                          controller: controller.search,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Tìm kiếm",
                            contentPadding:
                                EdgeInsets.only(right: 15, top: 15, bottom: 15),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.search.clear();

                                controller.search.text = "";
                                controller.getAllInfoCustomer(isRefresh: true);
                              },
                              icon: Icon(Icons.clear),
                            ),
                          ),
                          onChanged: (v) {
                            EasyDebounce.debounce(
                                'customer', const Duration(milliseconds: 300),
                                () {
                              controller.search.text = v;
                              controller.getAllInfoCustomer(isRefresh: true);
                            });
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
                        await controller.getAllInfoCustomer(isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await controller.getAllInfoCustomer();
                        refreshController.loadComplete();
                      },
                      child: ListView.builder(
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          itemCount: controller.listCustomer.length,
                          itemBuilder: (BuildContext context, int index) {
                            return itemCustomer(controller.listCustomer[index]);
                          }),
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Xác nhận",
              onPressed: () {
                onChooseCustomer(controller.listCustomerChoose.toList());
                Get.back();
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemCustomer(InfoCustomer infoCustomer) {
    return Column(
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
                () => Checkbox(
                    value: controller.listCustomerChoose
                        .where((e) => e.id == infoCustomer.id)
                        .isNotEmpty,
                    onChanged: (v) {
                      if (v == true) {
                        controller.listCustomerChoose.add(infoCustomer);
                      } else {
                        controller.listCustomerChoose
                            .removeWhere((e) => e.id == infoCustomer.id);
                      }
                    }),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
