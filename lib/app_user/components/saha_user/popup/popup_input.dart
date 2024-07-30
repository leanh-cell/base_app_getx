import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/calendar_shifts_res.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/time_keeping_calculate_res.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/model/history_checkin_checkout.dart';
import 'package:com.ikitech.store/app_user/model/shifts.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../dialog/dialog.dart';

class PopupInput {
  void showDialogInputInfoInventory(
      {int? stockInput, double? priceInput, required Function confirm}) {
    TextEditingController priceCapitalEditingController = TextEditingController(
        text: priceInput == null
            ? null
            : "${SahaStringUtils().convertToUnit(priceInput)}");
    TextEditingController stockEditingController =
        TextEditingController(text: stockInput == null ? null : "$stockInput");

    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.all(0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Thông tin kho ",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Row(
                    children: [
                      Text("Giá vốn "),
                      InkWell(
                        onTap: () {
                          SahaDialogApp.showDialogSuggestion(
                              title: 'Giá vốn',
                              contentWidget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      'Giá vốn là giá trị trung bình của một sản phẩm (đã bao gồm chi phí chiết khấu, chi phí nhập hàng), được tính bình quân sau mỗi lần nhập kho.\n\nGiá vốn được dùng để tính lãi lỗ.')
                                ],
                              ));
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.blue,
                              size: 20,
                            ),
                            Text(
                              'i',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: TextFormField(
                              textAlign: TextAlign.end,
                              controller: priceCapitalEditingController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                              ),
                              onChanged: (v) async {},
                              minLines: 1,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Row(
                    children: [
                      Text("Tồn kho "),
                      InkWell(
                        onTap: () {
                          SahaDialogApp.showDialogSuggestion(
                              title: 'Tồn kho',
                              contentWidget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      'Là số lượng sản phẩm còn lại trong kho.\n\nTồn kho có thể âm.')
                                ],
                              ));
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.blue,
                              size: 20,
                            ),
                            Text(
                              'i',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: TextFormField(
                              textAlign: TextAlign.end,
                              controller: stockEditingController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(5),
                              ),
                              onChanged: (v) async {},
                              minLines: 1,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey[200]!,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Thoát",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          print(SahaStringUtils().convertFormatText(
                              priceCapitalEditingController.text == ""
                                  ? "0"
                                  : priceCapitalEditingController.text));
                          confirm({
                            "price_capital": double.parse(SahaStringUtils()
                                .convertFormatText(
                                    priceCapitalEditingController.text == ""
                                        ? "0"
                                        : priceCapitalEditingController.text)),
                            "stock": int.parse(SahaStringUtils()
                                .convertFormatText(
                                    stockEditingController.text == ""
                                        ? "0"
                                        : stockEditingController.text)),
                          });
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              "Lưu",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void showDialogInputInfoPrice(
      {required String title,
      double? priceImport,
      double? price,
      String? barcode,
      Function? cancel,
      required Function confirm}) {
    TextEditingController priceImportEditingController = TextEditingController(
        text: priceImport == null
            ? null
            : "${SahaStringUtils().convertToUnit(priceImport)}");
    TextEditingController priceEditingController = TextEditingController(
        text:
            price == null ? null : "${SahaStringUtils().convertToUnit(price)}");
    TextEditingController barcodeEditController =
        TextEditingController(text: barcode ?? "");

    Future<void> scanBarcodeNormal({required Function callback}) async {
      String barcodeScanRes;
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE);
        print(barcodeScanRes);
      } on PlatformException {
        barcodeScanRes = 'Failed to get platform version.';
      }
      callback(barcodeScanRes);
    }

    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.all(0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10.0, left: 15, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Divider(
                        height: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: Get.width * 0.3, child: Text("Giá nhập")),
                          Expanded(
                            child: Container(
                              height: 30,
                              child: TextField(
                                controller: priceImportEditingController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  ThousandsFormatter(),
                                ],
                                //textInputAction: TextInputAction.done,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  prefixText: "₫",
                                  contentPadding: EdgeInsets.only(left: 5),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: Get.width * 0.3, child: Text("Giá lẻ")),
                          Expanded(
                            child: Container(
                              height: 30,
                              child: TextField(
                                controller: priceEditingController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  ThousandsFormatter(),
                                ],
                                //textInputAction: TextInputAction.done,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  prefixText: "₫",
                                  contentPadding: EdgeInsets.only(left: 5),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10.0, left: 15, right: 10),
                  child: Row(
                    children: [
                      SizedBox(width: Get.width * 0.3, child: Text("Barcode")),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 30,
                              child: TextField(
                                controller: barcodeEditController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!)),
                            ),
                            Positioned(
                                top: 3,
                                right: 5,
                                child: InkWell(
                                  onTap: () {
                                    scanBarcodeNormal(callback: (v) {
                                      barcodeEditController.text = v;
                                    });
                                  },
                                  child: Icon(
                                    Ionicons.barcode_outline,
                                    color: Colors.grey,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (cancel != null) {
                            cancel();
                          }
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey[200]!,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Thoát",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          confirm({
                            "import_price": double.parse(SahaStringUtils()
                                .convertFormatText(
                                    priceImportEditingController.text == ""
                                        ? "0"
                                        : priceImportEditingController.text)),
                            "price": double.parse(SahaStringUtils()
                                .convertFormatText(
                                    priceEditingController.text == ""
                                        ? "0"
                                        : priceEditingController.text)),
                            "barcode": barcodeEditController.text,
                          });
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              "Lưu",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void showDialogInputNote(
      {String? title,
      String? textInput,
      required Function confirm,
      Function? cancel,
      double? height}) {
    TextEditingController textEditingController =
        TextEditingController(text: textInput == null ? null : textInput);
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.all(0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? "",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: Get.width * 0.7,
                  height: height ?? Get.height / 5,
                  child: TextFormField(
                    controller: textEditingController,
                    autofocus: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      isDense: true,
                      border: InputBorder.none,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (v) async {},
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (cancel != null) {
                            cancel();
                          }
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey[200]!,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Thoát",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          confirm(textEditingController.text);
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              "Lưu",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void showDialogInputSizeProduct({
    int? length,
    int? width,
    int? height,
    required Function confirm,
    Function? cancel,
  }) {
    TextEditingController lengthEditingController =
        TextEditingController(text: length == null ? null : length.toString());
    TextEditingController widthEditingController =
        TextEditingController(text: width == null ? null : width.toString());
    TextEditingController heightEditingController =
        TextEditingController(text: height == null ? null : height.toString());

    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.all(0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Kích thước gói hàng",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Chiều dài (cm)",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Chiều rộng (cm)",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Chiều cao (cm)",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: lengthEditingController,
                            onTap: () => lengthEditingController.selection =
                                TextSelection(
                                    baseOffset: 0,
                                    extentOffset: lengthEditingController
                                        .value.text.length),
                            maxLength: 4,
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              isDense: true,
                              counterText: "",
                            ),
                            keyboardType: TextInputType.number,
                            maxLines: null,
                            onChanged: (v) async {},
                          ),
                          TextFormField(
                            controller: widthEditingController,
                            onTap: () => widthEditingController.selection =
                                TextSelection(
                                    baseOffset: 0,
                                    extentOffset: widthEditingController
                                        .value.text.length),
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              isDense: true,
                              counterText: "",
                            ),
                            keyboardType: TextInputType.number,
                            maxLines: null,
                            onChanged: (v) async {},
                          ),
                          TextFormField(
                            controller: heightEditingController,
                            onTap: () => heightEditingController.selection =
                                TextSelection(
                                    baseOffset: 0,
                                    extentOffset: heightEditingController
                                        .value.text.length),
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              isDense: true,
                              counterText: "",
                            ),
                            keyboardType: TextInputType.number,
                            maxLines: null,
                            onChanged: (v) async {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (cancel != null) {
                            cancel();
                          }
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey[200]!,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Thoát",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          confirm(
                              int.parse(lengthEditingController.text),
                              int.parse(widthEditingController.text),
                              int.parse(heightEditingController.text));
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              "Lưu",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void showDialogCalendarShifts(
      {required Shifts shifts,
      required StaffInTime staffInTime,
      required Function confirm}) {
    var listStaffChoose = RxList<Staff>();
    var listStaff = RxList<Staff>();
    var isLoading = false.obs;

    listStaffChoose((staffInTime.staffWork ?? [])
        .map((e) => Staff(id: e.id, name: e.name, avatarImage: e.avatarImage))
        .toList());

    Future<void> getListStaff() async {
      try {
        isLoading.value = true;
        var data = await RepositoryManager.staffRepository.getListStaff();
        listStaff(data!.data!);
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
      isLoading.value = false;
    }

    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          getListStaff();
          return AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.only(top: 10, right: 10, left: 10),
            titlePadding:
                EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 0),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${shifts.name ?? ""} (${(shifts.startWorkHour ?? 0) < 10 ? "0${shifts.startWorkHour}" : shifts.startWorkHour}:${(shifts.startWorkMinute ?? 0) < 10 ? "0${shifts.startWorkMinute}" : shifts.startWorkMinute} - ${(shifts.endWorkHour ?? 0) < 10 ? "0${shifts.endWorkHour}" : shifts.endWorkHour}:${(shifts.endWorkMinute ?? 0) < 10 ? "0${shifts.endWorkMinute}" : shifts.endWorkMinute})",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${SahaDateUtils().convertDateToWeekDate(staffInTime.date ?? DateTime.now())}, ${(staffInTime.date ?? DateTime.now()).day} tháng ${(staffInTime.date ?? DateTime.now()).month} ${(staffInTime.date ?? DateTime.now()).year}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Row(
                    children: [
                      Text(
                        " ${listStaffChoose.length}/${listStaff.length} Nhân viên",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          if (listStaffChoose.length == listStaff.length) {
                            listStaffChoose([]);
                          } else {
                            listStaffChoose(listStaff.toList());
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              "Toàn chi nhánh",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            Checkbox(
                                value:
                                    listStaffChoose.length == listStaff.length,
                                onChanged: (v) {
                                  if (listStaffChoose.length ==
                                      listStaff.length) {
                                    listStaffChoose([]);
                                  } else {
                                    listStaffChoose(listStaff.toList());
                                  }
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Obx(
                    () => isLoading.value
                        ? SahaLoadingWidget()
                        : Column(
                            children: [
                              ...listStaff
                                  .map((e) => e.name == null
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            if (listStaffChoose
                                                .map((s) => s.id)
                                                .contains(e.id)) {
                                              listStaffChoose.removeWhere(
                                                  (s) => s.id == e.id);
                                            } else {
                                              listStaffChoose.add(e);
                                            }
                                          },
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(7),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  child: Text(
                                                    "${e.name![0]}"
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "${e.name ?? ""}",
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                                Spacer(),
                                                Checkbox(
                                                    value: listStaffChoose
                                                        .map((e) => e.id)
                                                        .contains(e.id),
                                                    onChanged: (v) {
                                                      if (listStaffChoose
                                                          .map((s) => s.id)
                                                          .contains(e.id)) {
                                                        listStaffChoose
                                                            .removeWhere((s) =>
                                                                s.id == e.id);
                                                      } else {
                                                        listStaffChoose.add(e);
                                                      }
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ))
                                  .toList(),
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey[200]!,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Thoát",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          confirm({
                            "date": staffInTime.date ?? DateTime.now(),
                            "shift_id": shifts.id,
                            "list_staff": listStaffChoose.toList(),
                          });
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              "Lưu",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void showDialogsCheckInOut({required List<HistoryCheckInCheckout> listHis}) {
    Widget historyCheckInOut(HistoryCheckInCheckout historyCheckInCheckout) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: historyCheckInCheckout.isCheckin == true
              ? Colors.green.withOpacity(0.05)
              : Colors.amber.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 10,
                  color: historyCheckInCheckout.isCheckin == true
                      ? Colors.green
                      : Colors.amber,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "${historyCheckInCheckout.isCheckin == true ? "Vào làm" : "Tan làm"}",
                  style: TextStyle(
                      color: historyCheckInCheckout.isCheckin == true
                          ? Colors.green
                          : Colors.amber,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "${SahaDateUtils().getHHMMSS(historyCheckInCheckout.timeCheck ?? DateTime.now())}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Spacer(),
              ],
            ),
            if (historyCheckInCheckout.remoteTimekeeping == true)
              Text(
                "(Từ xa)",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            if (historyCheckInCheckout.fromUser != null)
              SizedBox(
                height: 5,
              ),
            if (historyCheckInCheckout.fromUser == true)
              Text(
                "${historyCheckInCheckout.isBonus == true ? "(Thêm công)" : "(Bớt công)"}",
                style: TextStyle(
                    color: historyCheckInCheckout.isBonus == false
                        ? Colors.red
                        : Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 11),
              ),
            if (historyCheckInCheckout.fromStaffCreated != null)
              SizedBox(
                height: 5,
              ),
            if (historyCheckInCheckout.fromStaffCreated != null)
              Text(
                "NV ${historyCheckInCheckout.isBonus == true ? "thêm" : "bớt"}: ${historyCheckInCheckout.fromStaffCreated!.name ?? ""}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: historyCheckInCheckout.isBonus == false
                        ? Colors.red
                        : Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 11),
              ),
            if (historyCheckInCheckout.fromUserCreated != null)
              SizedBox(
                height: 5,
              ),
            if (historyCheckInCheckout.fromUserCreated != null)
              Text(
                "User ${historyCheckInCheckout.isBonus == true ? "thêm" : "bớt"}: ${historyCheckInCheckout.fromUserCreated!.name ?? ""}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: historyCheckInCheckout.isBonus == false
                        ? Colors.red
                        : Colors.green,
                    fontWeight: FontWeight.w500,
                    fontSize: 11),
              ),
            if (historyCheckInCheckout.reason != null)
              SizedBox(
                height: 5,
              ),
            if (historyCheckInCheckout.reason != null)
              Text(
                "Lý do: ${historyCheckInCheckout.reason}",
                maxLines: 3,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis),
              )
          ],
        ),
      );
    }

    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.only(top: 10, right: 10, left: 10),
            titlePadding:
                EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Lịch sử chấm công",
                  style: TextStyle(fontSize: 17),
                )
              ],
            ),
            content: Column(
              children: [
                SizedBox(
                  width: Get.width,
                  height: listHis.length > 6 ? Get.height / 2 : Get.height / 3,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                    childAspectRatio: 1,
                    children: listHis.map((e) => historyCheckInOut(e)).toList(),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        "Thoát",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void showDialogsRecordingTime(
      {required List<RecordingTime> listRecordingTime}) {
    Widget recordingTime(RecordingTime recordingTime) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Vào làm",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Text(
                        "${SahaDateUtils().getHHMMSS(recordingTime.timeCheckIn ?? DateTime.now())}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Tan ca",
                            style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Text(
                        "${SahaDateUtils().getHHMMSS(recordingTime.timeCheckOut ?? DateTime.now())}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${recordingTime.isBonus == false ? "-" : ""} ${(recordingTime.totalInTime ?? 0) == 0 ? "Thời gian không được ghi nhận" : SahaDateUtils().secondsToHours(recordingTime.totalInTime ?? 0)}",
              style: TextStyle(
                fontSize: 12,
                color: recordingTime.isBonus == false ? Colors.red : null,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(),
          ],
        ),
      );
    }

    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.only(top: 10, right: 10, left: 10),
            titlePadding:
                EdgeInsets.only(top: 20, right: 10, left: 10, bottom: 0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Thời gian ghi nhận",
                  style: TextStyle(fontSize: 17),
                )
              ],
            ),
            content: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...listRecordingTime
                          .map((e) => recordingTime(e))
                          .toList(),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          child: Center(
                            child: Text(
                              "Thoát",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
