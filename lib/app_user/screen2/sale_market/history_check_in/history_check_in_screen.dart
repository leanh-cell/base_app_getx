import 'package:com.ikitech.store/app_user/components/saha_user/divide/divide.dart';
import 'package:com.ikitech.store/app_user/screen2/sale_market/history_check_in/detail_history_check_in/detail_history_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../components/saha_user/loading/loading_full_screen.dart';
import '../../../model/history_check_in.dart';
import 'history_check_in_controller.dart';

class HistoryCheckInScreen extends StatelessWidget {
  HistoryCheckInScreen({Key? key, required this.agencyId}) : super(key: key) {
    controller = HistoryCheckInController(agencyId: agencyId);
  }
  final int agencyId;
  late final HistoryCheckInController controller;
  final RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch sử checkin đại lý"),
      ),
      body: Obx(
        () => controller.loadInit.value
            ? SahaLoadingFullScreen()
            : controller.listHistoryCheckIn.isEmpty
                ? const Center(
                    child: Text('Không có lịch sử nào'),
                  )
                : SmartRefresher(
                    footer: CustomFooter(
                      builder: (
                        BuildContext context,
                        LoadStatus? mode,
                      ) {
                        Widget body = Container();
                        if (mode == LoadStatus.idle) {
                          body = Obx(() => controller.isLoading.value
                              ? const CupertinoActivityIndicator()
                              : Container());
                        } else if (mode == LoadStatus.loading) {
                          body = const CupertinoActivityIndicator();
                        }
                        return SizedBox(
                          height: 100,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: refreshController,
                    enablePullDown: true,
                    enablePullUp: true,
                    header: const MaterialClassicHeader(),
                    onRefresh: () async {
                      await controller.getAllHistoryCheckIn(isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await controller.getAllHistoryCheckIn();
                      refreshController.loadComplete();
                    },
                    child: ListView.builder(
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemCount: controller.listHistoryCheckIn.length,
                        itemBuilder: (BuildContext context, int index) {
                          return itemHistory(
                              controller.listHistoryCheckIn[index]);
                        }),
                  ),
      ),
    );
  }

  Widget itemHistory(HistoryCheckIn historyCheckIn) {
    // Duration? timeVisit;
    // if (historyCheckIn.timeCheckout != null) {
    //   timeVisit = (historyCheckIn.timeCheckout ?? DateTime.now())
    //       .difference(historyCheckIn.timeCheckin ?? DateTime.now());
    // }
    return InkWell(
      onTap: (){
        Get.to(()=> DetailHistoryScreen(historyId: historyCheckIn.id!,));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Ngày tháng"),
                Text(
                    "${DateFormat("dd-MM-yyyy").format(historyCheckIn.createdAt ?? DateTime.now())}"),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Check in"),
                Text(
                    "${DateFormat("HH:mm").format(historyCheckIn.timeCheckin ?? DateTime.now())}"),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Check out"),
                Text(historyCheckIn.timeCheckin == null
                    ? "Chưa check out"
                    : "${DateFormat("HH:mm").format(historyCheckIn.timeCheckout ?? DateTime.now())}"),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            //  if (timeVisit != null)
            // Column(
            //   children: [
          
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text("Thời gian viếng thăm :"),
            //         Text(
            //             "${timeVisit.inHours}:${(timeVisit.inMinutes % 60).toString().padLeft(2, '0')}:${(timeVisit.inSeconds % 60).toString().padLeft(2, '0')}"),
            //       ],
            //     ),
            //      const SizedBox(
            //       height: 5,
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Trạng thái"),
                Text(
                  historyCheckIn.isAgencyOpen == true ? "Mở cửa" : "Đóng cửa",
                  style: TextStyle(
                      color: historyCheckIn.isAgencyOpen == true
                          ? Colors.green
                          : Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            SahaDivide()
          ],
        ),
      ),
    );
  }
}
