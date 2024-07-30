// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';

// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
// import 'package:com.ikitech.store/app_user/model/printer.dart';
// import 'package:com.ikitech.store/app_user/model/stamp.dart';
// import 'package:com.ikitech.store/app_user/screen2/config/print/printers_screen.dart';
// import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
// import 'package:sahashop_customer/app_customer/model/product.dart';
// import 'package:tiengviet/tiengviet.dart';

// import '../../../saha_data_controller.dart';

// class StampController extends GetxController {
//   Product? productInput;
//   var listStamp = RxList<Stamp>();
//   var priceType = 0.obs;
//   var isNameProduct = true.obs;
//   var isCode = true.obs;
//   var isPrice = true.obs;
//   var isVnd = true.obs;
//   var isNameStore = true.obs;
//   var listPrinter = RxList<Printer>();

//   StampController({this.productInput}) {
//     getListPrint();
//   }

//   String? checkPriceType(int type) {
//     if (type == 0) {
//       return "Giá bán lẻ";
//     }
//     if (type == 1) {
//       return "Giá nhập";
//     }
//     if (type == 2) {
//       return "Giá vốn";
//     }
//     return "Giá bán lẻ";
//   }

//   void updateQuantityStamp(int index, int realityExist) {
//     listStamp[index].quantity = realityExist;
//     listStamp.refresh();
//   }

//   void deleteStamp(int index) {
//     listStamp.removeAt(index);
//     listStamp.refresh();
//   }

//   void increaseStamp(int index) {
//     listStamp[index].quantity = (listStamp[index].quantity ?? 0) + 1;
//     listStamp.refresh();
//   }

//   void decreaseStamp(int index) {
//     if ((listStamp[index].quantity ?? 0) >= 1) {
//       listStamp[index].quantity = (listStamp[index].quantity ?? 0) - 1;
//     }
//     listStamp.refresh();
//   }

//   void getListPrint({bool? isRefresh}) async {
//     var box = await Hive.openBox('printers');
//     print(box.values);
//     listPrinter([]);
//     box.values.forEach((element) {
//       listPrinter.add(element);
//     });
//   }

//   Future<void> printAll() async {
//     print("vovovovovov========");
//     bool isNoPrinterAuto = false;
//     await Future.wait(listPrinter.map((e) {
//       if (e.autoPrint == true) {
//         if (e.ipPrinter == null) {
//           print("avvvvv========");
//           return Future.value(null);
//         } else {
//           isNoPrinterAuto = true;
//           print("a========");
//           return printBill(e.ipPrinter!);
//         }
//       } else {
//         return Future.value(null);
//       }
//     }));
//     if (isNoPrinterAuto == false) {
//       if (listPrinter.isNotEmpty) {
//         Get.to(() => PrintScreen(isChoosePrint: true));
//       }
//     }
//   }

//   Future<void> printBill(String ipDevice) async {
//     const PaperSize paper = PaperSize.mm58;
//     final profile = await CapabilityProfile.load();
//     final printer = NetworkPrinter(paper, profile);

//     final PosPrintResult res =
//         await printer.connect("192.168.1.230", port: 9100);

//     if (res == PosPrintResult.success) {
//       testReceipt(printer);
//       printer.disconnect();
//       SahaAlert.showSuccess(message: "Đã in");
//     } else {
//       SahaAlert.showError(message: "Không thể kết nối với máy in");
//     }

//     print('Print result: ${res.msg}');
//   }

//   SahaDataController sahaDataController = Get.find();

//   void testReceipt(NetworkPrinter printer) async {
//     var data = sahaDataController.branchCurrent.value;
//     printer.text(TiengViet.parse('${data.name ?? ""}'.toUpperCase()),

//         linesAfter: 1);
//     listStamp.forEach((stamp) {
//       print(stamp.barcode);
//       if (stamp.barcode != null && stamp.barcode! != "") {
//         printer.text(TiengViet.parse('${data.name ?? ""}'.toUpperCase()),
//             styles: PosStyles(
//               height: PosTextSize.size1,
//               width: PosTextSize.size1,
//               bold: true,
//               align: PosAlign.center,
//             ),
//             linesAfter: 1);
//         printer.text(TiengViet.parse('${stamp.nameProduct ?? ""}'),
//             styles: PosStyles(
//               height: PosTextSize.size1,
//               width: PosTextSize.size1,
//               bold: true,
//               align: PosAlign.center,
//             ),
//             linesAfter: 1);
//         // final List<String> barData = [
//         //   "1",
//         //   "2",
//         //   "3",
//         //   "4",
//         //   "5",
//         //   "6",
//         //   "7",
//         //   "8",
//         //   "9",
//         //   "0",
//         //   "4"
//         // ];
//         // printer.barcode(Barcode.upcA(barData));
//         printer.text(TiengViet.parse('${stamp.barcode ?? "hieudeptrai"}'),
//             styles: PosStyles(
//               height: PosTextSize.size1,
//               width: PosTextSize.size1,
//               bold: true,
//               align: PosAlign.center,
//             ),
//             linesAfter: 1);
//         printer.text(
//             TiengViet.parse(
//                 '${SahaStringUtils().convertToMoney(stamp.price ?? 0)}'),
//             styles: PosStyles(
//               height: PosTextSize.size1,
//               width: PosTextSize.size1,
//               bold: true,
//               align: PosAlign.center,
//             ),
//             linesAfter: 1);
//       }
//     });
//     printer.feed(2);
//     printer.cut();
//   }
// }
