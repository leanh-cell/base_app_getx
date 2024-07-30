import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/model/location_address.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../../const/type_address.dart';
import '../../../data/repository/repository_manager.dart';
import '../loading/loading_full_screen.dart';
import '../toast/saha_alert.dart';

class PopupKeyboard {
  void showDialogInputKeyboard({
    required String title,
    String? numberInput,
    String? maxInput,
    required Function confirm,
    bool? isPercentInput,
  }) {
    TextEditingController textEditingController =
        TextEditingController(text: numberInput ?? "0");
    bool isPercent = false;

    if (isPercentInput != null) {
      isPercent = isPercentInput;
    }

    void input({
      required String text,
      bool? isRemove,
    }) {
      if (isRemove == true) {
        if (textEditingController.text.length > 1) {
          textEditingController.text = textEditingController.text
              .substring(0, textEditingController.text.length - 1);
        } else {
          if (textEditingController.text != "0") {
            textEditingController.text = "0";
          }
        }
      } else {
        if (textEditingController.text.length == 1 &&
            textEditingController.text == "0" &&
            text == "0") {
        } else {
          textEditingController.text = textEditingController.text + text;
          textEditingController.text =
              textEditingController.text.replaceFirst(new RegExp(r'^0+'), '');
          if (maxInput != null) {
            if (double.parse(textEditingController.text) >
                double.parse(maxInput)) {
              textEditingController.text = "$maxInput";
            }
          }
          if (isPercent == true &&
              double.parse(textEditingController.text) >= 100) {
            textEditingController.text = "100";
          }
        }
      }
      textEditingController.text = NumberFormat('#,##0', 'ID')
          .format(int.parse(textEditingController.text.replaceAll(".", "")));
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
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            content: StatefulBuilder(
              builder: (BuildContext context,
                  void Function(void Function()) setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        TextFormField(
                          enabled: false,
                          textAlign: TextAlign.center,
                          controller: textEditingController,
                          inputFormatters: [
                            ThousandsFormatter(allowFraction: true)
                          ],
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 15),
                          ),
                          onChanged: (v) async {},
                          style: TextStyle(fontSize: 20),
                          minLines: 1,
                          maxLines: 1,
                        ),
                        Positioned(
                          right: 30,
                          top: 10,
                          child: InkWell(
                            onTap: () {
                              textEditingController.text = "0";
                            },
                            child: Container(
                              padding: EdgeInsets.all(2),
                              child: Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 13,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[350],
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    if (isPercentInput != null)
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[300],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                isPercent = false;
                                setState(() {});
                              },
                              child: Container(
                                width: 50,
                                decoration: isPercent != true
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      )
                                    : null,
                                padding: EdgeInsets.all(5),
                                child: Center(
                                  child: Text(
                                    "Giá trị",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                isPercent = true;
                                setState(() {});
                              },
                              child: Container(
                                width: 50,
                                decoration: isPercent == true
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white,
                                      )
                                    : null,
                                padding: EdgeInsets.all(5),
                                child: Center(
                                    child: Text(
                                  "%",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )),
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
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  //                    <--- top side
                                  color: Colors.grey[200]!,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    input(text: "1");
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(child: Text("1")),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    input(text: "4");
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(child: Text("4")),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    input(text: "7");
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(child: Text("7")),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                isPercent != true
                                    ? InkWell(
                                        onTap: () {
                                          input(text: "000");
                                        },
                                        child: Container(
                                          height: 50,
                                          child: Center(child: Text("000")),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          input(text: ".");
                                        },
                                        child: Container(
                                          height: 50,
                                          child: Center(child: Text(".")),
                                        ),
                                      ),
                                Divider(
                                  height: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.grey[200]!,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    input(text: "2");
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(child: Text("2")),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    input(text: "5");
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(child: Text("5")),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    input(text: "8");
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(child: Text("8")),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    input(text: "0");
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(child: Text("0")),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    input(text: "3");
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(child: Text("3")),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    input(text: "6");
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(child: Text("6")),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    input(text: "9");
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(child: Text("9")),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    input(text: "", isRemove: true);
                                  },
                                  child: Container(
                                    height: 50,
                                    child: Center(
                                        child: Icon(
                                      Icons.backspace_outlined,
                                      color: Colors.black54,
                                    )),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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
                              if (isPercentInput != null) {
                                confirm(
                                    double.parse(textEditingController.text
                                        .replaceAll(".", "")),
                                    isPercent);
                              } else {
                                confirm(double.parse(textEditingController.text
                                    .replaceAll(".", "")));
                              }
                              Get.back();
                            },
                            child: Container(
                              height: 50,
                              child: Center(
                                child: Text(
                                  "Xác nhận",
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
                );
              },
            ),
          );
        });
  }

  void showDialogAddressChoose({
    required Function callback,
    int? idProvince,
    int? idDistrict,
  }) {
    TextEditingController textEditingController = TextEditingController();

    var nameTitleAppbar = "".obs;
    var listLocationAddress = RxList<LocationAddress>();
    List<LocationAddress> listLocationAddressCache = [];
    var isLoadingAddress = false.obs;

    Future<void> getProvince() async {
      isLoadingAddress.value = true;
      try {
        var res = await RepositoryManager.addressRepository.getProvince();

        res!.data!.forEach((element) {
          listLocationAddress.add(element);
          listLocationAddressCache.add(element);
        });
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }

      isLoadingAddress.value = false;
    }

    Future<void> getDistrict(int? idProvince) async {
      isLoadingAddress.value = true;
      try {
        var res =
            await RepositoryManager.addressRepository.getDistrict(idProvince);

        res!.data!.forEach((element) {
          listLocationAddress.add(element);
          listLocationAddressCache.add(element);
        });
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }

      isLoadingAddress.value = false;
    }

    Future<void> getWard(int? idDistrict) async {
      isLoadingAddress.value = true;
      try {
        var res = await RepositoryManager.addressRepository.getWard(idDistrict);

        res!.data!.forEach((element) {
          listLocationAddress.add(element);
          listLocationAddressCache.add(element);
        });
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }
      isLoadingAddress.value = false;
    }

    if (idProvince == null && idDistrict == null) {
      nameTitleAppbar.value = "Tỉnh/Thành phố";
      getProvince();
    } else if (idProvince == null && idDistrict != null) {
      nameTitleAppbar.value = "Phường/Xã";
      getWard(idDistrict);
    } else {
      nameTitleAppbar.value = "Quận/Huyện";
      getDistrict(idProvince);
    }

    void search(String text) {
      listLocationAddress(listLocationAddressCache
          .where((e) => TiengViet.parse(e.name ?? "")
              .toLowerCase()
              .contains(TiengViet.parse(text).toLowerCase()))
          .toList());
    }

    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    nameTitleAppbar.value,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            content: SizedBox(
              height: Get.height / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        isDense: true,
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 14),
                      ),
                      onChanged: (v) async {
                        if (v != "") search(v);
                      },
                      style: TextStyle(fontSize: 14),
                      minLines: 1,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => isLoadingAddress.value == true
                        ? Expanded(
                            child: Center(child: SahaLoadingFullScreen()))
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: listLocationAddress
                                    .map((e) => InkWell(
                                          onTap: () {
                                            callback(e);
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Text(
                                                  e.name ?? "",
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ),
                                              Divider(
                                                height: 1,
                                              )
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showDialogAddressSelected({
    required Function callback,
    List<int>? listProvinceIdSelected,
  }) {
    TextEditingController textEditingController = TextEditingController();

    var nameTitleAppbar = "".obs;
    var listLocationAddress = RxList<LocationAddress>();
    var listLocationAddressSelected = RxList<LocationAddress>();
    List<LocationAddress> listLocationAddressCache = [];
    var isLoadingAddress = false.obs;

    Future<void> getProvince() async {
      isLoadingAddress.value = true;
      try {
        var res = await RepositoryManager.addressRepository.getProvince();

        res!.data!.forEach((element) {
          listLocationAddress.add(element);
          listLocationAddressCache.add(element);
        });
      } catch (err) {
        SahaAlert.showError(message: err.toString());
      }

      isLoadingAddress.value = false;
    }

    nameTitleAppbar.value = "Tỉnh/Thành phố";
    getProvince();

    void search(String text) {
      listLocationAddress(listLocationAddressCache
          .where((e) => TiengViet.parse(e.name ?? "")
              .toLowerCase()
              .contains(TiengViet.parse(text).toLowerCase()))
          .toList());
    }

    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    nameTitleAppbar.value,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            content: SizedBox(
              height: Get.height / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        isDense: true,
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 14),
                      ),
                      onChanged: (v) async {
                        if (v != "") search(v);
                      },
                      style: TextStyle(fontSize: 14),
                      minLines: 1,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => isLoadingAddress.value == true
                        ? Expanded(
                            child: Center(child: SahaLoadingFullScreen()))
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: listLocationAddress
                                    .map((e) => InkWell(
                                          onTap: () {
                                            if (listLocationAddressSelected
                                                .map((e) => e.id)
                                                .contains(e.id)) {
                                              listLocationAddressSelected
                                                  .removeWhere(
                                                      (l) => l.id == e.id);
                                            } else {
                                              listLocationAddressSelected
                                                  .add(e);
                                            }
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    width: Get.width,
                                                    child: Text(
                                                      e.name ?? "",
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  if (listLocationAddressSelected
                                                      .map((e) => e.id)
                                                      .contains(e.id))
                                                    Positioned(
                                                        right: 10,
                                                        top: 10,
                                                        child: Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        ))
                                                ],
                                              ),
                                              Divider(
                                                height: 1,
                                              )
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Center(
                              child: Text(
                                "Đóng",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              callback(listLocationAddressSelected);
                            },
                            child: Center(
                              child: Text(
                                "Xác nhận",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
