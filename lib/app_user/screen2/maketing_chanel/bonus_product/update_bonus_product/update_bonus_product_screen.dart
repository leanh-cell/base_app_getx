import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';

import '../../../../components/saha_user/dialog/dialog.dart';
import '../../../../utils/date_utils.dart';
import 'list_bonus_product/list_bonus_product_screen.dart';
import 'update_bonus_product_controller.dart';

class UpdateBonusProductScreen extends StatelessWidget {
  UpdateBonusProductScreen({Key? key, required this.updateBonusProductId})
      : super(key: key) {
    controller = UpdateBonusProductController(
        updateBonusProductId: updateBonusProductId);
  }
  final int updateBonusProductId;
  late UpdateBonusProductController controller;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tặng thưởng sản phẩm"),
      ),
      body: Obx(
        () => controller.loadInit.value
            ? SahaLoadingFullScreen()
            : SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            right: 10, left: 10, bottom: 5, top: 5),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text("Thưởng theo bậc thang")),
                            Obx(() => CupertinoSwitch(
                                value: controller
                                        .bonusProductReq.value.ladderReward ??
                                    false,
                                onChanged: (v) {
                                  controller
                                      .bonusProductReq.value.ladderReward = v;
                                  controller.bonusProductReq.refresh();
                                })),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          SahaDialogApp.showDialogGroupMarketingTypev2(
                              onChoose: (v) {
                                if ((controller.bonusProductReq.value.group ??
                                        [])
                                    .contains(v)) {
                                  (controller.bonusProductReq.value.group ?? [])
                                      .remove(v);
                                  controller.bonusProductReq.refresh();
                                  if (v == 2) {
                                    controller
                                        .bonusProductReq.value.agencyTypes = [];
                                  }
                                  if (v == 4) {
                                    controller
                                        .bonusProductReq.value.groupTypes = [];
                                  }
                                } else {
                                  controller.bonusProductReq.value.group!
                                      .add(v);
                                  controller.bonusProductReq.refresh();
                                }
                              },
                              groupType:
                                  controller.bonusProductReq.value.group);
                        },
                        child: Container(
                          width: Get.width,
                          height: 50,
                          padding: EdgeInsets.only(left: 10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.group,
                                color: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Obx(
                                  () => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Nhóm áp dụng: '),
                                      Expanded(
                                        child: Text(
                                          '${controller.bonusProductReq.value.group!.contains(0) ? "Tất cả," : ""}${controller.bonusProductReq.value.group!.contains(1) ? "Cộng tác viên," : ""}${controller.bonusProductReq.value.group!.contains(2) ? "Đại lý," : ""} ${controller.bonusProductReq.value.group!.contains(4) ? "Nhóm khách hàng" : ""}${controller.bonusProductReq.value.group!.contains(5) ? "Khách lẻ đã đăng nhập," : ""}${controller.bonusProductReq.value.group!.contains(6) ? "Khách lẻ chưa đăng nhập" : ""}',
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down_rounded),
                            ],
                          ),
                        ),
                      ),
                      Obx(() => controller.bonusProductReq.value.group!
                              .contains(2)
                          ? InkWell(
                              onTap: () {
                                SahaDialogApp.showDialogAgencyTypev2(
                                    onChoose: (v) {
                                      if (controller
                                          .bonusProductReq.value.agencyTypes!
                                          .contains(v)) {
                                        controller
                                            .bonusProductReq.value.agencyTypes!
                                            .remove(v);
                                      } else {
                                        controller
                                            .bonusProductReq.value.agencyTypes!
                                            .add(v);
                                      }
                                    },
                                    type: controller
                                        .bonusProductReq.value.agencyTypes!
                                        .map((e) => e.id ?? 0)
                                        .toList(),
                                    listAgencyType:
                                        controller.listAgencyType.toList());
                              },
                              child: Container(
                                width: Get.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 10),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.leaderboard,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Chọn cấp đại lý: '),
                                            Expanded(
                                              child: Text(
                                                controller.bonusProductReq.value
                                                        .agencyTypes!.isEmpty
                                                    ? ""
                                                    : "${controller.bonusProductReq.value.agencyTypes!.map((e) => "${e.name},")}",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.keyboard_arrow_down_rounded),
                                  ],
                                ),
                              ),
                            )
                          : Container()),
                      Obx(() => controller.bonusProductReq.value.group!
                              .contains(4)
                          ? InkWell(
                              onTap: () {
                                SahaDialogApp.showDialogCustomerGroupTypev2(
                                    onChoose: (v) {
                                      if (controller
                                          .bonusProductReq.value.groupTypes!
                                          .contains(v)) {
                                        controller
                                            .bonusProductReq.value.groupTypes!
                                            .remove(v);
                                      } else {
                                        controller
                                            .bonusProductReq.value.groupTypes!
                                            .add(v);
                                      }
                                    },
                                    type: controller
                                        .bonusProductReq.value.groupTypes!
                                        .map((e) => e.id ?? 0)
                                        .toList(),
                                    listGroupCustomer:
                                        controller.listGroup.toList());
                              },
                              child: Container(
                                width: Get.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 10),
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.leaderboard,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => Row(
                                          children: [
                                            Text('Chọn nhóm khách hàng: '),
                                            Expanded(
                                              child: Text(
                                                controller.bonusProductReq.value
                                                        .groupTypes!.isEmpty
                                                    ? ""
                                                    : "${controller.bonusProductReq.value.groupTypes!.map((e) => "${e.name},")}",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.keyboard_arrow_down_rounded),
                                  ],
                                ),
                              ),
                            )
                          : Container()),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text('Tên chương trình'),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller:
                                    controller.nameProgramEditingController,
                                validator: (value) {
                                  if (value!.length < 1) {
                                    return 'Chưa nhập tên chương trình';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText:
                                      "Nhập tên chương trình khuyến mãi tại đây",
                                ),
                                style: TextStyle(fontSize: 14),
                                minLines: 1,
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Thời gian bắt đầu'),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(1999, 1, 1),
                                        maxTime: DateTime(2050, 1, 1),
                                        onConfirm: (date) {
                                      controller.onChangeDateStart(date);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.vi);
                                  },
                                  child: Text(
                                    '${SahaDateUtils().getDDMMYY(controller.dateStart.value)}',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      DatePicker.showTime12hPicker(
                                        context,
                                        showTitleActions: true,
                                        onChanged: (date) {
                                          print('change $date in time zone ' +
                                              date.timeZoneOffset.inHours
                                                  .toString());
                                        },
                                        onConfirm: (date) {
                                          var timeCheck = DateTime(
                                              controller.dateStart.value.year,
                                              controller.dateStart.value.month,
                                              controller.dateStart.value.day,
                                              date.hour,
                                              date.minute,
                                              date.second);
                                          if (DateTime.now()
                                                  .isAfter(timeCheck) ==
                                              true) {
                                            controller.checkDayStart.value =
                                                true;
                                            controller.timeStart.value = date;
                                          } else {
                                            controller.checkDayStart.value =
                                                false;
                                            controller.timeStart.value = date;
                                          }
                                        },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.vi,
                                      );
                                    },
                                    child: Text(
                                      '  ${SahaDateUtils().getHHMM(controller.timeStart.value)}',
                                      style: TextStyle(color: Colors.blue),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      controller.checkDayStart.value
                          ? Container(
                              padding: EdgeInsets.all(8.0),
                              color: Colors.red[50],
                              width: Get.width,
                              child: Text(
                                "Vui lòng nhập thời gian bắt đầu chương trình khuyến mãi sau thời gian hiện tại",
                                style:
                                    TextStyle(fontSize: 13, color: Colors.red),
                              ),
                            )
                          : Divider(
                              height: 1,
                            ),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Thời gian kết thúc'),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(1999, 1, 1),
                                        maxTime: DateTime(2050, 1, 1),
                                        onChanged: (date) {},
                                        onConfirm: (date) {
                                      controller.onChangeDateEnd(date);
                                    },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.vi);
                                  },
                                  child: Text(
                                    '${SahaDateUtils().getDDMMYY(controller.dateEnd.value)}',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {
                                      DatePicker.showTime12hPicker(
                                        context,
                                        showTitleActions: true,
                                        onChanged: (date) {
                                          print('change $date in time zone ' +
                                              date.timeZoneOffset.inHours
                                                  .toString());
                                        },
                                        onConfirm: (date) {
                                          controller.onChangeTimeEnd(date);
                                        },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.vi,
                                      );
                                    },
                                    child: Text(
                                      '  ${SahaDateUtils().getHHMM(controller.timeEnd.value)}',
                                      style: TextStyle(color: Colors.blue),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      controller.checkDayEnd.value
                          ? Container(
                              padding: EdgeInsets.all(8.0),
                              color: Colors.red[50],
                              width: Get.width,
                              child: Text(
                                "Thời gian kết thúc phải sau thời gian bắt đầu",
                                style:
                                    TextStyle(fontSize: 13, color: Colors.red),
                              ),
                            )
                          : Divider(
                              height: 1,
                            ),
                      SizedBox(
                        height: 8,
                      ),
                      if (controller.bonusProductReq.value.ladderReward ==
                          false)
                        Container(
                          padding: EdgeInsets.only(
                              right: 10, left: 10, bottom: 5, top: 5),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child:
                                      Text("Hàng tặng nhân theo số lượng mua")),
                              Obx(() => CupertinoSwitch(
                                  value: controller.bonusProductReq.value
                                          .multiplyByNumber ??
                                      false,
                                  onChanged: (v) {
                                    controller.bonusProductReq.value
                                        .multiplyByNumber = v;
                                    controller.bonusProductReq.refresh();
                                  })),
                            ],
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Giới hạn tặng"),
                            Container(
                              width: Get.width * 0.6,
                              child: TextFormField(
                                controller: controller
                                    .amountCodeAvailableEditingController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  hintText: "Giới hạn tặng có thể sử dụng",
                                ),
                                minLines: 1,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      const Divider(),
                      Card(
                        child: ListTile(
                          onTap: () {
                            Get.to(() => ListBonusProductScreen(
                                  updateBonusProductId: updateBonusProductId,
                                ));
                          },
                          title: Text("Cài đặt danh sách thưởng"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
