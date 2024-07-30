import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/screen2/order_manage/order_detail_manage/bluetooth_print/bluetooth_print_controller.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

import '../../../../utils/string_utils.dart';
import '../../../home/home_controller.dart';

class OrderBluetoothPrintScreen extends StatelessWidget {
  OrderBluetoothPrintScreen({Key? key, required this.order}) {
    controller = OrderBluetoothPrintController(order: order);
  }

  final Order order;
  late OrderBluetoothPrintController controller;
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mẫu in"),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(10),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         Center(
      //           child: Column(
      //             children: [
      //               Text(
      //                 SahaStringUtils().toNonAccentVietnamese(
      //                     Get.find<HomeController>().storeCurrent?.value.name ??
      //                         ""),
      //                 style:
      //                     TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      //               ),
      //               const SizedBox(
      //                 height: 4,
      //               ),
      //               Text(
      //                   "Chi nhanh: ${SahaStringUtils().toNonAccentVietnamese(Get.find<SahaDataController>().branchCurrent.value.name ?? "")}"),
      //               const SizedBox(
      //                 height: 4,
      //               ),
      //               Text(
      //                   "Hotline: ${Get.find<SahaDataController>().branchCurrent.value.phone ?? ''}"),
      //               const SizedBox(
      //                 height: 4,
      //               ),
      //               Text(
      //                 "DON HANG",
      //                 style:
      //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      //               ),
      //               const SizedBox(
      //                 height: 4,
      //               ),
      //               Text(
      //                 order.orderCode ?? "",
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      //               ),
      //               const SizedBox(
      //                 height: 4,
      //               ),
      //               Text(
      //                   "Ngay ${order.createdAt?.day ?? ""} thang ${order.createdAt?.month ?? ""} nam ${order.createdAt?.year ?? ""}")
      //             ],
      //           ),
      //         ),
      //         const SizedBox(
      //           height: 16,
      //         ),
      //         Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               "Khach hang: ${SahaStringUtils().toNonAccentVietnamese(order.infoCustomer?.name ?? '')}",
      //               style: TextStyle(fontWeight: FontWeight.bold),
      //             ),
      //             const SizedBox(
      //               height: 4,
      //             ),
      //             Text("SDT: ${order.infoCustomer?.phoneNumber ?? ''}"),
      //             const SizedBox(
      //               height: 4,
      //             ),
      //             Text(
      //                 "Dia chi: ${SahaStringUtils().toNonAccentVietnamese(order.infoCustomer?.districtName ?? '')}"),
      //             const Divider(),
      //             Row(
      //               children: [
      //                 Expanded(
      //                     flex: 2,
      //                     child: Text(
      //                       "Don gia",
      //                       style: TextStyle(fontWeight: FontWeight.bold),
      //                     )),
      //                 Expanded(
      //                     flex: 1,
      //                     child: Text("SL",
      //                         style: TextStyle(fontWeight: FontWeight.bold))),
      //                 Expanded(
      //                     flex: 1,
      //                     child: Text("T.Tien",
      //                         style: TextStyle(fontWeight: FontWeight.bold))),
      //               ],
      //             ),
      //             const SizedBox(
      //               height: 10,
      //             ),
      //             Column(
      //               children: [
      //                 ...(order.lineItemsAtTime ?? [])
      //                     .map((e) => itemProduct(e))
      //               ],
      //             ),
      //             const Divider(),
      //           ],
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...controller.listLineText.map((e) {
                if (e.x == 1) {
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(

                      children: [
                        const Divider(),
                        Row(
                          children: [
                            
                            Expanded(
                                flex: 2,
                                child: Text(
                                  "Don gia",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Expanded(
                                flex: 1,
                                child: Text("SL",
                                    style: TextStyle(fontWeight: FontWeight.bold))),
                            Expanded(
                                flex: 1,
                                child: Text("T.Tien",
                                    style: TextStyle(fontWeight: FontWeight.bold))),
                          ],
                        ),
                        const Divider()
                      ],
                    ),
                  );
                }
                if (e.x == 2) {
                  List<String> splitStrings = (e.content ?? '').split('  ');
                  print("======>${splitStrings[1]}");
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              splitStrings[0],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text(splitStrings[1],
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(
                            flex: 1,
                            child: Text(
                                splitStrings[2],
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ],
                    ),
                  );
                }
                if (e.type == LineText.TYPE_TEXT && e.x == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: Align(
                      alignment: e.align == LineText.ALIGN_CENTER
                          ? Alignment.center
                          : e.align == LineText.ALIGN_LEFT
                              ? Alignment.topLeft
                              : e.align == LineText.ALIGN_RIGHT
                                  ? Alignment.topRight
                                  : Alignment.center,
                      child: Text(
                        e.content ?? "",
                        style: TextStyle(
                            fontWeight: e.weight == 1 ? FontWeight.bold : null),
                      ),
                    ),
                  );
                } else {
                  return Text("");
                }
              })
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "In",
              onPressed: (){
                if(sahaDataController.device == null || sahaDataController.isConnected != true){
                  SahaAlert.showError(message: "Chưa kết nối máy in nào");
                  return;
                }
                Map<String, dynamic> config = Map();
                sahaDataController.bluetoothPrint.printReceipt(config, controller.listLineText);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget itemProduct(LineItemsAtTime e) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${SahaStringUtils().toNonAccentVietnamese(e.name ?? '')}",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: Text(
                    "${SahaStringUtils().convertToUnit(e.itemPrice ?? 0)}d",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              Expanded(
                  flex: 1,
                  child: Text("${e.quantity ?? ''}",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 1,
                  child: Text(
                      "${SahaStringUtils().convertToUnit((e.itemPrice ?? 0) * (e.quantity ?? 0))}d",
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          )
        ],
      ),
    );
  }
}
