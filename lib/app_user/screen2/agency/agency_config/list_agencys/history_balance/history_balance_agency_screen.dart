import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../../../saha_data_controller.dart';
import '../../../../../components/saha_user/button/saha_button.dart';
import '../../../../../components/saha_user/loading/loading_full_screen.dart';
import '../../../../../data/remote/response-request/ctv/history_balance_res.dart';
import '../../../../../model/agency.dart';
import 'history_balance_agency_controller.dart';

class HistoryBalanceAgencyScreen extends StatelessWidget {
  Agency agency;

  HistoryBalanceAgencyScreen({required this.agency}) {
    controller = HistoryBalanceAgencyController(agency: agency);
  }

  late HistoryBalanceAgencyController controller;
  RefreshController refreshController = RefreshController();
   SahaDataController sahaDataController = Get.find();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Lịch sử số dư"),
      ),
      body: Obx(
        () => controller.loadInit.value
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
                      body = Obx(() => controller.isLoading.value
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
                  await controller.getHistoryBalance(isRefresh: true);
                  refreshController.refreshCompleted();
                },
                onLoading: () async {
                  await controller.getHistoryBalance();
                  refreshController.loadComplete();
                },
                child: ListView.builder(
                  itemCount: controller.listHistoryBalance.length,
                  itemBuilder: (context, index) {
                    return item(controller.listHistoryBalance[index]);
                  },
                ),
              ),
      ),
      bottomNavigationBar:sahaDataController
                            .badgeUser.value.decentralization?.collaboratorAddSubBalance == 
                        true ? Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SahaButtonFullParent(
                    text: "Cộng số dư",
                    onPressed: () {
                      showDialogMoney(onInput: (String reason, double money) {
                        controller.addSubHistoryBalanceAgency(
                            money: money, reason: reason, isSub: false);
                        Get.back();
                      });
                    },
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: SahaButtonFullParent(
                    text: "Trừ số dư",
                    onPressed: () {
                      showDialogMoney(onInput: (String reason, double money) {
                        controller.addSubHistoryBalanceAgency(
                            money: money, reason: reason, isSub: true);
                        Get.back();
                      });
                    },
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ) : const SizedBox()
    );
  }

  Future<void> showDialogMoney({Function? onInput, Function? onCancel}) {
    return showDialog<String>(
        context: Get.context!,
        builder: (BuildContext context) {
          TextEditingController reasonEdit = new TextEditingController();
          TextEditingController moneyEdit = new TextEditingController();
          return new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new TextField(
                        autofocus: true,
                        controller: reasonEdit,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                          labelText: "Lý do",
                          hintText: "Nhập lý do",
                          hintStyle: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new TextField(
                        autofocus: true,
                        controller: moneyEdit,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          labelText: "Số tiền",
                          hintText: "Nhập số tiền",
                          hintStyle: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              new TextButton(
                  child: const Text('Hủy'),
                  onPressed: () {
                    if (onCancel != null) onCancel();
                    Get.back();
                  }),
              new TextButton(
                  child: const Text('Đồng ý'),
                  onPressed: () {
                    onInput!(
                        reasonEdit.text, double.tryParse(moneyEdit.text) ?? 0);
                  })
            ],
          );
        });
  }

  Widget item(HistoryBalance historyBalance) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
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
          Align(
            alignment: Alignment.topRight,
            child: Text(
              '${SahaStringUtils().convertToMoney(historyBalance.money)}',
              style: TextStyle(
                  color: (historyBalance.money ?? 0) < 0
                      ? Colors.red
                      : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          Text(
            "${historyBalance.typeName ?? ''}",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(child: Text('Số dư tại thời điểm:')),
              Text(
                  '${SahaStringUtils().convertToMoney(historyBalance.currentBalance ?? 0)}'),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                'Thời gian:',
                style: TextStyle(
                  color: Colors.grey,
                ),
              )),
              Text(
                '${SahaDateUtils().getHHMM(historyBalance.createdAt ?? DateTime.now())} ${SahaDateUtils().getDDMMYY(historyBalance.createdAt ?? DateTime.now())}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
