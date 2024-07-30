// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/history_shipper_response.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:intl/intl.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/state_order.dart';
import 'package:tiengviet/tiengviet.dart';

class OrderDetailController extends GetxController {
  Order? inputOrder;
  SahaDataController sahaDataController = Get.find();
  var orderResponse = Order().obs;
  var isLoadingOrder = false.obs;

  OrderDetailController({this.inputOrder}) {
    getOneOrder();
    getStateHistoryOrder();
    getStateHistoryShipper();
  }

  var listStateOrder = RxList<StateOrder>();
  var listHistoryShipper = RxList<HistoryShipper>();

  Future<void> getOneOrder() async {
    isLoadingOrder.value = true;
    try {
      var res = await RepositoryManager.orderRepository
          .getOneOrder(inputOrder!.orderCode!);
      orderResponse(res!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
    isLoadingOrder.value = false;
  }

  Future<void> getStateHistoryOrder() async {
    try {
      var res = await RepositoryManager.orderRepository
          .getStateHistoryOrder(inputOrder!.id);
      listStateOrder(res!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> getStateHistoryShipper() async {
    try {
      var res = await RepositoryManager.orderRepository
          .getStateHistoryShipper(inputOrder!.orderCode);
      listHistoryShipper(res!.data);
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> changeOrderStatus(String orderStatusCode) async {
    try {
      var res = await RepositoryManager.orderRepository
          .changeOrderStatus(inputOrder!.orderCode, orderStatusCode);
      getOneOrder();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> changePaymentStatus(String paymentStatusCode) async {
    try {
      var res = await RepositoryManager.orderRepository
          .changePaymentStatus(inputOrder!.orderCode, paymentStatusCode);
      getOneOrder();
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  Future<void> printBill(String ipDevice) async {

      const PaperSize paper = PaperSize.mm80;
      final profile = await CapabilityProfile.load();
      final generator = Generator(paper, profile);

      testReceipt(generator);
    
    // const PaperSize paper = PaperSize.mm80;
    // final profile = await CapabilityProfile.load();
    // final printer = NetworkPrinter(paper, profile);

    // final PosPrintResult res = await printer.connect(ipDevice, port: 9100);

    // if (res == PosPrintResult.success) {
    //   testReceipt(printer);
    //   printer.disconnect();
    //   SahaAlert.showSuccess(message: "Đã in");
    // } else {
    //   SahaAlert.showError(message: "Không thể kết nối với máy in");
    // }

    // print('Print result: ${res.msg}');
  }

  void testReceipt(Generator printer) async {
    var data = sahaDataController.badgeUser.value.infoAddress;

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
    printer.text(TiengViet.parse('Mã đơn hàng: ${orderResponse.value.orderCode ?? ""}'),
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
    if (orderResponse.value.lineItemsAtTime != null) {
      orderResponse.value.lineItemsAtTime!.forEach((e) {
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
    if (orderResponse.value.totalShippingFee != null) {
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
          text: '${SahaStringUtils().convertToK(orderResponse.value.totalShippingFee ?? 0)}',
          width: 2,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text: '${SahaStringUtils().convertToK(orderResponse.value.totalShippingFee ?? 0)}',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
      ]);
    }
    if (orderResponse.value.productDiscountAmount != null &&
        orderResponse.value.productDiscountAmount != 0) {
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
          '-${SahaStringUtils().convertToK(orderResponse.value.productDiscountAmount ?? 0)}',
          width: 2,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text:
          '-${SahaStringUtils().convertToK(orderResponse.value.productDiscountAmount ?? 0)}',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
      ]);
    }
    if (orderResponse.value.voucherDiscountAmount != null &&
        orderResponse.value.voucherDiscountAmount != 0) {
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
          '-${SahaStringUtils().convertToK(orderResponse.value.voucherDiscountAmount ?? 0)}',
          width: 2,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text:
          '-${SahaStringUtils().convertToK(orderResponse.value.voucherDiscountAmount ?? 0)}',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
      ]);
    }
    if (orderResponse.value.comboDiscountAmount != null && orderResponse.value.comboDiscountAmount != 0) {
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
          '-${SahaStringUtils().convertToK(orderResponse.value.comboDiscountAmount ?? 0)}',
          width: 2,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text:
          '-${SahaStringUtils().convertToK(orderResponse.value.comboDiscountAmount ?? 0)}',
          width: 3,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
      ]);
    }
    if (orderResponse.value.bonusAgencyHistory != null) {
      printer.row([
        PosColumn(
          text: 'Bonus đại lý',
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
          '+${SahaStringUtils().convertToK(orderResponse.value.bonusAgencyHistory!.rewardValue ?? 0)}',
          width: 2,
          styles: PosStyles(
            align: PosAlign.left,
          ),
        ),
        PosColumn(
          text:
          '+${SahaStringUtils().convertToK(orderResponse.value.bonusAgencyHistory!.rewardValue ?? 0)}',
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
          '${SahaStringUtils().convertToMoney(orderResponse.value.totalFinal ?? 0)} VND',
          width: 9,
          styles: PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
    ]);

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
