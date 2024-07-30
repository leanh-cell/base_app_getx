import 'package:com.ikitech.store/app_user/data/remote/response-request/staff/all_operation_history_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../components/saha_user/loading/loading_full_screen.dart';
import '../../const/const_operation_history.dart';
import '../../utils/date_utils.dart';
import 'filter/operation_filter_screen.dart';
import 'operation_history_controller.dart';

class OperationHistoryScreen extends StatelessWidget {
  OperationHistoryController operationHistoryController =
      OperationHistoryController();
  RefreshController refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch sử thao tác'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => OperationFilterScreen(
                      operationFilterInput:
                          operationHistoryController.filter.value,
                      callback: (filter) {
                        operationHistoryController.filter.value = filter;
                        operationHistoryController.getAllOperationHistory(isRefresh: true);
                      },
                    ));
              },
              icon: Icon(Icons.filter_alt_sharp))
        ],
      ),
      body: Obx(
        () => operationHistoryController.loadInit.value
            ? SahaLoadingFullScreen()
            : operationHistoryController.listHistory.isEmpty
                ? Center(
                    child: Text('Không có thao tác'),
                  )
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
                              operationHistoryController.isLoading.value
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
                      await operationHistoryController.getAllOperationHistory(
                          isRefresh: true);
                      refreshController.refreshCompleted();
                    },
                    onLoading: () async {
                      await operationHistoryController.getAllOperationHistory();
                      refreshController.loadComplete();
                    },
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            ...operationHistoryController.listHistory
                                .map((e) => itemHis(e))
                                .toList(),
                          ]),
                    ),
                  ),
      ),
    );
  }

  Widget itemHis(OperationHistory operationHistory) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
      margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Nhân viên: "),
              Expanded(
                  child: Text(
                '${operationHistory.userName ?? ""}',
                textAlign: TextAlign.end,
              ))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text("Chức năng: "),
              Expanded(
                  child: Text(
                '${operationHistory.functionTypeName ?? ""}',
                textAlign: TextAlign.end,
                style: TextStyle(color: Theme.of(Get.context!).primaryColor),
              ))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text('Thao tác'),
              Expanded(
                  child: Text(
                getAction(operationHistory.actionType ?? ""),
                textAlign: TextAlign.end,
                style: TextStyle(color: Theme.of(Get.context!).primaryColor),
              ))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nội dung: '),
              Expanded(
                child: Text(
                  "${operationHistory.content ?? ""}",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Theme.of(Get.context!).primaryColor),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Chi nhánh: '),
              Expanded(
                child: Text(
                  "${operationHistory.branchName ?? ""}",
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Theme.of(Get.context!).primaryColor),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text("IP: ${operationHistory.ip ?? ''}"),
              Spacer(),
              Text(
                  "${SahaDateUtils().getDDMMYY(operationHistory.createdAt ?? DateTime.now())} ${SahaDateUtils().getHHMM((operationHistory.createdAt ?? DateTime.now()))}"),
            ],
          )
        ],
      ),
    );
  }

  String getAction(String text) {
    if (text == OPERATION_ACTION_ADD) return "Thêm";
    if (text == OPERATION_ACTION_DELETE) return "Xoá";
    if (text == OPERATION_ACTION_UPDATE) return "Sửa";
    if (text == OPERATION_ACTION_CANCEL) return "Huỷ";
    return '';
  }
}
