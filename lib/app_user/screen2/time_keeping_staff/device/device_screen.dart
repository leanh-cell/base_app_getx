import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/model/device.dart';

import 'device_controller.dart';

class DeviceScreen extends StatelessWidget {
  DeviceController deviceController = DeviceController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Thiết bị chấm công"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(children: [
            SizedBox(
              height: 10,
            ),
            ...deviceController.listDevice.map((e) => device(e)).toList(),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: "Thêm thiết bị",
              onPressed: () {
                showDialogDevice(onDone: () {
                  deviceController.addDevice();
                  Get.back();
                });
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  void showDialogDevice({
    required Function onDone,
  }) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.all(0),
        titlePadding: EdgeInsets.all(20),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  "Thiết bị hiện tại",
                  textAlign: TextAlign.center,
                )),
              ],
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Tên thiết bị: "),
                      Text(
                        "${deviceController.deviceCurrent.value.name ?? ""}",
                        style: TextStyle(
                          color: Theme.of(Get.context!).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ID: "),
                      Expanded(
                        child: Text(
                          "${deviceController.deviceCurrent.value.deviceId ?? ""}",
                          style: TextStyle(
                            color: Theme.of(Get.context!).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 50,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Theme.of(Get.context!).primaryColor,
                              borderRadius: BorderRadius.circular(2)),
                          child: Center(
                            child: Text(
                              "Huỷ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      InkWell(
                        onTap: () {
                          onDone();
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Theme.of(Get.context!).primaryColor,
                              borderRadius: BorderRadius.circular(2)),
                          child: Text(
                            "Lưu thiết bị",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }

  Widget device(Device device) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${device.name ?? ""}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "ID: ${device.deviceId ?? ""}",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${device.status == 0 ? "Chờ duyệt" : device.status == 2 ? 'Không được duyệt' : "Đã duyệt"}",
                    style: TextStyle(
                      color: device.status == 0
                          ? Colors.red
                          : device.status == 2
                              ? Colors.red
                              : Colors.blue,
                    ),
                  ),
                  if (deviceController.deviceCurrent.value.deviceId ==
                      device.deviceId)
                    SizedBox(
                      height: 5,
                    ),
                  if (deviceController.deviceCurrent.value.deviceId ==
                      device.deviceId)
                    Container(
                      padding:
                          EdgeInsets.only(top: 3, left: 6, right: 6, bottom: 3),
                      decoration: BoxDecoration(
                        color: Theme.of(Get.context!).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Điện thoại này",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
