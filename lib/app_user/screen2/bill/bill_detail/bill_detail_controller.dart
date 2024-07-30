// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';


import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/printer.dart';
import 'package:com.ikitech.store/app_user/screen2/config/print/printers_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:intl/intl.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:tiengviet/tiengviet.dart';
import '../../../../saha_data_controller.dart';


class BillDetailController extends GetxController {
  var listPrinter = RxList<Printer>();

  String orderCode;
  var orderShow = Order().obs;
  var isLoading = false.obs;

  BillDetailController({required this.orderCode}) {
    getListPrint();
    getOneOrder(orderCode);
  }

  Future<void> getOneOrder(String orderCode) async {
    isLoading.value = true;
    try {
      var res = await RepositoryManager.orderRepository.getOneOrder(orderCode);
      orderShow.value = res!.data!;
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoading.value = false;
  }

  void getListPrint({bool? isRefresh}) async {
    var box = await Hive.openBox('printers');
    print(box.values);
    listPrinter([]);
    box.values.forEach((element) {
      listPrinter.add(element);
    });
  }

  Future<void> printAll() async {
    print("vovovovovov========");
    bool isNoPrinterAuto = false;
    await Future.wait(listPrinter.map((e) {
      if (e.autoPrint == true) {
        if (e.ipPrinter == null) {
          print("avvvvv========");
          return Future.value(null);
        } else {
          isNoPrinterAuto = true;
          print("a========");
          return printBill(e.ipPrinter!);
        }
      } else {
        return Future.value(null);
      }
    }));
    if (isNoPrinterAuto == false) {
      if (listPrinter.isNotEmpty) {
        Get.to(() => PrintScreen(isChoosePrint: true));
      }
    }
  }

  Future<void> printBill(String ipDevice) async {
    const PaperSize paper = PaperSize.mm80;
    final profile = await CapabilityProfile.load();
     final generator = Generator(paper, profile);
    
    testReceipt(generator);
    // final PosPrintResult res = await printer.connect(ipDevice, port: 9100);
    

    // if (res == PosPrintResult.success) {
    //   testReceipt(printer);
    //   printer.disconnect();
    //   // SahaAlert.showSuccess(message: "Đã in");
    // } else {
    //   SahaAlert.showError(message: "Không thể kết nối với máy in");
    // }

    // print('Print result: ${res.msg}');
  }

  SahaDataController sahaDataController = Get.find();

  void testReceipt(Generator printer) async {
    var data = sahaDataController.badgeUser.value.infoAddress;
    var order = orderShow.value;
    printer.text(TiengViet.parse('${data?.name ?? ""}'.toUpperCase()),
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          bold: true,
          align: PosAlign.center,
        ),
        linesAfter: 1);

    printer.text(
        TiengViet.parse(
            '${data?.addressDetail ?? ""} ${data?.wardsName ?? ""} ${data?.districtName ?? ""} ${data?.provinceName ?? ""}'),
        styles: PosStyles(align: PosAlign.center),
        linesAfter: 1);
    printer.text("Phone: ${data?.phone ?? ""}",
        styles: PosStyles(align: PosAlign.center), linesAfter: 1);

    printer.text(
      TiengViet.parse('HOÁ ĐƠN'),
      styles: PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
        bold: true,
        align: PosAlign.center,
      ),
    );
    printer.feed(1);
    printer.text(TiengViet.parse('Mã đơn hàng: ${order.orderCode ?? ""}'),
        styles: PosStyles(
          align: PosAlign.center,
        ));
    printer.feed(1);
    printer.text(
        TiengViet.parse(
            'Ngày: ${SahaDateUtils().getDDMMYY(DateTime.now())}  ${DateFormat('HH:mm:ss').format(DateTime.now())}'),
        styles: PosStyles(
          align: PosAlign.left,
        ));
    printer.feed(1);

    printer.hr();
    printer.row([
      PosColumn(
          text: 'San pham', width: 6, styles: PosStyles(align: PosAlign.left)),
      PosColumn(text: 'SL', width: 1, styles: PosStyles(align: PosAlign.left)),
      PosColumn(text: 'Gia', width: 2, styles: PosStyles(align: PosAlign.left)),
      PosColumn(
          text: 'Total', width: 3, styles: PosStyles(align: PosAlign.left)),
    ]);
    if (order.lineItemsAtTime != null) {
      order.lineItemsAtTime!.forEach((e) {
        printer.row([
          PosColumn(
            text: '${TiengViet.parse(e.name ?? "")}',
            width: 6,
            styles: PosStyles(
              align: PosAlign.left,
            ),
          ),
          PosColumn(
            text: '${e.quantity}',
            width: 1,
            styles: PosStyles(
              align: PosAlign.left,
            ),
          ),
          PosColumn(
            text: '${SahaStringUtils().convertToK(e.itemPrice ?? 0)}',
            width: 2,
            styles: PosStyles(
              align: PosAlign.left,
            ),
          ),
          PosColumn(
            text:
            '${SahaStringUtils().convertToK(e.itemPrice! * (e.quantity!))}',
            width: 3,
            styles: PosStyles(
              align: PosAlign.left,
            ),
          ),
        ]);
      });
    }
    if (order.totalShippingFee != null) {
      printer.row([
        PosColumn(
          text: 'Phi giao hang',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text: '1',
          width: 1,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text: '${SahaStringUtils().convertToK(order.totalShippingFee ?? 0)}',
          width: 2,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text: '${SahaStringUtils().convertToK(order.totalShippingFee ?? 0)}',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
      ]);
    }
    if (order.productDiscountAmount != null &&
        order.productDiscountAmount != 0) {
      printer.row([
        PosColumn(
          text: 'Sale san pham',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text: '1',
          width: 1,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text:
          '-${SahaStringUtils().convertToK(order.productDiscountAmount ?? 0)}',
          width: 2,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text:
          '-${SahaStringUtils().convertToK(order.productDiscountAmount ?? 0)}',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
      ]);
    }
    if (order.voucherDiscountAmount != null &&
        order.voucherDiscountAmount != 0) {
      printer.row([
        PosColumn(
          text: 'Voucher',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text: '1',
          width: 1,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text:
          '-${SahaStringUtils().convertToK(order.voucherDiscountAmount ?? 0)}',
          width: 2,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text:
          '-${SahaStringUtils().convertToK(order.voucherDiscountAmount ?? 0)}',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
      ]);
    }
    if (order.comboDiscountAmount != null && order.comboDiscountAmount != 0) {
      printer.row([
        PosColumn(
          text: 'Combo',
          width: 6,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text: '1',
          width: 1,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text:
          '-${SahaStringUtils().convertToK(order.comboDiscountAmount ?? 0)}',
          width: 2,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text:
          '-${SahaStringUtils().convertToK(order.comboDiscountAmount ?? 0)}',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
      ]);
    }
    printer.hr();
    printer.row([
      PosColumn(
          text: 'TOTAL',
          width: 3,
          styles: PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
      PosColumn(
          text:
          '${SahaStringUtils().convertToMoney(order.totalFinal ?? 0)} VND',
          width: 9,
          styles: PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
    ]);

    if (order.customerNote != null) {
      printer.feed(1);
      printer.text('Ghi chu: ${order.customerNote ?? ""}',
          styles: PosStyles(align: PosAlign.center, bold: true));
    }

    printer.hr(ch: '=', linesAfter: 1);

    printer.feed(1);
    printer.text('Xin cam on!',
        styles: PosStyles(align: PosAlign.center, bold: true));
    printer.feed(1);
    printer.text('COPYRIGHT © IKITECH.VN',
        styles:
        PosStyles(align: PosAlign.center, bold: true, codeTable: 'CP1252'));
    printer.feed(2);
    printer.cut();
  }
}

