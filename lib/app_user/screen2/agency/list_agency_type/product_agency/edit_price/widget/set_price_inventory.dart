import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_request.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class SetPriceInventory extends StatelessWidget {
  SetPriceInventory({required this.distributesRequest, required this.onDone}) {
    distributesRequest = DistributesRequest(
        name: distributesRequest.name,
        subElementDistributeName: distributesRequest.subElementDistributeName,
        elementDistributes: distributesRequest.elementDistributes!
            .map((e) => ElementDistributesRequest(
                  name: e!.name,
                  imageUrl: e.imageUrl,
                  price: e.price,
                  quantityInStock: e.quantityInStock,
                  subElementDistribute: e.subElementDistribute == null
                      ? null
                      : e.subElementDistribute!
                          .map((e) => SubElementDistributeRequest(
                              name: e.name,
                              price: e.price,
                              quantityInStock: e.quantityInStock))
                          .toList(),
                ))
            .toList());
  }
  late DistributesRequest distributesRequest;
  final Function onDone;
  bool checkChange = false;
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
            title: Text("Chỉnh kho và giá bán"),
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
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: Get.width * 0.4,
                          child: Text("Phân loại hàng")),
                      SizedBox(width: Get.width * 0.25, child: Text("Giá")),
                      SizedBox(width: Get.width * 0.15, child: Text("Kho")),
                    ],
                  ),
                ),
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
    var priceEditController = TextEditingController(
      text: elementDistributesRequest.price == null
          ? null
          : "${SahaStringUtils().convertToUnit(elementDistributesRequest.price)}",
    );

    var stockEditController = TextEditingController(
      text: elementDistributesRequest.quantityInStock == null
          ? null
          : elementDistributesRequest.quantityInStock == -1 ? null : "${SahaStringUtils().convertToUnit(elementDistributesRequest.quantityInStock)}",
    );

    priceEditController.selection = TextSelection.fromPosition(
        TextPosition(offset: priceEditController.text.length));
    stockEditController.selection = TextSelection.fromPosition(
        TextPosition(offset: stockEditController.text.length));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: Get.width * 0.4,
                  child: Text(elementDistributesRequest.name ?? "")),
              elementDistributesRequest.subElementDistribute != null
                  ? elementDistributesRequest.subElementDistribute!.isEmpty
                      ? Container(
                          width: Get.width * 0.48,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
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
                              Container(
                                height: 30,
                                width: Get.width * 0.15,
                                child: TextField(
                                  inputFormatters: [
                                    ThousandsFormatter(),
                                  ],
                                  controller: stockEditController,
                                  keyboardType: TextInputType.number,
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
                                              .quantityInStock =
                                          int.parse(SahaStringUtils()
                                              .convertFormatText(v));
                                      print(distributesRequest.toJson());
                                    } else {
                                      distributesRequest
                                          .elementDistributes![index]!
                                          .quantityInStock = null;
                                    }
                                  },
                                ),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey[300]!)),
                              ),
                            ],
                          ),
                        )
                      : Container()
                  : Container(
                      width: Get.width * 0.48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
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
                                contentPadding: EdgeInsets.only(left: 5),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              onChanged: (v) {
                                if (v != "") {
                                  distributesRequest
                                          .elementDistributes![index]!.price =
                                      double.parse(SahaStringUtils()
                                          .convertFormatText(v));
                                  print(distributesRequest.toJson());
                                } else {
                                  distributesRequest
                                      .elementDistributes![index]!.price = null;
                                }
                                checkChange = true;
                              },
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!)),
                          ),
                          Container(
                            height: 30,
                            width: Get.width * 0.15,
                            child: TextField(
                              inputFormatters: [
                                ThousandsFormatter(),
                              ],
                              controller: stockEditController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 5),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              onChanged: (v) {
                                checkChange = true;
                                if (v != "") {
                                  distributesRequest.elementDistributes![index]!
                                          .quantityInStock =
                                      int.parse(SahaStringUtils()
                                          .convertFormatText(v));
                                  print(distributesRequest.toJson());
                                } else {
                                  distributesRequest.elementDistributes![index]!
                                      .quantityInStock = null;
                                }
                              },
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!)),
                          ),
                        ],
                      ),
                    )
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
            var priceEditController = TextEditingController(
              text: elementDistributesRequest
                          .subElementDistribute![indexSub].price ==
                      null
                  ? null
                  : "${SahaStringUtils().convertToUnit(elementDistributesRequest.subElementDistribute![indexSub].price)}",
            );
            var stockEditController = TextEditingController(
              text: elementDistributesRequest
                          .subElementDistribute![indexSub].quantityInStock ==
                      null
                  ? null
                  : "${SahaStringUtils().convertToUnit(elementDistributesRequest.subElementDistribute![indexSub].quantityInStock)}",
            );
            priceEditController.selection = TextSelection.fromPosition(
                TextPosition(offset: priceEditController.text.length));
            stockEditController.selection = TextSelection.fromPosition(
                TextPosition(offset: stockEditController.text.length));
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: Get.width * 0.4,
                          child: Text(elementDistributesRequest
                                  .subElementDistribute![indexSub].name ??
                              "")),
                      Container(
                        height: 30,
                        width: Get.width * 0.25,
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
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          onChanged: (v) {
                            checkChange = true;
                            if (v != "") {
                              distributesRequest.elementDistributes![index]!
                                      .subElementDistribute![indexSub].price =
                                  double.parse(
                                      SahaStringUtils().convertFormatText(v));
                            } else {
                              distributesRequest.elementDistributes![index]!
                                  .subElementDistribute![indexSub].price = null;
                              print(distributesRequest.toJson());
                            }
                          },
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!)),
                      ),
                      Container(
                        height: 30,
                        width: Get.width * 0.15,
                        child: TextField(
                          controller: stockEditController,
                          inputFormatters: [
                            ThousandsFormatter(),
                          ],
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 5),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          onChanged: (v) {
                            checkChange = true;
                            if (v != "") {
                              distributesRequest
                                      .elementDistributes![index]!
                                      .subElementDistribute![indexSub]
                                      .quantityInStock =
                                  int.parse(
                                      SahaStringUtils().convertFormatText(v));
                              print(distributesRequest.toJson());
                            } else {
                              distributesRequest
                                  .elementDistributes![index]!
                                  .subElementDistribute![indexSub]
                                  .quantityInStock = null;
                              print(distributesRequest.toJson());
                            }
                          },
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!)),
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
          color: Colors.grey[200],
        )
      ],
    );
  }
}
