import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/model/supplier.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/suppliers/add_suppliers/add_suppliers_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'choose_suppliers_controller.dart';

class ChooseSuppliersScreen extends StatelessWidget {

  TextEditingController searchEditingController = TextEditingController();
  var timeInputSearch = DateTime.now();
  ChooseSuppliersController suppliersController = ChooseSuppliersController();
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn nhà cung cấp"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => AddSuppliersScreen())!.then((value) => {
                      suppliersController.getAllSuppliers(isRefresh: true),
                    });
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
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
                      hintText: "Nhập tên nhà cung cấp",
                      hintStyle: TextStyle(fontSize: 15),
                      suffixIcon: IconButton(
                        onPressed: () {
                          searchEditingController.clear();
                        },
                        icon: Icon(Icons.clear),
                      ),
                    ),
                    onChanged: (v) async {
                      // timeInputSearch = DateTime.now();
                      // await Future.delayed(Duration(milliseconds: 500));
                      // var diff = DateTime.now().difference(timeInputSearch);
                      // if (diff.inMilliseconds > 500) {
                      //   billController.textSearch = v;
                      //   billController.loadMoreOrder(isSearch: true);
                      // }
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
            child: SmartRefresher(
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
                    body = Obx(() => suppliersController.isLoading.value
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
                await suppliersController.getAllSuppliers(isRefresh: true);
                refreshController.refreshCompleted();
              },
              onLoading: () async {
                await suppliersController.getAllSuppliers();
                refreshController.loadComplete();
              },
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(children: [
                    ...suppliersController.listSupplier
                        .map((e) => itemProvider(
                            supplier: e,
                            onTap: () {
                              Get.back(result: e);
                            }))
                        .toList(),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemProvider({required Supplier supplier, required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(supplier.name ?? ""),
                Text(
                  "${supplier.phone ?? ""}",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text("${supplier.addressDetail}",
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text(
                  "${supplier.wardsName} ${supplier.districtName} ${supplier.provinceName}",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
