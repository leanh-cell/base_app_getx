import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as dp;
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/screen2/maketing_chanel/my_voucher/add_product_to_voucher/add_product_voucher_screen.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/keyboard.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../components/saha_user/dialog/dialog.dart';
import 'create_my_voucher_controller.dart';

// ignore: must_be_immutable
class CreateMyVoucher extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _formKeyTypeVoucher = GlobalKey<FormState>();
  int? voucherType;
  CreateMyVoucherController createMyVoucherController =
      CreateMyVoucherController();

  CreateMyVoucher({this.voucherType});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Tạo Voucher'),
        ),
        body: Obx(
          () => SingleChildScrollView(
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
                            if (createMyVoucherController.group.contains(v)) {
                              createMyVoucherController.group.remove(v);
                              createMyVoucherController.group.refresh();
                              if (v == 2) {
                                createMyVoucherController.agencyType.value = [];
                              }
                              if (v == 4) {
                                createMyVoucherController.groupCustomer.value =
                                    [];
                              }
                            } else {
                              createMyVoucherController.group.add(v);
                              createMyVoucherController.group.refresh();
                            }
                          },
                          groupType: createMyVoucherController.group);
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
                                      '${createMyVoucherController.group.contains(0) ? "Tất cả," : ""}${createMyVoucherController.group.contains(1) ? "Cộng tác viên," : ""}${createMyVoucherController.group.contains(2) ? "Đại lý," : ""} ${createMyVoucherController.group.contains(4) ? "Nhóm khách hàng" : ""}${createMyVoucherController.group.contains(5) ? "Khách lẻ đã đăng nhập" : ""}${createMyVoucherController.group.contains(6) ? "Khách lẻ chưa đăng nhập" : ""}',
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
                  ),
                  Obx(() => createMyVoucherController.group.contains(2)
                      ? InkWell(
                          onTap: () {
                            SahaDialogApp.showDialogAgencyTypev2(
                                onChoose: (v) {
                                  if (createMyVoucherController.agencyType
                                      .contains(v)) {
                                    createMyVoucherController.agencyType
                                        .remove(v);
                                  } else {
                                    createMyVoucherController.agencyType.add(v);
                                  }
                                },
                                type: createMyVoucherController.agencyType
                                    .map((e) => e.id ?? 0)
                                    .toList(),
                                listAgencyType: createMyVoucherController
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
                                            createMyVoucherController
                                                    .agencyType.isEmpty
                                                ? ""
                                                : "${createMyVoucherController.agencyType.map((e) => "${e.name},")}",
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
                  Obx(() => createMyVoucherController.group.contains(4)
                      ? InkWell(
                          onTap: () {
                            SahaDialogApp.showDialogCustomerGroupTypev2(
                                onChoose: (v) {
                                  if (createMyVoucherController.groupCustomer
                                      .contains(v)) {
                                    createMyVoucherController.groupCustomer
                                        .remove(v);
                                  } else {
                                    createMyVoucherController.groupCustomer
                                        .add(v);
                                  }
                                },
                                type: createMyVoucherController.groupCustomer
                                    .map((e) => e.id ?? 0)
                                    .toList(),
                                listGroupCustomer: createMyVoucherController
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
                                            createMyVoucherController
                                                    .groupCustomer.isEmpty
                                                ? ""
                                                : "${createMyVoucherController.groupCustomer.map((e) => "${e.name},")}",
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
                        Text('Tên chương trình khuyến mãi'),
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
                            controller: createMyVoucherController
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
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Chọn kiểu phát hành voucher:'),
                        Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                  value: createMyVoucherController
                                          .isUseOnceCodeMultipleTime.value ==
                                      true,
                                  onChanged: (v) {
                                    if (v == true) {
                                      createMyVoucherController
                                          .isUseOnceCodeMultipleTime
                                          .value = true;
                                    }
                                  }),
                            ),
                            Text('Một mã sử dụng nhiều lần')
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                value: createMyVoucherController
                                        .isUseOnceCodeMultipleTime.value ==
                                    false,
                                onChanged: (v) {
                                  if (v == true) {
                                    createMyVoucherController
                                        .isUseOnceCodeMultipleTime
                                        .value = false;
                                  }
                                }),
                            Text('Nhiều mã chỉ sử dụng 1 lần')
                          ],
                        )
                      ],
                    ),
                  ),
                  if(createMyVoucherController.isUseOnceCodeMultipleTime.value ==true)
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mã giảm giá"),
                        Container(
                          width: Get.width * 0.5,
                          child: TextFormField(
                            controller: createMyVoucherController
                                .codeVoucherEditingController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.length < 1) {
                                return 'Chưa nhập mã giảm giá';
                              } else {
                                if (SahaStringUtils()
                                    .validateCharacter(value)) {
                                  return null;
                                } else {
                                  return "Không chứa các kí tự đặc biệt";
                                }
                              }
                            },
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText: "Nhập mã Voucher"),
                            minLines: 1,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
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
                                            fontSize: 16)), onConfirm: (date) {
                                  createMyVoucherController
                                      .onChangeDateStart(date);
                                },
                                    currentTime: DateTime.now(),
                                    locale: dp.LocaleType.vi);
                              },
                              child: Text(
                                '${SahaDateUtils().getDDMMYY(createMyVoucherController.dateStart.value)}',
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
                                          createMyVoucherController
                                              .dateStart.value.year,
                                          createMyVoucherController
                                              .dateStart.value.month,
                                          createMyVoucherController
                                              .dateStart.value.day,
                                          date.hour,
                                          date.minute,
                                          date.second);
                                      if (DateTime.now().isAfter(timeCheck) ==
                                          true) {
                                        createMyVoucherController
                                            .checkDayStart.value = true;
                                        createMyVoucherController
                                            .timeStart.value = date;
                                      } else {
                                        createMyVoucherController
                                            .checkDayStart.value = false;
                                        createMyVoucherController
                                            .timeStart.value = date;
                                      }
                                    },
                                    currentTime: DateTime.now(),
                                    locale: dp.LocaleType.vi,
                                  );
                                },
                                child: Text(
                                  '  ${SahaDateUtils().getHHMM(createMyVoucherController.timeStart.value)}',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  createMyVoucherController.checkDayStart.value
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
                                            color: Colors.black, fontSize: 16)),
                                    onChanged: (date) {}, onConfirm: (date) {
                                  createMyVoucherController
                                      .onChangeDateEnd(date);
                                },
                                    currentTime: DateTime.now(),
                                    locale: dp.LocaleType.vi);
                              },
                              child: Text(
                                '${SahaDateUtils().getDDMMYY(createMyVoucherController.dateEnd.value)}',
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
                                      createMyVoucherController
                                          .onChangeTimeEnd(date);
                                    },
                                    currentTime: DateTime.now(),
                                    locale: dp.LocaleType.vi,
                                  );
                                },
                                child: Text(
                                  '  ${SahaDateUtils().getHHMM(createMyVoucherController.timeEnd.value)}',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  createMyVoucherController.checkDayEnd.value
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
                  if (voucherType != 1)
                    Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kiểu giảm giá',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Row(
                            children: [
                              Text('Giảm giá hoá đơn'),
                              Checkbox(
                                  value: createMyVoucherController
                                              .discountFor.value !=
                                          1
                                      ? true
                                      : false,
                                  onChanged: (v) {
                                    createMyVoucherController
                                        .discountFor.value = 0;
                                  }),
                              Spacer(),
                              Text('Giảm giá vận chuyển'),
                              Checkbox(
                                  value: createMyVoucherController
                                              .discountFor.value ==
                                          1
                                      ? true
                                      : false,
                                  onChanged: (v) {
                                    createMyVoucherController
                                        .discountFor.value = 1;
                                    createMyVoucherController
                                        .isChoosedTypeVoucherDiscount
                                        .value = true;
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  if (createMyVoucherController.discountFor.value == 1)
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          color: Colors.white,
                          child: Row(
                            children: [
                              Text('Miễn phí vận chuyển'),
                              Checkbox(
                                  value: createMyVoucherController
                                      .isFreeShip.value,
                                  onChanged: (v) {
                                    createMyVoucherController.isFreeShip.value =
                                        !createMyVoucherController
                                            .isFreeShip.value;
                                  }),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        if (createMyVoucherController.isFreeShip.value == false)
                          Container(
                            padding: EdgeInsets.all(10),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Giá trị giảm"),
                                Container(
                                  width: Get.width * 0.7,
                                  child: TextFormField(
                                    controller:
                                        createMyVoucherController.valueShipEdit,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [ThousandsFormatter()],
                                    validator: (value) {
                                      if (createMyVoucherController
                                              .discountFor.value ==
                                          1) {
                                        if (createMyVoucherController
                                                .isFreeShip ==
                                            false) {
                                          if (value != null && value != '') {
                                          } else {
                                            return 'Chưa nhập giá trị';
                                          }
                                        }
                                      } else {
                                        return null;
                                      }
                                    },
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.end,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none,
                                        hintText: "Nhập giá trị giảm"),
                                    minLines: 1,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  Divider(
                    height: 1,
                  ),
                  if (createMyVoucherController.discountFor.value != 1)
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 15, bottom: 15),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Loại giảm giá"),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return Obx(
                                    () => Form(
                                      key: _formKeyTypeVoucher,
                                      child: Container(
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
                                                            createMyVoucherController
                                                                .discountType
                                                                .value,
                                                        onChanged: (dynamic v) {
                                                          createMyVoucherController
                                                              .onChangeRatio(v);
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                          "Giảm giá (Giá cố định)")
                                                    ],
                                                  ),
                                                ),
                                                createMyVoucherController
                                                            .discountType
                                                            .value ==
                                                        DiscountType.k1
                                                    ? Container(
                                                        height: 55,
                                                        width: Get.width * 0.7,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "đ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600]),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  TextFormField(
                                                                inputFormatters: [
                                                                  ThousandsFormatter()
                                                                ],
                                                                controller:
                                                                    createMyVoucherController
                                                                        .pricePermanentEditingController,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                          .length <
                                                                      1) {
                                                                    return 'Chưa nhập giá trị muốn giảm';
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
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
                                                                        "Nhập giá trị bạn muốn giảm"),
                                                                minLines: 1,
                                                                maxLines: 1,
                                                              ),
                                                            ),
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
                                                            createMyVoucherController
                                                                .discountType
                                                                .value,
                                                        onChanged: (dynamic v) {
                                                          createMyVoucherController
                                                              .onChangeRatio(v);
                                                        },
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text("Giảm giá (Theo %)")
                                                    ],
                                                  ),
                                                ),
                                                createMyVoucherController
                                                            .discountType
                                                            .value ==
                                                        DiscountType.k0
                                                    ? Container(
                                                        width: Get.width * 0.7,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      TextFormField(
                                                                    maxLength:
                                                                        2,
                                                                    controller:
                                                                        createMyVoucherController
                                                                            .pricePercentEditingController,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    inputFormatters: [
                                                                      FilteringTextInputFormatter
                                                                          .deny(
                                                                              RegExp('[,.]')),
                                                                    ],
                                                                    validator:
                                                                        (value) {
                                                                      if (value!
                                                                              .length <
                                                                          1) {
                                                                        return 'Chưa nhập % giảm giá';
                                                                      } else {
                                                                        var myInt =
                                                                            double.parse(value);
                                                                        if (myInt >
                                                                            99) {
                                                                          return '% giảm giá không được quá 99 %';
                                                                        }
                                                                        return null;
                                                                      }
                                                                    },
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    decoration: InputDecoration(
                                                                        counterText:
                                                                            "",
                                                                        isDense:
                                                                            true,
                                                                        border: InputBorder
                                                                            .none,
                                                                        hintText:
                                                                            "Nhập giá trị bạn muốn giảm"),
                                                                    minLines: 1,
                                                                    maxLines: 1,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  "% Giảm",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .grey[
                                                                          600]),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              height: 1,
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  "Giảm tối đa"),
                                                            ),
                                                            Row(
                                                              children: [
                                                                InkWell(
                                                                    onTap: () {
                                                                      createMyVoucherController
                                                                          .isLimitedPrice
                                                                          .value = true;
                                                                    },
                                                                    child: createMyVoucherController.isLimitedPrice.value ==
                                                                            true
                                                                        ? Container(
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(5)),
                                                                            height:
                                                                                40,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                "chọn mức giảm",
                                                                                style: TextStyle(
                                                                                  color: Theme.of(context).primaryColor,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            padding:
                                                                                EdgeInsets.all(8.0),
                                                                          )
                                                                        : Container(
                                                                            decoration:
                                                                                BoxDecoration(border: Border.all(color: Colors.grey[600]!), borderRadius: BorderRadius.circular(5)),
                                                                            height:
                                                                                40,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                "chọn mức giảm",
                                                                                style: TextStyle(color: Colors.grey[600]),
                                                                              ),
                                                                            ),
                                                                            padding:
                                                                                EdgeInsets.all(8.0),
                                                                          )),
                                                                Spacer(),
                                                                InkWell(
                                                                  onTap: () {
                                                                    createMyVoucherController
                                                                        .isLimitedPrice
                                                                        .value = false;
                                                                    createMyVoucherController
                                                                        .priceDiscountLimitedEditingController
                                                                        .text = "";
                                                                  },
                                                                  child: createMyVoucherController
                                                                              .isLimitedPrice
                                                                              .value ==
                                                                          false
                                                                      ? Container(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(color: Theme.of(context).primaryColor),
                                                                              borderRadius: BorderRadius.circular(5)),
                                                                          height:
                                                                              40,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              "Không giới hạn",
                                                                              style: TextStyle(
                                                                                color: Theme.of(context).primaryColor,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          padding:
                                                                              EdgeInsets.all(8.0),
                                                                          decoration: BoxDecoration(
                                                                              border: Border.all(color: Colors.grey[600]!),
                                                                              borderRadius: BorderRadius.circular(5)),
                                                                          height:
                                                                              40,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              "Không giới hạn",
                                                                              style: TextStyle(
                                                                                color: Colors.grey[600],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                )
                                                              ],
                                                            ),
                                                            createMyVoucherController
                                                                        .isLimitedPrice
                                                                        .value ==
                                                                    true
                                                                ? Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(8),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          "đ",
                                                                          style:
                                                                              TextStyle(color: Colors.grey[600]),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              TextFormField(
                                                                            controller:
                                                                                createMyVoucherController.priceDiscountLimitedEditingController,
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            inputFormatters: [
                                                                              ThousandsFormatter()
                                                                            ],
                                                                            validator:
                                                                                (value) {
                                                                              if (value!.length < 1) {
                                                                                return 'Chưa nhập giá trị muốn giảm';
                                                                              } else {
                                                                                var myInt = int.parse(SahaStringUtils().convertFormatText(value));
                                                                                if (myInt > 100000000) {
                                                                                  return 'giảm giá không được quá 100.000.000 đ';
                                                                                }
                                                                                if (myInt < 1000) {
                                                                                  return 'giảm giá không nên dưới 1000 đ';
                                                                                }
                                                                                return null;
                                                                              }
                                                                            },
                                                                            style:
                                                                                TextStyle(fontSize: 14),
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            decoration: InputDecoration(
                                                                                isDense: true,
                                                                                border: InputBorder.none,
                                                                                hintText: "Nhập giá trị bạn muốn giảm"),
                                                                            minLines:
                                                                                1,
                                                                            maxLines:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    height: 20,
                                                                  ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                            Container(
                                              height: 10,
                                              color: Colors.grey[200],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                if (_formKeyTypeVoucher
                                                    .currentState!
                                                    .validate()) {
                                                  _formKeyTypeVoucher
                                                      .currentState!
                                                      .save();
                                                  KeyboardUtil.hideKeyboard(
                                                      context);
                                                  createMyVoucherController
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
                                                                FontWeight
                                                                    .w400),
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
                                    createMyVoucherController
                                        .typeVoucherDiscount.value,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  createMyVoucherController
                              .isChoosedTypeVoucherDiscount.value ==
                          false
                      ? Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.red[50],
                          width: Get.width,
                          child: Text(
                            "Chưa chọn loại giảm giá",
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
                        Text("Đơn tối thiểu"),
                        Container(
                          width: Get.width * 0.7,
                          child: TextFormField(
                            controller: createMyVoucherController
                                .minimumOrderEditingController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [ThousandsFormatter()],
                            validator: (value) {
                              if (value!.length < 1) {
                                return 'Chưa nhập giá trị tối thiểu đơn hàng';
                              } else {
                                if (createMyVoucherController
                                    .pricePermanentEditingController
                                    .text
                                    .isEmpty) {
                                  return null;
                                } else {
                                  var myInt = int.parse(SahaStringUtils()
                                      .convertFormatText(value));
                                  var pricePermanent = int.parse(
                                      SahaStringUtils().convertFormatText(
                                          createMyVoucherController
                                              .pricePermanentEditingController
                                              .text));
                                  if (myInt < pricePermanent) {
                                    createMyVoucherController
                                        .isCheckMinimumOrderDiscount
                                        .value = false;
                                    return "";
                                  } else {
                                    createMyVoucherController
                                        .isCheckMinimumOrderDiscount
                                        .value = true;
                                    return null;
                                  }
                                }
                              }
                            },
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText:
                                    "Chọn giá trị tối thiểu của đơn hàng"),
                            minLines: 1,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  createMyVoucherController.isCheckMinimumOrderDiscount.value ==
                          false
                      ? Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.red[50],
                          width: Get.width,
                          child: Text(
                            "Giá trị voucher không thể vượt quá giá trị tối thiểu của đơn hàng",
                            style: TextStyle(fontSize: 13, color: Colors.red),
                          ),
                        )
                      : Divider(
                          height: 1,
                        ),
                  Obx(() => createMyVoucherController
                              .isUseOnceCodeMultipleTime.value ==
                          true
                      ? Column(
                          children: [
                            Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Chỉ sử dụng một lần"),
                                    CupertinoSwitch(
                                        value: createMyVoucherController
                                            .isUseOnce.value,
                                        onChanged: (v) {
                                          createMyVoucherController
                                              .isUseOnce.value = v;
                                        })
                                  ],
                                )),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Số mã có thể sử dụng"),
                                  Container(
                                    width: Get.width * 0.55,
                                    child: TextFormField(
                                      controller: createMyVoucherController
                                          .amountCodeAvailableEditingController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [ThousandsFormatter()],
                                      validator: (value) {
                                        if (value!.length < 1) {
                                          return 'Chưa nhập số mã có thể sử dụng';
                                        } else {
                                          return null;
                                        }
                                      },
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.end,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText:
                                              "Tổng số Mã giảm giá có thể sử dụng"),
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
                            InkWell(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 250,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              createMyVoucherController
                                                  .isPublic.value = true;

                                              Get.back();
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              height: 80,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Hiện thị",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Các Mã voucher được hiển thị trong phần thanh toán hóa đơn",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            height: 1,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              createMyVoucherController
                                                  .isPublic.value = false;

                                              Get.back();
                                            },
                                            child: Container(
                                              height: 80,
                                              padding: EdgeInsets.all(5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Không hiển thị",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Các Mã voucher được ẩn đi và chỉ được sử dụng khi nhập đúng Mã voucher",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 10,
                                            color: Colors.grey[200],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  "Thoát",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Hiển thị cho khách hàng : "),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          createMyVoucherController
                                                      .isPublic.value ==
                                                  true
                                              ? Text("Hiển thị")
                                              : Text("Không hiển thị"),
                                          Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Số mã có thể sử dụng"),
                                  Container(
                                    width: Get.width * 0.55,
                                    child: TextFormField(
                                      controller: createMyVoucherController
                                          .amountUseOnce,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [ThousandsFormatter()],
                                      validator: (value) {
                                        if (value!.length < 1) {
                                          return 'Chưa nhập số mã có thể sử dụng';
                                        } else {
                                          return null;
                                        }
                                      },
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.end,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText:
                                              "Số lượng mã phiếu có thể sử dụng"),
                                      minLines: 1,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Độ dài của voucher"),
                                  Container(
                                    width: Get.width * 0.55,
                                    child: TextFormField(
                                      controller: createMyVoucherController
                                          .voucherLength,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [ThousandsFormatter()],
                                      validator: (value) {
                                        if (value!.length < 1) {
                                          return 'Chưa nhập độ dài';
                                        } else {
                                          return null;
                                        }
                                      },
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.end,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "Độ dài của mã voucher"),
                                      minLines: 1,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                             Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Ký tự bắt đầu"),
                                  Container(
                                    width: Get.width * 0.55,
                                    child: TextFormField(
                                      controller: createMyVoucherController
                                          .startingCharacter,
                                     
                                      validator: (value) {
                                        if (value!.length < 1) {
                                          return 'Chưa nhập ký tự bắt đầu';
                                        } else {
                                          return null;
                                        }
                                      },
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.end,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "Nhập ký tự bắt đầu"),
                                      minLines: 1,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                        ),
                  Divider(
                    height: 1,
                  ),
                  voucherType == 1
                      ? Container(
                          color: Colors.white,
                          width: Get.width,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Sản phẩm'),
                                    createMyVoucherController
                                                .listSelectedProduct.length ==
                                            0
                                        ? Container()
                                        : IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            onPressed: () {
                                              Get.to(() =>
                                                  AddProductToVoucherScreen(
                                                    callback: (List<Product>?
                                                        listProduct) {
                                                      createMyVoucherController
                                                          .listSelectedProduct(
                                                              listProduct!);
                                                    },
                                                    listProductInput:
                                                        createMyVoucherController
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
                                () => createMyVoucherController
                                            .listSelectedProduct.length ==
                                        0
                                    ? InkWell(
                                        onTap: () {
                                          Get.to(
                                              () => AddProductToVoucherScreen(
                                                    callback: (List<Product>?
                                                        listProduct) {
                                                      createMyVoucherController
                                                          .listSelectedProduct
                                                          .addAll(listProduct!);
                                                    },
                                                    listProductInput:
                                                        createMyVoucherController
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
                                                color: Theme.of(context)
                                                    .primaryColor,
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
                                            children:
                                                createMyVoucherController
                                                    .listSelectedProduct
                                                    .map(
                                                      (e) => Stack(
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                            ),
                                                            child:
                                                                CachedNetworkImage(
                                                                    width: (Get.width /
                                                                            4) -
                                                                        11,
                                                                    height: 100,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    imageUrl: e.images!.length ==
                                                                            0
                                                                        ? ""
                                                                        : e
                                                                            .images![
                                                                                0]
                                                                            .imageUrl!,
                                                                    errorWidget:
                                                                        (context,
                                                                                url,
                                                                                error) =>
                                                                            Icon(
                                                                              Icons.image,
                                                                              color: Colors.grey,
                                                                              size: 40,
                                                                            )),
                                                          ),
                                                          Positioned(
                                                            top: -10,
                                                            right: -10,
                                                            child: IconButton(
                                                                icon: Icon(
                                                                  Icons.delete,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                                ),
                                                                onPressed: () {
                                                                  createMyVoucherController
                                                                      .deleteProduct(
                                                                          e.id!);
                                                                }),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                    .toList()),
                                      ),
                              ),
                            ],
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
                () => createMyVoucherController.isLoadingCreate.value == true
                    ? IgnorePointer(
                        child: SahaButtonFullParent(
                          text: "Lưu",
                          textColor: Colors.grey[600],
                          onPressed: () {},
                          color: Colors.grey[300],
                        ),
                      )
                    : SahaButtonFullParent(
                        text: "Lưu",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            KeyboardUtil.hideKeyboard(context);
                            createMyVoucherController
                                .listSelectedProductToString();

                            if (createMyVoucherController.discountFor.value !=
                                1) {
                              if (createMyVoucherController
                                      .typeVoucherDiscount.value ==
                                  "Chọn loại giảm giá") {
                                createMyVoucherController
                                    .isChoosedTypeVoucherDiscount.value = false;
                              } else {
                                if (createMyVoucherController
                                        .listSelectedProduct.isEmpty &&
                                    voucherType == 1) {
                                  SahaAlert.showError(
                                      message: "Chưa chọn sản phẩm");
                                } else {
                                  createMyVoucherController.createVoucher(
                                      voucherType:
                                          voucherType); // CREATE VOUCHER
                                  createMyVoucherController
                                      .isChoosedTypeVoucherDiscount
                                      .value = true;
                                }
                              }
                            } else {
                              createMyVoucherController
                                  .createVoucher(); // CREATE VOUCHER
                              createMyVoucherController
                                  .isChoosedTypeVoucherDiscount.value = true;
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
