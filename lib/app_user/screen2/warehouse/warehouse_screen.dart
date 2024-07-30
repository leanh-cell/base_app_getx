import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../saha_data_controller.dart';
import '../../components/saha_user/decentralization/decentralization_widget.dart';
import '../inventory/change_inventory/transfer_stock_screen.dart';
import '../inventory/check_inventory/check_inventory_screen.dart';
import '../inventory/import_stock/import_stock_screen.dart';
import '../inventory/inventory_product/inventory_product_screen.dart';


class WarehouseScreen extends StatelessWidget {
   WarehouseScreen({Key? key}) : super(key: key);
   SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
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
                    .badgeUser.value.decentralization?.inventoryList ??
                false,
            child: itemBody(
                Icon(Ionicons.cube_outline,
                    color: Theme.of(context).primaryColor),
                "Kho hàng", () {
              Get.to(() => InventoryProductScreen());
            }),
          ),
          DecentralizationWidget(
            decent: sahaDataController
                    .badgeUser.value.decentralization?.inventoryTallySheet ??
                false,
            child: itemBody(
                Icon(Ionicons.list_outline,
                    color: Theme.of(context).primaryColor),
                "Kiểm kho", () {
                  Get.to(() => CheckInventoryScreen());
            }),
          ),
          DecentralizationWidget(
            decent: sahaDataController
                    .badgeUser.value.decentralization?.inventoryImport ??
                false,
            child: itemBody(
                Icon(Ionicons.grid_outline,
                    color: Theme.of(context).primaryColor),
                "Nhập hàng", () {
              Get.to(() => ImportStockScreen());
            }),
          ),
          DecentralizationWidget(
            decent: sahaDataController
                    .badgeUser.value.decentralization?.transferStock ??
                false,
            child: itemBody(
                Icon(Ionicons.filter, color: Theme.of(context).primaryColor),
                "Chuyển kho", () {
               Get.to(() => TransferStockScreen());
            }),
          ),
         
      
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