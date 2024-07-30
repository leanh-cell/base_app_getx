import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/model/e_commerce.dart';
import 'package:com.ikitech.store/app_user/screen2/config/e-commerce/shop_detail/shop_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../utils/user_info.dart';
import 'e_commerce_controller.dart';

class ECommerceScreen extends StatelessWidget {
  ECommerceScreen({Key? key}) : super(key: key);
  ECommerceController eCommerceController = ECommerceController();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách các sàn TMĐT'),
        actions: [
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
                                  if (eCommerceController.platformName ==
                                      "TIKI") {
                                    eCommerceController.platformName = null;
                                    eCommerceController.getAllEcommerce();
                                    Get.back();
                                  } else {
                                    eCommerceController.platformName = "TIKI";
                                    eCommerceController.getAllEcommerce();
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
                                    eCommerceController.platformName == "TIKI"
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
                                  if (eCommerceController.platformName ==
                                      "LAZADA") {
                                    eCommerceController.platformName = null;
                                    eCommerceController.getAllEcommerce();
                                    Get.back();
                                  } else {
                                    eCommerceController.platformName = "LAZADA";
                                    eCommerceController.getAllEcommerce();
                                    Get.back();
                                  }
                                },
                                leading: Image.asset('assets/images/lazada.png',
                                    width: 40, height: 40),
                                title: Text('Lazada'),
                                trailing:
                                    eCommerceController.platformName == "LAZADA"
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
                                  if (eCommerceController.platformName ==
                                      "SHOPEE") {
                                    eCommerceController.platformName = null;
                                    eCommerceController.getAllEcommerce();
                                    Get.back();
                                  } else {
                                    eCommerceController.platformName =
                                        "SHOPEE";
                                    eCommerceController.getAllEcommerce();
                                    Get.back();
                                  }
                                },
                                leading: Image.asset('assets/icons/shopee.png',
                                    width: 40, height: 40),
                                title: Text('Shopee'),
                                trailing: eCommerceController.platformName ==
                                        "SHOPEE"
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
                                  if (eCommerceController.platformName ==
                                      "TIKTOK") {
                                    eCommerceController.platformName = null;
                                    eCommerceController.getAllEcommerce();
                                    Get.back();
                                  } else {
                                    eCommerceController.platformName = "TIKTOK";
                                    eCommerceController.getAllEcommerce();
                                    Get.back();
                                  }
                                },
                                leading: Image.asset('assets/images/tiktok.png',
                                    width: 40, height: 40),
                                title: Text('Tiktok'),
                                trailing:
                                    eCommerceController.platformName == "TIKTOK"
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
          () => eCommerceController.loadInit.value
              ? SahaLoadingFullScreen()
              : SmartRefresher(
                  controller: refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  header: const MaterialClassicHeader(),
                  onRefresh: () async {
                    await eCommerceController.getAllEcommerce();
                    refreshController.refreshCompleted();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...eCommerceController.listEcommerce
                            .map((e) => eCommerce(e))
                      ],
                    ),
                  ),
                ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Thêm kết nối ",
              onPressed: () async {
                if (eCommerceController.platformName == "TIKI") {
                  var result = await FlutterWebAuth.authenticate(
                      preferEphemeral: true,
                      url:
                          'https://dev.doapp.vn/api/store/ecommerce/connect/tiki?store_code=${UserInfo().getCurrentStoreCode()}',
                      callbackUrlScheme: "foobar");
                  print(result.toString());
                } else if (eCommerceController.platformName == "LAZADA") {
                  await FlutterWebAuth.authenticate(
                      preferEphemeral: true,
                      url:
                          'https://dev.doapp.vn/api/store/ecommerce/connect/lazada?store_code=${UserInfo().getCurrentStoreCode()}',
                      callbackUrlScheme: "foobar");
                } else if (eCommerceController.platformName == "TIKTOK") {
                  await FlutterWebAuth.authenticate(
                      preferEphemeral: true,
                      url:
                          'https://dev.doapp.vn/api/store/ecommerce/connect/tiktok?store_code=${UserInfo().getCurrentStoreCode()}',
                      callbackUrlScheme: "foobar");
                } else if (eCommerceController.platformName == "SHOPEE") {
                  await FlutterWebAuth.authenticate(
                      preferEphemeral: true,
                      url:
                          'https://dev.doapp.vn/api/store/ecommerce/connect/shopee?store_code=${UserInfo().getCurrentStoreCode()}',
                      callbackUrlScheme: "foobar");
                } else {
                  showModalBottomSheet(
                      context: Get.context!,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0)),
                      ),
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            if (eCommerceController.platformName == null ||
                                eCommerceController.platformName == "TIKI")
                              button(" TIKI", "assets/icons/tiki.png",
                                  () async {
                                var result = await FlutterWebAuth.authenticate(
                                    preferEphemeral: true,
                                    url:
                                        'https://dev.doapp.vn/api/store/ecommerce/connect/tiki?store_code=${UserInfo().getCurrentStoreCode()}',
                                    callbackUrlScheme: "foobar");
                                print(result.toString());
                              }),
                            if (eCommerceController.platformName == null ||
                                eCommerceController.platformName == "LAZADA")
                              button("LAZADA", "assets/icons/lazada2.png",
                                  () async {
                                await FlutterWebAuth.authenticate(
                                    preferEphemeral: true,
                                    url:
                                        'https://dev.doapp.vn/api/store/ecommerce/connect/lazada?store_code=${UserInfo().getCurrentStoreCode()}',
                                    callbackUrlScheme: "foobar");
                              }),
                            if (eCommerceController.platformName == null ||
                                eCommerceController.platformName == "TIKTOK")
                              button("TIKTOK", "assets/icons/tiktok.png",
                                  () async {
                                await FlutterWebAuth.authenticate(
                                    preferEphemeral: true,
                                    url:
                                        'https://dev.doapp.vn/api/store/ecommerce/connect/tiktok?store_code=${UserInfo().getCurrentStoreCode()}',
                                    callbackUrlScheme: "foobar");
                              }),
                            if (eCommerceController.platformName == null ||
                                eCommerceController.platformName == "SHOPEE")
                              button("SHOPEE", "assets/icons/shopee.png",
                                  () async {
                                await FlutterWebAuth.authenticate(
                                    preferEphemeral: true,
                                    url:
                                        'https://dev.doapp.vn/api/store/ecommerce/connect/shopee?store_code=${UserInfo().getCurrentStoreCode()}',
                                    callbackUrlScheme: "foobar");
                              })
                          ],
                        );
                      });
                }

                //print(result);
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget eCommerce(ECommerce eCommerce) {
    return InkWell(
      onTap: () {
        Get.to(() => ShopDetailScreen(
                  eCommerce: eCommerce,
                ))!
            .then((value) => eCommerceController.getAllEcommerce());
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
            subtitle: Text(eCommerce.shopId ?? ''),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ),
      ),
    );
  }

  Widget button(String title, String icon, Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              icon,
              width: 50,
              height: 50,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'Kết nối với $title',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
