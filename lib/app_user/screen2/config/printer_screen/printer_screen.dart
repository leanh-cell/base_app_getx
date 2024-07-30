import 'package:com.ikitech.store/app_user/screen2/config/print/printers_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/config/print_bluetooth/print_bluetooth_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrinterScreen extends StatelessWidget {
  const PrinterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Máy in"),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Get.to(() => PrintScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.print,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Máy in Wifi")
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Get.to(() => PrintBluetoothScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.print_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Máy in bluetooth")
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
