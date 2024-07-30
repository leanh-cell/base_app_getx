import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/model/shifts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'shifts_controller.dart';
import 'shifts_detail/shifts_detail_screen.dart';

class ShiftsScreen extends StatelessWidget {
  List<Shifts>? listShiftsInput;
  Function? onDone;
  ShiftsScreen({this.listShiftsInput, this.onDone}) {
    shiftsController = ShiftsController(listShiftsInput: listShiftsInput);
  }

  late ShiftsController shiftsController;
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Ca chấm công"),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: CustomFooter(
          builder: (
            BuildContext context,
            LoadStatus? mode,
          ) {
            Widget body = Container();
            if (mode == LoadStatus.idle) {
              body = Obx(() => shiftsController.isLoading.value
                  ? CupertinoActivityIndicator()
                  : Container());
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            }
            return Container(
              height: 100,
              child: Center(child: body),
            );
          },
        ),
        controller: refreshController,
        onRefresh: () async {
          await shiftsController.getListShift(isRefresh: true);
          refreshController.refreshCompleted();
        },
        onLoading: () async {
          await shiftsController.getListShift();
          refreshController.loadComplete();
        },
        child: SingleChildScrollView(
          child: Obx(
            () => Column(children: [
              SizedBox(height: 5,),
              ...shiftsController.listShift.map((e) => itemShifts(e)).toList(),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            SahaButtonFullParent(
              text: onDone != null ? "Lưu" : "Thêm ca",
              onPressed: () {
                if (onDone != null) {
                  onDone!(shiftsController.listShiftsChoose);
                } else {
                  Get.to(() => ShiftsDetailScreen())!.then((value) => {
                        if (value == "reload")
                          {
                            shiftsController.getListShift(isRefresh: true),
                          }
                      });
                }
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget itemShifts(Shifts shifts) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            if (onDone != null) {
              if (shiftsController.checkChoose(shifts)) {
                shiftsController.listShiftsChoose
                    .removeWhere((e) => e.id == shifts.id);
              } else {
                shiftsController.listShiftsChoose.add(shifts);
              }
            } else {
              Get.to(() => ShiftsDetailScreen(
                        shiftsInput: shifts,
                      ))!
                  .then((value) => {
                        if (value == "reload")
                          {shiftsController.getListShift(isRefresh: true)}
                      });
            }
          },
          child: Container(
            padding: EdgeInsets.only(top: 10, right: 20, left: 20),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${(shifts.startWorkHour ?? 0) < 10 ? "0${shifts.startWorkHour}" : shifts.startWorkHour}:${(shifts.startWorkMinute ?? 0) < 10 ? "0${shifts.startWorkMinute}" : shifts.startWorkMinute} - ${(shifts.endWorkHour ?? 0) < 10 ? "0${shifts.endWorkHour}" : shifts.endWorkHour}:${(shifts.endWorkMinute ?? 0) < 10 ? "0${shifts.endWorkMinute}" : shifts.endWorkMinute}"),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${shifts.name}",
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        height: 1,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (shifts.daysOfWeekList != null)
                            Text(
                                "${shifts.daysOfWeekList!.map((e) => e == 8 ? "CN" : "T$e").toList().toString().replaceAll("[", "").replaceAll("]", "")}"),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Ngày trong tuần",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            height: 1,
                          )
                        ],
                      ),
                      if (onDone != null)
                        Positioned(
                          right: 10,
                          top: -5,
                          child: Checkbox(
                              value: shiftsController.checkChoose(shifts),
                              onChanged: (v) {
                                if (shiftsController.checkChoose(shifts)) {
                                  shiftsController.listShiftsChoose
                                      .removeWhere((e) => e.id == shifts.id);
                                } else {
                                  shiftsController.listShiftsChoose.add(shifts);
                                }
                              }),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!shiftsController.checkChoose(shifts))
          if (shiftsController.checkDuplicate(shifts))
            Positioned.fill(
                child: Container(
              color: Colors.grey.withOpacity(0.1),
            ))
      ],
    );
  }
}
