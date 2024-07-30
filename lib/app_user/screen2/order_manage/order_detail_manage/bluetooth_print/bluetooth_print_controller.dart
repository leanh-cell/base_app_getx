import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

class OrderBluetoothPrintController extends GetxController {
  OrderBluetoothPrintController({required this.order}) {
    listLineText = printReceipt();
  }
  final Order order;
  var dropdownValue = "A8".obs;
  List<String> listPaper = <String>[
    'A8',
    'A6',
  ];
  Map<String, dynamic> config = Map();
  List<LineText> listLineText = [];
  List<LineText> printReceipt() {
    List<LineText> listText = [];
    if (dropdownValue.value == "A8") {
      listText.add(LineText(
          type: LineText.TYPE_TEXT,
          align: LineText.ALIGN_CENTER,
          content: SahaStringUtils().toNonAccentVietnamese(
              Get.find<HomeController>().storeCurrent?.value.name ?? ""),
          linefeed: 1,
          weight: 1));
      listText.add(LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_CENTER,
        content:
            "Chi nhanh: ${SahaStringUtils().toNonAccentVietnamese(Get.find<SahaDataController>().branchCurrent.value.name ?? "")}",
        linefeed: 1,
      ));
        listText.add(LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_CENTER,
        content:
            "Dia chi: ${SahaStringUtils().toNonAccentVietnamese(Get.find<SahaDataController>().branchCurrent.value.addressDetail ?? "")} ${SahaStringUtils().toNonAccentVietnamese(Get.find<SahaDataController>().branchCurrent.value.wardsName ?? "")} ${SahaStringUtils().toNonAccentVietnamese(Get.find<SahaDataController>().branchCurrent.value.districtName ?? "")} ${SahaStringUtils().toNonAccentVietnamese(Get.find<SahaDataController>().branchCurrent.value.provinceName ?? "")}",
        linefeed: 1,
      ));
      listText.add(LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_CENTER,
        content:
            "Hotline: ${Get.find<SahaDataController>().branchCurrent.value.phone ?? ''}",
        linefeed: 1,
      ));
      listText.add(LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_CENTER,
        content: "DON HANG",
        weight: 1,
        linefeed: 1,
      ));

      listText.add(LineText(
          type: LineText.TYPE_TEXT,
          align: LineText.ALIGN_CENTER,
          content: order.orderCode ?? "",
          linefeed: 1));

      listText.add(LineText(
          type: LineText.TYPE_TEXT,
          align: LineText.ALIGN_CENTER,
          content:
              "Ngay ${order.createdAt?.day ?? ""} thang ${order.createdAt?.month ?? ""} nam ${order.createdAt?.year ?? ""}",
          linefeed: 1));
      listText.add(LineText(
          type: LineText.TYPE_TEXT,
          align: LineText.ALIGN_LEFT,
          weight: 1,
          content:
              "Khach hang: ${SahaStringUtils().toNonAccentVietnamese(order.infoCustomer?.name ?? '')}",
          linefeed: 1));
      listText.add(LineText(
          type: LineText.TYPE_TEXT,
          align: LineText.ALIGN_LEFT,
          content: "SDT: ${order.infoCustomer?.phoneNumber ?? ''}",
          linefeed: 1));

      listText.add(LineText(
        type: LineText.TYPE_TEXT,
        align: LineText.ALIGN_LEFT,
        content:
            "Dia chi: ${SahaStringUtils().toNonAccentVietnamese(order.infoCustomer?.addressDetail ?? '')} ${SahaStringUtils().toNonAccentVietnamese(order.infoCustomer?.wardsName ?? '')} ${SahaStringUtils().toNonAccentVietnamese(order.infoCustomer?.districtName ?? '')} ${SahaStringUtils().toNonAccentVietnamese(order.infoCustomer?.provinceName ?? '')}",
        linefeed: 1,
      ));
      listText.add(
        LineText(
            type: LineText.TYPE_TEXT,
            content: "-------------------",
            linefeed: 1),
      );
      listText.add(LineText(
          x: 1, //Dùng để check khi gen ra giao diện
          type: LineText.TYPE_TEXT,
          weight: 1,
          content: "Don gia         SL     T.Tien",
          linefeed: 1));
      listText.add(
        LineText(
            type: LineText.TYPE_TEXT,
            content: "-------------------",
            linefeed: 1),
      );

      (order.lineItemsAtTime ?? []).forEach(
        (e) {
          listText.add(LineText(
              type: LineText.TYPE_TEXT,
              weight: 1,
              content:
                  "${(order.lineItemsAtTime ?? []).indexOf(e) + 1}.${SahaStringUtils().toNonAccentVietnamese(e.name ?? '')}",
              linefeed: 1));
          listText.add(LineText(
            x: 2, //Dùng để check khi gen ra giao diện
            type: LineText.TYPE_TEXT,
            content:
                "${SahaStringUtils().convertToUnit(e.itemPrice ?? 0)}d         ${e.quantity ?? ''}          ${SahaStringUtils().convertToUnit((e.itemPrice ?? 0) * (e.quantity ?? 0))}d",
          ));
        },
      );
      listText.add(
        LineText(
            type: LineText.TYPE_TEXT,
            content: "-------------------",
            linefeed: 1),
      );

      listText.add(LineText(
          type: LineText.TYPE_TEXT,
          align: LineText.ALIGN_RIGHT,
          weight: 1,
          content:
              "Tong tien hang : ${SahaStringUtils().convertToMoney(order.totalBeforeDiscount ?? 0)} d",
          linefeed: 1));
      listText.add(LineText(
          type: LineText.TYPE_TEXT,
          align: LineText.ALIGN_RIGHT,
          weight: 1,
          content:
              "Phi van chuyen : ${SahaStringUtils().convertToMoney(order.totalShippingFee ?? 0)} d",
          linefeed: 1));
      listText.add(LineText(
          type: LineText.TYPE_TEXT,
          weight: 1,
          align: LineText.ALIGN_RIGHT,
          content:
              "Thanh tien : ${SahaStringUtils().convertToMoney(order.totalFinal ?? 0)} d",
          linefeed: 1));
      listText.add(LineText(
          type: LineText.TYPE_TEXT,
          weight: 1,
          align: LineText.ALIGN_RIGHT,
          content:
              "Da thanh toan : ${SahaStringUtils().convertToMoney((order.totalFinal ?? 0) - (order.remainingAmount ?? 0))} d",
          linefeed: 1));
      listText.add(LineText(
          type: LineText.TYPE_TEXT,
          weight: 1,
          align: LineText.ALIGN_RIGHT,
          content:
              "Con lai : ${SahaStringUtils().convertToMoney(order.remainingAmount ?? 0)} d",
          linefeed: 1));
      return listText;
    }
    if (dropdownValue.value == "A6") {}
    return listText;
  }
}
