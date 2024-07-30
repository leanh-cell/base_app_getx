import 'dart:typed_data';

// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/const/const_database_shared_preferences.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';
import 'package:printing/printing.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'dart:io';
import 'package:image/image.dart' as a;
import 'package:tiengviet/tiengviet.dart';
import '../../../saha_data_controller.dart';
import 'network_printer.dart';
import 'package:pdf/widgets.dart' as pw;

class PrinterManagerController extends GetxController {
  SahaDataController sahaDataController = Get.find();
  ScreenshotController screenshotController = ScreenshotController();
  var onFind = false.obs;
  int port = 9100;
  String ipInput = '192.168.1';
  var listDevice = RxList<String>();
  Order order;
  a.Image? image;

  // late pos.TsplPrinter printer;

  PrinterManagerController({required this.order}) {
    getListDevice();
    // connectPrint();
  }

  void searchingDevice() async {
    onFind.value = true;
    await getIp();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final stream = NetworkAnalyzer.discover2(
      ipInput,
      port,
      timeout: Duration(milliseconds: 5000),
    );
    List<String> listIpDevice = [];
    int found = 0;
    stream.listen((NetworkAddress addr) {
      print('${addr.ip}:$port');
      if (addr.exists) {
        found++;
        listIpDevice.add(addr.ip);
        print('Found device: ${addr.ip}:$port');
      }
    }).onDone(() {
      if (listIpDevice.isNotEmpty) {
        listIpDevice.forEach((e) {
          if (!listDevice.contains(e)) {
            listDevice.add(e);
          }
        });
        prefs.setString(LIST_DEVICE_IP, listDevice.toString());
        SahaAlert.showSuccess(message: "Đã tìm thấy $found thiết bị");
      } else {
        SahaAlert.showError(
            message:
                "Không tìm thấy thiết bị nào\nvui lòng kiểm tra thiết bị máy in");
      }
      print('Finish. Found $found device(s)');
      onFind.value = false;
    });
  }

  void deleteDevice(String ip) async {
    listDevice.removeWhere((e) => e == ip);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LIST_DEVICE_IP, listDevice.toString());
  }

  void addIP(String ip) async {
    if (!ip.contains(RegExp(r'[a-z]')) &&
        !ip.contains(RegExp(r'[A-Z]')) &&
        ip != "") {
      print(ip);
      if (listDevice.contains(ip)) {
        SahaAlert.showError(message: "Thiết bị đã tồn tại");
      } else {
        listDevice.add(ip);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(LIST_DEVICE_IP, listDevice.toString());
      }
    } else {
      SahaAlert.showSuccess(message: "Địa chỉ IP không hợp lệ");
    }
  }

  void getListDevice() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = prefs.getString(LIST_DEVICE_IP);
    if (list != null) {
      if (list != "[]") {
        var replace = list.replaceAll("[", "").replaceAll("]", "");
        List<String> listIpDevice = replace.split(",");
        listDevice(listIpDevice);
      }
    }
  }

  Future<void> getIp() async {
    final info = NetworkInfo();
    var wifiIP = await info.getWifiIP();
    if (wifiIP != null) {
      var index = wifiIP.indexOf(".", 8);
      ipInput = wifiIP.substring(0, index);
      print(ipInput);
    }
  }

  void getImage() async {
    File file = await getImageFileFromAssets('logo_pos.png');
    image = a.decodeImage(file.readAsBytesSync());
  }

  Future<void> printBill(String ipDevice) async {
    // const PaperSize paper = PaperSize.mm80;
    // final profile = await CapabilityProfile.load(name: 'XP-N160I');
    // final printer = await NetworkPrinter2(paper, profile);

    // final PosPrintResult res = await printer.connect(ipDevice, port: 9100);

    // if (res == PosPrintResult.success) {
    //   printer.setGlobalCodeTable('CP1252');
    //   printer.disconnect();
    //   SahaAlert.showSuccess(message: "Đã in");
    // } else {
    //   SahaAlert.showError(message: "Không thể kết nối với máy in");
    // }

    // print('Print result: ${res.msg}');
  }

  // void testReceipt(NetworkPrinter2 printer) async {
  //   var data = sahaDataController.badgeUser.value.infoAddress;

  //   printer.text(TiengViet.parse('${data?.name ?? ""}'.toUpperCase()),
  //       styles: PosStyles(
  //         height: PosTextSize.size2,
  //         width: PosTextSize.size2,
  //         bold: true,
  //         align: PosAlign.center,
  //       ),
  //       linesAfter: 1);

  //   printer.text(
  //       TiengViet.parse(
  //           '${data?.addressDetail ?? ""} ${data?.wardsName ?? ""} ${data?.districtName ?? ""} ${data?.provinceName ?? ""}'),
  //       styles: PosStyles(align: PosAlign.center),
  //       linesAfter: 1);
  //   printer.text("Phone: ${data?.phone ?? ""}",
  //       styles: PosStyles(align: PosAlign.center), linesAfter: 1);

  //   printer.text(
  //     TiengViet.parse('HOÁ ĐƠN'),
  //     styles: PosStyles(
  //       height: PosTextSize.size2,
  //       width: PosTextSize.size2,
  //       bold: true,
  //       align: PosAlign.center,
  //     ),
  //   );
  //   printer.feed(1);
  //   printer.text(TiengViet.parse('Mã đơn hàng: ${order.orderCode ?? ""}'),
  //       styles: PosStyles(
  //         align: PosAlign.center,
  //       ));
  //   printer.feed(1);
  //   printer.text(
  //       TiengViet.parse(
  //           'Ngày: ${SahaDateUtils().getDDMMYY(DateTime.now())}  ${DateFormat('HH:mm:ss').format(DateTime.now())}'),
  //       styles: PosStyles(
  //         align: PosAlign.left,
  //       ));
  //   printer.feed(1);

  //   printer.hr();
  //   printer.row([
  //     PosColumn(
  //         text: 'San pham', width: 6, styles: PosStyles(align: PosAlign.left)),
  //     PosColumn(text: 'SL', width: 1, styles: PosStyles(align: PosAlign.left)),
  //     PosColumn(text: 'Gia', width: 2, styles: PosStyles(align: PosAlign.left)),
  //     PosColumn(
  //         text: 'Total', width: 3, styles: PosStyles(align: PosAlign.left)),
  //   ]);
  //   if (order.lineItemsAtTime != null) {
  //     order.lineItemsAtTime!.forEach((e) {
  //       printer.row([
  //         PosColumn(
  //           text: '${TiengViet.parse(e.name ?? "")}',
  //           width: 6,
  //           styles: PosStyles(
  //             align: PosAlign.left,
  //           ),
  //         ),
  //         PosColumn(
  //           text: '${e.quantity}',
  //           width: 1,
  //           styles: PosStyles(
  //             align: PosAlign.left,
  //           ),
  //         ),
  //         PosColumn(
  //           text: '${SahaStringUtils().convertToK(e.itemPrice ?? 0)}',
  //           width: 2,
  //           styles: PosStyles(
  //             align: PosAlign.left,
  //           ),
  //         ),
  //         PosColumn(
  //           text:
  //               '${SahaStringUtils().convertToK(e.itemPrice! * (e.quantity!))}',
  //           width: 3,
  //           styles: PosStyles(
  //             align: PosAlign.left,
  //           ),
  //         ),
  //       ]);
  //     });
  //   }
  //   if (order.totalShippingFee != null) {
  //     printer.row([
  //       PosColumn(
  //         text: 'Phi giao hang',
  //         width: 6,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text: '1',
  //         width: 1,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text: '${SahaStringUtils().convertToK(order.totalShippingFee ?? 0)}',
  //         width: 2,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text: '${SahaStringUtils().convertToK(order.totalShippingFee ?? 0)}',
  //         width: 3,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //     ]);
  //   }
  //   if (order.productDiscountAmount != null &&
  //       order.productDiscountAmount != 0) {
  //     printer.row([
  //       PosColumn(
  //         text: 'Sale san pham',
  //         width: 6,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text: '1',
  //         width: 1,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text:
  //             '-${SahaStringUtils().convertToK(order.productDiscountAmount ?? 0)}',
  //         width: 2,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text:
  //             '-${SahaStringUtils().convertToK(order.productDiscountAmount ?? 0)}',
  //         width: 3,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //     ]);
  //   }
  //   if (order.voucherDiscountAmount != null &&
  //       order.voucherDiscountAmount != 0) {
  //     printer.row([
  //       PosColumn(
  //         text: 'Voucher',
  //         width: 6,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text: '1',
  //         width: 1,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text:
  //             '-${SahaStringUtils().convertToK(order.voucherDiscountAmount ?? 0)}',
  //         width: 2,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text:
  //             '-${SahaStringUtils().convertToK(order.voucherDiscountAmount ?? 0)}',
  //         width: 3,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //     ]);
  //   }
  //   if (order.comboDiscountAmount != null && order.comboDiscountAmount != 0) {
  //     printer.row([
  //       PosColumn(
  //         text: 'Combo',
  //         width: 6,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text: '1',
  //         width: 1,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text:
  //             '-${SahaStringUtils().convertToK(order.comboDiscountAmount ?? 0)}',
  //         width: 2,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text:
  //             '-${SahaStringUtils().convertToK(order.comboDiscountAmount ?? 0)}',
  //         width: 3,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //     ]);
  //   }
  //   if (order.bonusAgencyHistory != null) {
  //     printer.row([
  //       PosColumn(
  //         text: 'Bonus đại lý',
  //         width: 6,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text: '1',
  //         width: 1,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text:
  //             '+${SahaStringUtils().convertToK(order.bonusAgencyHistory!.rewardValue ?? 0)}',
  //         width: 2,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //       PosColumn(
  //         text:
  //             '+${SahaStringUtils().convertToK(order.bonusAgencyHistory!.rewardValue ?? 0)}',
  //         width: 3,
  //         styles: PosStyles(
  //           align: PosAlign.left,
  //         ),
  //       ),
  //     ]);
  //   }
  //   printer.hr();
  //   printer.row([
  //     PosColumn(
  //         text: 'TOTAL',
  //         width: 3,
  //         styles: PosStyles(
  //           height: PosTextSize.size2,
  //           width: PosTextSize.size2,
  //         )),
  //     PosColumn(
  //         text:
  //             '${SahaStringUtils().convertToMoney(order.totalFinal ?? 0)} VND',
  //         width: 9,
  //         styles: PosStyles(
  //           align: PosAlign.right,
  //           height: PosTextSize.size2,
  //           width: PosTextSize.size2,
  //         )),
  //   ]);

  //   printer.hr(ch: '=', linesAfter: 1);

  //   printer.feed(1);
  //   printer.text('Xin cam on!',
  //       styles: PosStyles(align: PosAlign.center, bold: true));
  //   printer.feed(1);
  //   printer.text('COPYRIGHT © IKITECH.VN',
  //       styles:
  //           PosStyles(align: PosAlign.center, bold: true, codeTable: 'CP1252'));
  //   printer.feed(2);
  //   printer.cut();
  // }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  Future<Uint8List> _buildDocument() async {
    final doc = pdf.Document();

    doc.addPage(
      pdf.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (context) => pdf.Center(
          child: pdf.PdfLogo(),
        ),
      ),
    );

    return await doc.save();
  }

  var printerDpi = 203.0;

  String printerIP = '192.168.2.230';

  // void connectPrint() async {
  //   printer = pos.TsplPrinter(
  //     dpi: "203",
  //     sizeHeight: "20",
  //     sizeWidth: "40",
  //   );
  //   final pos.PosPrintResult res = await printer.connect(printerIP, port: 9100);
  //   if (res == pos.PosPrintResult.success) {
  //     SahaAlert.showSuccess(message: "Đã kết nối");
  //   } else {
  //     SahaAlert.showError(message: "Không thể kết nối với máy in");
  //   }
  // }

  Future<void> _exportPng() async {}

  Future printLabel() async {
    // final pdf = pw.Document();
    //
    // pdf.addPage(pw.Page(
    //   build: (context) => pw.Center(
    //     child: pw.Column(children: [
    //       pw.BarcodeWidget(
    //         barcode: b.Barcode.code128(
    //             useCode128C: true), // Barcode type and settings
    //         data: 'hieudeptrai',
    //         drawText: false,
    //         height: 40,
    //       ),
    //     ]),
    //   ),
    // ));
    //
    // await for (var page in Printing.raster(await pdf.save(), dpi: printerDpi)) {
    //   final image = page.asImage();
    //   print(image.data.buffer.asUint8List());

    // }

    // screenshotController
    //     .captureFromWidget(
    //   Text(
    //     "hieu",
    //     style: TextStyle (color: Colors.black),
    //   ),
    // )
    //     .then((capturedImage) async {
    //   final directory = await getApplicationDocumentsDirectory();
    //   final imagePath = await File('${directory.path}/image.png').create();
    //   await imagePath.writeAsBytes(capturedImage);
    //   await Share.shareFiles([imagePath.path]);
    //   print(capturedImage);
    //   printer.image(capturedImage);
    //   printer.beep();
    // });

    // final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    //
    //   printer.barcode(pos.Barcode.upcA(barData));
    //   printer.beep();
  }
}
