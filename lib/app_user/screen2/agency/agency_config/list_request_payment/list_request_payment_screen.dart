import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty_widget/saha_empty_payment_request.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:com.ikitech.store/app_user/model/request_payment.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../../saha_data_controller.dart';
import 'list_request_payment_controller.dart';

class ListRequestPaymentAgencyScreen extends StatelessWidget {
  ListRequestPaymentAgencyController listRequestPaymentController =
      ListRequestPaymentAgencyController();
  SahaDataController sahaDataController = Get.find();
  late List<Widget> itemWidget;
  List<String> choices = ["Quyết toán cho toàn bộ CTV"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Row(
              children: [
                listRequestPaymentController.isSearch.value
                    ? Expanded(
                        child: SahaTextFieldSearch(
                          hintText: "Tên hoặc STK",
                          textEditingController: listRequestPaymentController
                              .inputTextEditingController,
                          onSubmitted: (va) {
                            listRequestPaymentController.findRequestPayment();
                          },
                          onClose: () {
                            listRequestPaymentController.findRequestPayment(
                                isClose: true);
                            listRequestPaymentController
                                .inputTextEditingController.text = "";
                            listRequestPaymentController.isSearch.value = false;
                          },
                        ),
                      )
                    : Expanded(
                        child: Text(
                          "Danh sách yêu cầu",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
              ],
            )),
        actions: [
          IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {
                listRequestPaymentController.isSearch.value = true;
              }),
          Obx(() => listRequestPaymentController.indexInit.isEmpty
              ? DecentralizationWidget(
                  decent: sahaDataController.badgeUser.value.decentralization
                          ?.collaboratorPaymentRequestSolve ??
                      false,
                  child: PopupMenuButton(
                    elevation: 3.2,
                    initialValue: choices[0],
                    onCanceled: () {},
                    icon: Icon(Icons.more_vert),
                    onSelected: (v) async {
                      if (DateTime.now().day != 1 || DateTime.now().day != 17) {
                        if (listRequestPaymentController
                                    .payment16OfMonth.value ==
                                true ||
                            listRequestPaymentController
                                    .paymentOneOfMonth.value ==
                                true) {
                          SahaDialogApp.showDialogYesNo(
                              mess: listRequestPaymentController
                                  .checkSettlement(),
                              onOK: () async {
                                await listRequestPaymentController
                                    .settlementPayment();
                                listRequestPaymentController
                                    .getListRequestPayment();
                              });
                        } else {
                          await listRequestPaymentController
                              .settlementPayment();
                          listRequestPaymentController.getListRequestPayment();
                        }
                      } else {
                        await listRequestPaymentController.settlementPayment();
                        listRequestPaymentController.getListRequestPayment();
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return choices.map((String choice) {
                        return PopupMenuItem(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                )
              : TextButton(
                  onPressed: () async {
                    listRequestPaymentController.indexInit([]);
                    await listRequestPaymentController.getListRequestPayment();
                  },
                  child: Text(
                    "Bỏ chọn",
                    style: TextStyle(color: Colors.white),
                  ))),
        ],
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              boxTab(
                  index: 0,
                  title: "Theo yêu cầu",
                  onTap: () {
                    listRequestPaymentController.indexWidget(0);
                  }),
              boxTab(
                  index: 1,
                  title: "Theo lịch",
                  onTap: () {
                    listRequestPaymentController.indexWidget(1);
                  }),
            ],
          ),
          Container(
            height: 8,
            color: Colors.grey[200],
          ),
          Expanded(
            child: Obx(
              () => listRequestPaymentController.listRequestPaymentShow.isEmpty
                  ? Center(
                      child: SahaEmptyPaymentRequest(
                        width: 50,
                        height: 50,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(children: [
                        ...List.generate(
                            listRequestPaymentController
                                .listRequestPaymentShow.length,
                            (index) => boxRequest(
                                listRequestPaymentController
                                    .listRequestPaymentShow[index],
                                index))
                      ]),
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 65,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {
                      if (listRequestPaymentController.indexWidget.value == 0) {
                        listRequestPaymentController.listRequestPaymentShow
                            .forEach((e) {
                          if (e.checkChoose == false && e.from == 0) {
                            listRequestPaymentController
                                .listRequestPaymentShow[
                                    listRequestPaymentController
                                        .listRequestPaymentShow
                                        .indexOf(e)]
                                .checkChoose = true;
                          }
                        });
                      } else {
                        listRequestPaymentController.listRequestPaymentShow
                            .forEach((e) {
                          if (e.checkChoose == false && e.from == 1) {
                            listRequestPaymentController
                                .listRequestPaymentShow[
                                    listRequestPaymentController
                                        .listRequestPaymentShow
                                        .indexOf(e)]
                                .checkChoose = true;
                          }
                        });
                      }
                      listRequestPaymentController.listRequestPaymentShow
                          .refresh();
                      listRequestPaymentController.indexInit([]);
                      listRequestPaymentController.listInit.forEach((element) {
                        if (element.checkChoose == true) {
                          listRequestPaymentController.indexInit
                              .add(element.id!);
                        }
                      });
                    },
                    child: Obx(
                      () => Text(
                        "  Chọn tất cả(${listRequestPaymentController.indexInit.length})",
                        style: TextStyle(color: Colors.green),
                      ),
                    )),
                DecentralizationWidget(
                  decent: sahaDataController.badgeUser.value.decentralization
                          ?.collaboratorPaymentRequestSolve ??
                      false,
                  child: TextButton(
                      onPressed: () async {
                        await listRequestPaymentController
                            .changeStatusPayment(2);
                        listRequestPaymentController.getListRequestPayment();
                        listRequestPaymentController.indexInit([]);
                      },
                      child: Text(
                        "Thanh toán  ",
                        style: TextStyle(color: Colors.blueAccent),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget boxRequest(RequestPayment requestPayment, int index) {
    if (listRequestPaymentController.indexWidget.value == 0) {
      if (requestPayment.from == 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                      width: Get.width,
                      child: Center(
                        child: Text(
                          "${SahaStringUtils().convertToMoney(requestPayment.money ?? 0)} ₫",
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        ),
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Tên: ${requestPayment.ctv?.firstAndLastName ?? "'Chưa đặt tên'"}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Ngân hàng: ${requestPayment.ctv?.bank ?? "Chưa có TK"} - ${requestPayment.ctv?.accountNumber ?? "Chưa có STK"}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Chủ tài khoản: ${requestPayment.ctv?.accountName ?? "Chưa có tên CTK"}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Ngày yêu cầu: ${SahaDateUtils().getDDMMYY(requestPayment.createdAt!)}"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Checkbox(
                            value: requestPayment.checkChoose,
                            onChanged: (v) {
                              listRequestPaymentController
                                  .checkBoxAction(index);
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(height: 8, color: Colors.grey[200])
          ],
        );
      } else {
        return Container();
      }
    } else {
      if (requestPayment.from == 1) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                      width: Get.width,
                      child: Center(
                        child: Text(
                          "${SahaStringUtils().convertToMoney(requestPayment.money ?? 0)}₫",
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        ),
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Tên: ${requestPayment.ctv?.firstAndLastName ?? "'Chưa đặt tên'"}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Ngân hàng: ${requestPayment.ctv?.bank} - ${requestPayment.ctv?.accountNumber}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Chủ tài khoản: ${requestPayment.ctv?.accountName}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "Ngày yêu cầu: ${SahaDateUtils().getDDMMYY(requestPayment.createdAt!)}"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Checkbox(
                            value: requestPayment.checkChoose,
                            onChanged: (v) {
                              listRequestPaymentController
                                  .checkBoxAction(index);
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(height: 8, color: Colors.grey[200])
          ],
        );
      } else {
        return Container();
      }
    }
  }

  Widget boxTab(
      {required int index, required String title, required Function onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: Get.width / 2,
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 5,
            ),
            Obx(
              () => Text(
                "$title (${listRequestPaymentController.listRequestPaymentShow.where((e) => e.from == index).toList().length})",
                style: TextStyle(
                    fontSize: 15,
                    color: listRequestPaymentController.indexWidget.value ==
                            index
                        ? SahaColorUtils().colorPrimaryTextWithWhiteBackground()
                        : Colors.grey[500]),
              ),
            ),
            Obx(
              () => listRequestPaymentController.indexWidget.value == index
                  ? Container(
                      height: 3,
                      width: 40,
                      color: SahaColorUtils()
                          .colorPrimaryTextWithWhiteBackground(),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
