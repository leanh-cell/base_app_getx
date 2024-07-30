import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/history_inventory_res.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'history_inventory_controller.dart';

class HistoryInventoryScreen extends StatelessWidget {
  int idProduct;
  String? distributeName;
  String? elm;
  String? sub;

  HistoryInventoryScreen(
      {required this.idProduct, this.elm, this.distributeName, this.sub}) {
    historyInventoryController = HistoryInventoryController(
        idProduct: idProduct,
        elm: elm,
        distributeName: distributeName,
        sub: sub);
  }

  late HistoryInventoryController historyInventoryController;
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch sử kho"),
      ),
      body: SmartRefresher(
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
              body = Obx(() => historyInventoryController.isLoading.value
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
          await historyInventoryController.getHistoryInventory(isRefresh: true);
          refreshController.refreshCompleted();
        },
        onLoading: () async {
          await historyInventoryController.getHistoryInventory();
          refreshController.loadComplete();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => historyInventoryController.listHistoryInventory.isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Sản phẩm chưa có lịch sử kho",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: historyInventoryController.listHistoryInventory
                        .map((e) => itemHistory(e))
                        .toList(),
                  ),
          ),
        ),
      ),
    );
  }

  Widget itemHistory(HistoryInventory historyInventory) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "${historyInventory.typeName ?? ""}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(Get.context!).primaryColor,
                  ),
                ),
              ),
              Text(
                "Kho: ${historyInventory.stock ?? ""}",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(Get.context!).primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          if(historyInventory.change != 0)
          Row(
            children: [
              Text("Thay đổi:"),
              Spacer(),

              Row(
                children: [
                  (historyInventory.change ?? 0) < 0 ? Icon( Icons.arrow_drop_down, color: Colors.red,) : Icon( Icons.arrow_drop_up, color: Colors.blue,),
                  Text(
                    "${SahaStringUtils().convertToMoney(historyInventory.change ?? 0)}",
                    style: TextStyle(
                      color: (historyInventory.change ?? 0) < 0
                          ? Colors.red
                          : Colors.blue,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text("Giá vốn:"),
              Spacer(),
              Text(
                  "${SahaStringUtils().convertToMoney(historyInventory.costOfCapital ?? 0)}")
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
              "${SahaDateUtils().getDDMMYY(historyInventory.createdAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(historyInventory.createdAt ?? DateTime.now())}",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          ),
        ],
      ),
    );
  }
}
