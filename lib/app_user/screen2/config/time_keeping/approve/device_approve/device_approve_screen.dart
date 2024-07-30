import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/model/device.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';

import 'device_approve_controller.dart';

class DeviceApproveScreen extends StatelessWidget {
  Staff staff;
  DeviceApproveScreen({required this.staff}) {
    deviceApproveController = DeviceApproveController(staff: staff);
  }
  late DeviceApproveController deviceApproveController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Thiết bị"),
      ),
      body: Obx(
        () => deviceApproveController.isLoading.value
            ? SahaLoadingFullScreen()
            : deviceApproveController.listDevice.isEmpty
                ? Center(
                    child: Text(
                      "Chưa có thiết bị nào được phê duyệt",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: deviceApproveController.listDevice
                          .map((e) => device(e))
                          .toList(),
                    ),
                  ),
      ),
    );
  }

  Widget device(Device device) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.mobile_friendly,
                          color: Theme.of(Get.context!).primaryColor,
                        ),
                        Text(
                          " ${device.name ?? ""}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "  ID: ${device.deviceId ?? ""}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  SahaDialogApp.showDialogYesNo(
                      mess: "Bạn có chắc chắn muốn xoá thiết bị này chứ ?",
                      onOK: () {
                        deviceApproveController.deleteDevice(
                            deviceId: device.id!);
                      });
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
