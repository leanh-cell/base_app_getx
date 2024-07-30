import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

class PrintBluetoothController extends GetxController {
  var namePrinter = TextEditingController();

  final Order? order;
  //BluetoothDevice? device;
  var isConnecting = false.obs;
  var dropdownValue = "A8".obs;
  List<String> listPaper = <String>[
    'A8',
    'A6',
  ];
  Map<String, dynamic> config = Map();
  List<LineText> listLineText = [];

  PrintBluetoothController({required this.order}) {
    namePrinter.text = Get.find<SahaDataController>().device?.name ?? "";
  }
  // List<LineText> printReceipt() {
  //   List<LineText> listText = [];
  //   if (dropdownValue.value == "A8") {
  //     listText.add(LineText(
  //       type: LineText.TYPE_TEXT,
  //       content: 'Nguoi ban',
  //       linefeed: 1,
  //     ));
  //     listText.add(LineText(
  //       type: LineText.TYPE_TEXT,
  //       content:
  //           'Ho ten: ${SahaStringUtils().toNonAccentVietnamese(Get.find<HomeController>().storeCurrent?.value.name ?? "")}',
  //       linefeed: 1,
  //     ));
  //     listText.add(LineText(
  //       type: LineText.TYPE_TEXT,
  //       content:
  //           'Chi nhanh: ${SahaStringUtils().toNonAccentVietnamese(Get.find<SahaDataController>().branchCurrent.value.name ?? "")}',
  //       linefeed: 1,
  //     ));
  //     listText.add(LineText(
  //       type: LineText.TYPE_TEXT,
  //       content:
  //           'So dien thoai: ${Get.find<SahaDataController>().branchCurrent.value.phone ?? ''}',
  //     ));

  //     listText.add(LineText(
  //         type: LineText.TYPE_TEXT, content: 'Nguoi mua', linefeed: 1));

  //     listText.add(LineText(
  //         type: LineText.TYPE_TEXT,
  //         content:
  //             'Ho ten: ${SahaStringUtils().toNonAccentVietnamese(order?.infoCustomer?.name ?? '')}',
  //         linefeed: 1));
  //     listText.add(LineText(
  //         type: LineText.TYPE_TEXT,
  //         content:
  //             'Dia chi: ${SahaStringUtils().toNonAccentVietnamese(order?.infoCustomer?.districtName ?? '')} ',
  //         linefeed: 1));
  //     listText.add(LineText(
  //       type: LineText.TYPE_TEXT,
  //       content: 'Dien thoai: ${order?.infoCustomer?.phoneNumber ?? ''}',
  //       linefeed: 1
  //     ));
  //     listText.add(LineText(linefeed: 1));
  //     listText.add(LineText(
  //         type: LineText.TYPE_TEXT, content: "**************", linefeed: 1,align: LineText.ALIGN_CENTER));

  //     (order?.lineItemsAtTime ?? []).forEach(
  //       (e) {
       
  //         listText.add(LineText(
  //             type: LineText.TYPE_TEXT,
  //             content:
  //                 "${(order?.lineItemsAtTime ?? []).indexOf(e) + 1}.${SahaStringUtils().toNonAccentVietnamese(e.name ?? '')}  x${e.quantity}",
  //             linefeed: 1));
  //         listText.add(LineText(type: LineText.TYPE_TEXT,content: "${SahaStringUtils().convertToUnit(e.beforePrice)}d"));
  //         listText.add(LineText(linefeed: 1));
  //       },
  //     );
  //     listText.add(LineText(
  //         type: LineText.TYPE_TEXT, content: "Tong tien hang : ${SahaStringUtils().convertToMoney(order?.totalBeforeDiscount ?? 0)} d", linefeed: 1));
  //     listText.add(LineText(
  //         type: LineText.TYPE_TEXT, content: "Phi van chuyen : ${SahaStringUtils().convertToMoney(order?.totalShippingFee ?? 0)} d", linefeed: 1));
  //     listText.add(LineText(
  //         type: LineText.TYPE_TEXT, content: "Thanh tien : ${SahaStringUtils().convertToMoney(order?.totalFinal ?? 0)} d", linefeed: 1));
  //     listText.add(LineText(
  //         type: LineText.TYPE_TEXT, content: "Da thanh toan : ${SahaStringUtils().convertToMoney(order?.totalFinal ?? 0)} d", linefeed: 1));
  //      listText.add(LineText(
  //         type: LineText.TYPE_TEXT, content: "Con lai : ${SahaStringUtils().convertToMoney(order?.remainingAmount ?? 0)} d", linefeed: 1));
  //     return listText;
  //   }
  //   if (dropdownValue.value == "A6") {
      
  //   }
  //   return listText;
  // }
}
