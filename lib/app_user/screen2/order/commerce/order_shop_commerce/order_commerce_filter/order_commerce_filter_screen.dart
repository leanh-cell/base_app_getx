import 'package:com.ikitech.store/app_user/model/e_commerce.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/saha_user/button/saha_button.dart';
import '../../../../../const/order_status_commerce.dart';
import '../order_shop_commerce_controller.dart';

class OrderCommerceFilterScreen extends StatelessWidget {
  OrderCommerceFilterScreen(
      {Key? key, required this.commerce})
      : super(key: key);

  final OrderShopCommerceController orderShopCommerceController = Get.find();
  final String commerce;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bộ lọc"),
      ),
      body: Column(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, bottom: 10, left: 10),
                  child: Row(
                    children: [
                      Text(
                        "Danh sách cửa hàng",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Icon(Icons.keyboard_arrow_down_rounded)
                    ],
                  ),
                ),
              ),
              if (orderShopCommerceController.shopIdsInput.isNotEmpty)
                Wrap(
                  children: [
                    ...orderShopCommerceController.shopIdsInput.map((e) => itemShop(eCommerce: e))
                  ],
                ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, bottom: 10, left: 10),
                  child: Row(
                    children: [
                      Text(
                        "Trạng thái đơn hàng",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Icon(Icons.keyboard_arrow_down_rounded)
                    ],
                  ),
                ),
              ),
              if (commerce == "LAZADA")
                Wrap(
                  children: [
                    ...orderShopCommerceController.orderStatusLazada
                        .map((e) => itemStatus(status: e))
                  ],
                ),
              if (commerce == "TIKI")
                Wrap(
                  children: [
                    ...orderShopCommerceController.orderStatusTiki
                        .map((e) => itemStatus(status: e))
                  ],
                ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Lọc",
              textColor: Colors.white,
              onPressed: () {
                orderShopCommerceController.getAllOrderCommerce(
                    isRefresh: true);
                Get.back();
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemStatus({required String status}) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            if (orderShopCommerceController.orderStatus.contains(status)) {
              orderShopCommerceController.orderStatus.remove(status);
            } else {
              orderShopCommerceController.orderStatus.add(status);
            }
          },
          child: Stack(
            children: [
              Container(
                width: Get.width / 2 - 16,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: orderShopCommerceController.orderStatus
                                .contains(status)
                            ? Theme.of(Get.context!).primaryColor
                            : Colors.grey[200]!)),
                child: SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      commerce == "LAZADA"
                          ? orderStatusMapLazada[status] ?? ''
                          : commerce == "TIKI"
                              ? orderStatusMapTiki[status] ?? ''
                              : '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:
                              status == orderShopCommerceController.orderStatus
                                  ? Theme.of(Get.context!).primaryColor
                                  : null),
                    ),
                  ),
                ),
              ),
              if (orderShopCommerceController.orderStatus.contains(status))
                Positioned(
                  left: -25,
                  top: -20,
                  child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                      transform: Matrix4.rotationZ(-0.5),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Positioned(
                              bottom: -0,
                              right: 20,
                              child: new RotationTransition(
                                turns: new AlwaysStoppedAnimation(20 / 360),
                                child: new Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 13,
                                ),
                              ))
                        ],
                      )),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemShop({required ECommerce eCommerce}) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            if (orderShopCommerceController.shopIds
                .map((e) => e.shopId)
                .contains(eCommerce.shopId)) {
              orderShopCommerceController.shopIds
                  .removeWhere((e) => e.shopId == eCommerce.shopId);
            } else {
              orderShopCommerceController.shopIds.add(eCommerce);
            }
          },
          child: Stack(
            children: [
              Container(
                width: Get.width / 2 - 16,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        color: orderShopCommerceController.shopIds
                            .map((e) => e.shopId)
                            .contains(eCommerce.shopId)
                            ? Theme.of(Get.context!).primaryColor
                            : Colors.grey[200]!)),
                child: SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      eCommerce.shopName ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color:
                          orderShopCommerceController.shopIds
                              .map((e) => e.shopId)
                              .contains(eCommerce.shopId)
                                  ? Theme.of(Get.context!).primaryColor
                                  : null),
                    ),
                  ),
                ),
              ),
              if ( orderShopCommerceController.shopIds
                  .map((e) => e.shopId)
                  .contains(eCommerce.shopId))
                Positioned(
                  left: -25,
                  top: -20,
                  child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                      transform: Matrix4.rotationZ(-0.5),
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: <Widget>[
                          Positioned(
                              bottom: -0,
                              right: 20,
                              child: new RotationTransition(
                                turns: new AlwaysStoppedAnimation(20 / 360),
                                child: new Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 13,
                                ),
                              ))
                        ],
                      )),
                )
            ],
          ),
        ),
      ),
    );
  }
}
