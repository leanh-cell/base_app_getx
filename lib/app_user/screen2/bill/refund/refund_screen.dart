import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/refund_request.dart';
import 'package:com.ikitech.store/app_user/screen2/bill/bill_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/order/order_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/widget/item_product_refund.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'refund_controller.dart';

class RefundScreen extends StatelessWidget {
  Order order;
  late RefundController refundController;

  TextEditingController inputQuantityEditingController =
      TextEditingController();
  FocusNode inputQuantityFocusNode = FocusNode();

  RefundScreen({required this.order}) {
    refundController = RefundController(inputOrder: order);
  }

  OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Hoàn tiền"),
      ),
      body: Obx(
        () => Column(
          children: [
            if ((refundController.orderResponse.value.lineItems ?? [])
                .isNotEmpty)
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        refundController.listNewItem([]);
                        refundController.refundCalculate();
                      },
                      child: Text(
                        "Bỏ chọn (${refundController.listNewItem.length})",
                        style: TextStyle(color: Colors.red),
                      )),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        refundController.priceToTal.value = 0;
                        refundController.listNewItem(
                            (refundController.orderResponse.value.lineItems ??
                                    [])
                                .map((e) => NewLineItem(
                                    lineItemId: e.id,
                                    quantity: e.quantity,
                                    price: e.itemPrice))
                                .toList());
                        refundController.refundCalculate();
                      },
                      child: Text(
                        "Chọn tất cả (${refundController.listNewItem.length})",
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      )),
                ],
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: refundController.isLoading.value == true
                    ? SahaLoadingFullScreen()
                    : (refundController.orderResponse.value.lineItems ?? [])
                            .isEmpty
                        ? Center(
                            child: Text(
                            "Đã hoàn trả toàn bộ sản phẩm",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ))
                        : ListView.builder(
                            itemCount: (refundController
                                        .orderResponse.value.lineItems ??
                                    [])
                                .length,
                            itemBuilder: (context, index) =>
                                ItemProductInCartRefundWidget(
                              valueCheckBox: refundController.listNewItem
                                  .map((e) => e.lineItemId!)
                                  .contains((refundController
                                              .orderResponse.value.lineItems ??
                                          [])[index]
                                      .id),
                              onCheckBox: () {
                                var lineItem = (refundController
                                        .orderResponse.value.lineItems ??
                                    [])[index];
                                if (refundController.listNewItem
                                    .map((e) => e.lineItemId!)
                                    .contains(lineItem.id)) {
                                  refundController.listNewItem.removeWhere(
                                      (e) => e.lineItemId == lineItem.id);
                                } else {
                                  refundController.listNewItem.add(NewLineItem(
                                    lineItemId: lineItem.id!,
                                    quantity: (lineItem.quantity ?? 0),
                                    price: lineItem.itemPrice,
                                  ));
                                }
                                refundController.orderResponse.refresh();
                                refundController.refundCalculate();
                              },
                              lineItem: (refundController
                                      .orderResponse.value.lineItems ??
                                  [])[index],
                              onDismissed: () async {
                                refundController.orderResponse.value.lineItems!
                                    .removeAt(index);
                              },
                              onDecreaseItem: () {
                                var lineItem = (refundController
                                        .orderResponse.value.lineItems ??
                                    [])[index];

                                if ((lineItem.quantity ?? 0) > 1) {
                                  lineItem.quantity = lineItem.quantity! - 1;
                                }

                                var indexL = refundController.listNewItem
                                    .indexWhere(
                                        (e) => e.lineItemId == lineItem.id);
                                if (indexL != -1) {
                                  refundController.listNewItem[indexL] =
                                      NewLineItem(
                                          lineItemId: lineItem.id,
                                          quantity: lineItem.quantity,
                                          price: lineItem.itemPrice);
                                }
                                refundController.orderResponse.refresh();
                                refundController.refundCalculate();
                              },
                              onIncreaseItem: () {
                                var lineItem = (refundController
                                        .orderResponse.value.lineItems ??
                                    [])[index];
                                if ((lineItem.quantity ?? 0) <
                                    refundController.listMax[index]) {
                                  lineItem.quantity = lineItem.quantity! + 1;
                                }
                                var indexL = refundController.listNewItem
                                    .indexWhere(
                                        (e) => e.lineItemId == lineItem.id);
                                if (indexL != -1) {
                                  refundController.listNewItem[indexL] =
                                      NewLineItem(
                                          lineItemId: lineItem.id,
                                          quantity: lineItem.quantity,
                                          price: lineItem.itemPrice);
                                }
                                refundController.orderResponse.refresh();
                                refundController.refundCalculate();
                              },
                              onUpdateQuantity: () {
                                refundController.isHideInputQuantity.value =
                                    true;
                                refundController.indexItem = index;
                                refundController.refundCalculate();
                              },
                              quantity: (refundController.orderResponse.value
                                      .lineItems![index].quantity ??
                                  0),
                            ),
                          ),
              ),
            ),
            if (refundController.isHideInputQuantity.value)
              Container(
                width: Get.width,
                height: 130,
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Column(
                  children: [
                    Text("Nhập số lượng"),
                    TextField(
                      autofocus: true,
                      controller: inputQuantityEditingController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      focusNode: inputQuantityFocusNode,
                    ),
                    TextButton(
                        onPressed: () {
                          refundController.isHideInputQuantity.value = false;
                          FocusScope.of(context).unfocus();
                          if (inputQuantityEditingController.text != "") {
                            if (refundController.indexItem != null) {
                              var max = refundController
                                  .listMax[refundController.indexItem!];
                              if (int.parse(
                                          inputQuantityEditingController.text) >
                                      0 &&
                                  int.parse(inputQuantityEditingController
                                          .text) <=
                                      max) {
                                refundController
                                        .orderResponse
                                        .value
                                        .lineItems![refundController.indexItem!]
                                        .quantity =
                                    int.parse(
                                        inputQuantityEditingController.text);
                                var indexL = refundController.listNewItem
                                    .indexWhere((e) =>
                                        e.lineItemId ==
                                        refundController
                                            .orderResponse
                                            .value
                                            .lineItems![
                                                refundController.indexItem!]
                                            .id);
                                if (indexL != -1) {
                                  refundController.listNewItem[indexL] =
                                      NewLineItem(
                                          lineItemId: refundController
                                              .orderResponse
                                              .value
                                              .lineItems![
                                                  refundController.indexItem!]
                                              .id,
                                          quantity: refundController
                                              .orderResponse
                                              .value
                                              .lineItems![
                                                  refundController.indexItem!]
                                              .quantity,
                                          price: refundController
                                              .orderResponse
                                              .value
                                              .lineItems![
                                                  refundController.indexItem!]
                                              .itemPrice);
                                }
                                refundController.refundCalculate();
                              } else {
                                SahaAlert.showError(
                                    message:
                                        "số lượng trả lớn hơn số lượng gốc");
                              }
                            }
                          }
                          inputQuantityEditingController.text = "";
                        },
                        child: Text("Xong"))
                  ],
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => (refundController.orderResponse.value.lineItems ?? []).isEmpty
            ? Container(
                height: 1,
                width: 1,
              )
            : Container(
                color: Colors.white,
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (refundController.refundCalculateShow.value
                                        .voucherDiscountAmount !=
                                    null &&
                                refundController.refundCalculateShow.value
                                        .voucherDiscountAmount !=
                                    0)
                              Row(
                                children: [
                                  Text(
                                    "Hoàn Voucher: ",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                      "${SahaStringUtils().convertToMoney(refundController.refundCalculateShow.value.voucherDiscountAmount ?? 0)}")
                                ],
                              ),
                            if (refundController.refundCalculateShow.value
                                        .voucherDiscountAmount !=
                                    null &&
                                refundController.refundCalculateShow.value
                                        .voucherDiscountAmount !=
                                    0)
                              SizedBox(
                                height: 5,
                              ),
                            if (refundController
                                        .refundCalculateShow.value.discount !=
                                    null &&
                                refundController
                                        .refundCalculateShow.value.discount !=
                                    0)
                              Row(
                                children: [
                                  Text(
                                    "Hoàn giảm giá SP: ",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                      "${SahaStringUtils().convertToMoney(refundController.refundCalculateShow.value.discount ?? 0)}")
                                ],
                              ),
                            if (refundController
                                        .refundCalculateShow.value.discount !=
                                    null &&
                                refundController
                                        .refundCalculateShow.value.discount !=
                                    0)
                              SizedBox(
                                height: 5,
                              ),
                            Row(
                              children: [
                                Text(
                                  "TỔNG TIỀN HOÀN: ",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${SahaStringUtils().convertToMoney(refundController.refundCalculateShow.value.totalRefundCurrentInTime ?? 0)}",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SahaButtonFullParent(
                        text: "HOÀN TIỀN",
                        onPressed: refundController.listNewItem.isEmpty
                            ? null
                            : () async {
                                await refundController.refund();
                                orderController.loadMoreOrder(isRefresh: true);
                              },
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
