import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/model/supplier.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/import_stock/add_import_stock/add_import_stock_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/import_stock/import_stock_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/suppliers/suppliers_profile/suppliers_profile_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'add_suppliers/add_suppliers_screen.dart';
import 'suppliers_controller.dart';

class SuppliersScreen extends StatelessWidget {
  bool? isChoose;

  SuppliersScreen({this.isChoose});

  TextEditingController searchEditingController = TextEditingController();
  var timeInputSearch = DateTime.now();
  SuppliersController suppliersController = SuppliersController();
  RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Nhà cung cấp"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => AddSuppliersScreen())!.then((value) => {
                      if (value == "reload")
                        {
                          suppliersController.getAllSuppliers(isRefresh: true),
                        }
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
                          suppliersController.textSearch = "";
                          suppliersController.getAllSuppliers(isRefresh: true);
                        },
                        icon: Icon(Icons.clear),
                      ),
                    ),
                    onChanged: (v) async {
                      timeInputSearch = DateTime.now();
                      await Future.delayed(Duration(milliseconds: 500));
                      var diff = DateTime.now().difference(timeInputSearch);
                      if (diff.inMilliseconds > 500) {
                        suppliersController.textSearch = v;
                        suppliersController.getAllSuppliers(isRefresh: true);
                      }
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
                    if (isChoose == true)
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                            "Bạn cần chọn nhà cung cấp trước khi tạo đơn nhập"),
                      ),
                    ...suppliersController.listSupplier
                        .map((e) => itemProvider(
                            supplier: e,
                            onTap: () {
                              if (isChoose == true) {
                                Get.to(() => AddImportStockScreen(
                                      supplier: e,
                                    ));
                              } else {
                                Get.to(() =>
                                        SuppliersProfileScreen(supplier: e))!
                                    .then((value) => {
                                          suppliersController.getAllSuppliers(
                                              isRefresh: true),
                                        });
                              }
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
    return Column(
      children: [
        InkWell(
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
                    if(supplier.phone != null)
                      Text(
                        "${supplier.phone ?? ""}",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    if(supplier.addressDetail != null)
                      Text("${supplier.addressDetail ??""}",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                    if(supplier.wardsName != null)
                      Text(
                        "${supplier.wardsName ?? ""} ${supplier.districtName ?? ""} ${supplier.provinceName??""}",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(height: 1,),
      ],
    );
  }
}
