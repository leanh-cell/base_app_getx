import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/customer/all_group_customer_res.dart';
import 'package:com.ikitech.store/app_user/model/agency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/model/discount_product_list.dart';
import 'package:com.ikitech.store/app_user/screen2/maketing_chanel/my_program/add_product/add_product_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/keyboard.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../components/saha_user/dialog/dialog.dart';
import '../../../../model/agency_type.dart';
import '../my_program_controller.dart';
import 'update_my_program_controller.dart';


class UpdateMyProgram extends StatefulWidget {
  DiscountProductsList? programDiscount;
  bool? onlyWatch;

  UpdateMyProgram({this.programDiscount, this.onlyWatch});

  @override
  _UpdateMyProgramState createState() => _UpdateMyProgramState();
}

class _UpdateMyProgramState extends State<UpdateMyProgram> {
  final _formKey = GlobalKey<FormState>();
  late DateTime dateStart;
  late DateTime timeStart;
  late DateTime dateEnd;
  late DateTime timeEnd;
  UpdateMyProgramController updateMyProgramController =
      Get.put(UpdateMyProgramController());
  MyProgramController myProgramController = Get.find();
  bool checkDayStart = false;
  bool checkDayEnd = false;
  TextEditingController nameProgramEditingController =
      new TextEditingController();
  TextEditingController discountEditingController = new TextEditingController();
  TextEditingController quantityEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    updateMyProgramController.listSelectedProduct.value
        .addAll(widget.programDiscount!.products!);
    dateStart = widget.programDiscount!.startTime ?? DateTime.now();
    timeStart = widget.programDiscount!.startTime ?? DateTime.now();
    dateEnd = widget.programDiscount!.endTime ?? DateTime.now();
    timeEnd = widget.programDiscount!.endTime ?? DateTime.now();
    nameProgramEditingController.text = widget.programDiscount!.name!;
    discountEditingController.text = SahaStringUtils()
        .convertToMoney(widget.programDiscount!.value.toString());
    quantityEditingController.text = widget.programDiscount!.amount == null
        ? ""
        : widget.programDiscount!.amount.toString();
    updateMyProgramController.group.value = widget.programDiscount?.group ?? [];
    updateMyProgramController.agencyType.value = widget.programDiscount?.agencyTypes ?? [];
    updateMyProgramController.groupCustomer.value =
      widget.programDiscount?.groupTypes ?? [];
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
          title: Text('Chỉnh sửa khuyến mãi'),
        ),
        body: IgnorePointer(
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
                         
                          if (updateMyProgramController.group.contains(v)) {
                            updateMyProgramController.group.remove(v);
                            updateMyProgramController.group.refresh();
                           if(v == 2){
                            updateMyProgramController.agencyType.value = [];
                           }
                            if(v == 4){
                            updateMyProgramController.groupCustomer.value = [];
                           }
                          } else {
                            updateMyProgramController.group.add(v);
                            updateMyProgramController.group.refresh();
                          }
                        },
                        groupType: updateMyProgramController.group);
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
                                      '${updateMyProgramController.group.contains(0) ? "Tất cả," : ""}${updateMyProgramController.group.contains(1) ? "Cộng tác viên," : ""}${updateMyProgramController.group.contains(2) ? "Đại lý," : ""} ${updateMyProgramController.group.contains(4) ? "Nhóm khách hàng" : ""}${updateMyProgramController.group.contains(5) ? "Khách lẻ đã đăng nhập" : ""}${updateMyProgramController.group.contains(6) ? "Khách lẻ chưa đăng nhập" : ""}',overflow: TextOverflow.ellipsis,),
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
                  Obx(() => updateMyProgramController.group.contains(2)
                      ? InkWell(
                          onTap: () {
                          SahaDialogApp.showDialogAgencyTypev2(
                              onChoose: (v) {
                                if (updateMyProgramController.agencyType
                                    .contains(v)) {
                                      updateMyProgramController.agencyType.remove(v);
                                    }else{
                                      updateMyProgramController.agencyType.add(v);
                                    }
                                
                              },
                              type: updateMyProgramController.agencyType
                                  .map((e) => e.id ?? 0)
                                  .toList(),
                              listAgencyType: updateMyProgramController
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
                                    () =>  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Chọn cấp đại lý: '),
                                      Expanded(
                                        child: Text(
                                            updateMyProgramController.agencyType.isEmpty ? "" : "${updateMyProgramController.agencyType.map((e) => "${e.name},")}",overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,),
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
                  Obx(() => updateMyProgramController.group.contains(4)
                      ? InkWell(
                          onTap: () {
                          SahaDialogApp.showDialogCustomerGroupTypev2(
                              onChoose: (v) {
                                if(updateMyProgramController
                                  .groupCustomer.contains(v)){
                                    updateMyProgramController.groupCustomer.remove(v);
                                   
                                  }else{
                                    updateMyProgramController.groupCustomer.add(v);
                                  }
                                
                              },
                              type: updateMyProgramController
                                  .groupCustomer.map((e) => e.id ?? 0).toList(),
                              listGroupCustomer:
                                  updateMyProgramController.listGroup.toList());
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
                                    () =>  Row(
                                    children: [
                                      Text('Chọn nhóm khách hàng: '),
                                      Expanded(
                                        child: Text(
                                            updateMyProgramController.groupCustomer.isEmpty ? "" : "${updateMyProgramController.groupCustomer.map((e) => "${e.name},")}",overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,),
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
                            controller: nameProgramEditingController,
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
                                            color: Colors.black, fontSize: 16)),
                                    onChanged: (date) {}, onConfirm: (date) {
                                  if (date.isBefore(dateStart) == true) {
                                    setState(() {
                                      checkDayStart = true;
                                      dateStart = date;
                                    });
                                  } else {
                                    setState(() {
                                      checkDayStart = false;
                                      dateStart = date;
                                    });
                                  }
                                },
                                    currentTime: DateTime.now(),
                                    locale:dp.LocaleType.vi);
                              },
                              child: Text(
                                '${SahaDateUtils().getDDMMYY(dateStart)}',
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
                                          dateStart.year,
                                          dateStart.month,
                                          dateStart.day,
                                          date.hour,
                                          date.minute,
                                          date.second);
                                      if (DateTime.now().isAfter(timeCheck) ==
                                          true) {
                                        setState(() {
                                          checkDayStart = true;
                                          timeStart = date;
                                        });
                                      } else {
                                        setState(() {
                                          checkDayStart = false;
                                          timeStart = date;
                                        });
                                      }
                                    },
                                    currentTime: DateTime.now(),
                                    locale: dp.LocaleType.vi,
                                  );
                                },
                                child: Text(
                                  '  ${SahaDateUtils().getHHMM(timeStart)}',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  checkDayStart
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
                                  if (date.isBefore(dateStart) == true) {
                                    setState(() {
                                      checkDayEnd = true;
                                      dateEnd = date;
                                    });
                                  } else {
                                    setState(() {
                                      checkDayEnd = false;
                                      dateEnd = date;
                                    });
                                  }
                                },
                                    currentTime: DateTime.now(),
                                    locale: dp.LocaleType.vi);
                              },
                              child: Text(
                                '${SahaDateUtils().getDDMMYY(dateEnd)}',
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
                                      if (date.isBefore(timeStart) == true) {
                                        setState(() {
                                          checkDayEnd = true;
                                          timeEnd = date;
                                        });
                                      } else {
                                        setState(() {
                                          checkDayEnd = false;
                                          timeEnd = date;
                                        });
                                      }
                                    },
                                    currentTime: DateTime.now(),
                                    locale: dp.LocaleType.vi,
                                  );
                                },
                                child: Text(
                                  '  ${SahaDateUtils().getHHMM(timeEnd)}',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  checkDayEnd
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
                        Text("Giảm giá"),
                        Container(
                          width: Get.width * 0.5,
                          child: TextFormField(
                            controller: discountEditingController,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp("[,.]")),
                            ],
                            validator: (value) {
                              if (value!.length < 1) {
                                return 'Chưa nhập % giảm giá';
                              } else {
                                var myInt = double.parse(value);
                                if (myInt > 50) {
                                  return '% giảm giá không được quá 50 %';
                                }
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                                counterText: "",
                                isDense: true,
                                border: InputBorder.none,
                                suffixText: "%",
                                hintText: "% Giảm"),
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
                              Text('Sản phẩm'),
                              updateMyProgramController
                                          .listSelectedProduct.length ==
                                      0
                                  ? Container()
                                  : IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      onPressed: () {
                                        Get.to(() => AddProductToSaleScreen(
                                              callback:
                                                  (List<Product>? listProduct) {
                                                updateMyProgramController
                                                    .listSelectedProduct(
                                                        listProduct!);
                                              },
                                              listProductInput:
                                                  updateMyProgramController
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
                          () => updateMyProgramController
                                      .listSelectedProduct.length ==
                                  0
                              ? InkWell(
                                  onTap: () {
                                    Get.to(() => AddProductToSaleScreen(
                                          callback:
                                              (List<Product>? listProduct) {
                                            updateMyProgramController
                                                .listSelectedProduct
                                                .addAll(listProduct!);
                                          },
                                          listProductInput:
                                              updateMyProgramController
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
                                      children: updateMyProgramController
                                          .listSelectedProduct
                                          .map(
                                            (e) => Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                  child: CachedNetworkImage(
                                                      width:
                                                          (Get.width / 4) - 11,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          e.images!.length == 0
                                                              ? ""
                                                              : e.images![0]
                                                                  .imageUrl!,
                                                      errorWidget: (context,
                                                              url, error) =>
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
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      onPressed: () {
                                                        updateMyProgramController
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
                () => updateMyProgramController.isLoadingCreate.value == true
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
                              print(
                                widget.programDiscount!.id,
                              );
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                KeyboardUtil.hideKeyboard(context);
                                if (updateMyProgramController
                                    .listSelectedProduct.isEmpty) {
                                  SahaAlert.showError(
                                      message: "Chưa chọn sản phẩm");
                                } else {
                                  updateMyProgramController
                                      .listSelectedProductToString();
                                  updateMyProgramController.updateDiscount(
                                    widget.programDiscount!.id,
                                    false,
                                    nameProgramEditingController.text,
                                    "",
                                    "",
                                    DateTime(
                                            dateStart.year,
                                            dateStart.month,
                                            dateStart.day,
                                            timeStart.hour,
                                            timeStart.minute,
                                            timeStart.second,
                                            timeStart.millisecond,
                                            timeStart.microsecond)
                                        .toIso8601String(), //timeStart.toIso8601String(),\
                                    DateTime(
                                            dateEnd.year,
                                            dateEnd.month,
                                            dateEnd.day,
                                            timeEnd.hour,
                                            timeEnd.minute,
                                            timeEnd.second,
                                            timeEnd.millisecond,
                                            timeEnd.microsecond)
                                        .toIso8601String(),
                                    double.parse(
                                        discountEditingController.text),
                                    quantityEditingController.text == "null"
                                        ? false
                                        : true,
                                    quantityEditingController.text == ""
                                        ? 0
                                        : int.parse(
                                            quantityEditingController.text),
                                    
                                 
                                 
                                    updateMyProgramController.listProductParam,
                                   
                                  );
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
