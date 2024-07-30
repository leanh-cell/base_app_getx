import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_keyboard.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/suppliers/suppliers_profile/suppliers_profile_screen.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'return_import_stock_controller.dart';

class ReturnImportStockScreen extends StatelessWidget {
  ImportStock? importStockInput;
  ReturnImportStockScreen({
    this.importStockInput,
  }) {
    returnImportStockController =
        ReturnImportStockController(importStockInput: importStockInput);
  }

  late ReturnImportStockController returnImportStockController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Hoàn trả NCC"),
      ),
      body: Obx(
        () => returnImportStockController.listImportStockItem.isEmpty
            ? Center(
                child: Text("Đã hoàn trả hết sản phẩm"),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: returnImportStockController
                                    .listImportStockItemChoose.length ==
                                returnImportStockController
                                    .listImportStockItem.length,
                            onChanged: (v) {
                              if (returnImportStockController
                                      .listImportStockItemChoose.length ==
                                  returnImportStockController
                                      .listImportStockItem.length) {
                                returnImportStockController
                                    .listImportStockItemChoose([]);
                              } else {
                                returnImportStockController
                                    .listImportStockItemChoose(
                                        returnImportStockController
                                            .listImportStockItem);
                              }
                            }),
                        Text("Tất cả sản phẩm"),
                      ],
                    ),
                    ...List.generate(
                        returnImportStockController.listImportStockItem.length,
                        (index) => importStockItem(
                            returnImportStockController
                                .listImportStockItem[index],
                            index)),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tổng số lượng"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("Giá trị hàng trả"),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Chiết khấu",
                              ),
                              if (returnImportStockController
                                  .importStock.value.hasRefunded !=
                                  true)
                              SizedBox(
                                height: 8,
                              ),
                              if (returnImportStockController
                                  .importStock.value.hasRefunded !=
                                  true)
                              Text(
                                "Chi phí nhập hàng",
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Tổng giá trị hàng trả: ",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    "${returnImportStockController.quantityAll()}"),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    "${SahaStringUtils().convertToMoney(returnImportStockController.priceAll())}"),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    "-${SahaStringUtils().convertToMoney(returnImportStockController.priceDiscountRefund())}"),
                                if (returnImportStockController
                                        .importStock.value.hasRefunded !=
                                    true)
                                  SizedBox(
                                    height: 8,
                                  ),
                                if (returnImportStockController
                                        .importStock.value.hasRefunded !=
                                    true)
                                  Text(
                                      "${SahaStringUtils().convertToMoney(returnImportStockController.importStock.value.cost ?? 0)}"),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    "${SahaStringUtils().convertToMoney(returnImportStockController.priceTotalRefund())}"),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => SuppliersProfileScreen(
                            supplier: returnImportStockController
                                .importStock.value.supplier!));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Icon(
                              Icons.store,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                                "${returnImportStockController.importStock.value.supplier?.name ?? ""} ${returnImportStockController.importStock.value.supplier?.phone ?? ""}"),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.grey,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Icon(
                            Icons.credit_card,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nhận tiền hoàn từ nhà cung cấp"),
                              Text(
                                "Số tiền tối đa có thể nhận lại: ${SahaStringUtils().convertToMoney(returnImportStockController.pricePaid())}",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (returnImportStockController.importStock.value.note ==
                            null ||
                        returnImportStockController.importStock.value.note ==
                            "")
                      InkWell(
                        onTap: () {
                          PopupInput().showDialogInputNote(
                              confirm: (v) {
                                returnImportStockController
                                    .importStock.value.note = v;
                                returnImportStockController.importStock
                                    .refresh();
                              },
                              title: "Ghi chú",
                              textInput:
                                  "${returnImportStockController.importStock.value.note ?? ""}");
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Thêm ghi chú",
                                style: TextStyle(color: Colors.blue),
                              ),
                              Icon(
                                Icons.assignment_outlined,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ),
                    if (returnImportStockController.importStock.value.note !=
                            null &&
                        returnImportStockController.importStock.value.note !=
                            "")
                      InkWell(
                        onTap: () {
                          PopupInput().showDialogInputNote(
                              confirm: (v) {
                                returnImportStockController
                                    .importStock.value.note = v;
                                returnImportStockController.importStock
                                    .refresh();
                              },
                              title: "Ghi chú",
                              textInput:
                                  "${returnImportStockController.importStock.value.note ?? ""}");
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Ghi chú",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "${returnImportStockController.importStock.value.note}")
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            Obx(
              () => SahaButtonFullParent(
                text: "Hoàn trả",
                onPressed: returnImportStockController
                        .listImportStockItemChoose.isNotEmpty
                    ? () {
                        returnImportStockController.refundImportStock();
                      }
                    : null,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget importStockItem(ImportStockItem importStockItem, int index) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
          color: Colors.white,
          child: Row(
            children: [
              Checkbox(
                  value: returnImportStockController
                      .checkChooseItem(importStockItem),
                  onChanged: (v) {
                    if (returnImportStockController
                        .checkChooseItem(importStockItem)) {
                      returnImportStockController.listImportStockItemChoose
                          .remove(importStockItem);
                    } else {
                      returnImportStockController.listImportStockItemChoose
                          .add(importStockItem);
                    }
                  }),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "${importStockItem.product?.name ?? ""}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                        Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    returnImportStockController
                                        .decreaseQuantityTallyItem(index);
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    color: Theme.of(Get.context!).primaryColor,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    PopupKeyboard().showDialogInputKeyboard(
                                        numberInput:
                                            "${importStockItem.quantity ?? 0}",
                                        title: "Số lượng",
                                        confirm: (number) {
                                          returnImportStockController
                                              .updateQuantityTallyItem(index,
                                                  (number as double).round());
                                        });
                                  },
                                  child: Container(
                                    width: 60,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey[300]!)),
                                    child: Center(
                                      child: Text(
                                        "${importStockItem.quantity ?? 0}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    returnImportStockController
                                        .increaseQuantityTallyItem(index);
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Theme.of(Get.context!).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${importStockItem.quantity}/${importStockItem.quantityReturnMax}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Text(
                        "Phân loại: ${importStockItem.elementDistributeName ?? ""}${importStockItem.subElementDistributeName == null ? "" : ","} ${importStockItem.subElementDistributeName == null ? "" : importStockItem.subElementDistributeName}"),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Nhập: ${SahaStringUtils().convertToMoney((importStockItem.importPrice ?? 0))}₫",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // PopupKeyboard().showDialogInputKeyboard(
                        //     numberInput: "${importStockItem.quantity ?? 0}",
                        //     title: "Điều chỉnh giá nhập",
                        //     confirm: (number) {
                        //       returnImportStockController.updatePriceTallyItem(
                        //           index, number);
                        //     });
                      },
                      child: Text(
                        "${SahaStringUtils().convertToMoney((importStockItem.importPrice ?? 0) * (importStockItem.quantity ?? 0))}₫",
                        style: TextStyle(

                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }
}
