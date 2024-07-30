import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/model/printer.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/info_customer/history_order/order_detail_manage/order_detail_manage_controller.dart';

import 'add_printer/add_printer_screen.dart';
import 'printers_controller.dart';

class PrintScreen extends StatelessWidget {
  bool? isChoosePrint;
  bool? isPrintOrderHis;

  PrintScreen({this.isChoosePrint, this.isPrintOrderHis});

  PrintersController printersController = PrintersController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Máy in"),
      ),
      body: Obx(
        () => printersController.listPrinter.isEmpty
            ? Center(child: Text("Không có máy in nào"))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ...List.generate(printersController.listPrinter.length,
                        (index) {
                      var e = printersController.listPrinter[index];
                      return itemBody(
                        Icon(
                          Icons.print,
                          color: Colors.grey,
                        ),
                        "${e.name}",
                        "${e.typePrinter ?? ""} (${e.ipPrinter})",
                        () {
                          if (isChoosePrint == true) {
                            HomeController homeController = Get.find();
                            homeController.printBill(e.ipPrinter ?? "");
                            Get.until(
                              (route) => route.settings.name == "home_screen",
                            );
                          } else if (isPrintOrderHis == true) {
                            OrderDetailController orderDetailController =
                                Get.find();
                            orderDetailController.printBill(e.ipPrinter ?? "");
                          } else {
                            Get.to(() => AddPrinterScreen(
                                      printer: Printer(
                                        name: e.name,
                                        autoPrint: e.autoPrint,
                                        ipPrinter: e.ipPrinter,
                                        typePrinter: e.typePrinter,
                                        print: e.print,
                                      ),
                                      indexPrint: index,
                                    ))!
                                .then((value) => {
                                      if (value == "success")
                                        {
                                          printersController.getListPrint(
                                              isRefresh: true),
                                        }
                                    });
                          }
                        },
                        index,
                      );
                    }),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: isChoosePrint == null || isChoosePrint == false
          ? Container(
              height: 65,
              color: Colors.white,
              child: Column(
                children: [
                  SahaButtonFullParent(
                    text: "Thêm máy in",
                    onPressed: () {
                      Get.to(() => AddPrinterScreen())!.then((value) => {
                            if (value == "success")
                              {
                                printersController.getListPrint(
                                    isRefresh: true),
                              }
                          });
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget itemBody(
      Icon icon, String text, String subText, Function onTap, int index) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                icon,
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      subText,
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                Spacer(),
                if (isChoosePrint == null || isChoosePrint == false)
                  IconButton(
                      onPressed: () {
                        SahaDialogApp.showDialogYesNo(
                            mess: "Bạn có chắc chắn muốn xoá thiết bị này chứ",
                            onOK: () {
                              printersController.deletePrinter(index);
                            });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              width: Get.width - 60,
              color: Colors.grey[300],
            )
          ],
        ),
      ),
    );
  }
}
