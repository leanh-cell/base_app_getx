import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/order_manage/order_detail_manage/bluetooth_print/bluetooth_print_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/printer_manager/printer_manager_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/screen2/bill/bill_detail/bill_detail_controller.dart';
import 'package:com.ikitech.store/app_user/screen2/bill/payment/pay_bill_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/bill/payment_history/payment_history_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/bill/refund/refund_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/bill/to_email/to_email_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/home/widget/bottom_detail.dart';
import 'package:com.ikitech.store/app_user/screen2/info_customer/info_customer_screen.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

class BillDetailScreen extends StatelessWidget {
  String orderCode;

  BillDetailScreen({required this.orderCode}) {
    billDetailController = BillDetailController(orderCode: orderCode);
  }
  List<String> choices = ["Lịch sử thanh toán", "In hoá đơn", "gửi hoá đơn"];

  late BillDetailController billDetailController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Hoá đơn POS"),
        actions: [
          PopupMenuButton(
            elevation: 3.2,
            onCanceled: () {},
            icon: Icon(Icons.more_vert),
            onSelected: (v) async {
              if (v == "In hoá đơn") {
                    showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Mời bạn chọn kiểu máy in"),
                      content: SizedBox(
                        width: Get.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              child: ListTile(
                                onTap: () {
                                  Get.back();
                                  Get.to(() => PrinterManagerScreen(
                                        order: billDetailController
                                            .orderShow.value,
                                      ));
                                },
                                leading: Icon(Icons.print),
                                title: Text("In wifi"),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Card(
                              child: ListTile(
                                onTap: () {
                                  Get.back();
                                  Get.to(()=>OrderBluetoothPrintScreen(order: billDetailController
                                            .orderShow.value,));
                                },
                                leading: Icon(Icons.print),
                                title: Text("In bluetooth"),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
                //billDetailController.printAll();

              } else if (v == "Lịch sử thanh toán") {
                Get.to(() => PaymentHistoryScreen(
                      orderCode:
                          billDetailController.orderShow.value.orderCode ?? "",
                    ));
              } else {
                if (billDetailController.orderShow.value.orderCode != null) {
                  Get.to(() => ToEmailScreen(
                      billDetailController.orderShow.value.orderCode ?? "",
                      billDetailController
                          .orderShow.value.infoCustomer?.email));
                }
              }
            },
            itemBuilder: (BuildContext context) {
              if (billDetailController.orderShow.value.orderCodeRefund !=
                  null) {
                choices = ["In hoá đơn", "gửi hoá đơn"];
              }
              return choices.map((String choice) {
                return PopupMenuItem(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Obx(
        () => billDetailController.isLoading.value
            ? SahaLoadingFullScreen()
            : Column(
                children: [
                  Obx(
                    () =>
                        billDetailController.orderShow.value.customerId == null
                            ? SizedBox(
                                height: 20,
                              )
                            : InkWell(
                                onTap: () {
                                  if (billDetailController
                                          .orderShow.value.customerId !=
                                      null) {
                                    Get.to(() => InfoCustomerScreen(
                                          infoCustomerId: billDetailController
                                              .orderShow.value.customerId!,
                                          isWatch: true,
                                        ));
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Khách hàng:"),
                                          Spacer(),
                                          Text(
                                              "${billDetailController.orderShow.value.infoCustomer?.name ?? ""}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text("SĐT:"),
                                          Spacer(),
                                          Text(
                                              "${billDetailController.orderShow.value.infoCustomer?.phoneNumber ?? ""}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text("Xu tích luỹ:"),
                                          Spacer(),
                                          Text(
                                              "${SahaStringUtils().convertToMoney(billDetailController.orderShow.value.infoCustomer?.point ?? 0)}")
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text("Công nợ:"),
                                          Spacer(),
                                          Text(
                                              "${SahaStringUtils().convertToMoney(billDetailController.orderShow.value.infoCustomer?.debt ?? 0)}")
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                  ),
                  Obx(
                    () =>
                        billDetailController.orderShow.value.orderCodeRefund !=
                                null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Đã hoàn tiền từ đơn",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      billDetailController.getOneOrder(
                                          billDetailController.orderShow.value
                                                  .orderCodeRefund ??
                                              "");
                                    },
                                    child: Text(
                                      " #${billDetailController.orderShow.value.orderCodeRefund ?? ""}",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 16),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                OrderDetailBottomDetail.showOrder(
                                    billDetailController.orderShow.value);
                              },
                              child: Row(
                                children: [
                                  Obx(() => Text(
                                      "${billDetailController.orderShow.value.orderCodeRefund != null ? "Đã hoàn: " : "Tổng phải trả: "}")),
                                  Obx(
                                    () => Text(
                                      "${SahaStringUtils().convertToMoney(billDetailController.orderShow.value.totalFinal ?? 0)}₫",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("Còn lại: "),
                                Obx(
                                  () => Text(
                                    "${SahaStringUtils().convertToMoney(billDetailController.orderShow.value.remainingAmount ?? 0)}₫",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                            child: Obx(() => billDetailController
                                            .orderShow.value.customerNote ==
                                        null ||
                                    billDetailController
                                            .orderShow.value.customerNote ==
                                        ""
                                ? Container()
                                : Text(
                                    "Ghi chú: ${billDetailController.orderShow.value.customerNote ?? ""}"))),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "HOÁ ĐƠN: ",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        Obx(
                          () => Text(
                            "#${billDetailController.orderShow.value.orderCode ?? ""}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => SingleChildScrollView(
                        child: Column(
                          children:
                              (billDetailController.orderShow.value.lineItems ??
                                      [])
                                  .map((e) => itemProduct(e))
                                  .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: Obx(
        () => billDetailController.orderShow.value.orderCodeRefund != null
            ? Container(
                height: 1,
                width: 1,
              )
            : Container(
                height: 65,
                color: Colors.white,
                child: Column(
                  children: [
                    SahaButtonFullParent(
                      text:
                          "${(billDetailController.orderShow.value.remainingAmount ?? 0) > 0 ? "THANH TOÁN CÒN LẠI" : "HOÀN TIỀN"}",
                      onPressed: () {
                        if ((billDetailController
                                    .orderShow.value.remainingAmount ??
                                0) >
                            0) {
                          Get.to(() => PayBillScreen(
                                moneyMustPay: billDetailController
                                        .orderShow.value.remainingAmount ??
                                    0,
                                orderCode: billDetailController
                                        .orderShow.value.orderCode ??
                                    "",
                              ));
                        } else {
                          Get.to(() => RefundScreen(
                                order: billDetailController.orderShow.value,
                              ));
                        }
                      },
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget itemProduct(
    LineItem order,
  ) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    imageUrl: (order.product?.images != null &&
                            order.product!.images!.isNotEmpty)
                        ? order.product!.images![0].imageUrl!
                        : "",
                    placeholder: (context, url) => new SahaLoadingWidget(
                      size: 20,
                    ),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${order.product?.name ?? ""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "SL: ${(order.quantity ?? 0)}",
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                        if ((order.totalRefund ?? 0) > 0 &&
                            billDetailController
                                    .orderShow.value.orderStatusCode !=
                                CUSTOMER_HAS_RETURNS)
                          Text(
                            ",  ",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12),
                          ),
                        if ((order.totalRefund ?? 0) > 0 &&
                            billDetailController
                                    .orderShow.value.orderStatusCode !=
                                CUSTOMER_HAS_RETURNS)
                          Text(
                            "Đã hoàn tiền SL: ${(order.totalRefund ?? 0)}",
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                      ],
                    ),
                    if(order.note != null && order.note != "")
                      Text(
                      "Ghi chú: ${order.note ?? ""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Text(
                      "${SahaStringUtils().convertToMoney(order.itemPrice ?? 0)}₫",
                      style: TextStyle(
                          color: Theme.of(Get.context!).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  ),
                  if (order.distributesSelected != null &&
                      order.distributesSelected!.isNotEmpty &&
                      order.distributesSelected![0].name != null)
                    Text(
                      "${order.distributesSelected![0].name}: ${order.distributesSelected![0].value}${order.distributesSelected![0].subElement != null && order.distributesSelected![0].subElement != "" ? "," : ""} ${order.distributesSelected![0].subElement ?? ""}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
