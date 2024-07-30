import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/model/device.dart';
import 'package:com.ikitech.store/app_user/model/history_checkin_checkout.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'approve_controller.dart';
import 'device_approve/device_approve_screen.dart';
// import 'list_device_approve/list_device_approve_screen.dart';

class ApproveScreen extends StatefulWidget {
  @override
  State<ApproveScreen> createState() => _ApproveScreenState();
}

class _ApproveScreenState extends State<ApproveScreen>
    with SingleTickerProviderStateMixin {
  RefreshController refreshController = RefreshController(initialRefresh: true);

  RefreshController refreshController2 =
      RefreshController(initialRefresh: true);

  ApproveController approveController = ApproveController();

  late TabController _tabController;

  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Phê duyệt"),
      ),
      body: Column(
        children: [
          Divider(
            height: 1,
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: Get.width,
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                        child: Text('Chấm công',
                            style: TextStyle(color: Colors.black))),
                    Tab(
                        child: Text('Thiết bị',
                            style: TextStyle(color: Colors.black))),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 1,
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              approveTimeKeeping(),
              approveMobile(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget approveMobile() {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: MaterialClassicHeader(),
      controller: refreshController,
      onRefresh: () async {
        await approveController.getAllDeviceAwait();
        refreshController.refreshCompleted();
      },
      child: Obx(
        () => approveController.isLoading.value
            ? SahaLoadingFullScreen()
            : approveController.listDevice.isEmpty
                ? Center(
                    child: Text(
                      "Không có thiết bị phê duyệt",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      ...approveController.listDevice
                          .map((e) => device(e))
                          .toList(),
                    ]),
                  ),
      ),
    );
  }

  Widget approveTimeKeeping() {
    return SmartRefresher(
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
            body = Obx(() => approveController.isLoading.value
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
      controller: refreshController2,
      onRefresh: () async {
        await approveController.getAllAwaitCheckInOutsAwait(isRefresh: true);
        refreshController2.refreshCompleted();
      },
      onLoading: () async {
        await approveController.getAllAwaitCheckInOutsAwait();
        refreshController2.loadComplete();
      },
      child: Obx(
        () => approveController.historyApprove.isEmpty
            ? Center(
                child: Text(
                  "Không có yêu cầu phê duyệt",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ...approveController.historyApprove
                        .map((e) => historyCheckInOut(e))
                        .toList(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget historyCheckInOut(HistoryCheckInCheckout his) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${(his.staff?.name ?? "P")[0].toUpperCase()}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: Text("${his.staff?.name ?? ""}")),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        approveController.changeStatusApprove(
                            status: 3, deviceId: his.id!);
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.red,
                      )),
                  IconButton(
                      onPressed: () {
                        approveController.changeStatusApprove(
                            status: 2, deviceId: his.id!);
                      },
                      icon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Ionicons.calendar_outline,
                            color: Theme.of(Get.context!).primaryColor,
                          ),
                          Text(
                            " ${SahaDateUtils().convertDateToWeekDate(his.date ?? DateTime.now())}, ${(his.date ?? DateTime.now()).day} tháng ${(his.date ?? DateTime.now()).month} ${(his.date ?? DateTime.now()).year}",
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Ionicons.time_outline,
                            color: Theme.of(Get.context!).primaryColor,
                          ),
                          Text(
                            " ${his.isCheckin == true ? "Vào làm" : "Tan làm"} | ${SahaDateUtils().getHHMM(his.timeCheck ?? DateTime.now())}",
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Chờ duyệt",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Lý do: ${his.reason ?? ""}")
            ],
          ),
        ),
        Divider(),
      ],
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
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 1,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${(device.staff?.name ?? "P")[0].toUpperCase()}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(child: Text("${device.staff?.name ?? ""}")),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => DeviceApproveScreen(
                              staff: device.staff!,
                            ));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.mobile_friendly_sharp,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                          Text(
                            "  Số thiết bị được duyệt: ${device.staff?.totalDevice ?? 0}",
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            approveController.changeStatusDevice(
                                status: 2, deviceId: device.id!); // 2 la huy
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.red,
                          )),
                      IconButton(
                          onPressed: () {
                            approveController.changeStatusDevice(
                                status: 1, deviceId: device.id!);
                          },
                          icon: Icon(
                            Icons.check,
                            color: Colors.green,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline_rounded,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Chờ duyệt",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      )
                    ],
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
