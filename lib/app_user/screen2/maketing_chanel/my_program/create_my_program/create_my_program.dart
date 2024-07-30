import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/screen2/maketing_chanel/my_program/add_product/add_product_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/keyboard.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../components/saha_user/dialog/dialog.dart';
import '../my_program_controller.dart';
import 'create_my_program_controller.dart';

class CreateMyProgram extends StatefulWidget {
  @override
  _CreateMyProgramState createState() => _CreateMyProgramState();
}

class _CreateMyProgramState extends State<CreateMyProgram> {
  final _formKey = GlobalKey<FormState>();
  DateTime dateStart = DateTime.now();
  DateTime timeStart = DateTime.now().add(Duration(minutes: 1));
  DateTime dateEnd = DateTime.now();
  DateTime timeEnd = DateTime.now().add(Duration(hours: 2));
  CreateMyProgramController createMyProgramController =
      Get.put(CreateMyProgramController());
  MyProgramController myProgramController = Get.find();
  bool checkDayStart = false;
  bool checkDayEnd = false;
  TextEditingController nameProgramEditingController =
      new TextEditingController();
  TextEditingController discountEditingController = new TextEditingController();
  TextEditingController quantityEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Tạo chương trình khuyến mãi'),
        ),
        body: SingleChildScrollView(
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
                         
                          if (createMyProgramController.group.contains(v)) {
                            createMyProgramController.group.remove(v);
                            createMyProgramController.group.refresh();
                           if(v == 2){
                            createMyProgramController.agencyType.value = [];
                           }
                            if(v == 4){
                            createMyProgramController.groupCustomer.value = [];
                           }
                          } else {
                            createMyProgramController.group.add(v);
                            createMyProgramController.group.refresh();
                          }
                        },
                        groupType: createMyProgramController.group);
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
                                      '${createMyProgramController.group.contains(0) ? "Tất cả," : ""}${createMyProgramController.group.contains(1) ? "Cộng tác viên," : ""}${createMyProgramController.group.contains(2) ? "Đại lý," : ""} ${createMyProgramController.group.contains(4) ? "Nhóm khách hàng," : ""}${createMyProgramController.group.contains(5) ? "Khách lẻ đã đăng nhập" : ""}${createMyProgramController.group.contains(6) ? "Khách lẻ chưa đăng nhập" : ""}',overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,),
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
                Obx(() => createMyProgramController.group.contains(2)
                    ? InkWell(
                        onTap: () {
                          SahaDialogApp.showDialogAgencyTypev2(
                              onChoose: (v) {
                                if (createMyProgramController.agencyType
                                    .contains(v)) {
                                      createMyProgramController.agencyType.remove(v);
                                    }else{
                                      createMyProgramController.agencyType.add(v);
                                    }
                                
                              },
                              type: createMyProgramController.agencyType
                                  .map((e) => e.id ?? 0)
                                  .toList(),
                              listAgencyType: createMyProgramController
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
                                            createMyProgramController.agencyType.isEmpty ? "" : "${createMyProgramController.agencyType.map((e) => "${e.name},")}",overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,),
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
                Obx(() => createMyProgramController.group.contains(4)
                    ? InkWell(
                        onTap: () {
                          SahaDialogApp.showDialogCustomerGroupTypev2(
                              onChoose: (v) {
                                if(createMyProgramController
                                  .groupCustomer.contains(v)){
                                    createMyProgramController.groupCustomer.remove(v);
                                   
                                  }else{
                                    createMyProgramController.groupCustomer.add(v);
                                  }
                                
                              },
                              type: createMyProgramController
                                  .groupCustomer.map((e) => e.id ?? 0).toList(),
                              listGroupCustomer:
                                  createMyProgramController.listGroup.toList());
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
                                            createMyProgramController.groupCustomer.isEmpty ? "" : "${createMyProgramController.groupCustomer.map((e) => "${e.name},")}",overflow: TextOverflow.ellipsis,textAlign: TextAlign.end,),
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
                                  locale: dp.LocaleType.vi);
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
                                        date.timeZoneOffset.inHours.toString());
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
                                        date.timeZoneOffset.inHours.toString());
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
                              isDense: true,
                              counterText: "",
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
                            createMyProgramController
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
                                              createMyProgramController
                                                  .listSelectedProduct(
                                                      listProduct!);
                                            },
                                            listProductInput:
                                                createMyProgramController
                                                    .listSelectedProduct
                                                    .toList(),
                                          ));
                                    })
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => createMyProgramController
                                    .listSelectedProduct.length ==
                                0
                            ? InkWell(
                                onTap: () {
                                  Get.to(() => AddProductToSaleScreen(
                                        callback: (List<Product>? listProduct) {
                                          createMyProgramController
                                              .listSelectedProduct
                                              .addAll(listProduct!);
                                        },
                                        listProductInput:
                                            createMyProgramController
                                                .listSelectedProduct,
                                      ));
                                },
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Theme.of(context).primaryColor)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Text(
                                        'Thêm sản phẩm',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
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
                                    children: createMyProgramController
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
                                                    width: (Get.width / 4) - 11,
                                                    height: 100,
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        e.images!.length == 0
                                                            ? ""
                                                            : e.images![0]
                                                                .imageUrl!,
                                                    errorWidget: (context, url,
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
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    onPressed: () {
                                                      createMyProgramController
                                                          .deleteProduct(e.id!);
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
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              Obx(
                () => createMyProgramController.isLoadingCreate.value == true
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
                            if (createMyProgramController
                                .listSelectedProduct.isEmpty) {
                              SahaAlert.showError(
                                  message: "Chưa chọn sản phẩm");
                            } else {
                              createMyProgramController
                                  .listSelectedProductToString();
                              createMyProgramController.createDiscount(
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
                                  //timeEnd.toIso8601String(),
                                  double.parse(discountEditingController.text),
                                  quantityEditingController.text.isEmpty
                                      ? false
                                      : true,
                                  quantityEditingController.text.isEmpty
                                      ? 0
                                      : int.parse(
                                          quantityEditingController.text),
                                
                                  createMyProgramController.listProductParam);
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
