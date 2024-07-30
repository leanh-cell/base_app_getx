import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/customer/all_group_customer_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/model/combo.dart';
import 'package:com.ikitech.store/app_user/screen2/maketing_chanel/my_combo/add_product/add_product_combo_screen.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/marketing_chanel_response/combo/combo_request.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/keyboard.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../components/saha_user/dialog/dialog.dart';
import '../../../../model/agency_type.dart';
import 'update_combo_controller.dart';

// ignore: must_be_immutable
class UpdateMyComboScreen extends StatefulWidget {
  Combo? combo;
  bool? onlyWatch;

  UpdateMyComboScreen({this.combo, this.onlyWatch});

  @override
  _UpdateMyComboScreenState createState() => _UpdateMyComboScreenState();
}

class _UpdateMyComboScreenState extends State<UpdateMyComboScreen> {
  final _formKey = GlobalKey<FormState>();

  late UpdateMyComboController updateMyComboController;

  @override
  void initState() {
    updateMyComboController = UpdateMyComboController(comboInput: widget.combo);
    updateMyComboController.discountTypeRequest.value =
        widget.combo!.discountType!;
    widget.combo!.productsCombo!.forEach((element) {
      updateMyComboController.listSelectedProduct.add(element.product!);

      updateMyComboController.listSelectedProductParam.add(ComboProduct(
          productId: element.product!.id, quantity: element.quantity));
    });

    updateMyComboController.nameProgramEditingController.text =
        widget.combo!.name!;
    updateMyComboController.dateStart.value = DateTime(
      widget.combo!.startTime!.year,
      widget.combo!.startTime!.month,
      widget.combo!.startTime!.day,
      widget.combo!.startTime!.hour,
      widget.combo!.startTime!.minute,
      widget.combo!.startTime!.second,
      widget.combo!.startTime!.millisecond,
      widget.combo!.startTime!.microsecond,
    );
    updateMyComboController.dateEnd.value = DateTime(
      widget.combo!.endTime!.year,
      widget.combo!.endTime!.month,
      widget.combo!.endTime!.day,
      widget.combo!.endTime!.hour,
      widget.combo!.endTime!.minute,
      widget.combo!.endTime!.second,
      widget.combo!.endTime!.millisecond,
      widget.combo!.endTime!.microsecond,
    );
    updateMyComboController.timeStart.value = DateTime(
      widget.combo!.startTime!.year,
      widget.combo!.startTime!.month,
      widget.combo!.startTime!.day,
      widget.combo!.startTime!.hour,
      widget.combo!.startTime!.minute,
      widget.combo!.startTime!.second,
      widget.combo!.startTime!.millisecond,
      widget.combo!.startTime!.microsecond,
    );
    updateMyComboController.timeEnd.value = DateTime(
      widget.combo!.endTime!.year,
      widget.combo!.endTime!.month,
      widget.combo!.endTime!.day,
      widget.combo!.endTime!.hour,
      widget.combo!.endTime!.minute,
      widget.combo!.endTime!.second,
      widget.combo!.endTime!.millisecond,
      widget.combo!.endTime!.microsecond,
    );
    updateMyComboController.discountTypeInput.value =
        widget.combo!.discountType!;
    if (widget.combo!.discountType == 1) {
      updateMyComboController.valueEditingController.text = SahaStringUtils()
          .convertToMoney(widget.combo!.valueDiscount.toString());
    } else {
      updateMyComboController.valueEditingController.text = SahaStringUtils()
          .convertToUnit(widget.combo!.valueDiscount.toString());
    }

    updateMyComboController.amountCodeAvailableEditingController.text =
        widget.combo!.amount == null ? "" : widget.combo!.amount.toString();
    updateMyComboController.checkTypeDiscountInput();
    updateMyComboController.group.value = widget.combo?.group ?? [];
    updateMyComboController.agencyType.value = widget.combo?.agencyTypes ?? [];
    updateMyComboController.groupCustomer.value =
        widget.combo?.groupTypes ?? [];
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
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Combo khuyến mãi'),
        ),
        body: Obx(
          () => IgnorePointer(
            ignoring: widget.onlyWatch ?? false,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () {
                        SahaDialogApp.showDialogGroupMarketingTypev2(
                            onChoose: (v) {
                              if (updateMyComboController.group.contains(v)) {
                                updateMyComboController.group.remove(v);
                                updateMyComboController.group.refresh();
                                if (v == 2) {
                                  updateMyComboController.agencyType.value = [];
                                }
                                if (v == 4) {
                                  updateMyComboController.groupCustomer.value =
                                      [];
                                }
                              } else {
                                updateMyComboController.group.add(v);
                                updateMyComboController.group.refresh();
                              }
                            },
                            groupType: updateMyComboController.group);
                      },
                      child: Container(
                        width: Get.width,
                        height: 50,
                        padding: EdgeInsets.only(left: 10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Icon(
                              Icons.group,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Obx(
                                () => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Nhóm áp dụng: '),
                                    Expanded(
                                      child: Text(
                                        '${updateMyComboController.group.contains(0) ? "Tất cả," : ""}${updateMyComboController.group.contains(1) ? "Cộng tác viên," : ""}${updateMyComboController.group.contains(2) ? "Đại lý," : ""} ${updateMyComboController.group.contains(4) ? "Nhóm khách hàng" : ""}${updateMyComboController.group.contains(5) ? "Khách lẻ đã đăng nhập," : ""}${updateMyComboController.group.contains(6) ? "Khách lẻ chưa đăng nhập" : ""}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded),
                          ],
                        ),
                      ),
                    ),
                    Obx(() => updateMyComboController.group.contains(2)
                        ? InkWell(
                            onTap: () {
                              SahaDialogApp.showDialogAgencyTypev2(
                                  onChoose: (v) {
                                    if (updateMyComboController.agencyType
                                        .contains(v)) {
                                      updateMyComboController.agencyType
                                          .remove(v);
                                    } else {
                                      updateMyComboController.agencyType.add(v);
                                    }
                                  },
                                  type: updateMyComboController.agencyType
                                      .map((e) => e.id ?? 0)
                                      .toList(),
                                  listAgencyType: updateMyComboController
                                      .listAgencyType
                                      .toList());
                            },
                            child: Container(
                              width: Get.width,
                              height: 50,
                              padding: EdgeInsets.only(left: 10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.leaderboard,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Obx(
                                      () => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Chọn cấp đại lý: '),
                                          Expanded(
                                            child: Text(
                                              updateMyComboController
                                                      .agencyType.isEmpty
                                                  ? ""
                                                  : "${updateMyComboController.agencyType.map((e) => "${e.name},")}",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_down_rounded),
                                ],
                              ),
                            ),
                          )
                        : Container()),
                    Obx(() => updateMyComboController.group.contains(4)
                        ? InkWell(
                            onTap: () {
                              SahaDialogApp.showDialogCustomerGroupTypev2(
                                  onChoose: (v) {
                                    if (updateMyComboController.groupCustomer
                                        .contains(v)) {
                                      updateMyComboController.groupCustomer
                                          .remove(v);
                                    } else {
                                      updateMyComboController.groupCustomer
                                          .add(v);
                                    }
                                  },
                                  type: updateMyComboController.groupCustomer
                                      .map((e) => e.id ?? 0)
                                      .toList(),
                                  listGroupCustomer: updateMyComboController
                                      .listGroup
                                      .toList());
                            },
                            child: Container(
                              width: Get.width,
                              height: 50,
                              padding: EdgeInsets.only(left: 10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.leaderboard,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Obx(
                                      () => Row(
                                        children: [
                                          Text('Chọn nhóm khách hàng: '),
                                          Expanded(
                                            child: Text(
                                              updateMyComboController
                                                      .groupCustomer.isEmpty
                                                  ? ""
                                                  : "${updateMyComboController.groupCustomer.map((e) => "${e.name},")}",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_down_rounded),
                                ],
                              ),
                            ),
                          )
                        : Container()),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text('Tên chương trình'),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: updateMyComboController
                                  .nameProgramEditingController,
                              validator: (value) {
                                if (value!.length < 1) {
                                  return 'Chưa nhập tên chương trình';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText:
                                    "Nhập tên chương trình khuyến mãi tại đây",
                              ),
                              style: TextStyle(fontSize: 14),
                              minLines: 1,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Thời gian bắt đầu'),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  dp.DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(1999, 1, 1),
                                      maxTime: DateTime(2050, 1, 1),
                                      theme: dp.DatePickerTheme(
                                          headerColor: Colors.white,
                                          backgroundColor: Colors.white,
                                          itemStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                          doneStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16)),
                                      onConfirm: (date) {
                                    updateMyComboController
                                        .onChangeDateStart(date);
                                  },
                                      currentTime: DateTime.now(),
                                      locale: dp.LocaleType.vi);
                                },
                                child: Text(
                                  '${SahaDateUtils().getDDMMYY(updateMyComboController.dateStart.value)}',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    dp.DatePicker.showTime12hPicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        print('change $date in time zone ' +
                                            date.timeZoneOffset.inHours
                                                .toString());
                                      },
                                      onConfirm: (date) {
                                        var timeCheck = DateTime(
                                            updateMyComboController
                                                .dateStart.value.year,
                                            updateMyComboController
                                                .dateStart.value.month,
                                            updateMyComboController
                                                .dateStart.value.day,
                                            date.hour,
                                            date.minute,
                                            date.second);
                                        if (DateTime.now().isAfter(timeCheck) ==
                                            true) {
                                          updateMyComboController
                                              .checkDayStart.value = true;
                                          updateMyComboController
                                              .timeStart.value = date;
                                        } else {
                                          updateMyComboController
                                              .checkDayStart.value = false;
                                          updateMyComboController
                                              .timeStart.value = date;
                                        }
                                      },
                                      currentTime: DateTime.now(),
                                      locale: dp.LocaleType.vi,
                                    );
                                  },
                                  child: Text(
                                    '  ${SahaDateUtils().getHHMM(updateMyComboController.timeStart.value)}',
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    updateMyComboController.checkDayStart.value
                        ? Container(
                            padding: EdgeInsets.all(8.0),
                            color: Colors.red[50],
                            width: Get.width,
                            child: Text(
                              "Vui lòng nhập thời gian bắt đầu chương trình khuyến mãi sau thời gian hiện tại",
                              style: TextStyle(fontSize: 13, color: Colors.red),
                            ),
                          )
                        : Divider(
                            height: 1,
                          ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Thời gian kết thúc'),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  dp.DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(1999, 1, 1),
                                      maxTime: DateTime(2050, 1, 1),
                                      theme: dp.DatePickerTheme(
                                          headerColor: Colors.white,
                                          backgroundColor: Colors.white,
                                          itemStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                          doneStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16)),
                                      onChanged: (date) {}, onConfirm: (date) {
                                    updateMyComboController
                                        .onChangeDateEnd(date);
                                  },
                                      currentTime: DateTime.now(),
                                      locale: dp.LocaleType.vi);
                                },
                                child: Text(
                                  '${SahaDateUtils().getDDMMYY(updateMyComboController.dateEnd.value)}',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                   dp.DatePicker.showTime12hPicker(
                                      context,
                                      showTitleActions: true,
                                      onChanged: (date) {
                                        print('change $date in time zone ' +
                                            date.timeZoneOffset.inHours
                                                .toString());
                                      },
                                      onConfirm: (date) {
                                        updateMyComboController
                                            .onChangeTimeEnd(date);
                                      },
                                      currentTime: DateTime.now(),
                                      locale: dp.LocaleType.vi,
                                    );
                                  },
                                  child: Text(
                                    '  ${SahaDateUtils().getHHMM(updateMyComboController.timeEnd.value)}',
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    updateMyComboController.checkDayEnd.value
                        ? Container(
                            padding: EdgeInsets.all(8.0),
                            color: Colors.red[50],
                            width: Get.width,
                            child: Text(
                              "Thời gian kết thúc phải sau thời gian bắt đầu",
                              style: TextStyle(fontSize: 13, color: Colors.red),
                            ),
                          )
                        : Divider(
                            height: 1,
                          ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Loại chương trình"),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return Obx(
                                    () => Container(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(15.0),
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      value: DiscountType.k1,
                                                      groupValue:
                                                          updateMyComboController
                                                              .discountType
                                                              .value,
                                                      onChanged: (dynamic v) {
                                                        updateMyComboController
                                                            .onChangeRatio(v);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text("Giảm giá theo %")
                                                  ],
                                                ),
                                              ),
                                              updateMyComboController
                                                          .discountType.value ==
                                                      DiscountType.k1
                                                  ? Container(
                                                      height: 55,
                                                      width: Get.width * 0.85,
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            width: 85,
                                                            height: 40,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child: Center(
                                                              child: TextField(
                                                                controller:
                                                                    updateMyComboController
                                                                        .valueEditingController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                maxLength: 2,
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter
                                                                      .deny(RegExp(
                                                                          "[,.]")),
                                                                ],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                decoration: InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    counterText:
                                                                        "",
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "% Giảm"),
                                                                minLines: 1,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text("%"),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(15.0),
                                                child: Row(
                                                  children: [
                                                    Radio(
                                                      value: DiscountType.k0,
                                                      groupValue:
                                                          updateMyComboController
                                                              .discountType
                                                              .value,
                                                      onChanged: (dynamic v) {
                                                        updateMyComboController
                                                            .onChangeRatio(v);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                        "Giảm giá theo số tiền")
                                                  ],
                                                ),
                                              ),
                                              updateMyComboController
                                                          .discountType.value ==
                                                      DiscountType.k0
                                                  ? Container(
                                                      width: Get.width * 0.85,
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Giảm",
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            width: 85,
                                                            height: 40,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .grey)),
                                                            child: Center(
                                                              child: TextField(
                                                                controller:
                                                                    updateMyComboController
                                                                        .valueEditingController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                inputFormatters: [
                                                                  ThousandsFormatter()
                                                                ],
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                decoration: InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "đ"),
                                                                minLines: 1,
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                              updateMyComboController
                                                          .validateComboPercent
                                                          .value ==
                                                      true
                                                  ? Container(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      color: Colors.red[50],
                                                      width: Get.width,
                                                      child: Text(
                                                        "Giá trị giảm là bắt buộc",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.red),
                                                      ),
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 10,
                                            color: Colors.grey[200],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (updateMyComboController
                                                  .valueEditingController
                                                  .text
                                                  .isEmpty) {
                                                updateMyComboController
                                                    .validateComboPercent
                                                    .value = true;
                                              } else {
                                                updateMyComboController
                                                    .isSaveTypeCombo = true;
                                                updateMyComboController
                                                    .validateComboPercent
                                                    .value = false;
                                                KeyboardUtil.hideKeyboard(
                                                    context);
                                                updateMyComboController
                                                    .checkTypeDiscount();
                                                Get.back();
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 50,
                                                  child: Center(
                                                    child: Text(
                                                      "Lưu",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: Get.width * 0.5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    updateMyComboController
                                        .typeVoucherDiscount.value,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    updateMyComboController
                                .isChoosedTypeVoucherDiscount.value ==
                            false
                        ? Container(
                            padding: EdgeInsets.all(8.0),
                            color: Colors.red[50],
                            width: Get.width,
                            child: Text(
                              "Chưa chọn loại chương trình",
                              style: TextStyle(fontSize: 13, color: Colors.red),
                            ),
                          )
                        : Divider(
                            height: 1,
                          ),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giới hạn combo"),
                          Container(
                            width: Get.width * 0.6,
                            child: TextFormField(
                              controller: updateMyComboController
                                  .amountCodeAvailableEditingController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.length < 1) {
                                  return 'Chưa nhập giới hạn combo';
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Giới hạn combo có thể sử dụng",
                              ),
                              minLines: 1,
                              maxLines: 1,
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
                      width: Get.width,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Combo sản phẩm"),
                                updateMyComboController
                                            .listSelectedProduct.length ==
                                        0
                                    ? Container()
                                    : IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          Get.to(() => AddProductComboScreen(
                                                callback: (List<Product>?
                                                    listProduct) {
                                                  updateMyComboController
                                                      .listSelectedProduct(
                                                          listProduct!);
                                                  updateMyComboController
                                                      .listSelectedProductToComboProduct();
                                                },
                                                listProductInput:
                                                    updateMyComboController
                                                        .listSelectedProduct,
                                              ));
                                        })
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Obx(
                            () => updateMyComboController
                                        .listSelectedProduct.length ==
                                    0
                                ? InkWell(
                                    onTap: () {
                                      Get.to(() => AddProductComboScreen(
                                            callback:
                                                (List<Product>? listProduct) {
                                              updateMyComboController
                                                  .listSelectedProduct
                                                  .addAll(listProduct!);
                                              updateMyComboController
                                                  .listSelectedProductToComboProduct();
                                            },
                                            listProductInput:
                                                updateMyComboController
                                                    .listSelectedProduct,
                                          ));
                                    },
                                    child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          Text(
                                            'Thêm sản phẩm',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Obx(
                                    () => Wrap(
                                      runSpacing: 5,
                                      spacing: 5,
                                      children: [
                                        ...List.generate(
                                            updateMyComboController
                                                .listSelectedProduct
                                                .length, (index) {
                                          var e = updateMyComboController
                                              .listSelectedProduct[index];
                                          return Stack(
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      height: 100,
                                                      width: Get.width / 4,
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          e.images!.length == 0
                                                              ? ""
                                                              : e.images![0]
                                                                  .imageUrl!,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Container(
                                                              height: 100,
                                                              width:
                                                                  Get.width / 4,
                                                              child: Icon(
                                                                Icons.image,
                                                                color:
                                                                    Colors.grey,
                                                                size: 40,
                                                              )),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        IconButton(
                                                            icon: Icon(
                                                                Icons.remove),
                                                            onPressed: () {
                                                              updateMyComboController
                                                                  .decreaseAmountProductCombo(
                                                                      index);
                                                            }),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Obx(
                                                          () => Text(
                                                              "${updateMyComboController.listSelectedProductParam[index].quantity}"),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        IconButton(
                                                            icon:
                                                                Icon(Icons.add),
                                                            onPressed: () {
                                                              updateMyComboController
                                                                  .increaseAmountProductCombo(
                                                                      index);
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Positioned(
                                                top: -10,
                                                left: -10,
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    onPressed: () {
                                                      updateMyComboController
                                                          .deleteProduct(e.id!);
                                                    }),
                                              ),
                                            ],
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
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
                () => updateMyComboController.isLoadingCreate.value == true
                    ? IgnorePointer(
                        child: SahaButtonFullParent(
                          text: "Lưu",
                          textColor: Colors.grey[600],
                          onPressed: () {},
                          color: Colors.grey[300],
                        ),
                      )
                    : widget.onlyWatch == true
                        ? Container()
                        : SahaButtonFullParent(
                            text: "Lưu",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                KeyboardUtil.hideKeyboard(context);
                                if (updateMyComboController
                                        .typeVoucherDiscount.value ==
                                    "Chọn") {
                                  updateMyComboController
                                      .isChoosedTypeVoucherDiscount
                                      .value = false;
                                } else {
                                  if (updateMyComboController
                                      .listSelectedProduct.isEmpty) {
                                    SahaAlert.showError(
                                        message: "Chưa chọn sản phẩm");
                                  } else {
                                    updateMyComboController
                                        .updateCombo(widget.combo!.id);
                                    updateMyComboController
                                        .isChoosedTypeVoucherDiscount
                                        .value = true;
                                  }
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
}
