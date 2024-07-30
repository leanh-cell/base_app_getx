import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/saha_user/loading/loading_full_screen.dart';
import '../../../model/e_commerce.dart';
import 'commerce_product/commerce_product_screen.dart';
import 'commerce_store_controller.dart';

class CommerceStoreScreen extends StatelessWidget {
  CommerceStoreScreen({Key? key}) : super(key: key);
  final CommerceStoreController commerceStoreController =
      CommerceStoreController();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách sàn điện tử'),
        actions: [
          Obx(
            () => commerceStoreController.loadInit.value == true ||
                    commerceStoreController.platformName.value == ''
                ? SizedBox()
                : IconButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Đồng bộ'),
                                  onPressed: () async {
                                    if (commerceStoreController
                                            .loadInit.value ==
                                        true) {
                                      return;
                                    }
                                    if (commerceStoreController
                                        .listShopId.isEmpty) {
                                      SahaAlert.showError(
                                          message: "Bạn chưa chọn shop nào");
                                      return;
                                    }
                                    // commerceStoreController.loadInit.value =
                                    //     true;
                                    commerceStoreController.pageCommerce = 1;
                                    await commerceStoreController.syncProduct();

                                    while (commerceStoreController
                                            .dataSync.totalInPage !=
                                        0) {
                                      commerceStoreController.pageCommerce =
                                          commerceStoreController.pageCommerce +
                                              1;

                                      await commerceStoreController
                                          .syncProduct();
                                    }

                                    SahaAlert.showSuccess(
                                        message: "Đồng bộ thành công");
                                    commerceStoreController.listShopId.value =
                                        [];

                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Thoát'),
                                  onPressed: () {
                                    commerceStoreController.listShopId.value =
                                        [];
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                              title: Text('Chọn cửa hàng'),
                              content: SizedBox(
                                width: Get.width,
                                child: SingleChildScrollView(
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ...commerceStoreController.listEcommerce
                                            .map(
                                          (e) => Card(
                                            child: ListTile(
                                              leading: Image.asset(
                                                e.platform == "TIKI"
                                                    ? 'assets/icons/tiki.png'
                                                    : e.platform == "LAZADA"
                                                        ? 'assets/icons/lazada2.png'
                                                        : e.platform == "TIKTOK"
                                                            ? 'assets/icons/tiktok.png'
                                                            : '',
                                                height: 30,
                                                width: 30,
                                              ),
                                              title: Text(e.shopName ?? ''),
                                              trailing: Obx(
                                                () => Checkbox(
                                                    value:
                                                        commerceStoreController
                                                            .listShopId
                                                            .contains(e.shopId),
                                                    onChanged: (v) {
                                                      if (v == true) {
                                                        commerceStoreController
                                                            .listShopId
                                                            .add(
                                                                e.shopId ?? '');
                                                        commerceStoreController
                                                            .listShopId
                                                            .refresh();
                                                      } else {
                                                        commerceStoreController
                                                            .listShopId
                                                            .remove(e.shopId);
                                                        commerceStoreController
                                                            .listShopId
                                                            .refresh();
                                                      }
                                                    }),
                                              ),
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            );
                          });
                    },
                    icon: Icon(Icons.sync)),
          ),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Lọc theo",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              child: ListTile(
                                onTap: () {
                                  if (commerceStoreController.platformName ==
                                      "TIKI") {
                                    commerceStoreController.platformName.value =
                                        '';
                                    commerceStoreController.getAllEcommerce();
                                    Get.back();
                                  } else {
                                    commerceStoreController.platformName.value =
                                        "TIKI";
                                    commerceStoreController.getAllEcommerce();
                                    Get.back();
                                  }
                                },
                                leading: Image.asset(
                                  'assets/icons/tiki.png',
                                  width: 40,
                                  height: 40,
                                ),
                                title: Text('Tiki'),
                                trailing:
                                    commerceStoreController.platformName ==
                                            "TIKI"
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : null,
                              ),
                            ),
                            Card(
                              child: ListTile(
                                onTap: () {
                                  if (commerceStoreController.platformName ==
                                      "LAZADA") {
                                    commerceStoreController.platformName.value =
                                        '';
                                    commerceStoreController.getAllEcommerce();
                                    Get.back();
                                  } else {
                                    commerceStoreController.platformName.value =
                                        "LAZADA";
                                    commerceStoreController.getAllEcommerce();
                                    Get.back();
                                  }
                                },
                                leading: Image.asset('assets/icons/lazada2.png',
                                    width: 40, height: 40),
                                title: Text('Lazada'),
                                trailing:
                                    commerceStoreController.platformName ==
                                            "LAZADA"
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : null,
                              ),
                            ),
                            Card(
                              child: ListTile(
                                onTap: () {
                                  if (commerceStoreController.platformName ==
                                      "SHOPEEE") {
                                    commerceStoreController.platformName.value =
                                        '';
                                    commerceStoreController.getAllEcommerce();
                                    Get.back();
                                  } else {
                                    commerceStoreController.platformName.value =
                                        "SHOPEEE";
                                    commerceStoreController.getAllEcommerce();
                                    Get.back();
                                  }
                                },
                                leading: Image.asset('assets/icons/shopee.png',
                                    width: 40, height: 40),
                                title: Text('Shopee'),
                                trailing:
                                    commerceStoreController.platformName ==
                                            "SHOPEEE"
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : null,
                              ),
                            ),
                            Card(
                              child: ListTile(
                                onTap: () {
                                  if (commerceStoreController.platformName ==
                                      "TIKTOK") {
                                    commerceStoreController.platformName.value =
                                        '';
                                    commerceStoreController.getAllEcommerce();
                                    Get.back();
                                  } else {
                                    commerceStoreController.platformName.value =
                                        "TIKTOK";
                                    commerceStoreController.getAllEcommerce();
                                    Get.back();
                                  }
                                },
                                leading: Image.asset('assets/icons/tiktok.png',
                                    width: 40, height: 40),
                                title: Text('Tiktok'),
                                trailing:
                                    commerceStoreController.platformName ==
                                            "TIKTOK"
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : null,
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
              icon: Icon(Icons.filter_list)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => commerceStoreController.loadInit.value
              ? SahaLoadingFullScreen()
              : SmartRefresher(
                  controller: refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  header: const MaterialClassicHeader(),
                  onRefresh: () async {
                    await commerceStoreController.getAllEcommerce();
                    refreshController.refreshCompleted();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...commerceStoreController.listEcommerce
                            .map((e) => eCommerce(e))
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget eCommerce(ECommerce eCommerce) {
    return InkWell(
      onTap: () {
        Get.to(() => CommerceProductScreen(
              shopId: eCommerce.shopId!,
            ));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Image.asset(
              eCommerce.platform == "TIKI"
                  ? 'assets/icons/tiki.png'
                  : eCommerce.platform == "LAZADA"
                      ? 'assets/images/lazada.png'
                      : eCommerce.platform == "TIKTOK"
                          ? 'assets/images/tiktok.png'
                          : eCommerce.platform == "SHOPEE"
                              ? 'assets/images/shopee.png'
                              : '',
              height: 80,
              width: 80,
            ),
            title: Text(eCommerce.shopName ?? ""),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ),
      ),
    );
  }
}
