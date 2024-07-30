import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/distribute/elm_request.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/distribute/sub_request.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_request.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';

import '../../add_product_controller.dart';
import 'distribute_update_controller.dart';

class SetPriceInventoryUpdate extends StatelessWidget {
  SetPriceInventoryUpdate() {
    distributesRequest = distributeUpdateController.listDistribute[0];
  }
  final DistributeUpdateController distributeUpdateController = Get.find();
  AddProductController addProductController = Get.find();
  late DistributesRequest distributesRequest;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Chỉnh giá bán"),
            actions: [
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    Get.back();
                  })
            ],
          ),
          body: SingleChildScrollView(
            child: Obx(() {
              var distributesRequestRefresh =
                  distributeUpdateController.listDistribute[0];
              distributesRequest = distributeUpdateController.listDistribute[0];
              return Column(
                children: [
                  ...List.generate(
                      distributesRequestRefresh.elementDistributes!.length,
                      (index) => elementDistribute(
                          distributesRequestRefresh.elementDistributes![index]!,
                          index)),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget elementDistribute(
      ElementDistributesRequest elementDistributesRequest, int index) {
    var priceEditController = TextEditingController(
      text: elementDistributesRequest.price == null
          ? null
          : "${SahaStringUtils().convertToUnit(elementDistributesRequest.price)}",
    );

    var priceImportEditController = TextEditingController(
      text: elementDistributesRequest.priceImport == null
          ? null
          : "${SahaStringUtils().convertToUnit(elementDistributesRequest.priceImport)}",
    );

    var priceCapitalEditController = TextEditingController(
      text: elementDistributesRequest.priceCapital == null
          ? null
          : "${SahaStringUtils().convertToUnit(elementDistributesRequest.priceCapital)}",
    );

    var stockEditController = TextEditingController(
      text: elementDistributesRequest.stock == null
          ? null
          : elementDistributesRequest.stock == -1
              ? null
              : "${SahaStringUtils().convertToUnit(elementDistributesRequest.stock)}",
    );

    var barcodeEditController = TextEditingController(
      text: elementDistributesRequest.barcode == null
          ? null
          : elementDistributesRequest.barcode == ""
              ? null
              : "${elementDistributesRequest.barcode}",
    );

    priceEditController.selection = TextSelection.fromPosition(
        TextPosition(offset: priceEditController.text.length));
    priceImportEditController.selection = TextSelection.fromPosition(
        TextPosition(offset: priceImportEditController.text.length));
    priceCapitalEditController.selection = TextSelection.fromPosition(
        TextPosition(offset: priceCapitalEditController.text.length));
    stockEditController.selection = TextSelection.fromPosition(
        TextPosition(offset: stockEditController.text.length));
    barcodeEditController.selection = TextSelection.fromPosition(
        TextPosition(offset: barcodeEditController.text.length));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(10.0),
            color: Colors.grey[300],
            width: Get.width,
            child: Text(
              "${distributesRequest.name ?? ""}${distributesRequest.name == null ? "" : ":"} ${elementDistributesRequest.name ?? " "}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(Get.context!).primaryColor),
            )),
        InkWell(
          onTap: () {
            var elm = elementDistributesRequest;
            PopupInput().showDialogInputInfoPrice(
                title:
                    "PL: ${distributesRequest.name ?? ""}${distributesRequest.name == null ? "" : ":"} ${elementDistributesRequest.name ?? " "}",
                priceImport: elm.priceImport,
                price: elm.price,
                barcode: elm.barcode,
                confirm: (v) {
                  distributeUpdateController.updateElmDistribute(
                      elmRequest: ElmRequest(
                          distributeName: distributesRequest.name,
                          price: v['price'],
                          importPrice: v['import_price'],
                          barcode: v['barcode']));
                });
          },
          child: IgnorePointer(
            child: Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  elementDistributesRequest.subElementDistribute != null
                      ? elementDistributesRequest.subElementDistribute!.isEmpty
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: Get.width * 0.4,
                                        child: Text("Giá nhập")),
                                    Expanded(
                                      child: Container(
                                        height: 30,
                                        width: Get.width * 0.2,
                                        child: TextField(
                                          controller: priceImportEditController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            ThousandsFormatter(),
                                          ],
                                          textInputAction: TextInputAction.done,
                                          style: TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            prefixText: "₫",
                                            contentPadding:
                                                EdgeInsets.only(left: 5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                          ),
                                          onChanged: (v) {
                                            if (v != "") {
                                              distributeUpdateController
                                                      .listDistribute[0]
                                                      .elementDistributes![index]!
                                                      .priceImport =
                                                  double.parse(SahaStringUtils()
                                                      .convertFormatText(v));
                                              print(distributeUpdateController
                                                  .listDistribute[0]
                                                  .toJson());
                                            } else {
                                              distributeUpdateController
                                                  .listDistribute[0]
                                                  .elementDistributes![index]!
                                                  .priceImport = null;
                                            }
                                          },
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[300]!)),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: Get.width * 0.4,
                                        child: Text("Giá lẻ")),
                                    Expanded(
                                      child: Container(
                                        height: 30,
                                        width: Get.width * 0.25,
                                        child: TextField(
                                          controller: priceEditController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            ThousandsFormatter(),
                                          ],
                                          textInputAction: TextInputAction.done,
                                          style: TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                            prefixText: "₫",
                                            contentPadding:
                                                EdgeInsets.only(left: 5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                          ),
                                          onChanged: (v) {
                                            if (v != "") {
                                              distributeUpdateController
                                                      .listDistribute[0]
                                                      .elementDistributes![index]!
                                                      .price =
                                                  double.parse(SahaStringUtils()
                                                      .convertFormatText(v));
                                              print(distributeUpdateController
                                                  .listDistribute[0]
                                                  .toJson());
                                            } else {
                                              distributeUpdateController
                                                  .listDistribute[0]
                                                  .elementDistributes![index]!
                                                  .price = null;
                                            }
                                          },
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[300]!)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container()
                      : Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    width: Get.width * 0.4,
                                    child: Text("Giá nhập")),
                                Expanded(
                                  child: Container(
                                    height: 30,
                                    width: Get.width * 0.2,
                                    child: TextField(
                                      controller: priceImportEditController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        ThousandsFormatter(),
                                      ],
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(fontSize: 14),
                                      decoration: InputDecoration(
                                        prefixText: "₫",
                                        contentPadding: EdgeInsets.only(left: 5),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.grey[300]!)),
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
                                    width: Get.width * 0.4,
                                    child: Text("Giá lẻ")),
                                Expanded(
                                  child: Container(
                                    height: 30,
                                    width: Get.width * 0.2,
                                    child: TextField(
                                      controller: priceEditController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        ThousandsFormatter(),
                                      ],
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(fontSize: 14),
                                      decoration: InputDecoration(
                                        prefixText: "₫",
                                        contentPadding: EdgeInsets.only(left: 5),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.grey[300]!)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  if (elementDistributesRequest.subElementDistribute == null ||
                      elementDistributesRequest.subElementDistribute!.isEmpty)
                    Row(
                      children: [
                        SizedBox(width: Get.width * 0.4, child: Text("Mã QR")),
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 30,
                                child: TextField(
                                  controller: barcodeEditController,
                                  inputFormatters: [
                                    ThousandsFormatter(),
                                  ],
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
                                        distributesRequest
                                            .elementDistributes![index]!
                                            .barcode = v;
                                      });
                                    },
                                    child: Icon(
                                      Icons.qr_code,
                                      color: Colors.grey,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          height: 1,
        ),
        if (elementDistributesRequest.subElementDistribute != null)
          ...List.generate(
              elementDistributesRequest.subElementDistribute!.length,
              (indexSub) {
            var priceEditController = TextEditingController(
              text: elementDistributesRequest
                          .subElementDistribute![indexSub].price ==
                      null
                  ? null
                  : "${SahaStringUtils().convertToUnit(elementDistributesRequest.subElementDistribute![indexSub].price)}",
            );
            var priceImportEditController = TextEditingController(
              text: elementDistributesRequest
                          .subElementDistribute![indexSub].priceImport ==
                      null
                  ? null
                  : "${SahaStringUtils().convertToUnit(elementDistributesRequest.subElementDistribute![indexSub].priceImport)}",
            );
            var priceCapitalEditController = TextEditingController(
              text: elementDistributesRequest
                          .subElementDistribute![indexSub].priceCapital ==
                      null
                  ? null
                  : "${SahaStringUtils().convertToUnit(elementDistributesRequest.subElementDistribute![indexSub].priceCapital)}",
            );
            var stockEditController = TextEditingController(
              text: elementDistributesRequest
                          .subElementDistribute![indexSub].stock ==
                      null
                  ? null
                  : "${SahaStringUtils().convertToUnit(elementDistributesRequest.subElementDistribute![indexSub].stock)}",
            );
            var barcodeEditController = TextEditingController(
              text: elementDistributesRequest
                          .subElementDistribute![indexSub].barcode ==
                      null
                  ? null
                  : "${elementDistributesRequest.subElementDistribute![indexSub].barcode}",
            );
            priceEditController.selection = TextSelection.fromPosition(
                TextPosition(offset: priceEditController.text.length));
            priceImportEditController.selection = TextSelection.fromPosition(
                TextPosition(offset: priceImportEditController.text.length));
            priceCapitalEditController.selection = TextSelection.fromPosition(
                TextPosition(offset: priceCapitalEditController.text.length));
            stockEditController.selection = TextSelection.fromPosition(
                TextPosition(offset: stockEditController.text.length));
            barcodeEditController.selection = TextSelection.fromPosition(
                TextPosition(offset: barcodeEditController.text.length));

            return InkWell(
              onTap: () {
                var sub =
                    elementDistributesRequest.subElementDistribute![indexSub];
                PopupInput().showDialogInputInfoPrice(
                    title:
                        "PL: ${distributesRequest.name ?? ""}${distributesRequest.name == null ? "" : ":"} ${elementDistributesRequest.name ?? " "}, ${distributesRequest.subElementDistributeName ?? ""}${distributesRequest.subElementDistributeName == null ? "" : ":"} ${elementDistributesRequest.subElementDistribute![indexSub].name ?? ""}",
                    priceImport: sub.priceImport,
                    price: sub.price,
                    barcode: sub.barcode,
                    confirm: (v) {
                      distributeUpdateController.updateSubDistribute(
                          subRequest: SubRequest(
                              subElementDistributeName:
                                  distributesRequest.subElementDistributeName,
                              subElementDistributeId: sub.id,
                              price: v['price'],
                              importPrice: v['import_price'],
                              barcode: v['barcode']));
                    });
              },
              child: IgnorePointer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10.0, left: 15, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              "${distributesRequest.subElementDistributeName ?? ""}${distributesRequest.subElementDistributeName == null ? "" : ":"} ${elementDistributesRequest.subElementDistribute![indexSub].name ?? ""}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(Get.context!).primaryColor),
                            ),
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
                                  width: Get.width * 0.4,
                                  child: Text("Giá nhập")),
                              Expanded(
                                child: Container(
                                  height: 30,
                                  child: TextField(
                                    controller: priceImportEditController,
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
                                      border:
                                          Border.all(color: Colors.grey[300]!)),
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
                                  width: Get.width * 0.4,
                                  child: Text("Giá lẻ")),
                              Expanded(
                                child: Container(
                                  height: 30,
                                  child: TextField(
                                    controller: priceEditController,
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
                                      border:
                                          Border.all(color: Colors.grey[300]!)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10.0, left: 15, right: 10),
                      child: Row(
                        children: [
                          SizedBox(
                              width: Get.width * 0.4, child: Text("Barcode")),
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
                                      border:
                                          Border.all(color: Colors.grey[300]!)),
                                ),
                                Positioned(
                                    top: 3,
                                    right: 5,
                                    child: InkWell(
                                      onTap: () {
                                        scanBarcodeNormal(callback: (v) {
                                          barcodeEditController.text = v;
                                          distributeUpdateController
                                              .listDistribute[0]
                                              .elementDistributes![index]!
                                              .subElementDistribute![indexSub]
                                              .barcode = v;
                                        });
                                      },
                                      child: Icon(
                                        Icons.qr_code,
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
                  ],
                ),
              ),
            );
          }),
        Container(
          height: 8,
          color: Colors.white,
        )
      ],
    );
  }

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
}
