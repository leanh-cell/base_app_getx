import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'printer_manager_controller.dart';

class PrinterManagerScreen extends StatelessWidget {
  Order order;

  PrinterManagerScreen({required this.order}) {
    printerManagerController = PrinterManagerController(order: order);
  }

  late PrinterManagerController printerManagerController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý máy in"),
        actions: [
          TextButton(
              onPressed: () {
                printerManagerController.searchingDevice();
              },
              child: Text(
                "Quét",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => printerManagerController.onFind.value == true
              ? Container(
                  height: Get.height - 100,
                  width: Get.width,
                  child: SahaLoadingFullScreen())
              : Column(children: [
                  ...printerManagerController.listDevice
                      .map((e) => itemDevice(e))
                      .toList(),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            SahaDialogApp.showDialogInput(
                                title: "Địa chỉ IP",
                                hintText: "VD: 198.168.1.199",
                                onInput: (v) {
                                  printerManagerController.addIP(v);
                                });
                          },
                          child: Text("Thêm thiết bị")),
                    ],
                  )
                ]),
        ),
      ),
    );
  }

  Widget itemDevice(String ipDevice) {
    return InkWell(
      onTap: () {
        printerManagerController.printBill(ipDevice);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.print,
                  color: Colors.pink,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Thiết bị: $ipDevice",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                InkWell(
                    onTap: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: "Bạn có chắc chắn muốn xoá thiết bị này chứ",
                          onOK: () {
                            printerManagerController.deleteDevice(ipDevice);
                          });
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
