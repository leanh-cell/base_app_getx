import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/model/history_checkin_checkout.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/saha_data_controller.dart';

import 'device/device_screen.dart';
import 'time_keeping_staff_controller.dart';

class TimeKeepingStaffScreen extends StatefulWidget {
  @override
  State<TimeKeepingStaffScreen> createState() => _TimeKeepingStaffScreenState();
}

class _TimeKeepingStaffScreenState extends State<TimeKeepingStaffScreen> {
  SahaDataController sahaDataController = Get.find();

  TimeKeepingStaffController timeKeepingStaffController =
      TimeKeepingStaffController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        try {
          timeKeepingStaffController.timer.cancel();
        } catch (err) {}

        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            "CHẤM CÔNG",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.to(() => DeviceScreen())!.then(
                      (value) => {timeKeepingStaffController.getAllDevice()});
                },
                child: Text("Thiết bị"))
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Obx(
                    () => Expanded(
                      child: Text(
                        "Xin chào ${sahaDataController.user.value.name}!",
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.to(() => DeviceScreen())!.then((value) =>
                            {timeKeepingStaffController.getAllDevice()});
                      },
                      child: Obx(
                        () => Text(
                          "${timeKeepingStaffController.listDevice.map((e) => e.deviceId).toList().contains(timeKeepingStaffController.deviceCurrent.value.deviceId) ? "Thiết bị: ${timeKeepingStaffController.deviceCurrent.value.deviceId}" : "Thiết bị chấm công chưa được duyệt!"}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
                width: Get.width,
              ),
              GestureDetector(
                onTap: () {
                  if (timeKeepingStaffController.isLoading.value == false) {
                    if (timeKeepingStaffController.listDevice
                        .map((e) => e.deviceId)
                        .toList()
                        .contains(timeKeepingStaffController
                            .deviceCurrent.value.deviceId)) {
                      timeKeepingStaffController.controllerTimer =
                          new CustomTimerController();
                      print(timeKeepingStaffController
                          .checkInCheckOutRequest.value.wifiName);
                      if (timeKeepingStaffController
                              .checkInCheckOutRequest.value.wifiName ==
                          null) {
                        timeKeepingStaffController
                            .checkInCheckOutRequest.value.isRemote = true;
                        PopupInput().showDialogInputNote(
                            confirm: (v) async {
                              timeKeepingStaffController
                                  .checkInCheckOutRequest.value.reason = v;
                              await timeKeepingStaffController
                                  .checkInCheckOut();
                              timeKeepingStaffController
                                  .checkInCheckOutRequest.value.reason = null;
                            },
                            title: "Lý do chấm công từ xa",
                            textInput: "");
                      } else {
                        timeKeepingStaffController.checkInCheckOut();
                      }
                    } else {
                      SahaDialogApp.showDialogYesNo(
                          mess:
                              "Bạn chưa có thiết bị chấm công\nThêm thiết bị ngay!",
                          onOK: () {
                            Get.to(() => DeviceScreen())!.then((value) =>
                                {timeKeepingStaffController.getAllDevice()});
                          });
                    }
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: Get.width - 150,
                      height: Get.width - 150,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 10,
                            blurRadius: 10,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Get.width - 200,
                      height: Get.width - 200,
                      child: Obx(
                        () => CircularProgressIndicator(
                          strokeWidth: 50,
                          value: timeKeepingStaffController.process.value,
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width - 200,
                      height: Get.width - 200,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            timeKeepingStaffController.listShifts.isEmpty
                                ? Text(
                                    "Không có ca trong ngày",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  )
                                : timeKeepingStaffController
                                            .listHistory.isNotEmpty &&
                                        timeKeepingStaffController
                                                .listHistory[0].isCheckin ==
                                            true
                                    ? Column(
                                        children: [
                                          Text(
                                            "${timeKeepingStaffController.isInShift.value ? "Bạn đang trong ca" : "Bạn đang làm ngoài ca"}",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          CustomTimer(
                                            controller:
                                                timeKeepingStaffController
                                                    .controllerTimer,
                                            begin: Duration(
                                                    hours: DateTime.now().hour -
                                                        timeKeepingStaffController
                                                            .listHistory
                                                            .first
                                                            .timeCheck!
                                                            .hour,
                                                    minutes: DateTime.now()
                                                            .minute -
                                                        timeKeepingStaffController
                                                            .listHistory
                                                            .first
                                                            .timeCheck!
                                                            .minute,
                                                    seconds: DateTime.now()
                                                            .second -
                                                        timeKeepingStaffController
                                                            .listHistory
                                                            .first
                                                            .timeCheck!
                                                            .second) -
                                                timeKeepingStaffController
                                                    .initTime.value,
                                            end: Duration(
                                                hours:
                                                    timeKeepingStaffController
                                                        .endWorkHour,
                                                minutes:
                                                    timeKeepingStaffController
                                                        .endWorkMinute,
                                                seconds: 0),
                                            builder: (time) {
                                              timeKeepingStaffController
                                                  .timeWorked = Duration(
                                                      hours:
                                                          int.parse(time.hours),
                                                      minutes: int.parse(
                                                          time.minutes),
                                                      seconds: int.parse(
                                                          time.seconds))
                                                  .inSeconds;
                                              return Text(
                                                  "${time.hours} giờ ${time.minutes} phút ${time.seconds}",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w500));
                                            },
                                          ),
                                        ],
                                      )
                                    : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            timeKeepingStaffController.listHistory.isEmpty
                                ? Text(
                                    "VÀO LÀM",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25),
                                  )
                                : Text(
                                    "${timeKeepingStaffController.listHistory[0].isCheckin == false ? "VÀO LÀM" : "TAN LÀM"}",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25),
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            Obx(() => timeKeepingStaffController.isLoading.value
                                ? SahaLoadingWidget(
                                    size: 20,
                                  )
                                : Column(
                                    children: [
                                      if (timeKeepingStaffController
                                              .checkInCheckOutRequest
                                              .value
                                              .wifiMac ==
                                          null)
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          padding: EdgeInsets.only(
                                              top: 2,
                                              bottom: 2,
                                              right: 10,
                                              left: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.location_off_outlined,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              Text(
                                                "Sai địa điểm",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        )
                                    ],
                                  )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Tổng giờ phải làm:",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${timeKeepingStaffController.timeSpacer.inHours}h ${timeKeepingStaffController.timeSpacer.inMinutes - 60 * timeKeepingStaffController.timeSpacer.inHours}p",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
                width: Get.width,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "${SahaDateUtils().convertDateToWeekDate(DateTime.now())}, ${DateTime.now().day} tháng ${DateTime.now().month} ${DateTime.now().year}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              Obx(
                () => timeKeepingStaffController.listShifts.isEmpty
                    ? Container(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, right: 10, left: 10),
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Không có ca trong ngày",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...timeKeepingStaffController.listShifts.map(
                              (shifts) => Container(
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 5, right: 10, left: 10),
                                margin: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: timeKeepingStaffController
                                          .checkInShift(shifts)
                                      ? Colors.green.withOpacity(0.8)
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "${(shifts.startWorkHour ?? 0) < 10 ? "0${shifts.startWorkHour}" : shifts.startWorkHour}:${(shifts.startWorkMinute ?? 0) < 10 ? "0${shifts.startWorkMinute}" : shifts.startWorkMinute} - ${(shifts.endWorkHour ?? 0) < 10 ? "0${shifts.endWorkHour}" : shifts.endWorkHour}:${(shifts.endWorkMinute ?? 0) < 10 ? "0${shifts.endWorkMinute}" : shifts.endWorkMinute}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: [
                        ...timeKeepingStaffController.listHistory
                            .map((e) => historyCheckInOut(e))
                            .toList(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget historyCheckInOut(HistoryCheckInCheckout historyCheckInCheckout) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
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
              SizedBox(
                width: 5,
              ),
              Text(
                "${SahaDateUtils().getHHMMSS(historyCheckInCheckout.timeCheck ?? DateTime.now())}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "${historyCheckInCheckout.isCheckin == true ? "Vào làm" : "Tan làm"}",
                style: TextStyle(
                    color: historyCheckInCheckout.isCheckin == true
                        ? Colors.green
                        : Colors.amber,
                    fontWeight: FontWeight.w500),
              ),
              Spacer(),
              if (historyCheckInCheckout.remoteTimekeeping == true)
                Text(
                  "(Từ xa)",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                )
            ],
          ),
          if (historyCheckInCheckout.reason != null)
            SizedBox(
              height: 5,
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
