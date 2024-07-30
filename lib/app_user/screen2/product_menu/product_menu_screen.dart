import 'package:com.ikitech.store/app_user/screen2/inventory/product/product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/inventory_product/inventory_product_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/stamp/stamp_screen.dart';
import 'package:ionicons/ionicons.dart';
import '../../../saha_data_controller.dart';
import '../inventory/attribute_search/attribute_search_screen.dart';
import '../inventory/categories/category_screen.dart';
import '../inventory/e_commerce_product/commerce_store_screen.dart';

class ProductMenuScreen extends StatelessWidget {
  SahaDataController sahaDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sản phẩm"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          DecentralizationWidget(
            decent: sahaDataController
                    .badgeUser.value.decentralization?.productList ??
                false,
            child: itemBody(
                Icon(Ionicons.list_outline,
                    color: Theme.of(context).primaryColor),
                "Danh sách sản phẩm", () {
              Get.to(() => ProductMainScreen());
            }),
          ),
          DecentralizationWidget(
            decent: sahaDataController
                    .badgeUser.value.decentralization?.productCategoryList ??
                false,
            child: itemBody(
                Icon(Ionicons.grid_outline,
                    color: Theme.of(context).primaryColor),
                "Danh mục sản phẩm", () {
              Get.to(() => CategoryScreen());
            }),
          ),
          DecentralizationWidget(
            decent: sahaDataController.badgeUser.value.decentralization?.productAttributeList ?? false,
            child: itemBody(
                Icon(Ionicons.filter, color: Theme.of(context).primaryColor),
                "Thuộc tính tìm kiếm", () {
              Get.to(() => AttributeSearchScreen());
            }),
          ),
          // DecentralizationWidget(
          //   decent: sahaDataController
          //           .badgeUser.value.decentralization?.inventoryList ??
          //       false,
          //   child: itemBody(
          //       Icon(Ionicons.cube_outline,
          //           color: Theme.of(context).primaryColor),
          //       "Kho hàng", () {
          //     Get.to(() => InventoryProductScreen());
          //   }),
          // ),
          // DecentralizationWidget(
          //   decent: true,
          //   child: itemBody(
          //       Icon(Ionicons.filter, color: Theme.of(context).primaryColor),
          //       "Thương mại điện tử", () {
          //     Get.to(() => CommerceStoreScreen());
          //   }),
          // ),

          // DecentralizationWidget(
          //   decent: sahaDataController
          //       .badgeUser.value.decentralization?.barcodePrint ??
          //       false,
          //   child: itemBody(
          //       Icon(Ionicons.barcode_outline,
          //           color: Theme.of(context).primaryColor),
          //       "In mã vạch", () {
          //     Get.to(() => StampScreen());
          //   }),
          // ),
        ],
      ),
    );
  }

  Widget itemBody(Icon icon, String text, Function onTap) {
    return ListTile(
      leading: icon,
      title: Text(
        text,
        style: TextStyle(fontSize: 15),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
