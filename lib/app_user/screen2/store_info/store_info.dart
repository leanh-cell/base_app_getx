import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/store/all_store_response.dart';
import 'package:com.ikitech.store/app_user/screen2/branch/branch_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/choose_store/choose_store.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/categories/category_screen.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../saha_data_controller.dart';
import '../inventory/product/product_screen.dart';
import 'change_store_info_screen/change_store_info_screen.dart';
import 'store_info_controller.dart';

class StoreInfoScreen extends StatelessWidget {
  HomeController homeController = Get.find();
  StoreInfoController storeInfoController = StoreInfoController();
  RefreshController _refreshController = RefreshController();
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin cửa hàng"),
        actions: [],
      ),
      body: Obx(() {
        Store store = homeController.storeCurrent!.value;
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: MaterialClassicHeader(),
          controller: _refreshController,
          onRefresh: () async {
            await storeInfoController.getInfoStore();
            _refreshController.refreshCompleted();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey[200]!)),
                          child: ClipRRect(
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                CachedNetworkImage(
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                  imageUrl: store.logoUrl ?? "",
                                  errorWidget: (context, url, error) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SahaEmptyImage(),
                                  ),
                                ),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(3000),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${store.name}",
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold),
                              ),
                              InkWell(
                                  onTap: () {
                                    Get.to(ChangeStoreInfoScreen());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5, right: 5),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Mã cửa hàng: ${store.storeCode}",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Chỉnh sửa",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Get.to(() => ChooseStoreScreen())!.then((value) {
                                // homeController.onHandleAfterChangeStore();
                              });
                            },
                            child: Text(
                              "Chuyển \n cửa hàng",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.teal, fontSize: 12),
                            )),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                DecentralizationWidget(
                  decent: sahaDataController
                          .badgeUser.value.decentralization?.branchList ??
                      false,
                  child: InkWell(
                    onTap: () {
                      Get.to(() => BranchScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        children: [
                          Icon(
                            Icons.store,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Chi nhánh: ${sahaDataController.branchCurrent.value.name}",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.more_vert,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "TỔNG QUAN CỬA HÀNG",
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, right: 10, left: 5),
                    child: Column(
                      children: [
                        buildListItem(
                            "https://${store.storeCode}.myiki.vn",
                            "",
                            Icon(
                              Icons.web,
                              color: Theme.of(context).primaryColor,
                            ), () {
                          launch("https://${store.storeCode}.myiki.vn");
                        }),
                        Divider(
                          height: 1,
                        ),
                        DecentralizationWidget(
                          decent: sahaDataController.badgeUser.value
                                  .decentralization?.productList ??
                              false,
                          child: buildListItem(
                              "Tổng sản phẩm",
                              "${store.totalProducts ?? ""}",
                              Icon(
                                Ionicons.layers_outline,
                                color: Theme.of(context).primaryColor,
                              ), () {
                            Get.to(() => ProductMainScreen());
                          }),
                        ),
                        Divider(
                          height: 1,
                        ),
                        DecentralizationWidget(
                          decent: sahaDataController.badgeUser.value
                                  .decentralization?.productCategoryList ??
                              false,
                          child: buildListItem(
                              "Tổng danh mục sản phẩm",
                              "${store.totalProductCategories ?? ""}",
                              Icon(
                                Ionicons.grid_outline,
                                color: Theme.of(context).primaryColor,
                              ), () {
                            Get.to(() => CategoryScreen());
                          }),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  int? totalProducts;
  int? totalProductCategories;
  int? totalPosts;
  int? totalPostCategories;
  int? totalCustomers;
  int? totalOrders;
  Widget buildListItem(String title, String value, Icon icon, Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 10,
            ),
            Expanded(child: Text(title)),
            if (value != "")
              SizedBox(
                width: 60,
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.teal),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
