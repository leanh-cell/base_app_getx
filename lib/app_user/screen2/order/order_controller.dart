// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/filter_order.dart';
import 'package:com.ikitech.store/app_user/model/printer.dart';
import 'package:com.ikitech.store/app_user/screen2/config/print/printers_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/finish_handle_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:intl/intl.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../utils/user_info.dart';

class OrderController extends GetxController {
  bool isEndOrder = false;
  int pageLoadMore = 1;
  var isDoneLoadMore = false.obs;
  var isLoadInit = true.obs;
  var listOrder = RxList<Order>();
  var listOrderChoose = RxList<Order>();
  var isChooseAll = false.obs;
  var checkIsEmpty = false.obs;
  var fromDay = DateTime.now().obs;
  var toDay = DateTime.now().obs;
  var isAll = true.obs;
  int indexTabTime = 0;
  int indexChooseTime = 0;
  var listFilter = RxList<FilterOrder>();
  var loadingRefresh = false.obs;
  String? textSearch = "";
  bool? isReturn;
  var finish = FinishHandle(milliseconds: 500);
  FilterOrder filterOrderChoose = FilterOrder(
      name: "Tất cả",
      listSource: [],
      listPaymentStt: [],
      listOrderStt: [],
      listBranch: []);
  var filterOrder = FilterOrder(
      name: "Tất cả",
      listSource: [],
      listPaymentStt: [],
      listOrderStt: [],
      listBranch: []).obs;

  SahaDataController sahaDataController = Get.find();

  var isList = false.obs;

  var listPrinter = RxList<Printer>();
  var orderShow = Order().obs;

  OrderController() {
    isList.value = UserInfo().getIsFullOrder() ?? false;
    filterOrder.value = FilterOrder(
        name: "Tất cả",
        listSource: [],
        listPaymentStt: [],
        listOrderStt: [],
        listBranch: [sahaDataController.branchCurrent.value]);
    getFilters();
    isLoadInit.value = true;
    // loadMoreOrder(isRefresh: true);
    getListPrint();
  }

  void getFilters() async {
    var box = await Hive.openBox('filters');
    listFilter.clear();
    box.values.forEach((element) {
      listFilter.add(element);
    });
    var index = listFilter
        .map((e) => e.name)
        .toList()
        .indexWhere((e) => e == filterOrder.value.name);
    if (index != -1) {
      filterOrder.value = listFilter[index];
    }
  }

  Future<void> loadMoreOrder({bool? isSearch, bool? isRefresh}) async {
    isDoneLoadMore.value = false;
    finish.run(() async {
      checkIsEmpty.value = false;
      if (isSearch == true) {
        pageLoadMore = 1;
        isEndOrder = false;
      }

      if (isRefresh == true) {
        pageLoadMore = 1;
        isEndOrder = false;
        loadingRefresh.value = true;
      }

      try {
        if (!isEndOrder) {
          var res = await RepositoryManager.orderRepository.getAllOrder(
              numberPage: pageLoadMore,
              search: textSearch ?? "",
              dateFrom: filterOrder.value.dateFrom == null
                  ? null
                  : (filterOrder.value.dateFrom ?? DateTime.now())
                      .toIso8601String(),
              dateTo: filterOrder.value.dateTo == null
                  ? null
                  : (filterOrder.value.dateTo ?? DateTime.now())
                      .toIso8601String(),
              listBranchId: sahaDataController.badgeUser.value.isStaff == true
                  ? ([sahaDataController.branchCurrent.value])
                      .map((e) => e.id)
                      .toList()
                      .toString()
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .replaceAll(" ", "")
                  : (filterOrder.value.listBranch ?? [])
                      .map((e) => e.id)
                      .toList()
                      .toString()
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .replaceAll(" ", ""),
              listPaymentStt: (filterOrder.value.listPaymentStt ?? [])
                  .toString()
                  .replaceAll("[", "")
                  .replaceAll("]", "")
                  .replaceAll(" ", ""),
              listOrderStt: (filterOrder.value.listOrderStt ?? [])
                  .toString()
                  .replaceAll("[", "")
                  .replaceAll("]", "")
                  .replaceAll(" ", ""),
              listOrderFrom: (filterOrder.value.listSource ?? [])
                  .toString()
                  .replaceAll("[", "")
                  .replaceAll("]", "")
                  .replaceAll(" ", ""),
              staffId: filterOrder.value.staff?.id);

          if (isRefresh == true || isSearch == true) {
            listOrder(res!.data!.data!);
          } else {
            listOrder.addAll(res!.data!.data!);
          }

          listOrder.refresh();

          if (listOrder.isEmpty) {
            checkIsEmpty.value = true;
          }

          if (res.data!.nextPageUrl != null) {
            pageLoadMore++;
            isEndOrder = false;
          } else {
            isEndOrder = true;
          }
          isLoadInit.value = false;
          isDoneLoadMore.value = true;
          loadingRefresh.value = false;
        } else {
          isLoadInit.value = false;
          isDoneLoadMore.value = true;
          loadingRefresh.value = false;
          return;
        }
        isLoadInit.value = false;
      } catch (err) {
        isLoadInit.value = false;
        SahaAlert.showError(message: err.toString());
      }
      isDoneLoadMore.value = true;
      loadingRefresh.value = false;

      isLoadInit.value = false;
    });
  }

  Future<void> getOneOrder(String orderCode) async {
    try {
      var res = await RepositoryManager.orderRepository.getOneOrder(orderCode);
      orderShow.value = res!.data!;
      var index = listOrder.indexWhere((e) => e.orderCode == orderCode);
      if (index != -1) {
        listOrder[index] = orderShow.value;
        listOrder.refresh();
      }
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  void getListPrint({bool? isRefresh}) async {
    var box = await Hive.openBox('printers');
    print(box.values);
    listPrinter([]);
    box.values.forEach((element) {
      listPrinter.add(element);
    });
  }

  Future<void> printAll(Order order) async {
    bool isNoPrinterAuto = false;
    if (listPrinter.isEmpty) {
      SahaAlert.showToastMiddle(message: "Chưa thiết lập máy in");
      return;
    }
    await Future.wait(listPrinter.map((e) {
      if (e.autoPrint == true) {
        if (e.ipPrinter == null) {
          return Future.value(null);
        } else {
          isNoPrinterAuto = true;
          return printBill(e.ipPrinter!, order);
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

  Future<void> printBill(String ipDevice, Order order) async {
    // const PaperSize paper = PaperSize.mm80;
    // final profile = await CapabilityProfile.load();
    // final printer = NetworkPrinter(paper, profile);

    // final PosPrintResult res = await printer.connect(ipDevice, port: 9100);

    // if (res == PosPrintResult.success) {
    //   testReceipt(printer, order);
    //   printer.disconnect();
    //   // SahaAlert.showSuccess(message: "Đã in");
    // } else {
    //   SahaAlert.showError(message: "Không thể kết nối với máy in");
    // }

    // print('Print result: ${res.msg}');
  }

  // void testReceipt(NetworkPrinter printer, Order order) async {
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

  //   if (order.customerNote != null) {
  //     printer.feed(1);
  //     printer.text('Ghi chu: ${order.customerNote ?? ""}',
  //         styles: PosStyles(align: PosAlign.center, bold: true));
  //   }

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
}
