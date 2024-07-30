import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../saha_data_controller.dart';
import '../../components/saha_user/call/call.dart';
import 'add_staff/add_staff_screen.dart';
import 'customer_for_sale/customer_for_sale_screen.dart';
import 'staff_controller.dart';

class StaffScreen extends StatelessWidget {
  List<Staff>? listStaffInput;
  bool? isStaffOnline;
  bool? isChooseOne;
  Function? onDone;
  StaffScreen(
      {this.listStaffInput,
      this.onDone,
      this.isStaffOnline,
      this.isChooseOne}) {
    staffController = StaffController(
        listStaffInput: listStaffInput, isStaffOnline: isStaffOnline);
  }
  late StaffController staffController;
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Nhân viên"),
        actions: [
          if (onDone != null)
            IconButton(
                onPressed: () {
                  Get.to(() => AddStaffScreen())!
                      .then((value) => {staffController.getListStaff()});
                },
                icon: Icon(Icons.add))
        ],
      ),
      body: Obx(
        () => staffController.loading.value
            ? SahaLoadingFullScreen()
            : staffController.listStaff.isEmpty
                ? Center(
                    child: Text('Không có nhân viên nào'),
                  )
                : SingleChildScrollView(
                    child: Column(children: [
                      if (onDone != null && isChooseOne != true)
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  staffController.listStaffChoose([]);
                                },
                                child: Text(
                                    "Bỏ chọn (${staffController.listStaffChoose.length})")),
                            Spacer(),
                            TextButton(
                                onPressed: () {
                                  staffController.listStaffChoose(
                                      staffController.listStaff.toList());
                                },
                                child: Text(
                                    "Chọn tất cả (${staffController.listStaffChoose.length})")),
                          ],
                        ),
                      ...staffController.listStaff
                          .map((e) => itemStaff(e))
                          .toList(),
                    ]),
                  ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: onDone != null ? "Lưu" : "Thêm nhân viên",
              onPressed: () {
                if (onDone != null) {
                  onDone!(staffController.listStaffChoose.toList());
                } else {
                  Get.to(() => AddStaffScreen())!
                      .then((value) => {staffController.getListStaff()});
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
    return InkWell(
      onTap: () {
        if (onDone != null) {
          if (isChooseOne == true) {
            staffController.listStaffChoose([staff]);
          } else {
            if (staffController.checkChoose(staff)) {
              staffController.listStaffChoose
                  .removeWhere((e) => e.id == staff.id);
            } else {
              staffController.listStaffChoose.add(staff);
            }
          }
        } else {
          Get.to(() => AddStaffScreen(
            staffInput: staff,
          ))!
              .then((value) => {
            staffController.getListStaff(),
          });
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.person, color: Theme.of(Get.context!).primaryColor,),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${staff.name ?? ""}",
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.phone, color: Theme.of(Get.context!).primaryColor,),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${staff.phoneNumber ?? ""}",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Tên đăng nhập: ",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${staff.username ?? ""}",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.admin_panel_settings, color: Theme.of(Get.context!).primaryColor,),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${staff.decentralization?.name ?? ""}",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
                          child: Row(
                            children: [
                              Text("Cho phép sale", style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                              Spacer(),
                              CupertinoSwitch(
                                value: staff.isSale ?? false,
                                onChanged: (v) {
                                  if ((staff.isSale ?? false) == true) {
                                    staffController.updateSaleStt(staff, false);
                                  } else {
                                    staffController.updateSaleStt(staff, true);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (onDone != null)
                      Positioned(
                        right: 10,
                        top: 40,
                        child: Checkbox(
                            value: staffController.checkChoose(staff),
                            onChanged: (v) {
                              if (isChooseOne == true) {
                                staffController.listStaffChoose([staff]);
                              } else {
                                if (staffController.checkChoose(staff)) {
                                  staffController.listStaffChoose
                                      .removeWhere((e) => e.id == staff.id);
                                } else {
                                  staffController.listStaffChoose.add(staff);
                                }
                              }
                            }),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}
