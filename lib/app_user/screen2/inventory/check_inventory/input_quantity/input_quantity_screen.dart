import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_keyboard.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/tally_sheet_request.dart';
import 'input_quantity_controller.dart';

class InputQuantityProductScreen extends StatelessWidget {
  TallySheetItem tallySheetItem;
  Function? onSave;
  bool? isNew;

  InputQuantityProductScreen(
      {required this.tallySheetItem, this.isNew, this.onSave}) {
    inputQuantityController =
        InputQuantityController(tallySheetItemInput: tallySheetItem);
  }

  late InputQuantityController inputQuantityController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sản phẩm"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                        imageUrl: tallySheetItem.imageProductUrl ?? "",
                        placeholder: (context, url) => new SahaLoadingWidget(
                          size: 20,
                        ),
                        errorWidget: (context, url, error) => new Icon(
                          Icons.image,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${tallySheetItem.nameProduct}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            if (tallySheetItem.elementDistributeName != null &&
                                tallySheetItem.subElementDistributeName != null)
                              Row(
                                children: [
                                  Text(
                                    "Phân loại: ",
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  Text(
                                    "${tallySheetItem.elementDistributeName ?? ""}${tallySheetItem.subElementDistributeName == null ? "" : ","} ${tallySheetItem.subElementDistributeName == null ? "" : tallySheetItem.subElementDistributeName}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
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
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Tồn chi nhánh",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${inputQuantityController.tallySheetItem.value.stockOnline ?? 0}",
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.grey,
                      ),
                      Column(
                        children: [
                          Text(
                            "Tồn đã kiểm",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => Text(
                              "${inputQuantityController.tallySheetItem.value.realityExist ?? 0}",
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 30,
                        color: Colors.grey,
                      ),
                      Column(
                        children: [
                          Text(
                            "Chênh lệch",
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => Text(
                              "${(inputQuantityController.tallySheetItem.value.realityExist ?? 0) - (inputQuantityController.tallySheetItem.value.stockOnline ?? 0)}",
                              style: TextStyle(
                                color: (inputQuantityController.tallySheetItem
                                                    .value.realityExist ??
                                                0) -
                                            (inputQuantityController
                                                    .tallySheetItem
                                                    .value
                                                    .stockOnline ??
                                                0) <
                                        0
                                    ? Colors.red
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Text("Số lượng tồn đang kiểm"),
                Spacer(),
                IconButton(
                  onPressed: () {
                    if (isNew == true) {
                      inputQuantityController.decreaseRealityExist();
                    } else {
                      inputQuantityController.decreaseRealityExistIsUp();
                    }
                  },
                  icon: Icon(
                    Icons.remove,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                InkWell(
                  onTap: () {
                    PopupKeyboard().showDialogInputKeyboard(
                        numberInput: isNew == true
                            ? "${inputQuantityController.tallySheetItem.value.realityExist ?? 0}"
                            : "${inputQuantityController.quantityRealityExistCheck.value}",
                        title: "Số lượng tồn đang kiểm",
                        confirm: (number) {
                          if (isNew == true) {
                            inputQuantityController.tallySheetItem.value
                                .realityExist = (number as double).round();
                            inputQuantityController.tallySheetItem.refresh();
                          } else {
                            inputQuantityController.quantityRealityExistCheck
                                .value = (number as double).round();
                          }
                        });
                  },
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey[300]!)),
                    child: Center(
                      child: Obx(
                        () => Text(
                          isNew == true
                              ? "${inputQuantityController.tallySheetItem.value.realityExist ?? 0}"
                              : "${inputQuantityController.quantityRealityExistCheck.value}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (isNew == true) {
                      inputQuantityController.increaseRealityExist();
                    } else {
                      inputQuantityController.increaseRealityExistIsUp();
                    }
                  },
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          if (isNew == true)
            SizedBox(
              height: 15,
            ),
          if (isNew == true)
            InkWell(
              onTap: () {
                if (onSave != null) {
                  onSave!([inputQuantityController.tallySheetItem.value]);
                  Get.back();
                }
              },
              child: Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    "Lưu",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          if (isNew == true)
            SizedBox(
              height: 8,
            ),
          if (isNew == true)
            GestureDetector(
              onTap: () {
                inputQuantityController.tallySheetItem.value.realityExist =
                    inputQuantityController.tallySheetItem.value.stockOnline;
                if (onSave != null) {
                  onSave!([inputQuantityController.tallySheetItem.value]);
                  Get.back();
                }
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Số lượng tồn đang kiểm bằng Tồn kho",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          if (isNew != true)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      inputQuantityController
                              .tallySheetItem.value.realityExist =
                          inputQuantityController
                              .quantityRealityExistCheck.value;
                      if (onSave != null) {
                        onSave!([inputQuantityController.tallySheetItem.value]);
                        Get.back();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[200]!),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          Text(
                            "Kiểm lại",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Thay thế SL đã kiểm",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      inputQuantityController.tallySheetItem.value
                          .realityExist = (inputQuantityController
                                  .tallySheetItem.value.realityExist ??
                              0) +
                          inputQuantityController
                              .quantityRealityExistCheck.value;
                      if (onSave != null) {
                        onSave!([inputQuantityController.tallySheetItem.value]);
                        Get.back();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          border: Border.all(color: Colors.grey[200]!),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          Text(
                            "Kiểm thêm",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            "Cộng thêm SL đã kiểm",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
