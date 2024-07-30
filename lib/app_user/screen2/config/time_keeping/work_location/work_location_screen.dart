import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/model/checkin_location.dart';

import 'add_checkin_location/add_checkin_location_screen.dart';
import 'work_location_controller.dart';

class WorkLocationScreen extends StatelessWidget {
  WorkLocationController workLCTController = WorkLocationController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Địa điểm làm việc"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: workLCTController.listCheckInLCT
                .map((e) => itemCheckInLocation(e))
                .toList(),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Thêm địa điểm",
              onPressed: () {
                Get.to(() => AddCheckInLocationScreen())!.then((value) => {
                      if (value == "reload")
                        {workLCTController.getCheckInLocation()}
                    });
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemCheckInLocation(CheckInLocation checkInLocation) {
    return InkWell(
      onTap: () {
        Get.to(() => AddCheckInLocationScreen(
                  checkInLocationInput: checkInLocation,
                ))!
            .then((value) => {
                  if (value == "reload")
                    {workLCTController.getCheckInLocation()}
                });
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_city_outlined,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      "${checkInLocation.name ?? ""}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ))
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.wifi,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text("${checkInLocation.wifiName ?? ""}"))
                  ],
                )
              ],
            ),
          ),
          Divider(height: 1,)
        ],
      ),
    );
  }
}
