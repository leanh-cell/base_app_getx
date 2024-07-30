import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/model/decentralization.dart';
import 'add_decentralization_controller.dart';

class AddDecentralizationScreen extends StatelessWidget {
  final Decentralization? decentralizationInput;

  AddDecentralizationScreen({this.decentralizationInput}) {
    if (decentralizationInput != null) {
      nameEditingController =
          TextEditingController(text: decentralizationInput!.name);
      desEditingController =
          TextEditingController(text: decentralizationInput!.description);
    }
    addDecentralizationController = AddDecentralizationController(
        decentralizationInput: decentralizationInput);
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController desEditingController = TextEditingController();
  late AddDecentralizationController addDecentralizationController;
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${decentralizationInput != null ? "Sửa phân quyền" : "Thêm phân quyền"}"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Obx(
            () => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tên phân quyền: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Container(
                        width: Get.width,
                        child: TextFormField(
                          controller: nameEditingController,
                          validator: (value) {
                            if (value!.length < 1) {
                              return 'Chưa nhập tên phân quyền';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            addDecentralizationController
                                .decentralization.value.name = v;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Nhập tên phân quyền",
                          ),
                          style: TextStyle(fontSize: 14),
                          minLines: 1,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mô tả phân quyền: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Container(
                        width: Get.width,
                        child: TextFormField(
                          controller: desEditingController,
                          validator: (value) {
                            if (value!.length < 1) {
                              return 'Chưa nhập mô tả phân quyền';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            addDecentralizationController
                                .decentralization.value.description = v;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Nhập mô tả phân quyền",
                          ),
                          style: TextStyle(fontSize: 14),
                          minLines: 1,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                ExpansionTile(
                  title: const Text('Thông tin hệ thống'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thông tin cửa hàng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.storeInfo ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .storeInfo = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tin tức bài viết"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.postList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .postList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thông báo tới cửa hàng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .notificationToStote ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .notificationToStote = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cài đặt chấm công"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.timekeeping ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .timekeeping = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Đào tạo"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.train ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization.value.train = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Quản lý sản phẩm'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Danh sách sản phẩm"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.productList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("In mã vạch"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .barcodePrint ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .barcodePrint = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thêm sản phẩm mới"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.productAdd ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productAdd = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cập nhật"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .productUpdate ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productUpdate = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sao chép"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.productCopy ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productCopy = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Xoá"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .productRemoveHide ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productRemoveHide = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Lấy sản phẩm sàn TMĐT"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .productEcommerce ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productEcommerce = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cài đặt hoa hồng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .productCommission ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productCommission = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Xuất file Excel"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .productExportToExcel ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productExportToExcel = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Nhập file Excel"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .productImportFromExcel ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productImportFromExcel = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Danh mục sản phẩm'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Danh sách danh mục"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .productCategoryList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productCategoryList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thêm mới"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .productCategoryAdd ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productCategoryAdd = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cập nhật"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .productCategoryUpdate ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productCategoryUpdate = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Xoá"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .productCategoryRemove ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productCategoryRemove = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Thuộc tính sản phẩm'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Danh sách thuộc tính sản phẩm"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .productAttributeList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productAttributeList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thêm mới"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .productAttributeAdd ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productAttributeAdd = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cập nhật"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .productAttributeUpdate ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productAttributeUpdate = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Xoá"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .productAttributeRemove ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .productAttributeRemove = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Đơn hàng'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Bán hàng tại quầy"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .createOrderPos ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .createOrderPos = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Xem hoá đơn"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.orderList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .orderList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thay đổi trạng thái đơn hàng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .orderAllowChangeStatus ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .orderAllowChangeStatus = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Xuất file excel"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .orderExportToExcel ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .orderExportToExcel = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Chỉnh sửa giá sảm phẩm tại quầy"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .changePricePos ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .changePricePos = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                     Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Chỉnh sửa chiết khấu tại quầy"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .changeDiscountPos ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .changeDiscountPos = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Quản lý kho'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Nhập hàng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .inventoryImport ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .inventoryImport = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Kiểm kho"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .inventoryTallySheet ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .inventoryTallySheet = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Chuyển kho"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .transferStock ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .transferStock = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Kho hàng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .inventoryList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .inventoryList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Nhà cung cấp"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.supplier ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .supplier = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Báo cáo'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Báo cáo bán hàng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .reportOverview ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .reportOverview = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Báo cáo kho"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .reportInventory ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .reportInventory = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Báo cáo tài chính"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .reportFinance ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .reportFinance = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Khách hàng/Đối tác'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Danh sách khách hàng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .customerList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .customerList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cài đặt Xu KH"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .customerConfigPoint ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .customerConfigPoint = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Chat với khách hàng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.chatList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .chatList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Nhóm khách hàng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .groupCustomer ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .groupCustomer = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Chỉnh sửa vai trò"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .customerRoleEdit ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .customerRoleEdit = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Cộng tác viên'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Danh sách cộng tác viên"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .collaboratorList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .collaboratorList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thay đổi số dư CTV"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .collaboratorAddSubBalance ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .collaboratorAddSubBalance = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cấu hình CTV"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .collaboratorConfig ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .collaboratorConfig = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Yêu cầu làm CTV"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .collaboratorRegister ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .collaboratorRegister = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Top doanh số"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .collaboratorTopSale ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .collaboratorTopSale = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Danh sách yêu cầu thanh toán"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .collaboratorPaymentRequestList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .collaboratorPaymentRequestList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Lịch sử thanh toán"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .collaboratorPaymentRequestHistory ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                            .decentralization
                                            .value
                                            .collaboratorPaymentRequestHistory =
                                        value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Đại lý'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Danh sách đại lý"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.agencyList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .agencyList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thay đổi số dư đại lý"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .agencyAddSubBalance ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .agencyAddSubBalance = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cấu hình đại lý"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .agencyConfig ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .agencyConfig = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Yêu cầu làm đại lý"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .agencyRegister ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .agencyRegister = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Top nhập hàng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .agencyTopImport ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .agencyTopImport = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Chương trình thưởng đại lý"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .agencyBonusProgram ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .agencyBonusProgram = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Top hoa hồng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .agencyTopCommission ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .agencyTopCommission = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Danh sách yêu cầu thanh toán"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .agencyPaymentRequestList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .agencyPaymentRequestList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Lích sử thanh toán"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .agencyPaymentRequestHistory ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .agencyPaymentRequestHistory = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Chỉnh sửa cấp đại lý"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .agencyChangeLevel ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .agencyChangeLevel = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Sale'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sale"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.saleList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .saleList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cấu hình sale"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.saleConfig ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .saleConfig = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Top sale"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.saleTop ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization.value.saleTop = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                // ExpansionTile(
                //   title: const Text('Onsale'),
                //   children: <Widget>[
                //     Column(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Row(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text("Danh sách onsale"),
                //               CupertinoSwitch(
                //                   value: addDecentralizationController
                //                           .decentralization.value.onsaleList ??
                //                       false,
                //                   onChanged: (bool value) {
                //                     addDecentralizationController
                //                         .decentralization
                //                         .value
                //                         .onsaleList = value;
                //                     addDecentralizationController
                //                         .decentralization
                //                         .refresh();
                //                   }),
                //             ],
                //           ),
                //         ),
                //         Divider(
                //           height: 1,
                //         ),
                //       ],
                //     ),
                //     Column(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Row(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text("Thêm khách hàng onsale"),
                //               CupertinoSwitch(
                //                   value: addDecentralizationController
                //                           .decentralization.value.onsaleAdd ??
                //                       false,
                //                   onChanged: (bool value) {
                //                     addDecentralizationController
                //                         .decentralization
                //                         .value
                //                         .onsaleAdd = value;
                //                     addDecentralizationController
                //                         .decentralization
                //                         .refresh();
                //                   }),
                //             ],
                //           ),
                //         ),
                //         Divider(
                //           height: 1,
                //         ),
                //       ],
                //     ),
                //     Column(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Row(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text("Cập nhật khách hàng onsale"),
                //               CupertinoSwitch(
                //                   value: addDecentralizationController
                //                           .decentralization.value.onsaleEdit ??
                //                       false,
                //                   onChanged: (bool value) {
                //                     addDecentralizationController
                //                         .decentralization
                //                         .value
                //                         .onsaleEdit = value;
                //                     addDecentralizationController
                //                         .decentralization
                //                         .refresh();
                //                   }),
                //             ],
                //           ),
                //         ),
                //         Divider(
                //           height: 1,
                //         ),
                //       ],
                //     ),
                //     Column(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Row(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text("Xoá onsale"),
                //               CupertinoSwitch(
                //                   value: addDecentralizationController
                //                           .decentralization
                //                           .value
                //                           .onsaleRemove ??
                //                       false,
                //                   onChanged: (bool value) {
                //                     addDecentralizationController
                //                         .decentralization
                //                         .value
                //                         .onsaleRemove = value;
                //                     addDecentralizationController
                //                         .decentralization
                //                         .refresh();
                //                   }),
                //             ],
                //           ),
                //         ),
                //         Divider(
                //           height: 1,
                //         ),
                //       ],
                //     ),
                //     Column(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Row(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text("Gán onsale cho nhân viên"),
                //               CupertinoSwitch(
                //                   value: addDecentralizationController
                //                           .decentralization
                //                           .value
                //                           .onsaleAssignment ??
                //                       false,
                //                   onChanged: (bool value) {
                //                     addDecentralizationController
                //                         .decentralization
                //                         .value
                //                         .onsaleAssignment = value;
                //                     addDecentralizationController
                //                         .decentralization
                //                         .refresh();
                //                   }),
                //             ],
                //           ),
                //         ),
                //         Divider(
                //           height: 1,
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
                
                
                ExpansionTile(
                  title: const Text('Cài đặt'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Quản lý nhân viên"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.staffList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .staffList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Chi nhánh"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.branchList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .branchList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Phân quyền"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .decentralizationList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .decentralizationList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cài đặt chung"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .configSetting ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .configSetting = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cài đặt SMS"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.configSms ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .configSms = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cài đặt mẫu in"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .invoiceTemplate ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .invoiceTemplate = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cài đặt quảng cáo"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.bannerAds ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .bannerAds = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Giao diện khách hàng'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Màn hình trang chủ"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .webThemeEdit ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .webThemeEdit = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tổng quan"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .webThemeOverview ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .webThemeOverview = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Liên hệ"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .webThemeContact ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .webThemeContact = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Hỗ trợ"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .webThemeHelp ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .webThemeHelp = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Chân trang"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .webThemeFooter ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .webThemeFooter = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Banners"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .webThemeBanner ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .webThemeBanner = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("SEO"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.webThemeSeo ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .webThemeSeo = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Khác'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Vận chuyển"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .deliveryPickAddressList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .deliveryPickAddressList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thanh toán"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.paymentList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .paymentList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Lên lịch thông báo"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .notificationScheduleList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .notificationScheduleList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Đánh giá khách hàng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .customerReviewList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .customerReviewList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Cài đặt game"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .gamification ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .gamification = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Lịch sử thao tác"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .historyOperation ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .historyOperation = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Chương trình khuyến mãi'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Giảm giá sản phẩm"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .promotionDiscountList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .promotionDiscountList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Voucher giảm giá"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .promotionVoucherList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .promotionVoucherList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Combo giảm giá"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .promotionComboList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .promotionComboList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thưởng sản phẩm"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .promotionBonusProductList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .promotionBonusProductList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Kế toán'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thu chi"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .revenueExpenditure ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .revenueExpenditure = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Bảng công"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .accountantTimeSheet ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .accountantTimeSheet = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Cộng đồng'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Xem danh sách tin đăng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .communicationList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .communicationList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Chỉnh sửa bài đăng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .communicationUpdate ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .communicationUpdate = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Xoá bài đăng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .communicationDelete ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .communicationDelete = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Xoá bài đăng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .communicationDelete ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .communicationDelete = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Đăng lại bài đăng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .communicationAdd ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .communicationAdd = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Duyệt bài đăng"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .communicationApprove ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .communicationApprove = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Đào tạo'),
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Xem danh sách khoá học"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.train ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization.value.train = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thêm khoá học"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.trainAdd ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .trainAdd = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Chỉnh sửa khoá học"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization.value.trainUpdate ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .trainUpdate = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Xem danh sách bài thi"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .trainExamList ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .trainExamList = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Thêm bài thi"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .trainExamAdd ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .trainExamAdd = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sửa bài thi"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .trainExamUpdate ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .trainExamUpdate = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Xoá bài thi"),
                              CupertinoSwitch(
                                  value: addDecentralizationController
                                          .decentralization
                                          .value
                                          .trainExamDelete ??
                                      false,
                                  onChanged: (bool value) {
                                    addDecentralizationController
                                        .decentralization
                                        .value
                                        .trainExamDelete = value;
                                    addDecentralizationController
                                        .decentralization
                                        .refresh();
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tạo khoản thu"),
                          CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.addRevenue ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController
                                    .decentralization.value.addRevenue = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tạo khoản chi"),
                          CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.addExpenditure ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.addExpenditure = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Cài đặt máy in"),
                          CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.settingPrint ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.settingPrint = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Chương trình KM"),
                          CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization.value.promotion ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController
                                    .decentralization.value.promotion = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giao diện khách hàng app"),
                          CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization
                                      .value
                                      .appThemeMainConfig ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.appThemeMainConfig = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
                  Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giao diện khách hàng app"),
                          CupertinoSwitch(
                              value: addDecentralizationController
                                      .decentralization
                                      .value
                                      .appThemeMainConfig ??
                                  false,
                              onChanged: (bool value) {
                                addDecentralizationController.decentralization
                                    .value.appThemeMainConfig = value;
                                addDecentralizationController.decentralization
                                    .refresh();
                              }),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
                // Column(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text("Truy cập onsale"),
                //           CupertinoSwitch(
                //               value: addDecentralizationController
                //                       .decentralization.value.onsale ??
                //                   false,
                //               onChanged: (bool value) {
                //                 addDecentralizationController
                //                     .decentralization.value.onsale = value;
                //                 addDecentralizationController.decentralization
                //                     .refresh();
                //               }),
                //         ],
                //       ),
                //     ),
                //     Divider(
                //       height: 1,
                //     ),
                //   ],
                // ),
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
            SahaButtonFullParent(
              text: "Xác nhận",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (decentralizationInput != null) {
                    addDecentralizationController.updateDecentralization();
                  } else {
                    addDecentralizationController.addDecentralization();
                  }
                } else {
                  _scrollController.animateTo(0,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.linear);
                }
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
