import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/model/shifts.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';

import 'shifts_detail_controller.dart';

class ShiftsDetailScreen extends StatelessWidget {
  Shifts? shiftsInput;
  ShiftsDetailScreen({this.shiftsInput}) {
    shiftDetailController = ShiftDetailController(shiftsInput: shiftsInput);
  }

  late ShiftDetailController shiftDetailController;

  final _formKey = GlobalKey<FormState>();
  var n = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ca chấm công"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Tên ca",
                        ),
                        validator: (value) {
                          if (value!.length == 0) {
                            return 'Không được để trống';
                          }
                          return null;
                        },
                        controller:
                            shiftDetailController.nameShiftsEditingController,
                        onChanged: (v) {
                          shiftDetailController.shifts.value.name = v;
                        },
                      ),
                      Divider(),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              dp.DatePicker.showTime12hPicker(
                                context,
                                showTitleActions: true,
                                onChanged: (date) {
                                  print('change $date in time zone ' +
                                      date.timeZoneOffset.inHours.toString());
                                },
                                onConfirm: (date) {
                                  shiftDetailController
                                      .shifts.value.startWorkHour = date.hour;
                                  shiftDetailController.shifts.value
                                      .startWorkMinute = date.minute;
                                  shiftDetailController.shifts.refresh();
                                },
                                currentTime: DateTime(
                                    n.year,
                                    n.month,
                                    n.day,
                                    shiftDetailController
                                            .shifts.value.startWorkHour ??
                                        0,
                                    shiftDetailController
                                            .shifts.value.startWorkMinute ??
                                        0),
                                locale: dp.LocaleType.vi,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Obx(
                                () => Text(
                                  '${textTime(shiftDetailController.shifts.value.startWorkHour ?? 0, shiftDetailController.shifts.value.startWorkMinute ?? 0)}',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                          Text(" - "),
                          InkWell(
                            onTap: () {
                              dp.DatePicker.showTime12hPicker(
                                context,
                                showTitleActions: true,
                                onChanged: (date) {
                                  print('change $date in time zone ' +
                                      date.timeZoneOffset.inHours.toString());
                                },
                                onConfirm: (date) {
                                  shiftDetailController
                                      .shifts.value.endWorkHour = date.hour;
                                  shiftDetailController
                                      .shifts.value.endWorkMinute = date.minute;
                                  shiftDetailController.shifts.refresh();
                                },
                                currentTime: DateTime(
                                    n.year,
                                    n.month,
                                    n.day,
                                    shiftDetailController
                                            .shifts.value.endWorkHour ??
                                        0,
                                    shiftDetailController
                                            .shifts.value.endWorkMinute ??
                                        0),
                                locale:dp. LocaleType.vi,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Obx(
                                () => Text(
                                  '${textTime(shiftDetailController.shifts.value.endWorkHour ?? 0, shiftDetailController.shifts.value.endWorkMinute ?? 0)}',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Thời gian ca",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Obx(
                        () => shiftDetailController.checkTimeEnd(
                          shiftDetailController.shifts.value.startWorkHour ?? 0,
                          shiftDetailController.shifts.value.startWorkMinute ??
                              0,
                          shiftDetailController.shifts.value.endWorkHour ?? 0,
                          shiftDetailController.shifts.value.endWorkMinute ?? 0,
                        )
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Thời gian kết thúc phải lớn hơn thời gian bắt đầu",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
                      ),
                      Divider(),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              dp.DatePicker.showTime12hPicker(
                                context,
                                showTitleActions: true,
                                onChanged: (date) {
                                  print('change $date in time zone ' +
                                      date.timeZoneOffset.inHours.toString());
                                },
                                onConfirm: (date) {
                                  shiftDetailController
                                      .shifts.value.startBreakHour = date.hour;
                                  shiftDetailController.shifts.value
                                      .startBreakMinute = date.minute;
                                  shiftDetailController.shifts.refresh();
                                },
                                currentTime: DateTime(
                                    n.year,
                                    n.month,
                                    n.day,
                                    shiftDetailController
                                            .shifts.value.startBreakHour ??
                                        0,
                                    shiftDetailController
                                            .shifts.value.startBreakMinute ??
                                        0),
                                locale: dp.LocaleType.vi,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Obx(
                                () => Text(
                                  '${textTime(shiftDetailController.shifts.value.startBreakHour ?? 0, shiftDetailController.shifts.value.startBreakMinute ?? 0)}',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                          Text(" - "),
                          InkWell(
                            onTap: () {
                             dp. DatePicker.showTime12hPicker(
                                context,
                                showTitleActions: true,
                                onChanged: (date) {
                                  print('change $date in time zone ' +
                                      date.timeZoneOffset.inHours.toString());
                                },
                                onConfirm: (date) {
                                  shiftDetailController
                                      .shifts.value.endBreakHour = date.hour;
                                  shiftDetailController.shifts.value
                                      .endBreakMinute = date.minute;
                                  shiftDetailController.shifts.refresh();
                                },
                                currentTime: DateTime(
                                    n.year,
                                    n.month,
                                    n.day,
                                    shiftDetailController
                                            .shifts.value.endBreakHour ??
                                        0,
                                    shiftDetailController
                                            .shifts.value.endBreakMinute ??
                                        0),
                                locale: dp.LocaleType.vi,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Obx(
                                () => Text(
                                  '${textTime(shiftDetailController.shifts.value.endBreakHour ?? 0, shiftDetailController.shifts.value.endBreakMinute ?? 0)}',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Thời gian nghỉ giữa ca",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Obx(
                        () => shiftDetailController.checkTimeEnd(
                          shiftDetailController.shifts.value.startBreakHour ??
                              0,
                          shiftDetailController.shifts.value.startBreakMinute ??
                              0,
                          shiftDetailController.shifts.value.endBreakHour ?? 0,
                          shiftDetailController.shifts.value.endBreakMinute ??
                              0,
                        )
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  "Thời gian kết thúc phải lớn hơn thời gian bắt đầu",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Text("Ngày trong tuần"),
                          Spacer(),
                          Text("Tất cả"),
                          Obx(
                            () => Checkbox(
                                value: shiftDetailController.listDate.length ==
                                    shiftDetailController.listDateChoose.length,
                                onChanged: (v) {
                                  if (shiftDetailController.listDate.length ==
                                      shiftDetailController
                                          .listDateChoose.length) {
                                    shiftDetailController.listDateChoose([]);
                                  } else {
                                    shiftDetailController
                                        .listDateChoose([2, 3, 4, 5, 6, 7, 8]);
                                  }
                                }),
                          )
                        ],
                      ),
                      Container(
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: shiftDetailController.listDate
                              .map((e) => InkWell(
                                    onTap: () {
                                      if (shiftDetailController
                                          .checkChoose(e)) {
                                        shiftDetailController.listDateChoose
                                            .removeWhere((date) => date == e);
                                      } else {
                                        shiftDetailController.listDateChoose
                                            .add(e);
                                      }
                                    },
                                    child: Obx(
                                      () => Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: shiftDetailController
                                                    .checkChoose(e)
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey[350],
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "${SahaDateUtils().textDateTimeKeeping(e)}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Divider(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                if (shiftsInput != null)
                  Divider(
                    height: 1,
                  ),
                if (shiftsInput != null)
                  InkWell(
                    onTap: () {
                      SahaDialogApp.showDialogYesNo(
                          mess: "Bạn có chắc muốn xoá ca này không?",
                          onOK: () {
                            shiftDetailController.deleteShifts();
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Xoá ca")
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
                    if (shiftDetailController.checkTimeEnd(
                      shiftDetailController.shifts.value.startWorkHour ?? 0,
                      shiftDetailController.shifts.value.startWorkMinute ?? 0,
                      shiftDetailController.shifts.value.endWorkHour ?? 0,
                      shiftDetailController.shifts.value.endWorkMinute ?? 0,
                    )) {
                      if (shiftsInput != null) {
                        shiftDetailController.updateShifts();
                      } else {
                        shiftDetailController.addShift();
                      }
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

  String? textTime(int hour, int minute) {
    return "${hour < 10 ? "0$hour" : hour}:${minute < 10 ? "0$minute" : minute}";
  }
}
