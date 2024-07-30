import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/model/tally_sheet.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'add_check_inventory/add_check_inventory_screen.dart';
import 'check_inventory_controller.dart';
import 'tally_sheet/tally_sheet_screen.dart';

class CheckInventoryScreen extends StatelessWidget {
  TextEditingController searchEditingController = TextEditingController();
  var timeInputSearch = DateTime.now();
  bool? isNeedHanding;

  CheckInventoryScreen({this.isNeedHanding}) {
    checkInventoryController =
        CheckInventoryController(isNeedHanding: isNeedHanding);
  }

  late CheckInventoryController checkInventoryController;
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text("Phiếu kiểm kho"),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => AddCheckInventoryScreen())!.then((value) => {
                      if (value == "reload")
                        {
                          checkInventoryController.getAllTallySheet(
                              isRefresh: true),
                        }
                    });
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 8, right: 15, bottom: 8),
                  child: Icon(Icons.search),
                ),
                Expanded(
                  child: TextFormField(
                    controller: searchEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.only(
                          left: 0, right: 15, top: 15, bottom: 0),
                      border: InputBorder.none,
                      hintText: "Nhập mã phiếu",
                      hintStyle: TextStyle(fontSize: 15),
                      suffixIcon: IconButton(
                        onPressed: () {
                          checkInventoryController.textSearch = "";
                          checkInventoryController.getAllTallySheet(
                              isRefresh: true);
                          searchEditingController.clear();
                        },
                        icon: Icon(Icons.clear),
                      ),
                    ),
                    onChanged: (v) async {
                      checkInventoryController.textSearch = v;
                      checkInventoryController.getAllTallySheet(
                          isRefresh: true);
                    },
                    style: TextStyle(fontSize: 14),
                    minLines: 1,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: Obx(
              () => checkInventoryController.loadInit.value
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
                            body = Obx(() =>
                                checkInventoryController.isLoading.value
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
                        await checkInventoryController.getAllTallySheet(
                            isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await checkInventoryController.getAllTallySheet();
                        refreshController.loadComplete();
                      },
                      child: ListView.builder(
                        itemCount:
                            checkInventoryController.listTallySheet.length,
                        itemBuilder: (context, index) {
                          return itemCheckInventory(
                              checkInventoryController.listTallySheet[index]);
                        },
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }

  Widget itemCheckInventory(TallySheet tallySheet) {
    return InkWell(
      onTap: () {
        Get.to(() => TallySheetScreen(
                  tallySheetInputId: tallySheet.id ?? 0,
                ))!
            .then((value) => {
                  if (value == "reload")
                    {
                      checkInventoryController.getAllTallySheet(
                          isRefresh: true),
                    }
                });
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${tallySheet.code ?? ""}"),
                    Text(
                      "${SahaDateUtils().getDDMM(tallySheet.updatedAt ?? DateTime.now())}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Text(
                  "${tallySheet.status == 0 ? "Đã kiểm kho" : "Đã cân bằng"}",
                  style: TextStyle(
                    color: tallySheet.status == 1
                        ? Theme.of(Get.context!).primaryColor
                        : null,
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
