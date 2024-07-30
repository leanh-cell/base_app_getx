import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/time_keeping/time_keeping_calculate_res.dart';
import 'package:com.ikitech.store/app_user/model/history_checkin_checkout.dart';
import 'package:com.ikitech.store/app_user/screen2/config/time_keeping/widget/calendar_time_keeping.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'add_time_keeping/add_time_keeping_screen.dart';
import 'time_keeping_calculate_controller.dart';

class TimeKeepingCalculateScreen extends StatelessWidget {
  TimeKeepingCalculateController calculateController =
  TimeKeepingCalculateController();

  bool? isAccountant;

  TimeKeepingCalculateScreen({this.isAccountant});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Bảng công"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              CalendarTimeKeeping(
                onChange: (DateTime dateFrom, DateTime dateTo) {
                  calculateController.dateFrom.value =
                      SahaDateUtils().getDate(dateFrom);
                  calculateController.dateTo.value =
                      SahaDateUtils().getDate(dateTo);
                  calculateController.getTimeKeepingCalculate();
                },
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(
                      () => Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "Nhân sự",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      if (calculateController.dateFrom.value
                          .isAtSameMomentAs(calculateController.dateTo.value))
                        if (isAccountant != true)
                          Expanded(
                            child: Center(
                              child: Text(
                                "Vào/Tan ca",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Số giờ làm",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              Expanded(
                child: Obx(
                      () => calculateController.timeKeepingCalculate.value
                      .listStaffTimekeeping !=
                      null &&
                      calculateController.timeKeepingCalculate.value
                          .listStaffTimekeeping!.isNotEmpty
                      ? SingleChildScrollView(
                    child: Column(
                      children: [
                        itemStaff(calculateController
                            .timeKeepingCalculate.value)
                      ],
                    ),
                  )
                      : Center(
                    child: Text(
                      "Không có bảng công nào",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 45,
            child: Container(
              width: Get.width - 100,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    "Tổng lương",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Obx(
                        () => Text(
                      "${SahaStringUtils().convertToMoney(calculateController.allSalary.value)}",
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddTimeKeepingScreen())!
              .then((value) => {calculateController.getTimeKeepingCalculate()});
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget itemStaff(TimeKeepingCalculate timeKeepingCalculate) {
    return !(timeKeepingCalculate.listStaffTimekeeping != null &&
        timeKeepingCalculate.listStaffTimekeeping!.isNotEmpty)
        ? Container()
        : Container(
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (timeKeepingCalculate.listStaffTimekeeping != null &&
              timeKeepingCalculate.listStaffTimekeeping!.isNotEmpty)
            ...timeKeepingCalculate.listStaffTimekeeping!
                .map((e) => Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                          child: Center(
                              child: Column(
                                children: [
                                  Text("${e.staff?.name ?? ""}"),
                                  if (isAccountant != true)
                                    if (e.shiftsWork != null)
                                      ...e.shiftsWork!
                                          .map(
                                            (shifts) => Container(
                                          padding: EdgeInsets.only(
                                              top: 5,
                                              bottom: 5,
                                              right: 10,
                                              left: 10),
                                          margin: EdgeInsets.only(
                                              top: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.green
                                                .withOpacity(0.8),
                                            borderRadius:
                                            BorderRadius.circular(
                                                20),
                                          ),
                                          child: Text(
                                            "${(shifts.startWorkHour ?? 0) < 10 ? "0${shifts.startWorkHour}" : shifts.startWorkHour}:${(shifts.startWorkMinute ?? 0) < 10 ? "0${shifts.startWorkMinute}" : shifts.startWorkMinute} - ${(shifts.endWorkHour ?? 0) < 10 ? "0${shifts.endWorkHour}" : shifts.endWorkHour}:${(shifts.endWorkMinute ?? 0) < 10 ? "0${shifts.endWorkMinute}" : shifts.endWorkMinute}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      )
                                          .toList(),
                                  if (isAccountant == true)
                                    if ((e.keepingHistories ?? [])
                                        .isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0),
                                        child: Text(
                                            "${SahaStringUtils().convertToMoney(e.salaryOneHour ?? 0)}₫/h"),
                                      ),
                                ],
                              ))),
                      if (isAccountant != true)
                        if (calculateController.dateFrom.value
                            .isAtSameMomentAs(
                            calculateController.dateTo.value))
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  if ((e.keepingHistories ?? [])
                                      .isNotEmpty) {
                                    PopupInput()
                                        .showDialogsCheckInOut(
                                        listHis:
                                        e.keepingHistories ??
                                            []);
                                  }
                                },
                                child: Column(
                                  children: [
                                    if (e.keepingHistories != null &&
                                        e.keepingHistories!
                                            .isNotEmpty)
                                      historyCheckInOut(
                                          e.keepingHistories![0]),
                                    if (e.keepingHistories != null &&
                                        e.keepingHistories!.length >
                                            2)
                                      Divider(
                                        height: 1,
                                      ),
                                    if (e.keepingHistories != null &&
                                        e.keepingHistories!.length >
                                            2)
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              size: 4,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Icon(
                                              Icons.circle,
                                              size: 4,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Icon(
                                              Icons.circle,
                                              size: 4,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (e.keepingHistories != null &&
                                        e.keepingHistories!.length >
                                            2)
                                      Divider(
                                        height: 1,
                                      ),
                                    if (e.keepingHistories != null &&
                                        e.keepingHistories!.length >
                                            1)
                                      historyCheckInOut(e
                                          .keepingHistories![
                                      e.keepingHistories!.length -
                                          1]),
                                  ],
                                ),
                              )),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if ((e.keepingHistories ?? [])
                                .isNotEmpty) {
                              PopupInput()
                                  .showDialogsRecordingTime(
                                  listRecordingTime:
                                  e.recordingTime!);
                            }
                          },
                          child: Center(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${SahaDateUtils().secondsToHours(e.totalSeconds ?? 0)}",
                                  style: TextStyle(
                                      color:
                                      (e.keepingHistories ??
                                          [])
                                          .isNotEmpty
                                          ? Colors.blue
                                          : null),
                                ),
                                if ((e.keepingHistories ?? [])
                                    .isNotEmpty)
                                  SizedBox(
                                    height: 5,
                                  ),
                                if (isAccountant != true)
                                  if ((e.keepingHistories ?? [])
                                      .isNotEmpty)
                                    Text(
                                        "${SahaStringUtils().convertToMoney(e.salaryOneHour ?? 0)}₫/h"),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    "${SahaStringUtils().convertToMoney(e.totalSalary ?? 0)}₫"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
              ],
            ))
                .toList(),
        ],
      ),
    );
  }

  Widget historyCheckInOut(HistoryCheckInCheckout historyCheckInCheckout) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: historyCheckInCheckout.isCheckin == true
            ? Colors.green.withOpacity(0.05)
            : Colors.amber.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 10,
                color: historyCheckInCheckout.isCheckin == true
                    ? Colors.green
                    : Colors.amber,
              ),
              Text(
                "${historyCheckInCheckout.isCheckin == true ? "Vào làm" : "Tan làm"}",
                style: TextStyle(
                    color: historyCheckInCheckout.isCheckin == true
                        ? Colors.green
                        : Colors.amber,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              if (historyCheckInCheckout.remoteTimekeeping == true)
                Text(
                  "(Từ xa)",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 11),
                ),
              if (historyCheckInCheckout.fromUser == true)
                Text(
                  "(Thêm công)",
                  style: TextStyle(
                      color: Theme.of(Get.context!).primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 11),
                ),
            ],
          ),
          Text(
            "${SahaDateUtils().getHHMMSS(historyCheckInCheckout.timeCheck ?? DateTime.now())}",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
          if (historyCheckInCheckout.reason != null)
            Text(
              "Lý do: ${historyCheckInCheckout.reason}",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            )
        ],
      ),
    );
  }
}