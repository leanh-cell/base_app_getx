import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/model/shifts.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:com.ikitech.store/app_user/screen2/config/time_keeping/shifts/shifts_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/config/time_keeping/widget/calendar_time_keeping.dart';
import 'package:com.ikitech.store/app_user/screen2/staff/staff_screen.dart';

import 'add_calendar_shifts_controller.dart';

class AddCalendarShiftsScreen extends StatelessWidget {
  AddCalendarShiftsController addCldSController = AddCalendarShiftsController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Tạo lịch làm việc"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ca làm việc",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Obx(
              () => addCldSController.listShifts.isEmpty
                  ? Text(
                      "Chưa chọn ca làm việc",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    )
                  : Column(
                      children: [
                        ...addCldSController.listShifts
                            .map((e) => itemShifts(e))
                            .toList()
                      ],
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.to(
                  () => ShiftsScreen(
                    listShiftsInput: addCldSController.listShifts.toList(),
                    onDone: (List<Shifts> listShifts) {
                      addCldSController.listShifts(listShifts);
                      Get.back();
                    },
                  ),
                );
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
                          border: Border.all(color: Colors.red)),
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
                      "Thêm ca",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),
            ),
            Text(
              "Thời gian áp dụng",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            CalendarTimeKeeping(
              isCreate: true,
              isAllPickDate: true,
              onChange: (DateTime dateFrom, DateTime dateTo) {
                addCldSController.dateFrom.value = dateFrom;
                addCldSController.dateTo.value = dateTo;
              },
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
                        addCldSController.listStaff.isEmpty
                            ? Text(
                                "Chưa chọn đối tượng áp dụng",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              )
                            : Column(
                                children: [
                                  ...addCldSController.listStaff
                                      .map((e) => itemStaff(e))
                                      .toList(),
                                ],
                              ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to((() => StaffScreen(
                                listStaffInput:
                                    addCldSController.listStaff.toList(),
                                onDone: (List<Staff> listStaff) {
                                  addCldSController
                                      .listStaff(listStaff.toList());
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
                                      border: Border.all(color: Colors.red)),
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
                                      color: Theme.of(context).primaryColor),
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
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: DecentralizationWidget(
          decent: true,
          // sahaDataController.badgeUser.value.decentralization?.staffAdd ??
          //     false,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Lưu",
                onPressed: () {
                  addCldSController.addCalendarShifts();
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
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
                  addCldSController.listStaff
                      .removeWhere((e) => e.id == staff.id);
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

  Widget itemShifts(Shifts shifts) {
    return Container(
      padding: EdgeInsets.only(top: 10, right: 20, left: 0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              addCldSController.listShifts
                  .removeWhere((e) => e.id == shifts.id);
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
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "${(shifts.startWorkHour ?? 0) < 10 ? "0${shifts.startWorkHour}" : shifts.startWorkHour}:${(shifts.startWorkMinute ?? 0) < 10 ? "0${shifts.startWorkMinute}" : shifts.startWorkMinute} - ${(shifts.endWorkHour ?? 0) < 10 ? "0${shifts.endWorkHour}" : shifts.endWorkHour}:${(shifts.endWorkMinute ?? 0) < 10 ? "0${shifts.endWorkMinute}" : shifts.endWorkMinute}"),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${shifts.name}",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  height: 1,
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (shifts.daysOfWeekList != null)
                      Text(
                          "${shifts.daysOfWeekList!.map((e) => e == 8 ? "CN" : "T$e").toList().toString().replaceAll("[", "").replaceAll("]", "")}"),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Ngày trong tuần",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      height: 1,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
