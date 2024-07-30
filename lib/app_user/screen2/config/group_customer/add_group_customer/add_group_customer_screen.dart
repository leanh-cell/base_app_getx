import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/customer/all_group_customer_res.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../components/saha_user/button/saha_button.dart';
import '../../../../const/const_type_compare.dart';
import '../../../../model/location_address.dart';
import 'add_group_customer_controller.dart';
import 'choose_customer/choose_customer_screen.dart';

class AddGroupCustomerScreen extends StatelessWidget {
  GroupCustomer? groupCustomerInput;

  AddGroupCustomerScreen({this.groupCustomerInput}) {
    controller =
        AddGroupCustomerController(groupCustomerInput: groupCustomerInput);
  }

  late AddGroupCustomerController controller;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(groupCustomerInput == null
              ? 'Thêm nhóm khách hàng'
              : "Cập nhật nhóm khách hàng"),
        ),
        body: Form(
          key: _formKey,
          child: Obx(
            () => controller.loadInit.value
                ? SahaLoadingFullScreen()
                : SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tên nhóm"),
                              Expanded(
                                child: TextFormField(
                                  controller: controller.nameEdit,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Không được để trống';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.end,
                                  onChanged: (v) {
                                    controller.groupCustomerRq.value.name = v;
                                  },
                                  decoration: InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: "Nhập Tên nhóm"),
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
                        if(groupCustomerInput !=null)
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Số lượng khách hàng"),
                              Text("${groupCustomerInput?.count ?? 0}")
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
                              Text("Ghi chú"),
                              Expanded(
                                child: TextFormField(
                                  controller: controller.noteEdit,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.end,
                                  onChanged: (v) {
                                    controller.groupCustomerRq.value.note = v;
                                  },
                                  decoration: InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: "Nhập ghi chú"),
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
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text('Chọn từ danh sách khác hàng'),
                                Spacer(),
                                Checkbox(
                                    value: controller.isSelectCustomer.value ==
                                        true,
                                    onChanged: (v) {
                                      controller.isSelectCustomer.value = v!;
                                      if (v == true) {
                                        controller.groupCustomerRq.value
                                            .groupType = 1;
                                        // controller.groupCustomerRq.value
                                        //     .conditionItems = [];
                                        controller.groupCustomerRq.refresh();
                                      } else {
                                        controller.groupCustomerRq.value
                                            .groupType = 0;
                                        // controller.groupCustomerRq.value
                                        //     .customerIds = null;
                                        // controller.listCustomerChoose.value =
                                        //     [];
                                      }
                                    })
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        Obx(
                          () => controller.isSelectCustomer.value
                              ? Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Chọn khách hàng'),
                                          Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                Get.to(() =>
                                                    ChooseCustomerScreen(
                                                      listCustomerInput:
                                                          controller
                                                              .listCustomerChoose,
                                                      onChooseCustomer: (v) {
                                                        controller
                                                            .listCustomerChoose
                                                            .value = v;
                                                        controller
                                                                .groupCustomerRq
                                                                .value
                                                                .customerIds =
                                                            controller
                                                                .listCustomerChoose
                                                                .map((e) =>
                                                                    e.id!)
                                                                .toList();
                                                      },
                                                    ));
                                              },
                                              icon: Icon(
                                                  Icons.keyboard_arrow_right)),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ...controller.listCustomerChoose
                                              .map((e) => Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('- ${e.name ?? ''}'),
                                                      Text(e.phoneNumber ?? '')
                                                    ],
                                                  ))
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Text('Các điều kiện'),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            controller.groupCustomerRq.value
                                                .conditionItems!
                                                .add(ConditionItem(
                                                    typeCompare: 0,
                                                    comparisonExpression: ">",
                                                    valueCompare: ""));
                                            controller.groupCustomerRq
                                                .refresh();
                                          },
                                          icon: Icon(Icons.add)),
                                    ],
                                  ),
                                ),
                        ),
                        Obx(
                          () => Column(
                              children: (controller.groupCustomerRq.value
                                          .conditionItems ??
                                      [])
                                  .map((e) => itemCondition(e))
                                  .toList()),
                        )
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
                text: "Lưu",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (groupCustomerInput != null) {
                      controller.updateGroupCustomer();
                    } else {
                      controller.addGroupCustomer();
                    }
                  }
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemCondition(ConditionItem conditionItem) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, top: 10),
      margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              showDialogTypeCondition(
                  typeInput: conditionItem.typeCompare,
                  onChoose: (v) {
                    conditionItem.typeCompare = v;
                    conditionItem.comparisonExpression = "=";
                    controller.groupCustomerRq.refresh();
                  });
            },
            child: Row(
              children: [
                Text(
                  getText(conditionItem.typeCompare ?? 0),
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
          ),
          Divider(),
          Stack(
            children: [
              if (conditionItem.typeCompare != TYPE_COMPARE_CTV &&
                  conditionItem.typeCompare != TYPE_COMPARE_AGENCY &&
                  conditionItem.typeCompare != TYPE_COMPARE_PROVINCE &&
                  conditionItem.typeCompare != TYPE_COMPARE_SEX &&
                  conditionItem.typeCompare != TYPE_NO_CUSTOMER)
                InkWell(
                  onTap: () {
                    showDialogCondition(
                        textInput: conditionItem.comparisonExpression,
                        onChoose: (v) {
                          conditionItem.comparisonExpression = v;
                          controller.groupCustomerRq.refresh();
                        });
                  },
                  child: Row(
                    children: [
                      Text('Điều kiện so sánh:'),
                      Spacer(),
                      Text(
                        conditionItem.comparisonExpression ?? '>',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded)
                    ],
                  ),
                ),
              if (conditionItem.typeCompare == TYPE_NO_CUSTOMER)
                Positioned.fill(
                    child: Container(
                  color: Colors.grey.withOpacity(0.1),
                ))
            ],
          ),
          Divider(),
          valueItem(conditionItem),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                (controller.groupCustomerRq.value.conditionItems ?? [])
                    .removeWhere((e) =>
                        e.valueCompare == conditionItem.valueCompare &&
                        e.typeCompare == conditionItem.typeCompare &&
                        e.comparisonExpression ==
                            conditionItem.comparisonExpression);
                controller.groupCustomerRq.refresh();
              },
              icon: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget valueItem(ConditionItem conditionItem) {
    var text = TextEditingController(text: conditionItem.valueCompare);
    if (conditionItem.typeCompare == TYPE_COMPARE_TOTAL_FINAL_COMPLETED ||
        conditionItem.typeCompare == TYPE_COMPARE_TOTAL_FINAL_WITH_REFUND ||
        conditionItem.typeCompare == TYPE_COMPARE_POINT ||
        conditionItem.typeCompare == TYPE_COMPARE_COUNT_ORDER ||
        conditionItem.typeCompare == TYPE_COMPARE_AGE)
      return Row(
        children: [
          Text('Giá trị so sánh:'),
          Expanded(
            child: TextFormField(
              controller: text,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: "Nhập giá trị"),
              minLines: 1,
              maxLines: 1,
              validator: (value) {
                if (value!.length <= 0) {
                  return 'Không được để trống';
                }
                return null;
              },
              onChanged: (v) {
                conditionItem.valueCompare = v;
              },
            ),
          ),
        ],
      );

    if (conditionItem.typeCompare == TYPE_COMPARE_MONTH_BIRTH)
      return Row(
        children: [
          Text('Giá trị so sánh:'),
          Expanded(
            child: TextFormField(
              controller: text,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: "Nhập giá trị"),
              minLines: 1,
              maxLines: 1,
              validator: (value) {
                if (value!.length <= 0) {
                  return 'Không được để trống';
                }

                if ((int.tryParse(value) ?? 0) <= 0) {
                  return "Giá trị không hợp lệ";
                }

                if ((int.tryParse(value) ?? 0) > 12) {
                  return "Giá trị không hợp lệ";
                }
                return null;
              },
              onChanged: (v) {
                conditionItem.valueCompare = v;
              },
            ),
          ),
        ],
      );

    if (conditionItem.typeCompare == TYPE_COMPARE_SEX)
      return InkWell(
        onTap: () {
          SahaDialogApp.showDialogSex(
              onChoose: (v) {
                conditionItem.valueCompare = v.toString();
                controller.groupCustomerRq.refresh();
              },
              sex: int.tryParse(conditionItem.valueCompare ?? "0") ?? 0);
        },
        child: Row(
          children: [
            Text('Chọn giới tính:'),
            Spacer(),
            Text(conditionItem.valueCompare == "0"
                ? 'Không xác định'
                : conditionItem.valueCompare == "1"
                    ? "Nam"
                    : "Nữ"),
            Icon(Icons.keyboard_arrow_down_rounded)
          ],
        ),
      );

    if (conditionItem.typeCompare == TYPE_COMPARE_PROVINCE)
      return InkWell(
        onTap: () {
          SahaDialogApp.showDialogAddressChoose(
            accept: () {},
            hideAll: true,
            callback: (LocationAddress v) {
              conditionItem.valueCompare = v.id.toString();
              conditionItem.sub = v.name;
              controller.groupCustomerRq.refresh();
              Get.back();
            },
          );
        },
        child: Row(
          children: [
            Text('Chọn tỉnh:'),
            Spacer(),
            Text(conditionItem.sub ?? ''),
            Icon(Icons.keyboard_arrow_down_rounded)
          ],
        ),
      );

    if (conditionItem.typeCompare == TYPE_COMPARE_DATE_REG)
      return InkWell(
        onTap: () {
          showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Container(
                    width: Get.width * 0.9,
                    height: Get.height * 0.5,
                    child: SfDateRangePicker(
                      onCancel: () {
                        Get.back();
                      },
                      onSubmit: (v) {
                        print(v);
                        conditionItem.valueCompare =
                            DateTime.parse("$v").toIso8601String();
                        print(conditionItem.valueCompare);
                        controller.groupCustomerRq.refresh();
                        Get.back();
                      },
                      showActionButtons: true,
                      selectionMode: DateRangePickerSelectionMode.single,
                      maxDate: DateTime(2050),
                    ),
                  ),
                );
              });
        },
        child: Row(
          children: [
            Text('Chọn ngày đăng ký:'),
            Spacer(),
            Text("${conditionItem.valueCompare ?? ''}"),
            Icon(Icons.keyboard_arrow_down_rounded)
          ],
        ),
      );

    if (conditionItem.typeCompare == TYPE_COMPARE_CTV)
      return Row(
        children: [Text('Giá trị so sánh:'), Spacer(), Text('Tất cả')],
      );
    if (conditionItem.typeCompare == TYPE_COMPARE_AGENCY)
      return Row(
        children: [Text('Giá trị so sánh:'), Spacer(), Text('Tất cả')],
      );
    return Container();
  }

  String getText(int type) {
    if (type == TYPE_COMPARE_TOTAL_FINAL_COMPLETED)
      return "Tổng mua (Chỉ đơn hoàn thành trừ trả hàng)";
    if (type == TYPE_COMPARE_TOTAL_FINAL_WITH_REFUND)
      return "Tổng mua (Tất cả trạng thái đơn trừ trả hàng)";
    if (type == TYPE_COMPARE_POINT) return "Xu hiện tại";
    if (type == TYPE_COMPARE_COUNT_ORDER) return "Số lần mua hàng";
    if (type == TYPE_COMPARE_MONTH_BIRTH) return "Tháng sinh nhật";
    if (type == TYPE_COMPARE_AGE) return "Tuổi";
    if (type == TYPE_COMPARE_SEX) return "Giới tính";
    if (type == TYPE_COMPARE_PROVINCE) return "Tỉnh";
    if (type == TYPE_COMPARE_DATE_REG) return "Ngày đăng ký";
    if (type == TYPE_COMPARE_CTV) return "Cộng tác viên";
    if (type == TYPE_COMPARE_AGENCY) return "Đại lý";
    if (type == TYPE_COMPARE_GROUP_CUSTOMER) return "Theo nhóm khách hàng";
    if (type == TYPE_NO_CUSTOMER) return "Khách hàng (Không phải CTV, Đại lý)";

    return "";
  }

  void showDialogTypeCondition({int? typeInput, required Function onChoose}) {
    Widget itemType(int type) {
      return Column(
        children: [
          ListTile(
            title: Text(
              getText(type),
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

    List<int> listType = [
      TYPE_COMPARE_TOTAL_FINAL_COMPLETED, // Tổng mua (Chỉ đơn hoàn thành trừ trả hàng),
      TYPE_COMPARE_TOTAL_FINAL_WITH_REFUND, // Tổng mua (Tất cả trạng thái đơn trừ trả hàng),
      TYPE_COMPARE_POINT, // Xu hiện tại,
      TYPE_COMPARE_COUNT_ORDER, // Số lần mua hàng
      TYPE_COMPARE_MONTH_BIRTH, // tháng sinh nhật
      TYPE_COMPARE_AGE, // tuổi
      TYPE_COMPARE_SEX, // giới tính,
      TYPE_COMPARE_PROVINCE, // tỉnh,
      TYPE_COMPARE_DATE_REG, // ngày đăng ký
      TYPE_COMPARE_CTV, // cộng tác viên
      TYPE_COMPARE_AGENCY, // Đại lý
      TYPE_NO_CUSTOMER, // Đại lý
    ];

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
                    "Chọn điều kiện",
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

  void showDialogCondition({String? textInput, required Function onChoose}) {
    var list = [">", ">=", "=", "<", "<="];

    Widget itemType(String type) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(type),
              onTap: () async {
                onChoose(type);
                Get.back();
              },
              trailing: textInput == type
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
        ),
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
                    "Chọn so sánh",
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
                    ...list.map((e) => itemType(e)).toList(),
                  ],
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
