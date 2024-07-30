import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/screen2/config/calculate/time_keeping_calculate_screen.dart';
import 'package:ionicons/ionicons.dart';

import 'approve/approve_screen.dart';
import 'calendar_shifts/calendar_shifts_screen.dart';
import 'shifts/shifts_screen.dart';
import 'work_location/work_location_screen.dart';

class TimeKeepingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chấm công"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          itemBody(
              Icon(Ionicons.checkmark_done_outline,
                  color: Theme.of(context).primaryColor),
              "Phê duyệt các yêu cầu", () {
            Get.to(() => ApproveScreen());
          }),
          itemBody(
              Icon(Ionicons.calendar_number_outline,
                  color: Theme.of(context).primaryColor),
              "Bảng công", () {
            Get.to(() => TimeKeepingCalculateScreen());
          }),
          itemBody(
              Icon(Ionicons.time_outline,
                  color: Theme.of(context).primaryColor),
              "Ca chấm công", () {
            Get.to(() => ShiftsScreen());
          }),
          itemBody(
              Icon(Ionicons.calendar_outline,
                  color: Theme.of(context).primaryColor),
              "Lịch làm việc", () {
            //Get.to(() => CalendarShiftsScreen());
          }),
          itemBody(
              Icon(Ionicons.location_outline,
                  color: Theme.of(context).primaryColor),
              "Địa điểm làm việc", () {
            Get.to(() => WorkLocationScreen());
          }),
        ],
      ),
    );
  }

  Widget itemBody(Icon icon, String text, Function onTap) {
    return ListTile(
      leading: icon,
      title: Text(
        text,
        style: TextStyle(fontSize: 15),
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
