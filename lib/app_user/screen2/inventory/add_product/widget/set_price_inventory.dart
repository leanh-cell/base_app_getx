import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_request.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:tiengviet/tiengviet.dart';

import '../add_product_controller.dart';

class SetPriceInventory extends StatelessWidget {
  SetPriceInventory(
      {required this.distributesRequest, required this.onDone, this.isNew}) {
    distributesRequest = DistributesRequest(
        name: distributesRequest.name,
        hasSub: distributesRequest.hasSub,
        boolHasImage: distributesRequest.boolHasImage,
        hasDistribute: distributesRequest.hasDistribute,
        subElementDistributeName: distributesRequest.subElementDistributeName,
        elementDistributes: distributesRequest.elementDistributes!
            .map((e) => ElementDistributesRequest(
                  name: e!.name,
                  sku: e.sku,
                  beforeName: e.beforeName,
                  isEdit: e.isEdit,
                  imageUrl: e.imageUrl,
                  price: e.price,
                  priceImport: e.priceImport,
                  priceCapital: e.priceCapital,
                  barcode: e.barcode,
                  stock: e.stock,
                  subElementDistribute: e.subElementDistribute == null
                      ? null
                      : e.subElementDistribute!
                          .map((e) => SubElementDistributeRequest(
                              name: e.name,
                              beforeName: e.beforeName,
                              isEdit: e.isEdit,
                              priceCapital: e.priceCapital,
                              price: e.price,
                              barcode: e.barcode,
                              priceImport: e.priceImport,
                              sku: e.sku,
                              stock: e.stock))
                          .toList(),
                ))
            .toList());
  }
  late DistributesRequest distributesRequest;
  final Function onDone;
  final bool? isNew;
  bool checkChange = false;
  AddProductController addProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          if (checkChange) {
            SahaDialogApp.showDialogYesNo(
                mess: "Cập nhật chưa được lưu. Bạn có chắc muốn huỷ thay đổi?",
                onOK: () {
                  Get.back();
                });
          }
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
                "${isNew == true ? "Chỉnh kho và giá bán" : "Chỉnh giá bán"}"),
            actions: [
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    onDone(distributesRequest);
                    Get.back();
                  })
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(
                    distributesRequest.elementDistributes!.length,
                    (index) => elementDistribute(
                        distributesRequest.elementDistributes![index]!, index)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget elementDistribute(
      ElementDistributesRequest elementDistributesRequest, int index) {
    var sku =
        TextEditingController(text: elementDistributesRequest.sku ?? null);
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
        Container(
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
                            if (isNew != true)
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
                                            distributesRequest
                                                    .elementDistributes![index]!
                                                    .priceImport =
                                                double.parse(SahaStringUtils()
                                                    .convertFormatText(v));
                                            print(distributesRequest.toJson());
                                          } else {
                                            distributesRequest
                                                .elementDistributes![index]!
                                                .priceImport = null;
                                          }
                                          checkChange = true;
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
                            if (isNew == true)
                              Row(
                                children: [
                                  SizedBox(
                                      width: Get.width * 0.4,
                                      child: Text("Giá vốn")),
                                  Expanded(
                                    child: Container(
                                      height: 30,
                                      width: Get.width * 0.2,
                                      child: TextField(
                                        controller: priceCapitalEditController,
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
                                            distributesRequest
                                                    .elementDistributes![index]!
                                                    .priceCapital =
                                                double.parse(SahaStringUtils()
                                                    .convertFormatText(v));
                                            print(distributesRequest.toJson());
                                          } else {
                                            distributesRequest
                                                .elementDistributes![index]!
                                                .priceCapital = null;
                                          }
                                          checkChange = true;
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
                                          distributesRequest
                                                  .elementDistributes![index]!
                                                  .price =
                                              double.parse(SahaStringUtils()
                                                  .convertFormatText(v));
                                          print(distributesRequest.toJson());
                                        } else {
                                          distributesRequest
                                              .elementDistributes![index]!
                                              .price = null;
                                        }
                                        checkChange = true;
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
                                    child: Text("Mã Sku")),
                                Expanded(
                                  child: Container(
                                    height: 30,
                                    width: Get.width * 0.25,
                                    child: TextField(
                                      controller: sku,
                                 
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(fontSize: 14),
                                      decoration: InputDecoration(
                                       
                                        contentPadding:
                                            EdgeInsets.only(left: 5),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none),
                                      ),
                                      onChanged: (v) {
                                        if (v != "") {
                                          distributesRequest
                                                  .elementDistributes![index]!
                                                  .sku =
                                             v;
                                          print(distributesRequest.toJson());
                                        } else {
                                          distributesRequest
                                              .elementDistributes![index]!
                                              .sku = null;
                                        }
                                        checkChange = true;
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
                                  onChanged: (v) {
                                    if (v != "") {
                                      distributesRequest
                                              .elementDistributes![index]!
                                              .priceImport =
                                          double.parse(SahaStringUtils()
                                              .convertFormatText(v));
                                      print(distributesRequest.toJson());
                                    } else {
                                      distributesRequest
                                          .elementDistributes![index]!
                                          .priceImport = null;
                                    }
                                    if (isNew == true) {
                                      distributesRequest
                                              .elementDistributes![index]!
                                              .priceCapital =
                                          distributesRequest
                                              .elementDistributes![index]!
                                              .priceImport;
                                    }
                                    checkChange = true;
                                  },
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
                                width: Get.width * 0.4, child: Text("Giá lẻ")),
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
                                  onChanged: (v) {
                                    if (v != "") {
                                      distributesRequest
                                              .elementDistributes![index]!
                                              .price =
                                          double.parse(SahaStringUtils()
                                              .convertFormatText(v));
                                      print(distributesRequest.toJson());
                                    } else {
                                      distributesRequest
                                          .elementDistributes![index]!
                                          .price = null;
                                    }
                                    checkChange = true;
                                  },
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
                                width: Get.width * 0.4, child: Text("Mã Sku")),
                            Expanded(
                              child: Container(
                                height: 30,
                                width: Get.width * 0.2,
                                child: TextField(
                                  controller: sku,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 5),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                  ),
                                  onChanged: (v) {
                                    if (v != "") {
                                      distributesRequest
                                          .elementDistributes![index]!.sku = v;
                                      print(distributesRequest.toJson());
                                    } else {
                                      distributesRequest
                                          .elementDistributes![index]!
                                          .sku = null;
                                    }
                                    checkChange = true;
                                  },
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
            ],
          ),
        ),
        if (elementDistributesRequest.subElementDistribute == null ||
            elementDistributesRequest.subElementDistribute!.isEmpty)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                SizedBox(width: Get.width * 0.4, child: Text("Mã QR")),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        height: 30,
                        child: TextField(
                          controller: barcodeEditController,
                          keyboardType: TextInputType.text,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          onChanged: (v) {
                            if (v != "") {
                              distributesRequest.elementDistributes![index]!
                                  .barcode = TiengViet.parse(v);
                              print(distributesRequest.toJson());
                            } else {
                              distributesRequest
                                  .elementDistributes![index]!.barcode = null;
                            }
                            checkChange = true;
                          },
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
                                    .elementDistributes![index]!.barcode = v;
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
        if (elementDistributesRequest.subElementDistribute != null)
          ...List.generate(
              elementDistributesRequest.subElementDistribute!.length,
              (indexSub) {
            var skuController = TextEditingController(
                text: elementDistributesRequest
                        .subElementDistribute![indexSub].sku ??
                    null);
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

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 10.0, left: 15, right: 10),
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
                              width: Get.width * 0.4, child: Text("Giá nhập")),
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
                                onChanged: (v) {
                                  checkChange = true;
                                  if (v != "") {
                                    distributesRequest
                                            .elementDistributes![index]!
                                            .subElementDistribute![indexSub]
                                            .priceImport =
                                        double.parse(SahaStringUtils()
                                            .convertFormatText(v));
                                  } else {
                                    distributesRequest
                                        .elementDistributes![index]!
                                        .subElementDistribute![indexSub]
                                        .priceImport = null;
                                    print(distributesRequest.toJson());
                                  }
                                  if (isNew == true) {
                                    distributesRequest
                                            .elementDistributes![index]!
                                            .subElementDistribute![indexSub]
                                            .priceCapital =
                                        distributesRequest
                                            .elementDistributes![index]!
                                            .subElementDistribute![indexSub]
                                            .priceImport;
                                  }
                                },
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
                              width: Get.width * 0.4, child: Text("Giá lẻ")),
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
                                onChanged: (v) {
                                  checkChange = true;
                                  if (v != "") {
                                    distributesRequest
                                            .elementDistributes![index]!
                                            .subElementDistribute![indexSub]
                                            .price =
                                        double.parse(SahaStringUtils()
                                            .convertFormatText(v));
                                  } else {
                                    distributesRequest
                                        .elementDistributes![index]!
                                        .subElementDistribute![indexSub]
                                        .price = null;
                                    print(distributesRequest.toJson());
                                  }
                                },
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
                              width: Get.width * 0.4, child: Text("Sku")),
                          Expanded(
                            child: Container(
                              height: 30,
                              child: TextField(
                                controller: skuController,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                                onChanged: (v) {
                                  checkChange = true;
                                  if (v != "") {
                                    distributesRequest
                                        .elementDistributes![index]!
                                        .subElementDistribute![indexSub]
                                        .sku = v;
                                  } else {
                                    distributesRequest
                                        .elementDistributes![index]!
                                        .subElementDistribute![indexSub]
                                        .sku = null;
                                    print(distributesRequest.toJson());
                                  }
                                },
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
                      SizedBox(width: Get.width * 0.4, child: Text("Mã QR")),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: 30,
                              child: TextField(
                                controller: barcodeEditController,
                                keyboardType: TextInputType.text,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 5),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                                onChanged: (v) {
                                  checkChange = true;
                                  if (v != "") {
                                    distributesRequest
                                        .elementDistributes![index]!
                                        .subElementDistribute![indexSub]
                                        .barcode = TiengViet.parse(v);
                                    print(distributesRequest.toJson());
                                  } else {
                                    distributesRequest
                                        .elementDistributes![index]!
                                        .subElementDistribute![indexSub]
                                        .barcode = null;
                                    print(distributesRequest.toJson());
                                  }
                                },
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
                                          .subElementDistribute![indexSub]
                                          .barcode = TiengViet.parse(v);
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
