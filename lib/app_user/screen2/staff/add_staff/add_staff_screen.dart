import 'package:direct_select_flutter/direct_select_container.dart';
import 'package:direct_select_flutter/direct_select_item.dart';
import 'package:direct_select_flutter/direct_select_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:com.ikitech.store/app_user/screen2/config/time_keeping/approve/device_approve/device_approve_screen.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:com.ikitech.store/app_user/utils/user_info.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'add_staff_controller.dart';

class AddStaffScreen extends StatefulWidget {
  Staff? staffInput;

  AddStaffScreen({this.staffInput}) {
    addStaffController = AddStaffController(staffInput: staffInput);
  }

  late AddStaffController addStaffController;

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late TextEditingController nameEditController;
  late TextEditingController userNameEditController;
  late TextEditingController passEditController;
  late TextEditingController phoneEditController;
  late TextEditingController addressEditController;
  late TextEditingController emailEditController;
  late TextEditingController salaryEditController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameEditController = TextEditingController(
        text:
            "${widget.staffInput != null ? "${widget.staffInput!.name}" : ""}");

    userNameEditController = TextEditingController(
        text:
            "${widget.staffInput != null ? "${widget.staffInput!.username!.replaceAll("${UserInfo().getCurrentStoreCode()}_", "")}" : ""}");
    passEditController = TextEditingController(text: "");
    phoneEditController = TextEditingController(
        text:
            "${widget.staffInput != null ? "${widget.staffInput!.phoneNumber}" : ""}");
    addressEditController = TextEditingController(
        text:
            "${widget.staffInput != null ? "${widget.staffInput!.address ?? ""}" : ""}");
    emailEditController = TextEditingController(
        text:
            "${widget.staffInput != null ? "${widget.staffInput!.email ?? ""}" : ""}");
    salaryEditController = TextEditingController(
        text:
            "${widget.staffInput != null ? "${SahaStringUtils().convertToUnit(widget.staffInput!.salaryOneHour ?? 0)}" : ""}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
              "${widget.staffInput != null ? "Sửa thông tin NV" : "Thêm nhân viên"}"),
          actions: [
            IconButton(
                onPressed: () {
                  SahaDialogApp.showDialogYesNo(
                      mess: "Bạn có chắc muốn xoá nhân viên này chứ ?",
                      onOK: () {
                        widget.addStaffController
                            .deleteStaff(widget.staffInput!.id!);
                      });
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ))
          ],
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tên nhân viên: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Container(
                        width: Get.width,
                        child: TextFormField(
                          controller: nameEditController,
                          validator: (value) {
                            if (value!.length < 1) {
                              return 'Chưa nhập tên nhân viên';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            widget.addStaffController.staff.value.name = v;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Nhập tên nhân viên",
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
                        "Mã nhân viên (Tên đăng nhập): ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Container(
                        width: Get.width,
                        child: TextFormField(
                          controller: userNameEditController,
                          validator: (value) {
                            if (value!.length < 1) {
                              return 'Chưa nhập tên đăng nhập';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            widget.addStaffController.staff.value.username =
                                '${UserInfo().getCurrentStoreCode()}_$v';
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            prefixText: "${UserInfo().getCurrentStoreCode()}_",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mật khẩu: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          if (widget.staffInput != null)
                            Obx(
                              () => InkWell(
                                onTap: () {
                                  widget.addStaffController.stateResetPassword
                                          .value =
                                      !widget.addStaffController
                                          .stateResetPassword.value;
                                  setState(() {});
                                },
                                child: Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: widget
                                                      .addStaffController
                                                      .stateResetPassword
                                                      .value ==
                                                  true
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: Text(
                                      "Lấy lại mật khẩu",
                                      style: TextStyle(
                                          color: widget
                                                      .addStaffController
                                                      .stateResetPassword
                                                      .value ==
                                                  true
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey),
                                    )),
                              ),
                            )
                        ],
                      ),
                      if (widget.staffInput == null ||
                          (widget.staffInput != null &&
                              widget.addStaffController.stateResetPassword
                                      .value ==
                                  true))
                        Container(
                          width: Get.width,
                          child: TextFormField(
                            controller: passEditController,
                            validator: (value) {
                              if (value!.length < 6) {
                                return 'Mật khẩu lớn hơn 6 kí tự';
                              }
                              return null;
                            },
                            onChanged: (v) {
                              widget.addStaffController.staff.value.password =
                                  v;
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: "Mật khẩu lớn hơn 6 kí tự",
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
                        "Số điện thoại: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Container(
                        width: Get.width,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: phoneEditController,
                          validator: (value) {
                            if (value!.length < 10) {
                              return 'Số điện thoại không hợp lệ';
                            }
                            return null;
                          },
                          onChanged: (v) {
                            widget.addStaffController.staff.value.phoneNumber =
                                v;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Nhập số điện thoại",
                          ),
                          style: TextStyle(fontSize: 14),
                          minLines: 1,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.staffInput != null)
                  InkWell(
                    onTap: () {
                      Get.to(() => DeviceApproveScreen(
                            staff: widget.staffInput!,
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Thiết bị chấm công",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Phân quyền:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SahaDialogApp.showDialogDecent(
                            listDecentralization:
                                widget.addStaffController.listDecentralization,
                            decentralizationInput: widget.addStaffController
                                .staff.value.decentralization,
                            onChoose: (decent) {
                              widget.addStaffController.staff.value
                                  .decentralization = decent;
                              widget.addStaffController.staff.refresh();
                            });
                      },
                      child: Container(
                        height: 50,
                        width: Get.width,
                        child: Card(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(
                                      () => Text(
                                        "   ${widget.addStaffController.staff.value.decentralization?.name ?? "chọn phân quyền"}",
                                        style: TextStyle(
                                          color: widget
                                                      .addStaffController
                                                      .staff
                                                      .value
                                                      .decentralization
                                                      ?.name !=
                                                  null
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Địa chỉ: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Container(
                        width: Get.width,
                        child: TextFormField(
                          controller: addressEditController,
                          onChanged: (v) {
                            widget.addStaffController.staff.value.address = v;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Nhập địa chỉ (có thể bỏ qua)",
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
                        "Email: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Container(
                        width: Get.width,
                        child: TextFormField(
                          controller: emailEditController,
                          onChanged: (v) {},
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Nhập email (có thể bỏ qua)",
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
                        "Lương theo giờ: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Container(
                        width: Get.width,
                        child: TextFormField(
                          controller: salaryEditController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [ThousandsFormatter()],
                          onChanged: (v) {
                            widget.addStaffController.staff.value
                                    .salaryOneHour =
                                double.parse(
                                    SahaStringUtils().convertFormatText(v));
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            suffixText: "VNĐ/h",
                            hintText: "Nhập lương theo giờ: (Có thể bỏ qua)",
                          ),
                          style: TextStyle(fontSize: 14),
                          minLines: 1,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Giới tính:",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SahaDialogApp.showDialogSex(
                            sex: widget.addStaffController.staff.value.sex ?? 0,
                            onChoose: (sex) {
                              widget.addStaffController.staff.value.sex = sex;
                              widget.addStaffController.staff.refresh();
                            });
                      },
                      child: Container(
                        height: 50,
                        width: Get.width,
                        child: Card(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(
                                      () => Text(
                                        "   ${getSexName(widget.addStaffController.staff.value.sex ?? 0)}",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                  text: "Xác nhận",
                  onPressed: widget.addStaffController.isLoading.value
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.staffInput != null) {
                              widget.addStaffController.updateStaff();
                            } else {
                              widget.addStaffController.addStaff();
                            }
                          }
                        },
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getSexName(int sex) {
    if (sex == 0) {
      return "Không xác định";
    }
    if (sex == 1) {
      return "Nam";
    }
    if (sex == 2) {
      return "Nữ";
    }
    return "";
  }
}
