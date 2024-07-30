import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dp;
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:com.ikitech.store/app_user/screen2/staff/staff_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:ionicons/ionicons.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'add_time_keeping_controller.dart';

class AddTimeKeepingScreen extends StatelessWidget {
  AddTimeKeepingController addTimeKeepingCtl = AddTimeKeepingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Bổ sung chấm công"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                child: Row(
                  children: [
                    Text(
                      "Thêm công",
                    ),
                    Obx(
                          () => Checkbox(
                          value: addTimeKeepingCtl.bonus.value.isBonus == true,
                          onChanged: (v) {
                            addTimeKeepingCtl.bonus.value.isBonus = true;
                            addTimeKeepingCtl.bonus.refresh();
                          }),
                    ),
                    Spacer(),
                    Text(
                      "Bớt công",
                    ),
                    Obx(
                          () => Checkbox(
                          value: addTimeKeepingCtl.bonus.value.isBonus == false,
                          onChanged: (v) {
                            addTimeKeepingCtl.bonus.value.isBonus = false;
                            addTimeKeepingCtl.bonus.refresh();
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Ngày yêu cầu: ",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: context,
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
                                addTimeKeepingCtl.dateChoose.value =
                                    DateTime.parse("$v");
                                Get.back();
                              },
                              showActionButtons: true,
                              selectionMode:
                              DateRangePickerSelectionMode.single,
                              initialSelectedDate:
                              addTimeKeepingCtl.dateChoose.value,
                              initialDisplayDate:
                              addTimeKeepingCtl.dateChoose.value,
                              maxDate: DateTime.now(),
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Ionicons.calendar_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                          "${SahaDateUtils().getDDMMYY(addTimeKeepingCtl.dateChoose.value)}")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Thời gian ghi nhận và bổ sung",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                          addTimeKeepingCtl.timeCheckIn.value = date;
                        },
                        currentTime: addTimeKeepingCtl.timeCheckIn.value,
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
                          '${SahaDateUtils().getHHMM(addTimeKeepingCtl.timeCheckIn.value)}',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Text("  -  "),
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
                          addTimeKeepingCtl.timeCheckOut.value = date;
                        },
                        currentTime: addTimeKeepingCtl.timeCheckIn.value,
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
                          '${SahaDateUtils().getHHMM(addTimeKeepingCtl.timeCheckOut.value)}',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              if (addTimeKeepingCtl.checkWrongTime.value)
                Text(
                  "Thời gian ghi nhận và bổ sung không hợp lệ",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Lý do",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  PopupInput().showDialogInputNote(
                      confirm: (v) {
                        addTimeKeepingCtl.bonus.value.reason = v;
                        addTimeKeepingCtl.bonus.refresh();
                      },
                      title: "Lý do",
                      textInput:
                      "${addTimeKeepingCtl.bonus.value.reason ?? ""}");
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "${addTimeKeepingCtl.bonus.value.reason == null || addTimeKeepingCtl.bonus.value.reason == "" ? "Nhập lý do" : addTimeKeepingCtl.bonus.value.reason}",
                    style: TextStyle(
                      color: addTimeKeepingCtl.bonus.value.reason == null ||
                          addTimeKeepingCtl.bonus.value.reason == ""
                          ? Colors.grey
                          : null,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Đối tượng áp dụng",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addTimeKeepingCtl.staff.value.id == null
                          ? Text(
                        "Chưa chọn đối tượng áp dụng",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      )
                          : itemStaff(addTimeKeepingCtl.staff.value),
                      SizedBox(
                        height: 10,
                      ),
                      if (addTimeKeepingCtl.staff.value.id == null)
                        InkWell(
                          onTap: () {
                            Get.to((() => StaffScreen(
                                isChooseOne: true,
                                listStaffInput: [
                                  addTimeKeepingCtl.staff.value
                                ],
                                onDone: (List<Staff> listStaff) {
                                  addTimeKeepingCtl.staff.value =
                                      listStaff.first;
                                  Get.back();
                                })));
                          },
                          child: Container(
                            width: Get.width,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                      Border.all(color: Colors.red)),
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Thêm nhân viên",
                                  style: TextStyle(
                                      color:
                                      Theme.of(context).primaryColor),
                                )
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              )),
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
              text: "Bổ sung",
              onPressed: () async {
                if (addTimeKeepingCtl.timeCheckOut.value
                    .isAfter(addTimeKeepingCtl.timeCheckIn.value)) {
                  addTimeKeepingCtl.checkWrongTime.value = false;
                  addTimeKeepingCtl.bonusCheckInOut();
                } else {
                  addTimeKeepingCtl.checkWrongTime.value = true;
                }
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemStaff(Staff staff) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, right: 20, left: 0),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  addTimeKeepingCtl.staff.value.id = null;
                  addTimeKeepingCtl.staff.refresh();
                },
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red)),
                  child: Icon(
                    Icons.remove,
                    color: Colors.red,
                    size: 18,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "${staff.name}",
                      maxLines: 1,
                    ),
                    Spacer(),
                    Text(
                      "Phân quyền: ${staff.decentralization?.name ?? ""}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
