import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'config_notification_controller.dart';

class ConfigNotification extends StatelessWidget {
  ConfigNotificationController configNotificationController =
      ConfigNotificationController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cài đặt thông báo"),
        ),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Divider(
                      height: 1,
                    ),
                    if (configNotificationController.hasKey.value == false)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.keyboard_hide_outlined,
                              size: 18,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: configNotificationController
                                    .keyEditingController.value,
                                onChanged: (v) {
                                  configNotificationController
                                      .keyEditingController
                                      .refresh();
                                },
                                cursorColor: Colors.grey,
                                minLines: 1,
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: configNotificationController
                                              .key.value ==
                                          ""
                                      ? "Nhập Key thông báo"
                                      : configNotificationController.key.value,
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (configNotificationController.hasKey.value == true)
                      Column(
                        children: [
                          Divider(
                            height: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_hide_outlined,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: configNotificationController
                                        .titleEditingController.value,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      hintText: "Nhập tiêu đề",
                                    ),
                                    style: TextStyle(fontSize: 15),
                                    minLines: 1,
                                    maxLines: 1,
                                    onChanged: (v) {
                                      configNotificationController
                                          .titleEditingController
                                          .refresh();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_hide_outlined,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: configNotificationController
                                        .contentEditingController.value,
                                    onChanged: (v) {
                                      configNotificationController
                                          .contentEditingController
                                          .refresh();
                                    },
                                    cursorColor: Colors.grey,
                                    minLines: 1,
                                    maxLines: 5,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Nhập thông tin thông báo',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
                if (configNotificationController.hasKey.value == true)
                  TextButton(
                    onPressed: () {
                      configNotificationController.hasKey.value =
                          !configNotificationController.hasKey.value;
                    },
                    child: Text(
                      "Thay đổi Key",
                    ),
                  ),
                if (configNotificationController.hasKey.value == false &&
                    configNotificationController.key.value != "")
                  TextButton(
                    onPressed: () {
                      configNotificationController.hasKey.value =
                          !configNotificationController.hasKey.value;
                    },
                    child: Text(
                      "Huỷ",
                    ),
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 65,
          child: Column(
            children: [
              Obx(() {
                var title = configNotificationController
                    .titleEditingController.value.text;
                var content = configNotificationController
                    .contentEditingController.value.text;
                var key = configNotificationController
                    .keyEditingController.value.text;
                bool hasKey = configNotificationController.hasKey.value;

                return SahaButtonFullParent(
                  text:
                      "${configNotificationController.hasKey.value == true ? "Gửi" : "Bật"}",
                  onPressed: hasKey == true
                      ? (title != "" && content != "")
                          ? () {
                              configNotificationController.sendNotification();
                            }
                          : null
                      : key != ""
                          ? () {
                              configNotificationController.configNotification();
                            }
                          : null,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
