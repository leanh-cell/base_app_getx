import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/model/staff.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import '../../../../saha_data_controller.dart';
import '../../staff/add_staff/add_staff_screen.dart';
import '../../staff/customer_for_sale/customer_for_sale_screen.dart';
import 'list_sale_controller.dart';
import 'sale_detail/sale_detail_screen.dart';

class ListSaleScreen extends StatelessWidget {
  List<Staff>? listStaffInput;
  bool? isStaffOnline;
  bool? isChooseOne;
  Function? onDone;
  ListSaleScreen(
      {this.listStaffInput,
      this.onDone,
      this.isStaffOnline,
      this.isChooseOne}) {
    staffController = ListSaleController(
        listStaffInput: listStaffInput, isStaffOnline: isStaffOnline);
  }
  late ListSaleController staffController;
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Nhân viên sale"),
        actions: [
          if (onDone == null)
            TextButton(
                onPressed: () {
                  if (staffController.isSale.value) {
                    staffController.isSale.value = false;
                  } else {
                    staffController.isSale.value = true;
                  }

                  staffController.getListStaff();
                },
                child: Obx(
                  () => Text(
                    staffController.isSale.value ? "Tất cả" : 'Chỉ sale',
                    style: TextStyle(color: Colors.white),
                  ),
                ))
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
      bottomNavigationBar: onDone != null
          ? Container(
              height: 65,
              color: Colors.white,
              child: Column(
                children: [
                  SahaButtonFullParent(
                    text: onDone != null ? "Lưu" : "Thêm nhân viên",
                    onPressed: () {
                      onDone!(staffController.listStaffChoose.toList());
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            )
          : Container(
              height: 1,
              width: 1,
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
          Get.to(() => SaleDetailScreen(
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
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Theme.of(Get.context!).primaryColor,
                                ),
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
                                Icon(
                                  Icons.phone,
                                  color: Theme.of(Get.context!).primaryColor,
                                ),
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
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10, right: 10),
                        child: Row(
                          children: [
                            Text(
                              "Cho phép sale",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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
                ),
                onDone != null
                    ? Checkbox(
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
                        })
                    : Icon(Icons.navigate_next)
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
