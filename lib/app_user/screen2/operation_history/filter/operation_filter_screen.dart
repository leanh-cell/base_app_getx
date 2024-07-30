import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../saha_data_controller.dart';
import '../../../components/saha_user/button/saha_button.dart';
import '../../../const/const_operation_history.dart';
import '../../../model/branch.dart';
import '../../../model/operation_filter.dart';
import '../../../model/staff.dart';
import 'operation_filter_controller.dart';

class OperationFilterScreen extends StatelessWidget {
  OperationFilter? operationFilterInput;
  Function callback;
  OperationFilterScreen({required this.callback, this.operationFilterInput}) {
    controller =
        OperationFilterController(operationFilterInput: operationFilterInput);
  }

  late OperationFilterController controller;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Lọc"),
      ),
      body: Obx(
        () => Column(
          children: [
            InkWell(
              onTap: () {
                showDialogStaff(
                    staffIdInput: controller.operationFilter.value.staffId,
                    onChoose: (Staff? v) {
                      controller.operationFilter.value.staffId = v?.id;
                      controller.operationFilter.value.staffName = v?.name;
                      controller.operationFilter.refresh();
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text('Nhân viên:'),
                    Expanded(
                        child: Text(
                      "${controller.operationFilter.value.staffName ?? "Tất cả"}",
                      textAlign: TextAlign.end,
                    )),
                    Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {
                showDialogTypeFunction(
                    typeInput: controller.operationFilter.value.functionType,
                    onChoose: (v) {
                      controller.operationFilter.value.functionType = v;
                      controller.operationFilter.refresh();
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text('Chức năng:'),
                    Expanded(
                        child: Text(
                      getFunction(
                          controller.operationFilter.value.functionType ?? ""),
                      textAlign: TextAlign.end,
                    )),
                    Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {
                showDialogTypeAction(
                    typeInput: controller.operationFilter.value.actionType,
                    onChoose: (v) {
                      controller.operationFilter.value.actionType = v;
                      controller.operationFilter.refresh();
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text('Thao tác:'),
                    Expanded(
                        child: Text(
                      getAction(
                          controller.operationFilter.value.actionType ?? ""),
                      textAlign: TextAlign.end,
                    )),
                    Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {
                showDialogBranch(
                  branchInput: controller.operationFilter.value.branch,
                  callback: (v) {
                    controller.operationFilter.value.branch = v;
                    controller.operationFilter.refresh();
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text('Chi nhánh:'),
                    Expanded(
                        child: Text(
                      controller.operationFilter.value.branch?.name ?? 'Tất cả',
                      textAlign: TextAlign.end,
                    )),
                    Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Đồng ý",
              onPressed: () {
                callback(controller.operationFilter.value);
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }

  String getAction(String text) {
    if (text == OPERATION_ACTION_ADD) return "Thêm";
    if (text == OPERATION_ACTION_DELETE) return "Xoá";
    if (text == OPERATION_ACTION_UPDATE) return "Cập nhật";
    if (text == OPERATION_ACTION_CANCEL) return "Huỷ";
    return 'Tất cả';
  }

  String getFunction(String text) {
    if (text == FUNCTION_TYPE_PRODUCT) return "Sản phẩm";
    if (text == FUNCTION_TYPE_INVENTORY) return "Kho";
    if (text == FUNCTION_TYPE_CATEGORY_PRODUCT) return "Danh mục sản phẩm";
    if (text == FUNCTION_TYPE_CATEGORY_POST) return "Danh mục tin tức";
    if (text == FUNCTION_TYPE_ORDER) return "Đơn hàng";
    if (text == FUNCTION_TYPE_THEME) return "Giao diện";
    if (text == FUNCTION_TYPE_PROMOTION) return "Khuyến mãi";
    return 'Tất cả';
  }

  void showDialogTypeFunction({String? typeInput, required Function onChoose}) {
    List<String> listType = [
      FUNCTION_TYPE_PRODUCT, // Tổng mua (Chỉ đơn hoàn thành trừ trả hàng),
      FUNCTION_TYPE_INVENTORY, // Tổng mua (Tất cả trạng thái đơn trừ trả hàng),
      FUNCTION_TYPE_CATEGORY_PRODUCT, // Xu hiện tại,
      FUNCTION_TYPE_CATEGORY_POST, // Số lần mua hàng
      FUNCTION_TYPE_ORDER, // tháng sinh nhật
      FUNCTION_TYPE_THEME, // tuổi
      FUNCTION_TYPE_PROMOTION, // giới tính,
    ];

    Widget itemType(String type) {
      return Column(
        children: [
          ListTile(
            title: Text(
              getFunction(type),
            ),
            onTap: () async {
              onChoose(type);
              Get.back();
            },
            trailing: typeInput == type
                ? Icon(
                    Icons.check,
                    color: Theme.of(Get.context!).primaryColor,
                  )
                : null,
          ),
          Divider(
            height: 1,
          ),
        ],
      );
    }

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
                    "Chọn chức năng",
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
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ListTile(
                          title: Text(
                            "Tất cả",
                          ),
                          onTap: () async {
                            onChoose("");
                            Get.back();
                          },
                          trailing: typeInput == null
                              ? Icon(
                                  Icons.check,
                                  color: Theme.of(Get.context!).primaryColor,
                                )
                              : null,
                        ),
                        Divider(
                          height: 1,
                        ),
                        ...listType.map((e) => itemType(e)).toList(),
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

  void showDialogTypeAction({String? typeInput, required Function onChoose}) {
    List<String> listType = [
      OPERATION_ACTION_ADD, // Tổng mua (Chỉ đơn hoàn thành trừ trả hàng),
      OPERATION_ACTION_DELETE, // Tổng mua (Tất cả trạng thái đơn trừ trả hàng),
      OPERATION_ACTION_UPDATE, // Xu hiện tại,
      OPERATION_ACTION_CANCEL, // Số lần mua hàng
    ];

    Widget itemType(String type) {
      return Column(
        children: [
          ListTile(
            title: Text(
              getAction(type),
            ),
            onTap: () async {
              onChoose(type);
              Get.back();
            },
            trailing: typeInput == type
                ? Icon(
                    Icons.check,
                    color: Theme.of(Get.context!).primaryColor,
                  )
                : null,
          ),
          Divider(
            height: 1,
          ),
        ],
      );
    }

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
                    "Chọn thao tác",
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
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ListTile(
                          title: Text("Tất cả"),
                          onTap: () async {
                            onChoose("");
                            Get.back();
                          },
                          trailing: typeInput == ""
                              ? Icon(
                                  Icons.check,
                                  color: Theme.of(Get.context!).primaryColor,
                                )
                              : null,
                        ),
                        Divider(
                          height: 1,
                        ),
                        ...listType.map((e) => itemType(e)).toList(),
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

  void showDialogStaff({int? staffIdInput, required Function onChoose}) {
    Widget itemType(Staff staff) {
      return Column(
        children: [
          ListTile(
            title: Text(staff.name ?? ''),
            onTap: () async {
              onChoose(staff);
              Get.back();
            },
            trailing: staffIdInput == staff.id
                ? Icon(
                    Icons.check,
                    color: Theme.of(Get.context!).primaryColor,
                  )
                : null,
          ),
          Divider(
            height: 1,
          ),
        ],
      );
    }

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
                    "Chọn nhân viên",
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
                 // isAlwaysShown: true,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ListTile(
                          title: Text('Tất cả'),
                          onTap: () async {
                            onChoose(null);
                            Get.back();
                          },
                          trailing: staffIdInput == null
                              ? Icon(
                                  Icons.check,
                                  color: Theme.of(Get.context!).primaryColor,
                                )
                              : null,
                        ),
                        Divider(
                          height: 1,
                        ),
                        ...controller.listStaff
                            .map((e) => itemType(e))
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

  void showDialogBranch({required Function callback, Branch? branchInput}) {
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
                      ListTile(
                        title: Text(
                          "Tất cả",
                        ),
                        onTap: () async {
                          callback("");
                          Get.back();
                        },
                        trailing: branchInput == null
                            ? Icon(
                                Icons.check,
                                color: Theme.of(Get.context!).primaryColor,
                              )
                            : null,
                      ),
                      Divider(
                        height: 1,
                      ),
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
                                    callback(branch);
                                    Get.back();
                                  },
                                  trailing: branchInput?.id == branch.id
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
}
