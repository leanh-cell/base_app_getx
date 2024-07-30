import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import 'commerce/order_commerce_screen.dart';
import 'order_screen.dart';

class TypeOrderScreen extends StatelessWidget {
  const TypeOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đơn hàng')),
      body: Column(
        children: [
          Card(
            child: ListTile(
              onTap: () {
                Get.to(() => OrderScreen());
              },
              leading: Icon(Ionicons.list_outline,
                  color: Theme.of(context).primaryColor),
              title: Text('Đơn hàng trong hệ thống'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Get.to(() => OrderCommerceScreen());
              },
              leading: Icon(Ionicons.accessibility,
                  color: Theme.of(context).primaryColor),
              title: Text('Sàn thương mại điện tử'),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),
        ],
      ),
    );
  }
}
