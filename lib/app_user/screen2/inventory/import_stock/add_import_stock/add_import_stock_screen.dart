import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_keyboard.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/tally_sheet_request.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';
import 'package:com.ikitech.store/app_user/model/supplier.dart';
import 'package:com.ikitech.store/app_user/model/tally_sheet.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/check_inventory/input_quantity/input_quantity_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/search_product/search_product_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/suppliers/suppliers_profile/suppliers_profile_screen.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:ionicons/ionicons.dart';
import 'package:permission_handler/permission_handler.dart';

import 'add_import_stock_controller.dart';

class AddImportStockScreen extends StatelessWidget {
  ImportStock? importStockInput;
  Supplier? supplier;
  AddImportStockScreen({this.importStockInput, this.supplier}) {
    addImportStockController =
        AddImportStockController(importStockInput: importStockInput);
    if (supplier != null) {
      addImportStockController.importStock.value.supplier = supplier;
    }
  }

  late AddImportStockController addImportStockController;

  SahaDataController sahaDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            if (sahaDataController
                    .badgeUser.value.decentralization?.productList ==
                false) {
              SahaAlert.showError(
                  message: "Chức năng danh sách sản phẩm bị chặn");
            } else {
              Get.to(
                () => SearchProductScreen(
                  isSearch: true,
                  checkInventory: true,
                  listImportStockItem:
                      addImportStockController.listImportStockItem.toList(),
                  onChooseImportStock:
                      (List<ImportStockItem> listImportStockItem,
                          bool? clickDone) {
                    Get.back();
                    if (clickDone == true) {
                      addImportStockController
                          .listImportStockItem(listImportStockItem);
                    } else {
                      if (addImportStockController
                          .listImportStockItem.isNotEmpty) {
                        addImportStockController.listImportStockItem
                            .addAll(listImportStockItem);
                      } else {
                        addImportStockController
                            .listImportStockItem(listImportStockItem);
                      }
                    }
                  },
                ),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.only(left: 10),
            height: 40,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              enabled: false,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.only(left: 0, right: 10, top: 12, bottom: 0),
                border: InputBorder.none,
                hintText: "Nhập tên",
                hintStyle: TextStyle(fontSize: 15),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Ionicons.barcode_outline,
                  ),
                ),
              ),
              onChanged: (v) async {},
              style: TextStyle(fontSize: 14),
              minLines: 1,
              maxLines: 1,
            ),
          ),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (addImportStockController.listImportStockItem.isEmpty)
                InkWell(
                  onTap: () {
                    if (sahaDataController
                            .badgeUser.value.decentralization?.productList ==
                        false) {
                      SahaAlert.showError(
                          message: "Chức năng danh sách sản phẩm bị chặn");
                    } else {
                      Get.to(
                        () => SearchProductScreen(
                          checkInventory: true,
                          listImportStockItem: addImportStockController
                              .listImportStockItem
                              .toList(),
                          onChooseImportStock:
                              (List<ImportStockItem> listImportStockItem,
                                  bool? clickDone) {
                            Get.back();
                            addImportStockController
                                .listImportStockItem(listImportStockItem);
                            addImportStockController.caculatePayment();
                          },
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: Get.width,
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Icon(
                          Icons.inventory_outlined,
                          size: 100,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Đơn nhập hàng của bạn chưa có\nsản phẩm nào!",
                          style: TextStyle(color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              if (addImportStockController.listImportStockItem.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      "Sản phẩm (${addImportStockController.listImportStockItem.length})"),
                ),
              ...List.generate(
                  addImportStockController.listImportStockItem.length,
                  (index) => importStockItem(
                      addImportStockController.listImportStockItem[index],
                      index)),
              if (addImportStockController.listImportStockItem.isNotEmpty)
                InkWell(
                  onTap: () {
                    Get.to(
                      () => SearchProductScreen(
                        checkInventory: true,
                        listImportStockItem: addImportStockController
                            .listImportStockItem
                            .toList(),
                        onChooseImportStock:
                            (List<ImportStockItem> listImportStockItem,
                                bool? clickDone) {
                          Get.back();
                          if (clickDone == true) {
                            addImportStockController
                                .listImportStockItem(listImportStockItem);
                          } else {
                            if (addImportStockController
                                .listImportStockItem.isNotEmpty) {
                              addImportStockController.listImportStockItem
                                  .addAll(listImportStockItem);
                            } else {
                              addImportStockController
                                  .listImportStockItem(listImportStockItem);
                            }
                          }
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Center(
                        child: Text(
                      "Thêm sản phẩm +",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                  ),
                ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tổng số lượng"),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Tổng tiền hàng"),
                        SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () {
                            PopupKeyboard().showDialogInputKeyboard(
                              numberInput:
                                  "${SahaStringUtils().convertToMoney(addImportStockController.importStock.value.discount ?? 0)}",
                              title: "Chiết khấu",
                              confirm: (number, isPercent) {
                                if (isPercent == true) {
                                  addImportStockController
                                          .importStock.value.discount =
                                      (addImportStockController.priceAll() *
                                              number) /
                                          100;
                                } else {
                                  addImportStockController
                                      .importStock.value.discount = number;
                                }
                                addImportStockController.importStock.refresh();
                                addImportStockController.caculatePayment();
                              },
                              isPercentInput:
                                  addImportStockController.isPercentInput,
                            );
                          },
                          child: Text(
                            "Chiết khấu",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () {
                            PopupKeyboard().showDialogInputKeyboard(
                              numberInput:
                                  "${SahaStringUtils().convertToMoney(addImportStockController.importStock.value.cost ?? 0)}",
                              title: "Chi phí nhập hàng",
                              confirm: (number) {
                                addImportStockController
                                    .importStock.value.cost = number;
                                addImportStockController.importStock.refresh();
                                addImportStockController.caculatePayment();
                              },
                            );
                          },
                          child: Text(
                            "Chi phí nhập hàng",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () {
                            PopupKeyboard().showDialogInputKeyboard(
                              numberInput:
                                  "${SahaStringUtils().convertToMoney(addImportStockController.importStock.value.vat ?? 0)}",
                              title: "VAT",
                              confirm: (number) {
                                addImportStockController.importStock.value.vat =
                                    number;
                                addImportStockController.importStock.refresh();
                                addImportStockController.caculatePayment();
                              },
                            );
                          },
                          child: Text(
                            "VAT",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text("Số tiền cần thanh toán"),
                        SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () {
                            PopupKeyboard().showDialogInputKeyboard(
                              numberInput:
                                  "${SahaStringUtils().convertToMoney(addImportStockController.importStock.value.totalPayment ?? 0)}",
                              title: "Thanh toán",
                              confirm: (number) {
                                addImportStockController
                                    .importStock.value.totalPayment = number;
                                addImportStockController.importStock.refresh();
                              },
                            );
                          },
                          child: Text(
                            "Thanh toán",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        )
                      ],
                    ),
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${addImportStockController.quantityAll()}"),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              "${SahaStringUtils().convertToMoney(addImportStockController.priceAll())}"),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              "${SahaStringUtils().convertToMoney(addImportStockController.importStock.value.discount ?? 0)}"),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              "${SahaStringUtils().convertToMoney(addImportStockController.importStock.value.cost ?? 0)}"),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              "${SahaStringUtils().convertToMoney(addImportStockController.importStock.value.vat ?? 0)}"),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              "${SahaStringUtils().convertToMoney(addImportStockController.totalNeedPayment.value)}"),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              "${SahaStringUtils().convertToMoney(addImportStockController.importStock.value.totalPayment ?? 0)}"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text("Phương thức thanh toán"),
                    const Spacer(),
                    Obx(
                      () => DropdownButton<String>(
                        value: addImportStockController.dropdownValue.value,
                        elevation: 16,
                        onChanged: (String? value) {
                          if (value == addImportStockController.list[0]) {
                            addImportStockController.dropdownValue.value =
                                addImportStockController.list[0];
                            addImportStockController
                                .importStock.value.paymentMethod = 0;
                          }
                          if (value == addImportStockController.list[1]) {
                            addImportStockController.dropdownValue.value =
                                addImportStockController.list[1];
                            addImportStockController
                                .importStock.value.paymentMethod = 1;
                          }
                          if (value == addImportStockController.list[2]) {
                            addImportStockController.dropdownValue.value =
                                addImportStockController.list[2];
                            addImportStockController
                                .importStock.value.paymentMethod = 2;
                          }
                          if (value == addImportStockController.list[3]) {
                            addImportStockController.dropdownValue.value =
                                addImportStockController.list[3];
                            addImportStockController
                                .importStock.value.paymentMethod = 3;
                          }
                        },
                        items: addImportStockController.list
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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
                  // Get.to(() => SuppliersProfileScreen(
                  //     supplier: addImportStockController
                  //         .importStock.value.supplier!));
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
                          "${addImportStockController.importStock.value.supplier?.name ?? ""} ${addImportStockController.importStock.value.supplier?.phone ?? ""}"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              if (addImportStockController.importStock.value.note == null ||
                  addImportStockController.importStock.value.note == "")
                InkWell(
                  onTap: () {
                    PopupInput().showDialogInputNote(
                        confirm: (v) {
                          addImportStockController.importStock.value.note = v;
                          addImportStockController.importStock.refresh();
                        },
                        title: "Ghi chú",
                        textInput:
                            "${addImportStockController.importStock.value.note ?? ""}");
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
              if (addImportStockController.importStock.value.note != null &&
                  addImportStockController.importStock.value.note != "")
                InkWell(
                  onTap: () {
                    PopupInput().showDialogInputNote(
                        confirm: (v) {
                          addImportStockController.importStock.value.note = v;
                          addImportStockController.importStock.refresh();
                        },
                        title: "Ghi chú",
                        textInput:
                            "${addImportStockController.importStock.value.note ?? ""}");
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13),
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
                            "${addImportStockController.importStock.value.note}")
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SahaButtonFullParent(
                      text: importStockInput != null ? "Lưu" : "Tạo phiếu nhập",
                      onPressed: addImportStockController
                              .listImportStockItem.isNotEmpty
                          ? () {
                              if (importStockInput != null) {
                                addImportStockController.updateImportStock();
                              } else {
                                addImportStockController.createImportStock();
                              }
                            }
                          : null,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  if (importStockInput?.status != 3)
                    Expanded(
                      child: SahaButtonFullParent(
                        text: "Hoàn thành",
                        onPressed: addImportStockController
                                .listImportStockItem.isNotEmpty
                            ? () {
                                if (importStockInput != null) {
                                  addImportStockController
                                      .importStock.value.status = 3;
                                  addImportStockController.updateImportStock();
                                } else {
                                  addImportStockController
                                      .importStock.value.status = 3;
                                  addImportStockController.createImportStock();
                                }
                              }
                            : null,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget importStockItem(ImportStockItem importStockItem, int index) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            PopupKeyboard().showDialogInputKeyboard(
                numberInput:
                    "${SahaStringUtils().convertToMoney(importStockItem.importPrice ?? 0)}",
                title: "Điều chỉnh giá nhập",
                confirm: (number) {
                  addImportStockController.updatePriceTallyItem(index, number);
                });
          },
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: () {
                        SahaDialogApp.showDialogYesNo(
                            mess:
                                "Bạn có chắc muốn xoá sản phẩm này ra khỏi đơn không?",
                            onOK: () {
                              addImportStockController
                                  .deleteQuantityTallyItem(index);
                            });
                      },
                      child: Icon(
                        Icons.clear,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      "${importStockItem.product?.name ?? ""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                    IconButton(
                      onPressed: () {
                        addImportStockController
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
                            numberInput: "${importStockItem.quantity ?? 0}",
                            title: "Số lượng tồn đang kiểm",
                            confirm: (number) {
                              addImportStockController.updateQuantityTallyItem(
                                  index, (number as double).round());
                            });
                      },
                      child: Container(
                        width: 60,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey[300]!)),
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
                        addImportStockController
                            .increaseQuantityTallyItem(index);
                      },
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                    ),
                  ],
                ),
                if (importStockItem.elementDistributeName != null)
                  Text(
                      "Phân loại: ${importStockItem.elementDistributeName ?? ""}${importStockItem.subElementDistributeName == null ? "" : ","} ${importStockItem.subElementDistributeName == null ? "" : importStockItem.subElementDistributeName}"),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    PopupKeyboard().showDialogInputKeyboard(
                        numberInput:
                            "${SahaStringUtils().convertToMoney(importStockItem.importPrice ?? 0)}",
                        title: "Điều chỉnh giá nhập",
                        confirm: (number) {
                          addImportStockController.updatePriceTallyItem(
                              index, number);
                        });
                  },
                  child: Text(
                    "Nhập: ${SahaStringUtils().convertToMoney((importStockItem.importPrice ?? 0))}₫",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Tổng: ${SahaStringUtils().convertToMoney((importStockItem.importPrice ?? 0) * (importStockItem.quantity ?? 0))}₫",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }
}
