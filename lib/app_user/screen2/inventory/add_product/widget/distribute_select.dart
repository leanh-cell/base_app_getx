import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/app_bar/saha_appbar.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/divide/divide.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/product/product_request.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';

import '../add_product_controller.dart';
import 'distribute_select_controller.dart';
import 'set_price_inventory.dart';

class DistributeSelect extends StatefulWidget {
  final Function? onData;
  final bool? isNew;

  const DistributeSelect({Key? key, this.onData, this.isNew}) : super(key: key);

  @override
  _DistributeSelectState createState() => _DistributeSelectState();
}

class _DistributeSelectState extends State<DistributeSelect> {
  final DistributeSelectController distributeSelectController = Get.find();
  final AddProductController addProductController = Get.find();
  Future<bool> onPop() async {
    var valid = distributeSelectController.checkValidParam();
    distributeSelectController.getQuantityElement();
    if (valid) {
      widget.onData!(distributeSelectController.getFinalDistribute(),
          distributeSelectController.quantityCurrent);
    }

    return distributeSelectController.checkValidParam();
  }

  @override
  void initState() {
    distributeSelectController.checkSetPriceAndInventory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SahaAppBar(
        titleText: "Phân loại sản phẩm",
        leading: InkWell(
            onTap: () {
              if (distributeSelectController.hasChange.value == false) {
                onPop();
                Get.back();
              } else {
                SahaDialogApp.showDialogYesNo(
                    mess:
                        "Cập nhật chưa được lưu. Bạn có chắc muốn huỷ thay đổi?",
                    onOK: () {
                      onPop();
                      Get.back();
                      print(
                          addProductController.listDistributeInit[0].toJson());
                      distributeSelectController.listDistribute(
                          distributeSelectController.castDistributeRequest(
                              addProductController.listDistributeInit));
                    });
              }
            },
            child: Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                onPop();
                Get.back();
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (distributeSelectController.listDistribute.isNotEmpty)
                  buildDistribute(distributeSelectController.listDistribute[0]),
                SizedBox(
                  height: 15,
                ),
                distributeSelectController.listDistribute.isEmpty == true
                    ? Center(
                        child: MaterialButton(
                          onPressed: () {
                            inputDialog().then((value) {
                              if (value != null && value.length > 0) {
                                distributeSelectController.addDistribute(value);

                                distributeSelectController.refresh();
                              }
                            });
                          },
                          padding: EdgeInsets.all(0),
                          child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: SahaPrimaryColor,
                              radius: Radius.circular(4),
                              strokeWidth: 1,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.add),
                                    Text("Thêm phân loại")
                                  ],
                                ),
                              )),
                        ),
                      )
                    : distributeSelectController
                                .listDistribute[0].subElementDistributeName ==
                            null
                        ? Center(
                            child: MaterialButton(
                              onPressed: () {
                                inputDialog().then((value) {
                                  if (value != null && value.length > 0) {
                                    distributeSelectController
                                        .addSubDistributeName(value);
                                  }
                                });
                              },
                              padding: EdgeInsets.all(0),
                              child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  color: SahaPrimaryColor,
                                  radius: Radius.circular(4),
                                  strokeWidth: 1,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.add),
                                        Text("Thêm phân loại")
                                      ],
                                    ),
                                  )),
                            ),
                          )
                        : Container(),
              ],
            ),
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
                text: "Tiếp: Chỉnh giá bán",
                onPressed: distributeSelectController
                            .checkSetPriceInventory.value ==
                        true
                    ? () {
                        Get.to(() => SetPriceInventory(
                              distributesRequest:
                                  distributeSelectController.listDistribute[0],
                              onDone: (v) {
                                distributeSelectController.listDistribute[0] =
                                    v;
                              },
                              isNew: widget.isNew,
                            ));
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

  Widget buildDistribute(DistributesRequest distributes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                inputDialog(initValue: distributes.name).then((value) {
                  if (value != null && value.length > 0) {
                    distributeSelectController.editNameDistribute(
                        distributeSelectController.listDistribute
                            .indexOf(distributes),
                        value);
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  distributes.name!,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Row(
              children: [
                if (distributeSelectController.listDistribute
                        .indexOf(distributes) !=
                    1)
                  Row(
                    children: [
                      Text(
                        "Ảnh minh họa",
                        style: TextStyle(color: Colors.grey, fontSize: 9),
                      ),
                      SizedBox(
                        child: Transform.scale(
                          scale: 0.5,
                          child: new CupertinoSwitch(
                            value: distributes.boolHasImage!,
                            onChanged: (bool value1) {
                              distributeSelectController.toggleHasImage(
                                  distributeSelectController.listDistribute
                                      .indexOf(distributes));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                InkWell(
                  onTap: () {
                    distributeSelectController.removeDistribute(
                        distributeSelectController.listDistribute
                            .indexOf(distributes));
                  },
                  child: Text(
                    "Xóa",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 9),
                  ),
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: buildListDistributes(
                      distribute: distributes,
                      list: distributes.elementDistributes,
                      onRemove: (distribute) {
                        distributeSelectController
                            .removeElementDistribute(distribute);
                        distributeSelectController.refresh();
                      },
                      onUpdateName: (name, elm) {
                        inputDialog(isElementDistribute: true).then((value) {
                          if (value != null && value.length != 0) {
                            distributeSelectController.updateNameDistribute(
                                elm, value);
                          }
                          distributeSelectController.refresh();
                        });
                      },
                      onAdd: () {
                        inputDialog(isElementDistribute: true).then((value) {
                          if (value != null && value.length != 0) {
                            distributeSelectController.addElementDistribute(
                                distributeSelectController.listDistribute
                                    .indexOf(distributes),
                                value);
                          }
                          distributeSelectController.refresh();
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 7,
        ),
        SahaDivide(),
        if (distributeSelectController
                .listDistribute[0].subElementDistributeName !=
            null)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      inputDialog(
                              initValue: distributes.subElementDistributeName)
                          .then((value) {
                        if (value != null && value.length > 0) {
                          distributeSelectController.listDistribute[0]
                              .subElementDistributeName = value;
                          distributeSelectController.listDistribute.refresh();
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        distributes.subElementDistributeName ?? "",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          distributeSelectController
                              .removeSubElementDistribute();
                          print(distributeSelectController.listDistribute[0]
                              .toJson());
                        },
                        child: Text(
                          "Xóa",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 9),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: buildListSubElementDistribute(
                            list: distributes.elementDistributes == null
                                ? null
                                : distributes.elementDistributes!.isNotEmpty
                                    ? distributes.elementDistributes![0]!
                                                .subElementDistribute ==
                                            null
                                        ? null
                                        : distributes.elementDistributes![0]!
                                            .subElementDistribute!
                                    : null,
                            onRemove: (subElementDistribute) {
                              var index = distributeSelectController
                                  .listDistribute[0]
                                  .elementDistributes![0]!
                                  .subElementDistribute!
                                  .indexOf(subElementDistribute);
                              if (index != -1) {
                                distributeSelectController
                                    .listDistribute[0]
                                    .elementDistributes![0]!
                                    .subElementDistribute!
                                    .removeAt(index);
                              }
                              distributeSelectController
                                  .listDistribute[0].elementDistributes!
                                  .forEach((e) {
                                e!.subElementDistribute =
                                    distributeSelectController
                                        .listDistribute[0]
                                        .elementDistributes![0]!
                                        .subElementDistribute;
                              });
                              distributeSelectController.refresh();
                              distributeSelectController
                                  .checkSetPriceAndInventory();
                              print(distributeSelectController.listDistribute[0]
                                  .toJson());
                            },
                            onAdd: () {
                              inputDialog(isElementDistribute: true)
                                  .then((value) {
                                if (value != null && value.length != 0) {
                                  distributeSelectController
                                      .addSubElementDistribute(value);
                                }
                                distributeSelectController.refresh();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }

  List<Widget> buildListSubElementDistribute(
      {required List<SubElementDistributeRequest?>? list,
      Function? onRemove,
      Function? onAdd}) {
    if (list != null) {
      var rtList = list
          .map((e) => buildItemSubElementDistribute(
              subElementDistribute: e, onRemove: onRemove))
          .toList();
      rtList.add(buildItemSubElementDistribute(
          onAdd: onAdd,
          isAdd: true,
          subElementDistribute: SubElementDistributeRequest(name: "")));
      return rtList;
    } else {
      return [
        buildItemSubElementDistribute(
            onAdd: onAdd,
            isAdd: true,
            subElementDistribute: SubElementDistributeRequest(name: ""))
      ];
    }
  }

  Widget buildItemSubElementDistribute(
      {SubElementDistributeRequest? subElementDistribute,
      Function? onRemove,
      Function? onAdd,
      bool isAdd = false}) {
    return subElementDistribute?.name != null
        ? InkWell(
            onTap: isAdd ? onAdd as void Function()? : null,
            child: Container(
              margin: EdgeInsets.only(right: 8, top: 8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: SahaPrimaryColor),
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(isAdd ? "Thêm" : subElementDistribute!.name ?? ""),
                        InkWell(
                            child: Icon(
                              isAdd ? Icons.add : Icons.clear,
                              size: 15,
                            ),
                            onTap: () {
                              isAdd
                                  ? onAdd!()
                                  : onRemove!(subElementDistribute);
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  List<Widget> buildListDistributes(
      {List<ElementDistributesRequest?>? list,
      Function? onRemove,
      Function? onUpdateName,
      DistributesRequest? distribute,
      Function? onAdd}) {
    if (list != null) {
      var rtList = list
          .map((e) => buildItemDistribute(
                distribute: distribute,
                elementDistribute: e,
                onRemove: onRemove,
                onUpdateName: onUpdateName,
              ))
          .toList();
      rtList.add(buildItemDistribute(
          onAdd: onAdd,
          isAdd: true,
          distribute: distribute,
          onUpdateName: onUpdateName,
          onRemove: onRemove,
          elementDistribute:
              ElementDistributesRequest(name: "", subElementDistribute: [])));
      return rtList;
    } else {
      return [
        buildItemDistribute(
            onAdd: onAdd,
            isAdd: true,
            onUpdateName: onUpdateName,
            distribute: distribute,
            onRemove: onRemove,
            elementDistribute:
                ElementDistributesRequest(name: "", subElementDistribute: []))
      ];
    }
  }

  Widget buildItemDistribute(
      {ElementDistributesRequest? elementDistribute,
      Function? onRemove,
      DistributesRequest? distribute,
      Function? onAdd,
      Function? onUpdateName,
      bool isAdd = false}) {
    return elementDistribute?.name != null
        ? InkWell(
            onTap: isAdd ? onAdd as void Function()? : null,
            child: Container(
              margin: EdgeInsets.only(right: 8, top: 8),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: SahaPrimaryColor),
                  borderRadius: BorderRadius.circular(4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  !isAdd &&
                          distribute!.boolHasImage != null &&
                          distribute.boolHasImage == true
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: SahaPrimaryColor,
                              radius: Radius.circular(4),
                              strokeWidth: 1,
                              child: InkWell(
                                onTap: () {
                                  distributeSelectController.chooseImage(
                                      distribute, elementDistribute);
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  child: elementDistribute!.imageUrl != null
                                      ? CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: elementDistribute.imageUrl!,
                                          placeholder: (context, url) => Center(
                                              child: SahaLoadingWidget()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )
                                      : Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.image_outlined,
                                            color: Colors.grey,
                                          )),
                                ),
                              )),
                        )
                      : Container(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                            onTap: () {
                              if (!isAdd) {
                                if (onUpdateName != null) {
                                  onUpdateName(elementDistribute!.name ?? "",
                                      elementDistribute);
                                }
                              } else {
                                onAdd!();
                              }
                            },
                            child: Text(isAdd
                                ? "Thêm"
                                : elementDistribute!.name ?? "")),
                        InkWell(
                            child: Icon(
                              isAdd ? Icons.add : Icons.clear,
                              size: 15,
                            ),
                            onTap: () {
                              isAdd ? onAdd!() : onRemove!(elementDistribute);
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  List<DropdownMenuItem> buildDropdownTestItems(List _testList) {
    List<DropdownMenuItem> items = [];
    for (var i in _testList) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['keyword']),
        ),
      );
    }
    return items;
  }

  onChangeDropdownTests(selectedTest) {
    print(selectedTest);
    // setState(() {
    //   _selectedTest = selectedTest;
    // });
  }

  Future inputDialog(
      {bool isElementDistribute = false, String? initValue}) async {
    String teamName = '';
    return showDialog(
      context: Get.context!,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isElementDistribute ? 'Tên thuộc tính' : "Tên phân loại"),
          content: new Row(
            children: [
              new Expanded(
                  child: new TextFormField(
                initialValue: initValue ?? "",
                autofocus: true,
                decoration: new InputDecoration(),
                onChanged: (value) {
                  teamName = value;
                },
              ))
            ],
          ),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(teamName);
              },
            ),
          ],
        );
      },
    );
  }
}
