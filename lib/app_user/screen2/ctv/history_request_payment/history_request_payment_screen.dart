import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/saha_text_field_search.dart';
import 'package:com.ikitech.store/app_user/model/request_payment.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'history_request_payment_controller.dart';

class HistoryRequestPaymentScreen extends StatelessWidget {
  HistoryRequestPaymentController listRequestPaymentController =
      HistoryRequestPaymentController();

  late List<Widget> itemWidget;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => listRequestPaymentController.isSearch.value
              ? SahaTextFieldSearch(
                  hintText: "Tên hoặc STK",
                  textEditingController:
                      listRequestPaymentController.inputTextEditingController,
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
                )
              : Text(
                  "Lịch sử thanh toán",
                  style: TextStyle(fontSize: 17),
                ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search_outlined),
              onPressed: () {
                listRequestPaymentController.isSearch.value = true;
              })
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(children: [
            ...List.generate(
                listRequestPaymentController.listRequestPaymentShow.length,
                (index) => boxRequest(
                    listRequestPaymentController.listRequestPaymentShow[index],
                    index))
          ]),
        ),
      ),
    );
  }

  Widget boxRequest(RequestPayment requestPayment, int index) {

    if (requestPayment.status == 0) {
      return Container();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: requestPayment.status == 2
                          ? Colors.green
                          : Colors.red)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${requestPayment.status == 2 ? "Đã thanh toán" : "Đã huỷ yêu cầu"}",
                      style: TextStyle(
                          fontSize: 18,
                          color: requestPayment.status == 2
                              ? Colors.green
                              : Colors.red),
                    ),
                  ),
                  SizedBox(
                      width: Get.width,
                      child: Center(
                        child: Text(
                          "${SahaStringUtils().convertToMoney(requestPayment.money ?? 0)}₫",
                          style: TextStyle(
                              fontSize: 18,
                              color: requestPayment.status == 2
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      )),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                "Tên: ${requestPayment.ctv?.customer?.name ?? "'Chưa đặt tên'"}"),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Ngày ${requestPayment.status == 2 ? "duyệt yêu cầu" : "huỷ yêu cầu"}: ${SahaDateUtils().getDDMMYY(requestPayment.updatedAt!)}",
                              style: TextStyle(
                                  color: requestPayment.status == 2
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(height: 8, color: Colors.grey[200])
        ],
      );
    }
  }
}
