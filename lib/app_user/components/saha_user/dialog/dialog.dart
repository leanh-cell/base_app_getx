import 'dart:io';
import 'dart:typed_data';

import 'package:com.ikitech.store/app_user/data/remote/response-request/order/calculate_fee_order_res.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/const/function_constant.dart';
import 'package:com.ikitech.store/app_user/model/decentralization.dart';
import 'package:com.ikitech.store/app_user/model/shipment.dart';
import 'package:com.ikitech.store/app_user/screen2/home/home_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/revenue_expanditure/revenue_expenditure_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/navigator/navigator_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/widget/map_button_function.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';
import 'package:reorderables/reorderables.dart';
import 'package:tiengviet/tiengviet.dart';
import '../../../data/remote/response-request/customer/all_group_customer_res.dart';
import '../../../data/repository/repository_manager.dart';
import '../../../model/agency_type.dart';
import '../../../model/branch.dart';
import '../../../model/location_address.dart';
import '../../../screen2/order/order_controller.dart';
import '../loading/loading_full_screen.dart';
import '../toast/saha_alert.dart';

class SahaDialogApp {
  static void showDialogAddressChoose({
    required Function callback,
    required Function accept,
    int? idProvince,
    int? idDistrict,
    bool? hideAll,
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
              height: Get.height / 1.5,
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
                              child: Column(children: [
                                if (hideAll != true)
                                  InkWell(
                                    onTap: () {
                                      callback(LocationAddress(name: "Tất cả"));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(
                                            'Tất cả',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                ...listLocationAddress
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
                              ]),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  static void showDialogImageTest(Uint8List bytes) {
    // flutter defined function
    showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thành công!"),
          content: Column(
            children: [Image.memory(bytes)],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogOneButton(
      {String? mess, bool barrierDismissible = true, Function? onClose}) {
    // flutter defined function
    showDialog(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thành công!"),
          content: new Text(
              mess == null ? "Gửi yêu cầu bài hát mới thành công!" : mess),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                onClose!();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogInputText({
    required String title,
    String? textInput,
    String? des,
    TextInputType? keyboardType,
    TextInputFormatter? formatter,
    bool? autoFocus,
    required String textButton,
    required Function onDone,
  }) {
    TextEditingController nameEditingController =
        TextEditingController(text: textInput);
    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              padding: EdgeInsets.all(10),
              child: TextField(
                autofocus: autoFocus ?? false,
                controller: nameEditingController,
                keyboardType: keyboardType ?? TextInputType.multiline,
                textInputAction: TextInputAction.done,
                style: TextStyle(fontSize: 14),
                inputFormatters: formatter == null ? null : [formatter],
                maxLines: 5,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: des,
                  contentPadding: EdgeInsets.only(left: 5),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
              ),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    onDone(nameEditingController.text);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      textButton,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }

  static void showDialogNotificationOneButton(
      {String? mess, bool barrierDismissible = true, Function? onClose}) {
    // flutter defined function
    showDialog(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thông báo!"),
          content: new Text(mess == null ? "Chú ý!" : mess),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                onClose!();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showDialogInput(
      {String? title,
      String? hintText,
      Function? onInput,
      TextInputType? textInputType,
      String? textInput,
      Function? onCancel}) {
    return showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) {
          TextEditingController textEditingController =
              new TextEditingController(text: textInput ?? '');
          return new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    autofocus: true,
                    controller: textEditingController,
                    keyboardType: textInputType ?? TextInputType.text,
                    decoration: new InputDecoration(
                      labelText: title ?? "",
                      hintText: hintText ?? "",
                      hintStyle: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new TextButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    if (onCancel != null) onCancel();
                    Get.back();
                  }),
              new TextButton(
                  child: const Text('Đồng ý'),
                  onPressed: () {
                    onInput!(textEditingController.text);
                  })
            ],
          );
        });
  }

  static void showDialogError(
      {required BuildContext context, String? errorMess}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Có lỗi xảy ra"),
          content: new Text(errorMess!),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogYesNo(
      {String? mess,
      bool barrierDismissible = true,
      Function? onClose,
      Function? onOK}) {
    // flutter defined function
    showDialog(
      barrierDismissible: barrierDismissible,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thông báo!"),
          content: new Text(mess == null ? "Chú ý!" : mess),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text(
                "Hủy",
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (onClose != null) {
                  onClose();
                }
              },
            ),
            new TextButton(
              child: new Text(
                "Đồng ý",
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onOK!();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDialogBranchOrder(
      {int? branchId, required Function callBack, List<Branch>? listBranch}) {
    SahaDataController sahaDataController = Get.find();
    var listBranchShow = listBranch ?? sahaDataController.listBranch;

    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chọn chi nhánh",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Expanded(
                child: Scrollbar(
                  //isAlwaysShown: true,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...listBranchShow
                            .map(
                              (branch) => Column(
                                children: [
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Text(
                                          "${branch.name ?? "branch no name"}",
                                        ),
                                        Spacer(),
                                        if (branch.isDefaultOrderOnline == true)
                                          Text(
                                            "(CN mặc định nhận hàng online)",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 12),
                                          ),
                                      ],
                                    ),
                                    onTap: () async {
                                      callBack(branch);
                                      Get.back();
                                    },
                                    trailing: branchId == branch.id
                                        ? Icon(
                                            Icons.check,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )
                                        : null,
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showDialogBranch() {
    SahaDataController sahaDataController = Get.find();
    HomeController homeController = Get.find();
    OrderController orderController = Get.find();
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chọn chi nhánh",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...sahaDataController.listBranch
                          .map(
                            (branch) => Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${branch.name ?? "branch no name"}",
                                        ),
                                      ),
                                      if (branch.isDefaultOrderOnline == true)
                                        Text(
                                          "(CN mặc định nhận hàng online)",
                                          style: TextStyle(
                                              color: Colors.blue, fontSize: 12),
                                        ),
                                    ],
                                  ),
                                  onTap: () async {
                                    sahaDataController.branchCurrent.value =
                                        branch;
                                    homeController.cartCurrent.value.id = 0;
                                    UserInfo()
                                        .setCurrentNameBranch(branch.name);
                                    await UserInfo()
                                        .setCurrentBranchId(branch.id);
                                    orderController
                                        .filterOrder.value.listBranch = [
                                      sahaDataController.branchCurrent.value
                                    ];
                                    homeController.refreshData();
                                    Get.back();
                                  },
                                  trailing: sahaDataController
                                              .branchCurrent.value.id ==
                                          branch.id
                                      ? Icon(
                                          Icons.check,
                                          color: Theme.of(context).primaryColor,
                                        )
                                      : null,
                                ),
                                Divider(
                                  height: 1,
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showDialogButtonHome() {
    NavigatorController navigatorController = Get.find();
    SahaDataController sahaDataController = Get.find();
    var listFunction = RxList<String>();
    var listMoreFunction = RxList<String>();
    var isEdit = false.obs;

    LIST_ALL_FUNCTION.forEach((e) {
      if (!UserInfo().getListFunctionHome()!.contains(e)) {
        listMoreFunction.add(e);
      }
    });

    listFunction(UserInfo().getListFunctionHome());

    void _onReorder(int oldIndex, int newIndex) {
      var pre = listFunction[oldIndex];
      listFunction.removeAt(oldIndex);
      listFunction.insert(newIndex, pre);
    }

    void addFunction(String function) {
      if (listFunction.length < 7) {
        listFunction.add(function);
        listMoreFunction.removeWhere((e) => e == function);
      }
    }

    void deleteFunction(String function) {
      listFunction.removeWhere((e) => e == function);
      listMoreFunction.add(function);
    }

    void save() {
      UserInfo().setListFunctionHome(listFunction);
      sahaDataController.isRefresh.refresh();
    }

    var wrap = Obx(() => SizedBox(
          width: Get.width,
          child: ReorderableWrap(
              alignment: WrapAlignment.start,
              maxMainAxisCount: 4,
              spacing: 0.0,
              runSpacing: 0.0,
              padding: const EdgeInsets.only(left: 10, right: 10),
              children: listFunction
                  .map(
                    (e) => SizedBox(
                      width: (Get.width - 20) / 4,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          IgnorePointer(
                            ignoring: isEdit.value,
                            child: MapButtonFunction(
                              typeFunction: e,
                            ),
                          ),
                          if (isEdit.value == true)
                            Positioned(
                              left: 12,
                              top: 5,
                              child: InkWell(
                                onTap: () {
                                  deleteFunction(e);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.red,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onReorder: _onReorder),
        ));

    var wrapUnder = Obx(() => Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          width: Get.width,
          child: Wrap(
            alignment: WrapAlignment.start,
            children: listMoreFunction
                .map(
                  (e) => SizedBox(
                    width: (Get.width - 20) / 4,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        IgnorePointer(
                          ignoring: isEdit.value,
                          child: MapButtonFunction(
                            typeFunction: e,
                          ),
                        ),
                        Positioned(
                          left: 12,
                          top: 5,
                          child: InkWell(
                            onTap: () {
                              print("aaaaa");
                              addFunction(e);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: Colors.blue),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ));

    var wrapAll = Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      width: Get.width,
      child: Wrap(alignment: WrapAlignment.start, children: [
        ...UserInfo()
            .getListFunctionHome()!
            .map(
              (e) => SizedBox(
                width: (Get.width - 20) / 4,
                child: MapButtonFunction(
                  typeFunction: e,
                ),
              ),
            )
            .toList(),
        ...listMoreFunction
            .map(
              (e) => SizedBox(
                width: (Get.width - 20) / 4,
                child: MapButtonFunction(
                  typeFunction: e,
                ),
              ),
            )
            .toList(),
      ]),
    );

    showModalBottomSheet(
        context: Get.context!,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        if (!isEdit.value) {
                          Get.back();
                        }
                        isEdit.value = false;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Huỷ"),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Phím tắt",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (isEdit.value) {
                          save();
                          Get.back();
                        }
                        isEdit.value = true;
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Obx(
                          () => Text(
                              "${isEdit.value == true ? "Lưu" : "Tuỳ chỉnh"}"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              SizedBox(
                height: 20,
              ),
              Obx(
                () => isEdit.value == true
                    ? Column(
                        children: [
                          wrap,
                          Divider(
                            height: 1,
                          ),
                          wrapUnder,
                        ],
                      )
                    : wrapAll,
              ),
            ],
          );
        });
  }

  static void showChooseRevenueExpenditure() {
    SahaDataController sahaDataController = Get.find();
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DecentralizationWidget(
                decent: sahaDataController
                        .badgeUser.value.decentralization?.addRevenue ??
                    false,
                child: ListTile(
                  leading: Icon(
                    Icons.monetization_on,
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Tạo phiếu thu',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    Get.back();
                    Get.to(() => RevenueExpenditureScreen(
                              isRevenue: true,
                            ))!
                        .then((value) => {});
                  },
                ),
              ),
              DecentralizationWidget(
                decent: sahaDataController
                        .badgeUser.value.decentralization?.addExpenditure ??
                    false,
                child: ListTile(
                  leading: Icon(Icons.monetization_on, color: Colors.red),
                  title: Text(
                    'Tạo phiếu chi',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Get.back();
                    Get.to(() => RevenueExpenditureScreen(
                              isRevenue: false,
                            ))!
                        .then((value) => {});
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showDialogDecent(
      {required List<Decentralization> listDecentralization,
      Decentralization? decentralizationInput,
      required Function onChoose}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chọn phân quyền",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...listDecentralization
                        .map(
                          (decent) => Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "${decent.name ?? "decent no name"}",
                                ),
                                onTap: () async {
                                  onChoose(decent);
                                  Get.back();
                                },
                                trailing: decent.id == decentralizationInput?.id
                                    ? Icon(
                                        Icons.check,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    : null,
                              ),
                              Divider(
                                height: 1,
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
            ],
          );
        });
  }

  static void showDialogSex({int? sex, required Function onChoose}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chọn giới tính",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      "Không xác định",
                    ),
                    onTap: () async {
                      onChoose(0);
                      Get.back();
                    },
                    trailing: sex == 0
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Nam",
                    ),
                    onTap: () async {
                      onChoose(1);
                      Get.back();
                    },
                    trailing: sex == 1
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Nữ",
                    ),
                    onTap: () async {
                      onChoose(2);
                      Get.back();
                    },
                    trailing: sex == 2
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showDialogGroupMarketingType(
      {int? groupType, required Function onChoose}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chọn nhóm áp dụng",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      "Tất cả",
                    ),
                    onTap: () async {
                      onChoose(0);
                      Get.back();
                    },
                    trailing: groupType == 0
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Cộng tác viên",
                    ),
                    onTap: () async {
                      onChoose(1);
                      Get.back();
                    },
                    trailing: groupType == 1
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Đại lý",
                    ),
                    onTap: () async {
                      onChoose(2);
                      Get.back();
                    },
                    trailing: groupType == 2
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Nhóm khách hàng",
                    ),
                    onTap: () async {
                      onChoose(4);
                      Get.back();
                    },
                    trailing: groupType == 4
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showDialogGroupMarketingTypev2(
      {List<int>? groupType, required Function onChoose}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chọn nhóm áp dụng",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      "Tất cả",
                    ),
                    onTap: () async {
                      onChoose(0);
                      Get.back();
                    },
                    trailing: (groupType ?? []).contains(0)
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Cộng tác viên",
                    ),
                    onTap: () async {
                      onChoose(1);
                      Get.back();
                    },
                    trailing: (groupType ?? []).contains(1)
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Đại lý",
                    ),
                    onTap: () async {
                      onChoose(2);
                      Get.back();
                    },
                    trailing: (groupType ?? []).contains(2)
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Nhóm khách hàng",
                    ),
                    onTap: () async {
                      onChoose(4);
                      Get.back();
                    },
                    trailing: (groupType ?? []).contains(4)
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                     ListTile(
                    title: Text(
                      "Khách lẻ đã đăng nhập",
                    ),
                    onTap: () async {
                      onChoose(5);
                      Get.back();
                    },
                    trailing: (groupType ?? []).contains(6)
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Khách lẻ chưa đăng nhập",
                    ),
                    onTap: () async {
                      onChoose(6);
                      Get.back();
                    },
                    trailing: (groupType ?? []).contains(6)
                        ? Icon(
                            Icons.check,
                            color: Theme.of(context).primaryColor,
                          )
                        : null,
                  ),
                  Divider(
                    height: 1,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showDialogAgencyType(
      {int? type,
      required Function onChoose,
      required List<AgencyType> listAgencyType}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chọn cấp đại lý",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...listAgencyType
                      .map((e) => Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "${e.name ?? ""}",
                                ),
                                onTap: () async {
                                  onChoose(e);
                                  Get.back();
                                },
                                trailing: type == e.id
                                    ? Icon(
                                        Icons.check,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    : null,
                              ),
                              Divider(
                                height: 1,
                              ),
                            ],
                          ))
                      .toList()
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showDialogAgencyTypev2(
      {List<int>? type,
      required Function onChoose,
      required List<AgencyType> listAgencyType}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chọn cấp đại lý",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...listAgencyType
                      .map((e) => Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "${e.name ?? ""}",
                                ),
                                onTap: () async {
                                  onChoose(e);
                                  Get.back();
                                },
                                trailing: (type ?? []).contains(e.id)
                                    ? Icon(
                                        Icons.check,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    : null,
                              ),
                              Divider(
                                height: 1,
                              ),
                            ],
                          ))
                      .toList()
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showDialogCustomerGroupType(
      {int? type,
      required Function onChoose,
      required List<GroupCustomer> listGroupCustomer}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chọn nhóm khách hàng",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...listGroupCustomer
                      .map((e) => Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "${e.name ?? ""}",
                                ),
                                onTap: () async {
                                  onChoose(e);
                                  Get.back();
                                },
                                trailing: type == e.id
                                    ? Icon(
                                        Icons.check,
                                        color: Theme.of(context).primaryColor,
                                      )
                                    : null,
                              ),
                              Divider(
                                height: 1,
                              ),
                            ],
                          ))
                      .toList()
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showDialogCustomerGroupTypev2(
      {List<int>? type,
      required Function onChoose,
      required List<GroupCustomer> listGroupCustomer}) {
    
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chọn nhóm khách hàng",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...listGroupCustomer
                          .map((e) => Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      "${e.name ?? ""}",
                                    ),
                                    onTap: () async {
                                      onChoose(e);
                                      Get.back();
                                    },
                                    trailing: (type ?? []).contains(e.id)
                                        ? Icon(
                                            Icons.check,
                                            color: Theme.of(context).primaryColor,
                                          )
                                        : null,
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                ],
                              ))
                          .toList()
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showDialogShipment(
      {required List<Shipment> list,
      required int shipmentCurrentId,
      required Function onTap}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chọn đơn vị vận chuyển",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...list
                      .map(
                        (shipment) => IgnorePointer(
                          ignoring: false,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      "${shipment.name ?? "no name"}",
                                    ),
                                    onTap: () async {
                                      onTap(shipment);
                                    },
                                    trailing: shipmentCurrentId ==
                                            shipment.shipperConfig?.partnerId
                                        ? Icon(
                                            Icons.check,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )
                                        : null,
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                ],
                              ),
                              if (shipment.shipperConfig?.use == false)
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.white.withOpacity(0.5),
                                    child: Center(
                                        child: Text(
                                      "Đã tắt",
                                      style: TextStyle(color: Colors.red),
                                    )),
                                  ),
                                )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }

  static void showDialogSuggestion(
      {required String title, required Widget contentWidget}) {
    // flutter defined function
    showDialog(
      barrierDismissible: true,
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          contentPadding:
              EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 0),
          alignment: Alignment.center,
          content: contentWidget,
          titlePadding: EdgeInsets.only(bottom: 10, top: 20),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding: EdgeInsets.all(0),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: new Text("Tôi đã hiểu"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static void showDialogServiceType({required Function onChoose}) {
    showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Loại phần thưởng",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      "Thưởng xu",
                    ),
                    // subtitle: Text(
                    //   'Dịch vụ có chỉ số đầu cuối (Điện, nước...)',
                    //   style: TextStyle(fontSize: 12),
                    // ),
                    onTap: () async {
                      onChoose(
                        0,
                        "Thưởng xu",
                      );
                      Get.back();
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Quà trong hệ thống",
                    ),
                    subtitle: Text(
                      'Là một sản phẩm trong hệ thống',
                      style: TextStyle(fontSize: 12),
                    ),
                    onTap: () async {
                      onChoose(
                        1,
                        "Quà trong hệ thống",
                      );
                      Get.back();
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    title: Text(
                      "Quà khác",
                    ),
                    subtitle: Text(
                      'Bạn có thể tự thiết lập một món quà',
                      style: TextStyle(fontSize: 12),
                    ),
                    onTap: () async {
                      onChoose(
                        2,
                        "Quà khác",
                      );
                      Get.back();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }
}
