import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/screen2/maketing_chanel/my_combo/add_product/add_product_combo_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/utils/keyboard.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../components/saha_user/dialog/dialog.dart';
import 'create_combo_controller.dart';

// ignore: must_be_immutable
class CreateMyComboScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  CreateMyComboController createMyComboController = CreateMyComboController();

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
          title: Text('Combo khuyến mãi'),
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
                         
                          if (createMyComboController.group.contains(v)) {
                            createMyComboController.group.remove(v);
                            createMyComboController.group.refresh();
                           if(v == 2){
                            createMyComboController.agencyType.value = [];
                           }
                            if(v == 4){
                            createMyComboController.groupCustomer.value = [];
                           }
                          } else {
                            createMyComboController.group.add(v);
                            createMyComboController.group.refresh();
                          }
                        },
                        groupType: createMyComboController.group);
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Nhóm áp dụng: '),
                                Expanded(
                                  child: Text(
                                      '${createMyComboController.group.contains(0) ? "Tất cả," : ""}${createMyComboController.group.contains(1) ? "Cộng tác viên," : ""}${createMyComboController.group.contains(2) ? "Đại lý," : ""} ${createMyComboController.group.contains(4) ? "Nhóm khách hàng" : ""}${createMyComboController.group.contains(5) ? "Khách lẻ đã đăng nhập," : ""}${createMyComboController.group.contains(6) ? "Khách lẻ chưa đăng nhập" : ""}',overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,),
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
                  Obx(() =>  createMyComboController.group.contains(2)
                      ? InkWell(
                          onTap: () {
                           SahaDialogApp.showDialogAgencyTypev2(
                              onChoose: (v) {
                                if (createMyComboController.agencyType
                                    .contains(v)) {
                                      createMyComboController.agencyType.remove(v);
                                    }else{
                                      createMyComboController.agencyType.add(v);
                                    }
                                
                              },
                              type: createMyComboController.agencyType
                                  .map((e) => e.id ?? 0)
                                  .toList(),
                              listAgencyType: createMyComboController
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Chọn cấp đại lý: '),
                                      Expanded(
                                        child: Text(
                                            createMyComboController.agencyType.isEmpty ? "" : "${createMyComboController.agencyType.map((e) => "${e.name},")}",overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,),
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
                  Obx(() => createMyComboController.group.contains(4)
                      ? InkWell(
                          onTap: () {
                             SahaDialogApp.showDialogCustomerGroupTypev2(
                              onChoose: (v) {
                                if(createMyComboController
                                  .groupCustomer.contains(v)){
                                    createMyComboController.groupCustomer.remove(v);
                                   
                                  }else{
                                    createMyComboController.groupCustomer.add(v);
                                  }
                                
                              },
                              type: createMyComboController
                                  .groupCustomer.map((e) => e.id ?? 0).toList(),
                              listGroupCustomer:
                                  createMyComboController.listGroup.toList());
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
                                            createMyComboController.groupCustomer.isEmpty ? "" : "${createMyComboController.groupCustomer.map((e) => "${e.name},")}",overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,),
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
                            controller: createMyComboController
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
                                            fontSize: 16)), onConfirm: (date) {
                                  createMyComboController
                                      .onChangeDateStart(date);
                                },
                                    currentTime: DateTime.now(),
                                    locale: dp.LocaleType.vi);
                              },
                              child: Text(
                                '${SahaDateUtils().getDDMMYY(createMyComboController.dateStart.value)}',
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
                                          createMyComboController
                                              .dateStart.value.year,
                                          createMyComboController
                                              .dateStart.value.month,
                                          createMyComboController
                                              .dateStart.value.day,
                                          date.hour,
                                          date.minute,
                                          date.second);
                                      if (DateTime.now().isAfter(timeCheck) ==
                                          true) {
                                        createMyComboController
                                            .checkDayStart.value = true;
                                        createMyComboController
                                            .timeStart.value = date;
                                      } else {
                                        createMyComboController
                                            .checkDayStart.value = false;
                                        createMyComboController
                                            .timeStart.value = date;
                                      }
                                    },
                                    currentTime: DateTime.now(),
                                    locale: dp.LocaleType.vi,
                                  );
                                },
                                child: Text(
                                  '  ${SahaDateUtils().getHHMM(createMyComboController.timeStart.value)}',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  createMyComboController.checkDayStart.value
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
                                  createMyComboController.onChangeDateEnd(date);
                                },
                                    currentTime: DateTime.now(),
                                    locale: dp.LocaleType.vi);
                              },
                              child: Text(
                                '${SahaDateUtils().getDDMMYY(createMyComboController.dateEnd.value)}',
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
                                      createMyComboController
                                          .onChangeTimeEnd(date);
                                    },
                                    currentTime: DateTime.now(),
                                    locale: dp.LocaleType.vi,
                                  );
                                },
                                child: Text(
                                  '  ${SahaDateUtils().getHHMM(createMyComboController.timeEnd.value)}',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  createMyComboController.checkDayEnd.value
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
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0))),
                              backgroundColor: Colors.black,
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => Obx(
                                () => Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
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
                                                      createMyComboController
                                                          .discountType.value,
                                                  onChanged: (dynamic v) {
                                                    createMyComboController
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
                                          createMyComboController
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
                                                                createMyComboController
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
                                                                fontSize: 14),
                                                            textAlign:
                                                                TextAlign.start,
                                                            decoration:
                                                                InputDecoration(
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
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(15.0),
                                            child: Row(
                                              children: [
                                                Radio(
                                                  value: DiscountType.k0,
                                                  groupValue:
                                                      createMyComboController
                                                          .discountType.value,
                                                  onChanged: (dynamic v) {
                                                    createMyComboController
                                                        .onChangeRatio(v);
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("Giảm giá theo số tiền")
                                              ],
                                            ),
                                          ),
                                          createMyComboController
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
                                                                createMyComboController
                                                                    .valueEditingController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                              ThousandsFormatter()
                                                            ],
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                            textAlign:
                                                                TextAlign.start,
                                                            decoration:
                                                                InputDecoration(
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
                                          createMyComboController
                                                      .validateComboPercent
                                                      .value ==
                                                  true
                                              ? Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  color: Colors.red[50],
                                                  width: Get.width,
                                                  child: Text(
                                                    "Số lượng và giá trị giảm là bắt buộc",
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
                                          if (createMyComboController
                                              .valueEditingController
                                              .text
                                              .isEmpty) {
                                            createMyComboController
                                                .validateComboPercent
                                                .value = true;
                                          } else {
                                            createMyComboController
                                                .validateComboPercent
                                                .value = false;
                                            KeyboardUtil.hideKeyboard(context);
                                            createMyComboController
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
                              ),
                            );
                          },
                          child: Container(
                            width: Get.width * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  createMyComboController
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
                  createMyComboController.isChoosedTypeVoucherDiscount.value ==
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
                            controller: createMyComboController
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
                  createMyComboController.isCheckMinimumOrderDiscount.value ==
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
                              createMyComboController
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
                                              callback:
                                                  (List<Product>? listProduct) {
                                                createMyComboController
                                                    .listSelectedProduct(
                                                        listProduct!);
                                                createMyComboController
                                                    .listSelectedProductToComboProduct();
                                              },
                                              listProductInput:
                                                  createMyComboController
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
                          () => createMyComboController
                                      .listSelectedProduct.length ==
                                  0
                              ? InkWell(
                                  onTap: () {
                                    Get.to(() => AddProductComboScreen(
                                          callback:
                                              (List<Product>? listProduct) {
                                            createMyComboController
                                                .listSelectedProduct
                                                .addAll(listProduct!);
                                            createMyComboController
                                                .listSelectedProductToComboProduct();
                                          },
                                          listProductInput:
                                              createMyComboController
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
                                          color: Theme.of(context).primaryColor,
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
                                          createMyComboController
                                              .listSelectedProduct
                                              .length, (index) {
                                        var e = createMyComboController
                                            .listSelectedProduct[index];
                                        return Stack(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Theme.of(context)
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
                                                    errorWidget: (context, url,
                                                            error) =>
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
                                                            createMyComboController
                                                                .decreaseAmountProductCombo(
                                                                    index);
                                                          }),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Obx(
                                                        () => Text(
                                                            "${createMyComboController.listSelectedProductParam[index].quantity}"),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      IconButton(
                                                          icon: Icon(Icons.add),
                                                          onPressed: () {
                                                            createMyComboController
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
                                                    createMyComboController
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
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              Obx(
                () => createMyComboController.isLoadingCreate.value == true
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
                            if (createMyComboController
                                    .typeVoucherDiscount.value ==
                                "Chọn") {
                              createMyComboController
                                  .isChoosedTypeVoucherDiscount.value = false;
                            } else {
                              if (createMyComboController
                                  .listSelectedProduct.isEmpty) {
                                SahaAlert.showError(
                                    message: "Chưa chọn sản phẩm");
                              } else {
                                createMyComboController.createCombo();
                                createMyComboController
                                    .isChoosedTypeVoucherDiscount.value = true;
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
