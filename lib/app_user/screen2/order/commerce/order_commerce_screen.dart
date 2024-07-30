import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/saha_user/loading/loading_full_screen.dart';
import '../../../components/saha_user/toast/saha_alert.dart';
import '../../../model/e_commerce.dart';
import 'order_commerce_controller.dart';
import 'order_shop_commerce/order_shop_commerce_screen.dart';

class OrderCommerceScreen extends StatelessWidget {
  OrderCommerceScreen({Key? key}) : super(key: key);
  OrderCommerceController orderCommerceController = OrderCommerceController();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sàn thương mại điện tử'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => orderCommerceController.loadInit.value
              ? SahaLoadingFullScreen()
              : SmartRefresher(
                  controller: refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  header: const MaterialClassicHeader(),
                  onRefresh: () async {
                    await orderCommerceController.getAllEcommerce();
                    refreshController.refreshCompleted();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          child: ListTile(
                            onTap: () {

                              var list = orderCommerceController.listEcommerce.where((e) => e.platform == "TIKI");

                              if (list.isEmpty) {
                                SahaAlert.showError(message: 'Chưa có cửa hàng nào');
                                return;
                              }

                              Get.to(() => OrderShopCommerceScreen(
                                shopIds: list.toList(),
                                commerce: 'TIKI',
                              ));
                            },
                            leading: Image.asset(
                              'assets/icons/tiki.png',
                              width: 50,
                              height: 50,
                            ),
                            title: Text('Tiki'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            onTap: () {
                              var list = orderCommerceController.listEcommerce.where((e) => e.platform == "LAZADA");

                              if (list.isEmpty) {
                                SahaAlert.showError(message: 'Chưa có cửa hàng nào');
                                return;
                              }

                              Get.to(() => OrderShopCommerceScreen(
                                shopIds: list.toList(),
                                commerce: 'LAZADA',
                              ));
                            },
                            leading: Image.asset('assets/images/lazada.png',
                                width: 50, height: 50),
                            title: Text('Lazada'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            onTap: () {
                              var list = orderCommerceController.listEcommerce.where((e) => e.platform == "SHOPEE");

                              if (list.isEmpty) {
                                SahaAlert.showError(message: 'Chưa có cửa hàng nào');
                                return;
                              }

                              Get.to(() => OrderShopCommerceScreen(
                                shopIds: list.toList(),
                                commerce: 'SHOPEE',
                              ));
                            },
                            leading: Image.asset('assets/icons/shopee.png',
                                width: 50, height: 50),
                            title: Text('Shopee'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            onTap: () {
                              var list = orderCommerceController.listEcommerce.where((e) => e.platform == "TIKTOK");

                              if (list.isEmpty) {
                                SahaAlert.showError(message: 'Chưa có cửa hàng nào');
                                return;
                              }

                              Get.to(() => OrderShopCommerceScreen(
                                shopIds: list.toList(),

                                commerce: 'TIKTOK',
                              ));
                            },
                            leading: Image.asset('assets/images/tiktok.png',
                                width: 50, height: 50),
                            title: Text('Tiktok'),
                          ),
                        )
                      ],
                    ),


                    // Column(
                    //   children: [
                    //     ...orderCommerceController.listEcommerce
                    //         .map((e) => eCommerce(e))
                    //   ],
                    // ),
                  ),
                ),
        ),
      ),
    );
  }
  //
  // Widget eCommerce(ECommerce eCommerce) {
  //   return InkWell(
  //     onTap: () {
  //       Get.to(() => OrderShopCommerceScreen(
  //             shopId: eCommerce.shopId ?? '',
  //             commerce: eCommerce.platform ?? '',
  //           ));
  //     },
  //     child: Card(
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: ListTile(
  //           leading: Image.asset(
  //             eCommerce.platform == "TIKI"
  //                 ? 'assets/icons/tiki.png'
  //                 : eCommerce.platform == "LAZADA"
  //                 ? 'assets/images/lazada.png'
  //                 : eCommerce.platform == "TIKTOK"
  //                 ? 'assets/images/tiktok.png'
  //                 : eCommerce.platform == "SHOPEE"
  //                 ? 'assets/images/shopee.png'
  //                 : '',
  //             height: 80,
  //             width: 80,
  //           ),
  //           title: Text(eCommerce.shopName ?? ""),
  //           trailing: Icon(Icons.keyboard_arrow_right),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
