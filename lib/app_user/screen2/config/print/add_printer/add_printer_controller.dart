// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/model/printer.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:ping_discover_network_forked/ping_discover_network_forked.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../../../../saha_data_controller.dart';

class AddPrinterController extends GetxController {
  var printerSave = Printer().obs;
  Printer? printerInput;
  int? indexPrinter;
  String? typePrinter;
  var onFind = false.obs;
  int port = 9100;
  String ipInput = '192.168.1';
  List<Printer> listPrinter = [];
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController ipTextEditingController = TextEditingController();
  SahaDataController sahaDataController = Get.find();

  AddPrinterController({this.printerInput, this.indexPrinter}) {
    if (printerInput != null) {
      printerSave.value = printerInput!;
    }
  }

  void searchingDevice() async {
    EasyLoading.show();
    await getIp();

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
          if (!listPrinter.map((e) => e.ipPrinter).toList().contains(e)) {
            ipTextEditingController.text = e;
          }
        });
        SahaAlert.showSuccess(message: "Đã tìm thấy $found thiết bị");
      } else {
        SahaAlert.showError(
            message:
                "Không tìm thấy thiết bị nào\nvui lòng kiểm tra thiết bị máy in");
      }
      print('Finish. Found $found device(s)');
      EasyLoading.dismiss();
    });
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

  void addPrinter() {
    var ip = printerSave.value.ipPrinter ?? "";
    if (!ip.contains(RegExp(r'[a-z]')) &&
        !ip.contains(RegExp(r'[A-Z]')) &&
        ip != "") {
      print(ip);
      if (listPrinter.map((e) => e.ipPrinter).toList().contains(ip)) {
        SahaAlert.showError(message: "Thiết bị đã tồn tại");
      } else {
        final printersBox = Hive.box('printers');
        if (printerSave.value.typePrinter == null) {
          printerSave.value.typePrinter = "Ethernet";
        }
        if (printerInput != null) {
          printersBox.putAt(indexPrinter!, printerSave.value);
          Get.back(result: "success");
        } else {
          printersBox.add(printerSave.value);
          Get.back(result: "success");
        }
      }
    } else {
      SahaAlert.showError(message: "Địa chỉ IP không hợp lệ");
    }
  }

  Future<void> printBill() async {
    var ip = printerSave.value.ipPrinter ?? "";
    if (!ip.contains(RegExp(r'[a-z]')) &&
        !ip.contains(RegExp(r'[A-Z]')) &&
        ip != "") {
      const PaperSize paper = PaperSize.mm80;
      final profile = await CapabilityProfile.load();
      final generator = Generator(paper, profile);

      testReceipt(generator);
      // const PaperSize paper = PaperSize.mm80;
      // final profile = await CapabilityProfile.load();
      // final printer = NetworkPrinter(paper, profile);
      // print(ipTextEditingController.text);
      // final PosPrintResult res =
      //     await printer.connect(ipTextEditingController.text, port: 9100);

      // if (res == PosPrintResult.success) {
      //   testReceipt(printer);
      //   printer.disconnect();
      //   SahaAlert.showSuccess(message: "Đã in");
      // } else {
      //   SahaAlert.showError(message: "Không thể kết nối với máy in");
      // }

      // print('Print result: ${res.msg}');
    } else {
      SahaAlert.showError(message: "Địa chỉ IP không hợp lệ");
    }
  }

  void testReceipt(Generator printer) async {
    printer.text(TiengViet.parse('${sahaDataController.user.value.name ?? ""}'),
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          bold: true,
          align: PosAlign.center,
        ),
        linesAfter: 1);

    printer.text(
        TiengViet.parse(
            'Thu ngân: ${sahaDataController.badgeUser.value.isStaff == true ? "Nhân viên" : "Chủ sở hữu"}'),
        styles: PosStyles(align: PosAlign.left),
        linesAfter: 1);
    printer.hr();
    printer.text('KIEM TRA HOA DON!',
        styles: PosStyles(align: PosAlign.center, bold: true));
    printer.hr();
    printer.feed(1);
    printer.text('COPYRIGHT © IKITECH.VN',
        styles:
            PosStyles(align: PosAlign.center, bold: true, codeTable: 'CP1252'));
    printer.feed(2);
    printer.cut();
  }
}
