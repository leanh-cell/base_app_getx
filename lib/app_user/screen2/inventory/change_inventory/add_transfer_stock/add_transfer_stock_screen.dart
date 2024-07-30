import 'package:com.ikitech.store/app_user/model/transfer_stock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_keyboard.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../model/transfer_stock_item.dart';
import '../search_transfer_stock/search_product_transfer_screen.dart';
import 'add_transfer_stock_controller.dart';

class AddTransferStockScreen extends StatelessWidget {
  TransferStock? transferStockInput;

  AddTransferStockScreen({this.transferStockInput}) {
    addTransferStockController =
        AddTransferStockController(transferStockInput: transferStockInput);
  }

  late AddTransferStockController addTransferStockController;
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
                () => SearchProductTransferScreen(
                  isSearch: true,
                  branchIdInput: addTransferStockController
                      .transferStockRequest.value.fromBranchId!,
                  listTransferStockItem:
                      addTransferStockController.listTransferStockItem.toList(),
                  onChooseTransferStock:
                      (List<TransferStockItem> listTransferStockItem,
                          bool? clickDone) {
                    Get.back();
                    if (clickDone == true) {
                      addTransferStockController
                          .listTransferStockItem(listTransferStockItem);
                    } else {
                      if (addTransferStockController
                          .listTransferStockItem.isNotEmpty) {
                        addTransferStockController.listTransferStockItem
                            .addAll(listTransferStockItem);
                      } else {
                        addTransferStockController
                            .listTransferStockItem(listTransferStockItem);
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
              SizedBox(
                height: 15,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      "Chi nhánh chuyển:",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Obx(
                          () => Text(
                        "${addTransferStockController.transferStockRequest.value.fromBranch?.name ?? "Chưa chọn"}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: addTransferStockController
                                .transferStockRequest
                                .value
                                .fromBranchId ==
                                null
                                ? Colors.red
                                : null),
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
                  SahaDialogApp.showDialogBranchOrder(
                      branchId: addTransferStockController
                          .transferStockRequest.value.toBranchId,
                      listBranch: addTransferStockController.listBranch,
                      callBack: (branch) {
                        addTransferStockController
                            .transferStockRequest.value.toBranchId = branch.id;
                        addTransferStockController
                            .transferStockRequest.value.toBranch = branch;
                        addTransferStockController.transferStockRequest
                            .refresh();
                      });
                },
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text("Chi nhánh nhận:",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          )),
                      Spacer(),
                      Obx(
                        () => Text(
                          "${addTransferStockController.transferStockRequest.value.toBranch?.name ?? "Chưa chọn"}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: addTransferStockController
                                          .transferStockRequest
                                          .value
                                          .toBranchId ==
                                      null
                                  ? Colors.red
                                  : null),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded,
                          color: addTransferStockController
                                      .transferStockRequest.value.toBranchId ==
                                  null
                              ? Colors.red
                              : null),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              if (addTransferStockController.listTransferStockItem.isEmpty)
                InkWell(
                  onTap: () {
                    if (sahaDataController
                            .badgeUser.value.decentralization?.productList ==
                        false) {
                      SahaAlert.showError(
                          message: "Chức năng danh sách sản phẩm bị chặn");
                    } else {
                      Get.to(
                        () => SearchProductTransferScreen(

                          branchIdInput: addTransferStockController
                              .transferStockRequest.value.fromBranchId!,
                          listTransferStockItem: addTransferStockController
                              .listTransferStockItem
                              .toList(),
                          onChooseTransferStock:
                              (List<TransferStockItem> listTransferStockItem,
                                  bool? clickDone) {
                            Get.back();
                            addTransferStockController
                                .listTransferStockItem(listTransferStockItem);
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
                          "Phiếu chuyển kho của bạn chưa có\nsản phẩm nào!",
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
              if (addTransferStockController.listTransferStockItem.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      "Sản phẩm (${addTransferStockController.listTransferStockItem.length})"),
                ),
              ...List.generate(
                  addTransferStockController.listTransferStockItem.length,
                  (index) => transferStockItem(
                      addTransferStockController.listTransferStockItem[index],
                      index)),
              if (addTransferStockController.listTransferStockItem.isNotEmpty)
                InkWell(
                  onTap: () {
                    Get.to(
                      () => SearchProductTransferScreen(
                        isSearch: true,
                        branchIdInput: addTransferStockController
                            .transferStockRequest.value.fromBranchId!,
                        listTransferStockItem: addTransferStockController
                            .listTransferStockItem
                            .toList(),
                        onChooseTransferStock:
                            (List<TransferStockItem> listTransferStockItem,
                                bool? clickDone) {
                          Get.back();
                          if (clickDone == true) {
                            addTransferStockController
                                .listTransferStockItem(listTransferStockItem);
                          } else {
                            if (addTransferStockController
                                .listTransferStockItem.isNotEmpty) {
                              addTransferStockController.listTransferStockItem
                                  .addAll(listTransferStockItem);
                            } else {
                              addTransferStockController
                                  .listTransferStockItem(listTransferStockItem);
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
                    Text("Tổng số lượng"),
                    Text("${addTransferStockController.quantityAll()}"),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              if (addTransferStockController.transferStockRequest.value.note ==
                      null ||
                  addTransferStockController.transferStockRequest.value.note ==
                      "")
                InkWell(
                  onTap: () {
                    PopupInput().showDialogInputNote(
                        confirm: (v) {
                          addTransferStockController
                              .transferStockRequest.value.note = v;
                          addTransferStockController.transferStockRequest
                              .refresh();
                        },
                        title: "Ghi chú",
                        textInput:
                            "${addTransferStockController.transferStockRequest.value.note ?? ""}");
                  },
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Thêm ghi chú",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.assignment_outlined,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                ),
              if (addTransferStockController.transferStockRequest.value.note !=
                      null &&
                  addTransferStockController.transferStockRequest.value.note !=
                      "")
                InkWell(
                  onTap: () {
                    PopupInput().showDialogInputNote(
                        confirm: (v) {
                          addTransferStockController
                              .transferStockRequest.value.note = v;
                          addTransferStockController.transferStockRequest
                              .refresh();
                        },
                        title: "Ghi chú",
                        textInput:
                            "${addTransferStockController.transferStockRequest.value.note ?? ""}");
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
                            "${addTransferStockController.transferStockRequest.value.note}")
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
              SahaButtonFullParent(
                text: transferStockInput != null ? "Lưu" : "Tạo phiếu chuyển",
                onPressed:
                    addTransferStockController.listTransferStockItem.isNotEmpty
                        ? () {
                            if (transferStockInput != null) {
                              addTransferStockController.updateTransferStock();
                            } else {
                              addTransferStockController.createTransferStock();
                            }
                          }
                        : null,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget transferStockItem(TransferStockItem transferStockItem, int index) {
    return Column(
      children: [
        Container(
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
                            addTransferStockController
                                .deleteQuantityTransferStock(index);
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
                    "${transferStockItem.product?.name ?? ""}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )),
                  IconButton(
                    onPressed: () {
                      addTransferStockController
                          .decreaseQuantityTransferStock(index);
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Theme.of(Get.context!).primaryColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      PopupKeyboard().showDialogInputKeyboard(
                          numberInput: "${transferStockItem.quantity ?? 0}",
                          title: "Số lượng chuyển kho",
                          confirm: (number) {
                            addTransferStockController
                                .updateQuantityTransferStock(
                                    index, (number as double).round());
                          });
                    },
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey[300]!)),
                      child: Center(
                        child: Text(
                          "${transferStockItem.quantity ?? 0}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (transferStockItem.quantityMax !=
                          transferStockItem.quantity) {
                        addTransferStockController
                            .increaseQuantityTransferStock(index);
                      } else {
                        SahaAlert.showToastMiddle(
                            message:
                                "Số lượng sản phẩm trong chi nhánh đã đạt giới hạn");
                      }
                    },
                    icon: Icon(
                      Icons.add,
                      color: transferStockItem.quantityMax ==
                              transferStockItem.quantity
                          ? Colors.grey
                          : Theme.of(Get.context!).primaryColor,
                    ),
                  ),
                ],
              ),
              if (transferStockItem.elementDistributeName != null)
                Text(
                    "Phân loại: ${transferStockItem.elementDistributeName ?? ""}${transferStockItem.subElementDistributeName == null ? "" : ","} ${transferStockItem.subElementDistributeName == null ? "" : transferStockItem.subElementDistributeName}"),
              SizedBox(
                height: 10,
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
