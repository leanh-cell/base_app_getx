import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'check_inventory/check_inventory_screen.dart';
import 'import_stock/import_stock_screen.dart';
import 'inventory_product/inventory_product_screen.dart';
import 'suppliers/suppliers_screen.dart';

class Inventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Kho"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          itemBody(
              Icon(Ionicons.cube_outline,
                  color: Theme.of(context).primaryColor),
              "Quản lý kho", () {
            Get.to(() => InventoryProductScreen());
          }),
          itemBody(
              Icon(Ionicons.archive_outline,
                  color: Theme.of(context).primaryColor),
              "Nhập hàng", () {
            Get.to(() => ImportStockScreen());
          }),
          itemBody(
              Icon(Ionicons.checkbox_outline,
                  color: Theme.of(context).primaryColor),
              "Kiểm kho", () {
            Get.to(() => CheckInventoryScreen());
          }),
          itemBody(
              Icon(Ionicons.people_outline,
                  color: Theme.of(context).primaryColor),
              "Nhà cung cấp", () {
            Get.to(() => SuppliersScreen());
          }),
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
