import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import '../../../../saha_data_controller.dart';
import 'config_schedule_screen/config_schedule_screen.dart';
import 'schedule_noti_controller.dart';

class ScheduleNotiScreen extends StatelessWidget {
  ScheduleNotiController scheduleNotiController = ScheduleNotiController();
  SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách thông báo"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: scheduleNotiController.listSchedule
                .map((e) => Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          new BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            spreadRadius: 4,
                            offset: new Offset(0.0, 0.0),
                            blurRadius: 15.0,
                          ),
                        ],
                      ),
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 8.0, bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/title.svg",
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Tiêu đề: ",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${e.title ?? "Không có tiêu đề"}",
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 8.0, bottom: 8.0),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/description.svg",
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Mô tả: ",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${e.description ?? "Không có mô tả"}",
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 8.0, bottom: 8.0),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/send.svg",
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Gửi tới: ",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${e.groupCustomer! == 0 ? "Tất cả" : e.groupCustomer! == 1 ? "Khách hàng có ngày sinh nhật" : e.groupCustomer! == 2 ? "Đại lý (${e.agencyTypeName})" : 'Cộng tác viên'}",
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 8.0, bottom: 8.0),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/bell2.svg",
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Kiểu thông báo: ",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${e.typeSchedule! == 0 ? "1 lần" : e.typeSchedule! == 1 ? "Hàng ngày" : e.typeSchedule! == 2 ? "Hàng tuần" : "Hàng tháng"}",
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                              ),
                              if (e.typeSchedule! == 0)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 8.0, bottom: 8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/history.svg",
                                        height: 25,
                                        width: 25,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Thời gian thông báo: ",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${SahaDateUtils().getDDMMYY(e.timeRun ?? DateTime.now())} ${SahaDateUtils().getHHMM(e.timeRun ?? DateTime.now())}",
                                          textAlign: TextAlign.right,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Divider(
                                height: 1,
                              ),
                              if (e.typeSchedule! == 2)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 8.0, bottom: 8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/calendar.svg",
                                        height: 25,
                                        width: 25,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Ngày thông báo: ",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${scheduleNotiController.convertDay(e.dayOfWeek ?? 0)}",
                                          textAlign: TextAlign.right,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Divider(
                                height: 1,
                              ),
                              if (e.typeSchedule! == 3)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 8.0, bottom: 8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/calendar.svg",
                                        height: 25,
                                        width: 25,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Ngày thông báo: ",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${e.dayOfMonth}",
                                          textAlign: TextAlign.right,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Divider(
                                height: 1,
                              ),
                              if (e.typeSchedule! != 0)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 8.0, bottom: 8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/history.svg",
                                        height: 25,
                                        width: 25,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Thời gian thông báo trong ngày: ",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Expanded(
                                          child: Text(
                                        "${e.timeOfDay}",
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ],
                                  ),
                                ),
                              Divider(
                                height: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, right: 8.0, bottom: 8.0),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/pause.svg",
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Tình trạng: ",
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${e.status == 0 ? "Đang chạy" : e.status == 1 ? "Tạm dừng" : "Đã chạy"}",
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: Divider(
                                  height: 1,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (e.status != 2)
                                    InkWell(
                                      onTap: () {
                                        scheduleNotiController
                                            .updateScheduleNoti(e);
                                      },
                                      child: Container(
                                        width: Get.width / 4,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.2)),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        height: 30,
                                        child: Center(
                                          child: Text(
                                            "${e.status == 0 ? "Tạm dừng" : e.status == 1 ? "Tiếp tục" : ""}",
                                          ),
                                        ),
                                      ),
                                    ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => ConfigScheduleScreen(
                                                scheduleInput: e,
                                              ))!
                                          .then((value) {
                                        scheduleNotiController
                                            .getAllScheduleNoti();
                                      });
                                    },
                                    child: Container(
                                      width: Get.width / 4,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.2)),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      height: 30,
                                      child: Center(
                                        child: Text(
                                          "Chỉnh sửa",
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      scheduleNotiController
                                          .deleteScheduleNoti(e.id!);
                                    },
                                    child: Container(
                                      width: Get.width / 4,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.2)),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      height: 30,
                                      child: Center(
                                        child: Text(
                                          "Xoá",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
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
              text: "Thêm lịch thông báo",
              onPressed: () {
                Get.to(() => ConfigScheduleScreen())!.then(
                    (value) => {scheduleNotiController.getAllScheduleNoti()});
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
