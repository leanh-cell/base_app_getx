import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:com.ikitech.store/app_user/screen2/staff/add_staff/add_staff_screen.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../saha_data_controller.dart';
import 'choose_staff_controller.dart';

class ChooseStaffScreen extends StatelessWidget {
  ChooseStaffController staffController = ChooseStaffController();
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Nhân viên"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children:
                staffController.listStaff.map((e) => itemStaff(e)).toList(),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: DecentralizationWidget(
          decent:
              sahaDataController.badgeUser.value.decentralization?.staffAdd ??
                  false,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Thêm nhân viên",
                onPressed: () {
                  Get.to(() => AddStaffScreen())!
                      .then((value) => {staffController.getListStaff()});
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
    return InkWell(
      onTap: (){
        Get.back(result: staff);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Tên: ",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "${staff.name ?? ""}",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Phân quyền: ",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "${staff.decentralization?.name ?? ""}",
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Số điện thoại: ",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "${staff.phoneNumber ?? ""}",
                      ),
                    ],
                  ),
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
