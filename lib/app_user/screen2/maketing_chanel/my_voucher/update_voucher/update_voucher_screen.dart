import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/customer/all_group_customer_res.dart';
import 'package:com.ikitech.store/app_user/screen2/maketing_chanel/my_voucher/update_voucher/voucher_code/voucher_code_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as dp;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/model/voucher.dart';
import 'package:com.ikitech.store/app_user/screen2/maketing_chanel/my_combo/create_my_combo/create_combo_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/maketing_chanel/my_voucher/add_product_to_voucher/add_product_voucher_screen.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/keyboard.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import '../../../../components/saha_user/dialog/dialog.dart';
import '../../../../model/agency_type.dart';
import 'update_voucher_controller.dart';

// ignore: must_be_immutable
class UpdateMyVoucherScreen extends StatefulWidget {
  Voucher? voucher;
  bool? onlyWatch;

  UpdateMyVoucherScreen({this.voucher, this.onlyWatch});

  @override
  _UpdateMyVoucherScreenState createState() => _UpdateMyVoucherScreenState();
}

class _UpdateMyVoucherScreenState extends State<UpdateMyVoucherScreen> {
  final _formKey = GlobalKey<FormState>();

  final _formKeyTypeVoucher = GlobalKey<FormState>();

  late UpdateVoucherController updateVoucherController;

  @override
  void initState() {
    updateVoucherController =
        UpdateVoucherController(voucherInput: widget.voucher);
    // updateVoucherController.listSelectedProduct
    //     .addAll(widget.voucher!.products!);
    // updateVoucherController.nameProgramEditingController.text =
    //     widget.voucher!.name!;
    // updateVoucherController.codeVoucherEditingController.text =
    //     widget.voucher!.code!;
    // updateVoucherController.isShowVoucher.value = widget.voucher?.isShowVoucher ?? true;

    // updateVoucherController.dateStart.value = DateTime(
    //   widget.voucher!.startTime!.year,
    //   widget.voucher!.startTime!.month,
    //   widget.voucher!.startTime!.day,
    //   widget.voucher!.startTime!.hour,
    //   widget.voucher!.startTime!.minute,
    //   widget.voucher!.startTime!.second,
    //   widget.voucher!.startTime!.millisecond,
    //   widget.voucher!.startTime!.microsecond,
    // );
    // updateVoucherController.dateEnd.value = DateTime(
    //   widget.voucher!.endTime!.year,
    //   widget.voucher!.endTime!.month,
    //   widget.voucher!.endTime!.day,
    //   widget.voucher!.endTime!.hour,
    //   widget.voucher!.endTime!.minute,
    //   widget.voucher!.endTime!.second,
    //   widget.voucher!.endTime!.millisecond,
    //   widget.voucher!.endTime!.microsecond,
    // );
    // updateVoucherController.timeStart.value = DateTime(
    //   widget.voucher!.startTime!.year,
    //   widget.voucher!.startTime!.month,
    //   widget.voucher!.startTime!.day,
    //   widget.voucher!.startTime!.hour,
    //   widget.voucher!.startTime!.minute,
    //   widget.voucher!.startTime!.second,
    //   widget.voucher!.startTime!.millisecond,
    //   widget.voucher!.startTime!.microsecond,
    // );
    // updateVoucherController.timeEnd.value = DateTime(
    //   widget.voucher!.endTime!.year,
    //   widget.voucher!.endTime!.month,
    //   widget.voucher!.endTime!.day,
    //   widget.voucher!.endTime!.hour,
    //   widget.voucher!.endTime!.minute,
    //   widget.voucher!.endTime!.second,
    //   widget.voucher!.endTime!.millisecond,
    //   widget.voucher!.endTime!.microsecond,
    // );
    // updateVoucherController.discountTypeInput.value =
    //     widget.voucher!.discountType ?? 0;
    // updateVoucherController.voucherTypeInput.value =
    //     widget.voucher!.voucherType ?? 0;

    // if (widget.voucher?.discountFor != 1) {
    //   if (widget.voucher!.discountType! == 1) {
    //     updateVoucherController.pricePercentEditingController.text =
    //         SahaStringUtils()
    //             .convertToUnit(widget.voucher!.valueDiscount!.toString());
    //   } else {
    //     updateVoucherController.pricePermanentEditingController.text =
    //         SahaStringUtils()
    //             .convertToUnit(widget.voucher!.valueDiscount.toString());
    //   }
    // }

    // updateVoucherController.priceDiscountLimitedEditingController.text =
    //     widget.voucher!.maxValueDiscount == null
    //         ? ""
    //         : SahaStringUtils()
    //             .convertToUnit(widget.voucher!.maxValueDiscount.toString());
    // updateVoucherController.isLimitedPrice.value =
    //     widget.voucher!.setLimitValueDiscount!;
    // updateVoucherController.minimumOrderEditingController.text =
    //     SahaStringUtils()
    //         .convertToUnit(widget.voucher!.valueLimitTotal.toString());
    // updateVoucherController.amountCodeAvailableEditingController.text =
    //     widget.voucher!.amount == null
    //         ? ""
    //         : SahaStringUtils()
    //             .convertToUnit(widget.voucher!.amount.toString());
    // updateVoucherController.checkTypeDiscountInput();
    // updateVoucherController.onChangeRatio(
    //     (widget.voucher!.discountType ?? 0) == 0
    //         ? DiscountType.k1
    //         : DiscountType.k0);

    // updateVoucherController.discountFor.value =
    //     widget.voucher?.discountFor ?? 0;
    // updateVoucherController.isFreeShip.value =
    //     widget.voucher?.isFreeShip ?? false;
    // updateVoucherController.valueShipEdit.text =
    //     widget.voucher!.shipDiscountValue == null
    //         ? ""
    //         : SahaStringUtils()
    //             .convertToUnit(widget.voucher!.shipDiscountValue.toString());
    // updateVoucherController.group.value = widget.voucher?.group ?? [];
    // updateVoucherController.agencyType.value =
    //     widget.voucher?.agencyTypes ?? [];
    // updateVoucherController.groupCustomer.value =
    //     widget.voucher?.groupTypes ?? [];
    // updateVoucherController.isUseOnce.value =
    //     widget.voucher?.isUseOnce ?? false;
    // updateVoucherController.isUseOnceCodeMultipleTime.value =
    //     widget.voucher?.isUseOnceCodeMultipleTime ?? true;
    // updateVoucherController.amountUseOnce.text =
    //     widget.voucher?.amountUseOnce == null
    //         ? ""
    //         : widget.voucher!.amountUseOnce!.toString();
    // updateVoucherController.voucherLength.text =
    //     widget.voucher?.voucherLength == null
    //         ? ""
    //         : widget.voucher!.voucherLength!.toString();
    // updateVoucherController.startingCharacter.text =
    //     widget.voucher?.startingCharacter == null
    //         ? ""
    //         : widget.voucher!.startingCharacter!.toString();
    // updateVoucherController.isPublic.value = widget.voucher?.isPublic ?? true;
    super.initState();
  }

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
          title: Text('Sửa chương trình khuyến mãi'),
        ),
        body: Obx(
          () => updateVoucherController.loadInit.value
              ? SahaLoadingFullScreen()
              : IgnorePointer(
                  ignoring: widget.onlyWatch ?? false,
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
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
                                    if (updateVoucherController.group
                                        .contains(v)) {
                                      updateVoucherController.group.remove(v);
                                      updateVoucherController.group.refresh();
                                      if (v == 2) {
                                        updateVoucherController
                                            .agencyType.value = [];
                                      }
                                      if (v == 4) {
                                        updateVoucherController
                                            .groupCustomer.value = [];
                                      }
                                    } else {
                                      updateVoucherController.group.add(v);
                                      updateVoucherController.group.refresh();
                                    }
                                  },
                                  groupType: updateVoucherController.group);
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
                                              '${updateVoucherController.group.contains(0) ? "Tất cả," : ""}${updateVoucherController.group.contains(1) ? "Cộng tác viên," : ""}${updateVoucherController.group.contains(2) ? "Đại lý," : ""} ${updateVoucherController.group.contains(4) ? "Nhóm khách hàng" : ""}${updateVoucherController.group.contains(5) ? "Khách lẻ đã đăng nhập" : ""}${updateVoucherController.group.contains(6) ? "Khách lẻ chưa đăng nhập" : ""}',
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
                          Obx(() => updateVoucherController.group.contains(2)
                              ? InkWell(
                                  onTap: () {
                                    SahaDialogApp.showDialogAgencyTypev2(
                                        onChoose: (v) {
                                          if (updateVoucherController.agencyType
                                              .contains(v)) {
                                            updateVoucherController.agencyType
                                                .remove(v);
                                          } else {
                                            updateVoucherController.agencyType
                                                .add(v);
                                          }
                                        },
                                        type: updateVoucherController.agencyType
                                            .map((e) => e.id ?? 0)
                                            .toList(),
                                        listAgencyType: updateVoucherController
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Chọn cấp đại lý: '),
                                                Expanded(
                                                  child: Text(
                                                    updateVoucherController
                                                            .agencyType.isEmpty
                                                        ? ""
                                                        : "${updateVoucherController.agencyType.map((e) => "${e.name},")}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                          Obx(() => updateVoucherController.group.contains(4)
                              ? InkWell(
                                  onTap: () {
                                    SahaDialogApp.showDialogCustomerGroupTypev2(
                                        onChoose: (v) {
                                          if (updateVoucherController
                                              .groupCustomer
                                              .contains(v)) {
                                            updateVoucherController
                                                .groupCustomer
                                                .remove(v);
                                          } else {
                                            updateVoucherController
                                                .groupCustomer
                                                .add(v);
                                          }
                                        },
                                        type: updateVoucherController
                                            .groupCustomer
                                            .map((e) => e.id ?? 0)
                                            .toList(),
                                        listGroupCustomer:
                                            updateVoucherController.listGroup
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                                    updateVoucherController
                                                            .groupCustomer
                                                            .isEmpty
                                                        ? ""
                                                        : "${updateVoucherController.groupCustomer.map((e) => "${e.name},")}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                    controller: updateVoucherController
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
                                          value: updateVoucherController
                                                  .isUseOnceCodeMultipleTime
                                                  .value ==
                                              true,
                                          onChanged: (v) {}),
                                    ),
                                    Text('Một mã sử dụng nhiều lần')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: updateVoucherController
                                                .isUseOnceCodeMultipleTime
                                                .value ==
                                            false,
                                        onChanged: (v) {}),
                                    Text('Nhiều mã chỉ sử dụng 1 lần')
                                  ],
                                )
                              ],
                            ),
                          ),
                          if (updateVoucherController
                                  .isUseOnceCodeMultipleTime.value ==
                              true)
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Mã giảm giá"),
                                  Container(
                                    width: Get.width * 0.5,
                                    child: TextFormField(
                                      controller: updateVoucherController
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
                                                    fontSize: 16)),
                                            onConfirm: (date) {
                                          updateVoucherController
                                              .onChangeDateStart(date);
                                        },
                                            currentTime: DateTime.now(),
                                            locale: dp.LocaleType.vi);
                                      },
                                      child: Text(
                                        '${SahaDateUtils().getDDMMYY(updateVoucherController.dateStart.value)}',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          dp.DatePicker.showTime12hPicker(
                                            context,
                                            showTitleActions: true,
                                            onChanged: (date) {
                                              print(
                                                  'change $date in time zone ' +
                                                      date.timeZoneOffset
                                                          .inHours
                                                          .toString());
                                            },
                                            onConfirm: (date) {
                                              var timeCheck = DateTime(
                                                  updateVoucherController
                                                      .dateStart.value.year,
                                                  updateVoucherController
                                                      .dateStart.value.month,
                                                  updateVoucherController
                                                      .dateStart.value.day,
                                                  date.hour,
                                                  date.minute,
                                                  date.second);
                                              if (DateTime.now()
                                                      .isAfter(timeCheck) ==
                                                  true) {
                                                updateVoucherController
                                                    .checkDayStart.value = true;
                                                updateVoucherController
                                                    .timeStart.value = date;
                                              } else {
                                                updateVoucherController
                                                    .checkDayStart
                                                    .value = false;
                                                updateVoucherController
                                                    .timeStart.value = date;
                                              }
                                            },
                                            currentTime: DateTime.now(),
                                            locale: dp.LocaleType.vi,
                                          );
                                        },
                                        child: Text(
                                          '  ${SahaDateUtils().getHHMM(updateVoucherController.timeStart.value)}',
                                          style: TextStyle(color: Colors.blue),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          updateVoucherController.checkDayStart.value
                              ? Container(
                                  padding: EdgeInsets.all(8.0),
                                  color: Colors.red[50],
                                  width: Get.width,
                                  child: Text(
                                    "Vui lòng nhập thời gian bắt đầu chương trình khuyến mãi sau thời gian hiện tại",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.red),
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
                                            onChanged: (date) {},
                                            onConfirm: (date) {
                                          updateVoucherController
                                              .onChangeDateEnd(date);
                                        },
                                            currentTime: DateTime.now(),
                                            locale: dp.LocaleType.vi);
                                      },
                                      child: Text(
                                        '${SahaDateUtils().getDDMMYY(updateVoucherController.dateEnd.value)}',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          dp.DatePicker.showTime12hPicker(
                                            context,
                                            showTitleActions: true,
                                            onChanged: (date) {
                                              print(
                                                  'change $date in time zone ' +
                                                      date.timeZoneOffset
                                                          .inHours
                                                          .toString());
                                            },
                                            onConfirm: (date) {
                                              updateVoucherController
                                                  .onChangeTimeEnd(date);
                                            },
                                            currentTime: DateTime.now(),
                                            locale: dp.LocaleType.vi,
                                          );
                                        },
                                        child: Text(
                                          '  ${SahaDateUtils().getHHMM(updateVoucherController.timeEnd.value)}',
                                          style: TextStyle(color: Colors.blue),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          updateVoucherController.checkDayEnd.value
                              ? Container(
                                  padding: EdgeInsets.all(8.0),
                                  color: Colors.red[50],
                                  width: Get.width,
                                  child: Text(
                                    "Thời gian kết thúc phải sau thời gian bắt đầu",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.red),
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
                                        value: updateVoucherController
                                                    .discountFor.value !=
                                                1
                                            ? true
                                            : false,
                                        onChanged: (v) {
                                          updateVoucherController
                                              .discountFor.value = 0;
                                          updateVoucherController
                                              .typeVoucherDiscount
                                              .value = "Chọn loại giảm giá";
                                        }),
                                    Spacer(),
                                    Text('Giảm giá vận chuyển'),
                                    Checkbox(
                                        value: updateVoucherController
                                                    .discountFor.value ==
                                                1
                                            ? true
                                            : false,
                                        onChanged: (v) {
                                          updateVoucherController
                                              .discountFor.value = 1;
                                          updateVoucherController
                                              .isChoosedTypeVoucherDiscount
                                              .value = true;
                                        }),
                                  ],
                                )
                              ],
                            ),
                          ),
                          if (updateVoucherController.discountFor.value == 1)
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Text('Miễn phí vận chuyển'),
                                      Checkbox(
                                          value: updateVoucherController
                                              .isFreeShip.value,
                                          onChanged: (v) {
                                            updateVoucherController
                                                    .isFreeShip.value =
                                                !updateVoucherController
                                                    .isFreeShip.value;
                                          }),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                if (updateVoucherController.isFreeShip.value ==
                                    false)
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Giá trị giảm"),
                                        Container(
                                          width: Get.width * 0.7,
                                          child: TextFormField(
                                            controller: updateVoucherController
                                                .valueShipEdit,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              ThousandsFormatter()
                                            ],
                                            validator: (value) {
                                              if (updateVoucherController
                                                      .discountFor.value ==
                                                  1) {
                                                if (updateVoucherController
                                                        .isFreeShip ==
                                                    false) {
                                                  if (value != null &&
                                                      value != '') {
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
                          if (updateVoucherController.discountFor.value != 1)
                            Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Loại giảm giá"),
                                  Expanded(
                                    child: InkWell(
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
                                                      bottom:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom),
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15.0),
                                                            child: Row(
                                                              children: [
                                                                Radio(
                                                                  value:
                                                                      DiscountType
                                                                          .k1,
                                                                  groupValue:
                                                                      updateVoucherController
                                                                          .discountType
                                                                          .value,
                                                                  onChanged:
                                                                      (dynamic
                                                                          v) {
                                                                    updateVoucherController
                                                                        .onChangeRatio(
                                                                            v);
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
                                                          updateVoucherController
                                                                      .discountType
                                                                      .value ==
                                                                  DiscountType
                                                                      .k1
                                                              ? Container(
                                                                  height: 55,
                                                                  width:
                                                                      Get.width *
                                                                          0.7,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        "đ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey[600]),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              updateVoucherController.pricePermanentEditingController,
                                                                          keyboardType:
                                                                              TextInputType.number,
                                                                          inputFormatters: [
                                                                            ThousandsFormatter()
                                                                          ],
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.length <
                                                                                1) {
                                                                              return 'Chưa nhập giá trị muốn giảm';
                                                                            } else {
                                                                              var myInt = int.parse(SahaStringUtils().convertFormatText(value));
                                                                              if (myInt > 100000000) {
                                                                                return '% giảm giá không được quá 100 triệu';
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
                                                              : Container(),
                                                        ],
                                                      ),
                                                      Divider(
                                                        height: 1,
                                                      ),
                                                      Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    15.0),
                                                            child: Row(
                                                              children: [
                                                                Radio(
                                                                  value:
                                                                      DiscountType
                                                                          .k0,
                                                                  groupValue:
                                                                      updateVoucherController
                                                                          .discountType
                                                                          .value,
                                                                  onChanged:
                                                                      (dynamic
                                                                          v) {
                                                                    updateVoucherController
                                                                        .onChangeRatio(
                                                                            v);
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                    "Giảm giá (Theo %)")
                                                              ],
                                                            ),
                                                          ),
                                                          updateVoucherController
                                                                      .discountType
                                                                      .value ==
                                                                  DiscountType
                                                                      .k0
                                                              ? Container(
                                                                  width:
                                                                      Get.width *
                                                                          0.7,
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
                                                                              maxLength: 2,
                                                                              controller: updateVoucherController.pricePercentEditingController,
                                                                              keyboardType: TextInputType.number,
                                                                              inputFormatters: [
                                                                                FilteringTextInputFormatter.deny(RegExp("[,.]")),
                                                                              ],
                                                                              validator: (value) {
                                                                                if (value!.length < 1) {
                                                                                  return 'Chưa nhập % giảm giá';
                                                                                } else {
                                                                                  var myInt = double.parse(value);
                                                                                  if (myInt > 99) {
                                                                                    return '% giảm giá không được quá 99 %';
                                                                                  }
                                                                                  return null;
                                                                                }
                                                                              },
                                                                              style: TextStyle(fontSize: 14),
                                                                              textAlign: TextAlign.start,
                                                                              decoration: InputDecoration(counterText: "", isDense: true, border: InputBorder.none, hintText: "Nhập giá trị bạn muốn giảm"),
                                                                              minLines: 1,
                                                                              maxLines: 1,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                10,
                                                                          ),
                                                                          Text(
                                                                            "% Giảm",
                                                                            style:
                                                                                TextStyle(color: Colors.grey[600]),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Divider(
                                                                        height:
                                                                            1,
                                                                      ),
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                            "Giảm tối đa"),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          InkWell(
                                                                              onTap: () {
                                                                                updateVoucherController.isLimitedPrice.value = true;
                                                                              },
                                                                              child: updateVoucherController.isLimitedPrice.value == true
                                                                                  ? Container(
                                                                                      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(5)),
                                                                                      height: 40,
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          "chọn mức giảm",
                                                                                          style: TextStyle(
                                                                                            color: Theme.of(context).primaryColor,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      padding: EdgeInsets.all(8.0),
                                                                                    )
                                                                                  : Container(
                                                                                      decoration: BoxDecoration(border: Border.all(color: Colors.grey[600]!), borderRadius: BorderRadius.circular(5)),
                                                                                      height: 40,
                                                                                      child: Center(
                                                                                        child: Text(
                                                                                          "chọn mức giảm",
                                                                                          style: TextStyle(color: Colors.grey[600]),
                                                                                        ),
                                                                                      ),
                                                                                      padding: EdgeInsets.all(8.0),
                                                                                    )),
                                                                          Spacer(),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              updateVoucherController.isLimitedPrice.value = false;
                                                                              updateVoucherController.priceDiscountLimitedEditingController.text = "";
                                                                            },
                                                                            child: updateVoucherController.isLimitedPrice.value == false
                                                                                ? Container(
                                                                                    padding: EdgeInsets.all(8.0),
                                                                                    decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(5)),
                                                                                    height: 40,
                                                                                    child: Center(
                                                                                      child: Text(
                                                                                        "Không giới hạn",
                                                                                        style: TextStyle(
                                                                                          color: Theme.of(context).primaryColor,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : Container(
                                                                                    padding: EdgeInsets.all(8.0),
                                                                                    decoration: BoxDecoration(border: Border.all(color: Colors.grey[600]!), borderRadius: BorderRadius.circular(5)),
                                                                                    height: 40,
                                                                                    child: Center(
                                                                                      child: Text(
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
                                                                      updateVoucherController.isLimitedPrice.value ==
                                                                              true
                                                                          ? Container(
                                                                              padding: EdgeInsets.all(8),
                                                                              child: Row(
                                                                                children: [
                                                                                  Text(
                                                                                    "đ",
                                                                                    style: TextStyle(color: Colors.grey[600]),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: TextFormField(
                                                                                      controller: updateVoucherController.priceDiscountLimitedEditingController,
                                                                                      keyboardType: TextInputType.number,
                                                                                      inputFormatters: [
                                                                                        ThousandsFormatter()
                                                                                      ],
                                                                                      validator: (value) {
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
                                                                                      style: TextStyle(fontSize: 14),
                                                                                      textAlign: TextAlign.start,
                                                                                      decoration: InputDecoration(isDense: true, border: InputBorder.none, hintText: "Nhập giá trị bạn muốn giảm"),
                                                                                      minLines: 1,
                                                                                      maxLines: 1,
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
                                                            updateVoucherController
                                                                    .isSaveTypeDiscount =
                                                                true;
                                                            _formKeyTypeVoucher
                                                                .currentState!
                                                                .save();
                                                            KeyboardUtil
                                                                .hideKeyboard(
                                                                    context);
                                                            updateVoucherController
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
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            )
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            updateVoucherController
                                                .typeVoucherDiscount.value,
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                          Icon(Icons.arrow_forward_ios_rounded),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          updateVoucherController
                                      .isChoosedTypeVoucherDiscount.value ==
                                  false
                              ? Container(
                                  padding: EdgeInsets.all(8.0),
                                  color: Colors.red[50],
                                  width: Get.width,
                                  child: Text(
                                    "Chưa chọn loại giảm giá",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.red),
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
                                    controller: updateVoucherController
                                        .minimumOrderEditingController,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    validator: (value) {
                                      if (value!.length < 1) {
                                        return 'Chưa nhập giá trị tối thiểu đơn hàng';
                                      } else {
                                        if (updateVoucherController
                                            .pricePermanentEditingController
                                            .text
                                            .isEmpty) {
                                          return null;
                                        } else {
                                          var myInt = double.parse(
                                              SahaStringUtils()
                                                  .convertFormatText(value));
                                          var pricePermanent = double.parse(
                                              SahaStringUtils().convertFormatText(
                                                  updateVoucherController
                                                      .pricePermanentEditingController
                                                      .text));
                                          if (myInt < pricePermanent) {
                                            updateVoucherController
                                                .isCheckMinimumOrderDiscount
                                                .value = false;
                                            return "";
                                          } else {
                                            updateVoucherController
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
                          updateVoucherController
                                      .isCheckMinimumOrderDiscount.value ==
                                  false
                              ? Container(
                                  padding: EdgeInsets.all(8.0),
                                  color: Colors.red[50],
                                  width: Get.width,
                                  child: Text(
                                    "Giá trị voucher không thể vượt quá giá trị tối thiểu của đơn hàng",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.red),
                                  ),
                                )
                              : Divider(
                                  height: 1,
                                ),
                          Obx(() => updateVoucherController
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
                                                value: updateVoucherController
                                                    .isUseOnce.value,
                                                onChanged: (v) {
                                                  updateVoucherController
                                                      .isUseOnce.value = v;
                                                })
                                          ],
                                        )),
                                    const Divider(),
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
                                              controller: updateVoucherController
                                                  .amountCodeAvailableEditingController,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                ThousandsFormatter()
                                              ],
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
                                                      updateVoucherController
                                                          .isPublic
                                                          .value = true;

                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      height: 80,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Hiện thị",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "Các Mã voucher được hiển thị trong phần thanh toán hóa đơn",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
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
                                                      updateVoucherController
                                                          .isPublic
                                                          .value = false;

                                                      Get.back();
                                                    },
                                                    child: Container(
                                                      height: 80,
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Không hiển thị",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            "Các Mã voucher được ẩn đi và chỉ được sử dụng khi nhập đúng Mã voucher",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
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
                                                                  FontWeight
                                                                      .w400),
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
                                                  updateVoucherController
                                                              .isPublic.value ==
                                                          true
                                                      ? Text("Hiển thị")
                                                      : Text("Không hiển thị"),
                                                  Icon(
                                                    Icons
                                                        .arrow_forward_ios_rounded,
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
                                              readOnly: true,
                                              controller:
                                                  updateVoucherController
                                                      .amountUseOnce,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                ThousandsFormatter()
                                              ],
                                              // validator: (value) {
                                              //   if (value!.length < 1) {
                                              //     return 'Chưa nhập số mã có thể sử dụng';
                                              //   } else {
                                              //     return null;
                                              //   }
                                              // },
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
                                  ],
                                )),
                          SizedBox(
                            height: 8,
                          ),
                          if (updateVoucherController
                                  .isUseOnceCodeMultipleTime.value ==
                              false)
                            Column(
                              children: [
                                Card(
                                  child: ListTile(
                                    onTap: () {
                                      Get.to(() => VoucherCodeScreen(
                                          voucherId: widget.voucher?.id ?? 0));
                                    },
                                    title: Text("Danh sách mã voucher"),
                                    trailing: Icon(Icons.keyboard_arrow_right),
                                  ),
                                )
                              ],
                            ),
                          widget.voucher!.voucherType == 1
                              ? Container(
                                  color: Colors.white,
                                  width: Get.width,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Obx(
                                        () => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Sản phẩm'),
                                            updateVoucherController
                                                        .listSelectedProduct
                                                        .length ==
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
                                                            callback: (List<
                                                                    Product>?
                                                                listProduct) {
                                                              updateVoucherController
                                                                  .listSelectedProduct(
                                                                      listProduct!);
                                                            },
                                                            listProductInput:
                                                                updateVoucherController
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
                                        () => updateVoucherController
                                                    .listSelectedProduct
                                                    .length ==
                                                0
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          AddProductToVoucherScreen(
                                                            callback: (List<
                                                                    Product>?
                                                                listProduct) {
                                                              updateVoucherController
                                                                  .listSelectedProduct
                                                                  .addAll(
                                                                      listProduct!);
                                                            },
                                                            listProductInput:
                                                                updateVoucherController
                                                                    .listSelectedProduct,
                                                          ));
                                                    },
                                                    child: Container(
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.add,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                          ),
                                                          Text(
                                                            'Thêm sản phẩm',
                                                            style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                            textAlign: TextAlign
                                                                .center,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    color: Colors.red[50],
                                                    width: Get.width,
                                                    child: Text(
                                                      "Voucher sẽ chuyển sang kiểu sử dụng cho toàn Shop nếu bạn không chọn sản phẩm",
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: Colors.red),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Container(
                                                height: 400,
                                                child: StaggeredGridView
                                                    .countBuilder(
                                                  crossAxisCount: 4,
                                                  itemCount:
                                                      updateVoucherController
                                                          .listSelectedProduct
                                                          .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                              int index) =>
                                                          Stack(
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
                                                          height: 100,
                                                          width: Get.width / 4,
                                                          fit: BoxFit.cover,
                                                          imageUrl: updateVoucherController
                                                                      .listSelectedProduct[
                                                                          index]
                                                                      .images!
                                                                      .length ==
                                                                  0
                                                              ? ""
                                                              : updateVoucherController
                                                                  .listSelectedProduct[
                                                                      index]
                                                                  .images![0]
                                                                  .imageUrl!,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Container(
                                                                  height: 100,
                                                                  width:
                                                                      Get.width /
                                                                          4,
                                                                  child: Icon(
                                                                    Icons.image,
                                                                    color: Colors
                                                                        .grey,
                                                                    size: 40,
                                                                  )),
                                                        ),
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
                                                              updateVoucherController
                                                                  .deleteProduct(
                                                                      updateVoucherController
                                                                          .listSelectedProduct[
                                                                              index]
                                                                          .id!);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                  staggeredTileBuilder: (int
                                                          index) =>
                                                      new StaggeredTile.fit(1),
                                                  mainAxisSpacing: 10,
                                                  crossAxisSpacing: 10,
                                                ),
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
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              Obx(
                () => updateVoucherController.isLoadingCreate.value == true
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
                                updateVoucherController
                                    .listSelectedProductToString();
                                if (updateVoucherController.discountFor.value !=
                                    1) {
                                  if (updateVoucherController
                                          .typeVoucherDiscount.value ==
                                      "Chọn loại giảm giá") {
                                    updateVoucherController
                                        .isChoosedTypeVoucherDiscount
                                        .value = false;
                                  } else {
                                    updateVoucherController
                                        .updateVoucher(widget.voucher!.id);
                                    updateVoucherController
                                        .isChoosedTypeVoucherDiscount
                                        .value = true;
                                  }
                                } else {
                                  updateVoucherController
                                      .updateVoucher(widget.voucher!.id);
                                  updateVoucherController
                                      .isChoosedTypeVoucherDiscount
                                      .value = true;
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
