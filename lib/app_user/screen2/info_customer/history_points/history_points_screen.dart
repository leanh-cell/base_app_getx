import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/model/score_history_item.dart';

import '../../../utils/string_utils.dart';
import 'history_points_controller.dart';

class HistoryPointScreen extends StatelessWidget {
  int customerId;

  HistoryPointScreen({required this.customerId}) {
    historyPointsController = HistoryPointsController(customerId: customerId);
  }

  RefreshController refreshController = RefreshController();
  late HistoryPointsController historyPointsController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử tích xu'),
      ),
      body: Column(
        children: [
          Obx(() => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                    'Xu hiện tại: ${SahaStringUtils().convertToMoney(historyPointsController.listHistoryPoint.first.currentPoint ?? 0)}', style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),),
              )),
          Divider(
            height: 1,
          ),
          Expanded(
            child: Obx(
              () => historyPointsController.isLoadInit.value
                  ? SahaLoadingFullScreen()
                  : SmartRefresher(
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
                            body = Obx(() =>
                                !historyPointsController.isDoneLoadMore.value
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
                        await historyPointsController.getHistoryPoints(
                            isRefresh: true);
                        refreshController.refreshCompleted();
                      },
                      onLoading: () async {
                        await historyPointsController.getHistoryPoints();
                        refreshController.loadComplete();
                      },
                      child: historyPointsController.isLoadInit.value
                          ? SahaLoadingFullScreen()
                          : historyPointsController.listHistoryPoint.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                    ),
                                    Text("Chưa có lịch sử tích xu")
                                  ],
                                )
                              : ListView.builder(
                                  itemCount: historyPointsController
                                      .listHistoryPoint.length,
                                  itemBuilder: (context, i) {
                                    return historyPoint(historyPointsController
                                        .listHistoryPoint[i]);
                                  },
                                )),
            ),
          ),
        ],
      ),
    );
  }

  Widget historyPoint(ScoreHistoryItem item) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "${item.referencesValue ?? ""}",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${SahaStringUtils().convertToMoney(item.point ?? 0)}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color:
                            (item.point ?? 0) >= 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${item.content}",
                  style: TextStyle(
                      color: Theme.of(Get.context!).primaryColor, fontSize: 12),
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
