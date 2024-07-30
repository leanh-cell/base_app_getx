import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_keyboard.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/tally_sheet_request.dart';
import 'package:com.ikitech.store/app_user/model/tally_sheet.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/check_inventory/input_quantity/input_quantity_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/search_product/search_product_screen.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:ionicons/ionicons.dart';

import 'add_check_inventory_controller.dart';

class AddCheckInventoryScreen extends StatelessWidget {
  TallySheet? tallySheetInput;

  AddCheckInventoryScreen({this.tallySheetInput}) {
    addCheckInventoryController =
        AddCheckInventoryController(tallySheetInput: tallySheetInput);
  }

  late AddCheckInventoryController addCheckInventoryController;
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
                  checkInventory: true,
                  isSearch: true,
                  listTallySheetItem:
                      addCheckInventoryController.listTallySheetItem.toList(),
                  onChoose: (List<TallySheetItem> listTallySheetItem,
                      bool? clickDone) {
                    if (clickDone == true) {
                      Get.back();
                      addCheckInventoryController
                          .listTallySheetItem(listTallySheetItem);
                    } else {
                      if (listTallySheetItem.length > 1) {
                        if (addCheckInventoryController
                            .listTallySheetItem.isNotEmpty) {
                          addCheckInventoryController.listTallySheetItem
                              .addAll(listTallySheetItem);
                        } else {
                          addCheckInventoryController
                              .listTallySheetItem(listTallySheetItem);
                        }
                      } else {
                        Get.to(() => InputQuantityProductScreen(
                              isNew: true,
                              tallySheetItem: listTallySheetItem[0],
                              onSave: (listTallySheetItem) {
                                if (listTallySheetItem.isNotEmpty) {
                                  Get.back();
                                  if (addCheckInventoryController
                                      .listTallySheetItem.isNotEmpty) {
                                    addCheckInventoryController
                                        .listTallySheetItem
                                        .addAll(listTallySheetItem);
                                  } else {
                                    addCheckInventoryController
                                        .listTallySheetItem(listTallySheetItem);
                                  }
                                } else {
                                  Get.back();
                                }

                                addCheckInventoryController.listTallySheetItem
                                    .refresh();
                              },
                            ));
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
              if (addCheckInventoryController.listTallySheetItem.isEmpty)
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
                          onChoose: (List<TallySheetItem> listTallySheetItem,
                              bool? clickDone) {
                            if (listTallySheetItem.length > 1) {
                              Get.back();
                              addCheckInventoryController
                                  .listTallySheetItem(listTallySheetItem);
                            } else {
                              Get.to(() => InputQuantityProductScreen(
                                    isNew: true,
                                    tallySheetItem: listTallySheetItem[0],
                                    onSave: (List<TallySheetItem>
                                        listTallySheetItem) {
                                      if (listTallySheetItem.isNotEmpty) {
                                        Get.back();
                                        addCheckInventoryController
                                            .listTallySheetItem(
                                                listTallySheetItem);
                                        addCheckInventoryController
                                            .listTallySheetItem
                                            .refresh();
                                      } else {
                                        Get.back();
                                      }
                                    },
                                  ));
                            }
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
                          "Phiếu kiểm hàng của bạn chưa có\nsản phẩm nào!",
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
              if (addCheckInventoryController.listTallySheetItem.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      "Sản phẩm (${addCheckInventoryController.listTallySheetItem.length})"),
                ),
              ...List.generate(
                  addCheckInventoryController.listTallySheetItem.length,
                  (index) => tallySheetItem(
                      addCheckInventoryController.listTallySheetItem[index],
                      index)),
              if (addCheckInventoryController.listTallySheetItem.isNotEmpty)
              InkWell(
                onTap: () {
                  Get.to(
                    () => SearchProductScreen(
                      checkInventory: true,
                      isSearch: true,
                      listTallySheetItem: addCheckInventoryController
                          .listTallySheetItem
                          .toList(),
                      onChoose: (List<TallySheetItem> listTallySheetItem,
                          bool? clickDone) {
                        if (clickDone == true) {
                          Get.back();
                          addCheckInventoryController
                              .listTallySheetItem(listTallySheetItem);
                        } else {
                          if (listTallySheetItem.length > 1) {
                            if (addCheckInventoryController
                                .listTallySheetItem.isNotEmpty) {
                              addCheckInventoryController.listTallySheetItem
                                  .addAll(listTallySheetItem);
                            } else {
                              addCheckInventoryController
                                  .listTallySheetItem(listTallySheetItem);
                            }
                          } else {
                            Get.to(() => InputQuantityProductScreen(
                                  isNew: true,
                                  tallySheetItem: listTallySheetItem[0],
                                  onSave: (listTallySheetItem) {
                                    if (listTallySheetItem.isNotEmpty) {
                                      Get.back();
                                      if (addCheckInventoryController
                                          .listTallySheetItem.isNotEmpty) {
                                        addCheckInventoryController
                                            .listTallySheetItem
                                            .addAll(listTallySheetItem);
                                      } else {
                                        addCheckInventoryController
                                            .listTallySheetItem(
                                                listTallySheetItem);
                                      }
                                    } else {
                                      Get.back();
                                    }

                                    addCheckInventoryController
                                        .listTallySheetItem
                                        .refresh();
                                  },
                                ));
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
                        Text("SL tồn thực tế"),
                        SizedBox(
                          height: 8,
                        ),
                        Text("SL tồn chi nhánh"),
                        SizedBox(
                          height: 8,
                        ),
                        Text("SL chênh lệch")
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                            "${addCheckInventoryController.quantityRealityExistAll()}"),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                            "${addCheckInventoryController.quantityStockOnlineAll()}"),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${addCheckInventoryController.quantityRealityExistAll() - addCheckInventoryController.quantityStockOnlineAll()}",
                          style: TextStyle(
                            color: (addCheckInventoryController
                                            .quantityRealityExistAll() -
                                        addCheckInventoryController
                                            .quantityStockOnlineAll()) <
                                    0
                                ? Colors.red
                                : null,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              if (addCheckInventoryController.tallySheetRequest.value.note ==
                      null ||
                  addCheckInventoryController.tallySheetRequest.value.note ==
                      "")
                InkWell(
                  onTap: () {
                    PopupInput().showDialogInputNote(
                        confirm: (v) {
                          addCheckInventoryController
                              .tallySheetRequest.value.note = v;
                          addCheckInventoryController.tallySheetRequest
                              .refresh();
                        },
                        title: "Ghi chú",
                        textInput:
                            "${addCheckInventoryController.tallySheetRequest.value.note ?? ""}");
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
              if (addCheckInventoryController.tallySheetRequest.value.note !=
                      null &&
                  addCheckInventoryController.tallySheetRequest.value.note !=
                      "")
                InkWell(
                  onTap: () {
                    PopupInput().showDialogInputNote(
                        confirm: (v) {
                          addCheckInventoryController
                              .tallySheetRequest.value.note = v;
                          addCheckInventoryController.tallySheetRequest
                              .refresh();
                        },
                        title: "Ghi chú",
                        textInput:
                            "${addCheckInventoryController.tallySheetRequest.value.note ?? ""}");
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
                            "${addCheckInventoryController.tallySheetRequest.value.note}")
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
                text: tallySheetInput != null ? "Lưu" : "Tạo phiếu kiểm",
                onPressed:
                    addCheckInventoryController.listTallySheetItem.isNotEmpty
                        ? () {
                            if (tallySheetInput != null) {
                              addCheckInventoryController.updateTallySheet();
                            } else {
                              addCheckInventoryController.createTallySheet();
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

  Widget tallySheetItem(TallySheetItem tallySheetItem, int index) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print(tallySheetItem.realityExist);
            if (tallySheetItem.realityExist == 0 ||
                tallySheetItem.realityExist == null) {
              Get.to(() => InputQuantityProductScreen(
                    isNew: true,
                    tallySheetItem: tallySheetItem,
                    onSave: (List<TallySheetItem> tallySheetItem) {
                      if (tallySheetItem.isNotEmpty) {
                        addCheckInventoryController.listTallySheetItem[index] =
                            tallySheetItem[0];
                        addCheckInventoryController.listTallySheetItem
                            .refresh();
                      }
                    },
                  ));
            } else {
              Get.to(() => InputQuantityProductScreen(
                    isNew: false,
                    tallySheetItem: tallySheetItem,
                    onSave: (tallySheetItem) {
                      if (tallySheetItem.isNotEmpty) {
                        addCheckInventoryController.listTallySheetItem[index] =
                            tallySheetItem[0];
                        addCheckInventoryController.listTallySheetItem
                            .refresh();
                      }
                    },
                  ));
            }
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
                              addCheckInventoryController
                                  .deleteRealityExistTallyItem(index);
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
                      "${tallySheetItem.nameProduct ?? ""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                    IconButton(
                      onPressed: () {
                        addCheckInventoryController
                            .decreaseRealityExistTallyItem(index);
                      },
                      icon: Icon(
                        Icons.remove,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        PopupKeyboard().showDialogInputKeyboard(
                            numberInput: "${tallySheetItem.realityExist ?? 0}",
                            title: "Số lượng tồn đang kiểm",
                            confirm: (number) {
                              addCheckInventoryController
                                  .updateRealityExistTallyItem(
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
                            "${tallySheetItem.realityExist ?? 0}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        addCheckInventoryController
                            .increaseRealityExistTallyItem(index);
                      },
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(Get.context!).primaryColor,
                      ),
                    ),
                  ],
                ),
                Text(
                    "Phân loại: ${tallySheetItem.elementDistributeName ?? ""}${tallySheetItem.subElementDistributeName == null ? "" : ","} ${tallySheetItem.subElementDistributeName == null ? "" : tallySheetItem.subElementDistributeName}"),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Tồn chi nhánh: ",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "${tallySheetItem.stockOnline ?? 0}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        )
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "Chênh lệch: ",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "${(tallySheetItem.realityExist ?? 0) - (tallySheetItem.stockOnline ?? 0)}",
                          style: TextStyle(
                            color: (tallySheetItem.realityExist ?? 0) -
                                        (tallySheetItem.stockOnline ?? 0) <
                                    0
                                ? Colors.red
                                : null,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 50,
                    ),
                  ],
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
