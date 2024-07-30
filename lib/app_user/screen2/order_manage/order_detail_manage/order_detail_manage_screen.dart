// ignore: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/calculate_fee_order_res.dart';
import 'package:com.ikitech.store/app_user/screen2/config/print_bluetooth/print_bluetooth_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/decentralization/decentralization_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/const/const_revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/model/box_chat_customer.dart';
import 'package:com.ikitech.store/app_user/model/shipment.dart';
import 'package:com.ikitech.store/app_user/screen2/chat/chat_user_screen/chat_user_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/info_customer/history_order/order_detail_manage/pdf/pdf_api.dart';
import 'package:com.ikitech.store/app_user/screen2/info_customer/history_order/order_detail_manage/pdf/pdf_invoice.dart';
import 'package:com.ikitech.store/app_user/screen2/printer_manager/printer_manager_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:hive/hive.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:screenshot/screenshot.dart';
import '../../../../saha_data_controller.dart';
import '../../../components/saha_user/popup/popup_keyboard.dart';
import '../../../const/order_constant.dart';
import '../../bill/payment/pay_bill_screen.dart';
import '../../bill/refund/refund_screen.dart';
import '../edit_order/edit_order_screen.dart';
import 'bluetooth_print/bluetooth_print_screen.dart';
import 'order_detail_manage_controller.dart';
import 'widget/dialog_choose_order_status.dart';
import 'widget/dialog_choose_payment_status.dart';

class OrderDetailScreen extends StatelessWidget {
  final Order order;
  final int? indexListOrder;
  final int? indexStateOrder;

  OrderDetailScreen(
      {required this.order, this.indexListOrder, this.indexStateOrder}) {
    orderDetailController = OrderDetailController(inputOrder: order);
  } 

  SahaDataController sahaDataController = Get.find();
  late OrderDetailController orderDetailController;

  var expanded = false.obs;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Đơn hàng"),
        leading: IconButton(
          onPressed: () {
            if (orderDetailController.isToOrderRefund) {
              Get.back();
            } else {
              Get.back(result: order.orderCode);
            }
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                final pdfFile = await PdfInvoiceApi.generate(
                    orderDetailController.orderResponse.value);

                PdfApi.openFile(pdfFile);
              },
              icon: Icon(Icons.picture_as_pdf)),
          IconButton(
              onPressed: () {
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
                                        order: orderDetailController
                                            .orderResponse.value,
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
                                  Get.to(()=>OrderBluetoothPrintScreen(order: order,));
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
              },
              icon: Icon(Icons.print)),
          IconButton(
              onPressed: () async {
                Get.to(() => EditOrderScreen(
                      oderCode: order.orderCode!,
                    ));
              },
              icon: Icon(Icons.edit)),
        ],
      ),
      body: Obx(
        () => orderDetailController.isLoadingOrder.value
            ? SahaLoadingFullScreen()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(
                      () => orderDetailController
                                  .orderResponse.value.orderCodeRefund !=
                              null
                          ? InkWell(
                              onTap: () {
                                orderDetailController.isToOrderRefund = true;
                                orderDetailController.getOneOrder(
                                    orderCode: orderDetailController
                                            .orderResponse
                                            .value
                                            .orderCodeRefund ??
                                        "");
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Đã hoàn tiền từ đơn",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "Từ đơn #${orderDetailController.orderResponse.value.orderCodeRefund ?? ""}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ),
                    Container(
                      color: Color(0xff16a5a1),
                      child: Column(
                        children: [
                          DecentralizationWidget(
                            decent: sahaDataController.badgeUser.value
                                    .decentralization?.orderAllowChangeStatus ??
                                false,
                            child: IgnorePointer(
                              ignoring: orderDetailController
                                      .orderResponse.value.orderStatusCode ==
                                  CUSTOMER_HAS_RETURNS,
                              child: InkWell(
                                onTap: () {
                                  if (sahaDataController
                                          .badgeUser.value.isStaff ==
                                      true) {
                                    print(sahaDataController
                                        .branchCurrent.value.id);
                                    print(orderDetailController
                                        .orderResponse.value.branch?.id);
                                    if (sahaDataController
                                            .branchCurrent.value.id ==
                                        orderDetailController
                                            .orderResponse.value.branch?.id) {
                                      DialogChooseOrderStatus.showChoose(
                                          (value) async {
                                        if (value == CUSTOMER_HAS_RETURNS) {
                                          Get.back();
                                          Get.to(() => RefundScreen(
                                                order: orderDetailController
                                                    .orderResponse.value,
                                              ));
                                        } else {
                                          Get.back();
                                          await orderDetailController
                                              .changeOrderStatus(value);
                                        }
                                      },
                                          orderDetailController.orderResponse
                                              .value.orderStatusCode!);
                                    } else {
                                      SahaAlert.showToastMiddle(
                                          message:
                                              "Bạn không có quyền của CN ${orderDetailController.orderResponse.value.branch?.name ?? ""}");
                                    }
                                  } else {
                                    DialogChooseOrderStatus.showChoose(
                                        (value) async {
                                      if (value == CUSTOMER_HAS_RETURNS) {
                                        Get.back();
                                        Get.to(() => RefundScreen(
                                              order: orderDetailController
                                                  .orderResponse.value,
                                            ));
                                      } else {
                                        Get.back();
                                        await orderDetailController
                                            .changeOrderStatus(value);
                                      }
                                    },
                                        orderDetailController.orderResponse
                                            .value.orderStatusCode!);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Trạng thái đơn hàng: ${orderDetailController.orderResponse.value.orderStatusName}",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .headline6!
                                                .color),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .headline6!
                                            .color,
                                        size: 18,
                                      ),
                                      Spacer(),
                                      if (orderDetailController.orderResponse
                                              .value.orderStatusName ==
                                          "Đã hoàn thành")
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => RefundScreen(
                                                  order: orderDetailController
                                                      .orderResponse.value,
                                                ));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Text(
                                              "Hoàn trả",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                          DecentralizationWidget(
                            decent: sahaDataController.badgeUser.value
                                    .decentralization?.orderAllowChangeStatus ??
                                false,
                            child: IgnorePointer(
                              ignoring: orderDetailController
                                      .orderResponse.value.orderStatusCode ==
                                  CUSTOMER_HAS_RETURNS,
                              child: InkWell(
                                onTap: () {
                                  if (sahaDataController
                                          .badgeUser.value.isStaff ==
                                      true) {
                                    if (sahaDataController
                                            .branchCurrent.value.id ==
                                        orderDetailController
                                            .orderResponse.value.branch?.id) {
                                      DialogChoosePaymentStatus
                                          .showChoosePayment((value) async {
                                        orderDetailController
                                            .changePaymentStatus(value);
                                        Get.back();
                                      },
                                              orderDetailController
                                                  .orderResponse
                                                  .value
                                                  .paymentStatusCode!);
                                    } else {
                                      SahaAlert.showToastMiddle(
                                          message:
                                              "Bạn không có quyền của CN ${orderDetailController.orderResponse.value.branch?.name ?? ""}");
                                    }
                                  } else {
                                    DialogChoosePaymentStatus.showChoosePayment(
                                        (value) async {
                                      orderDetailController
                                          .changePaymentStatus(value);
                                      Get.back();
                                    },
                                        orderDetailController.orderResponse
                                            .value.paymentStatusCode!);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Trạng thái thanh toán: ${orderDetailController.orderResponse.value.paymentStatusName}",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryTextTheme
                                                .headline6!
                                                .color),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .headline6!
                                            .color,
                                        size: 18,
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print(orderDetailController
                            .orderResponse.value.orderStatusCode);
                        if (orderDetailController
                                    .orderResponse.value.orderStatusCode ==
                                SHIPPING ||
                            orderDetailController
                                    .orderResponse.value.orderStatusCode ==
                                COMPLETED) {
                          SahaAlert.showToastMiddle(
                              message:
                                  'Đơn hàng đã xử lý không thể điều chuyển chi nhánh');
                        } else {
                          SahaDialogApp.showDialogBranchOrder(
                              branchId: orderDetailController
                                  .orderResponse.value.branchId,
                              listBranch: orderDetailController.listBranch,
                              callBack: (branch) {
                                orderDetailController.updateOrder(
                                    branchId: branch.id);
                              });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              "Chuyển chi nhánh: ${orderDetailController.orderResponse.value.branch?.name ?? ""}",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_down_rounded),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    if (orderDetailController
                            .orderResponse.value.orderStatusCode !=
                        CUSTOMER_HAS_RETURNS)
                      Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Column(
                          children: [
                            if (orderDetailController
                                .listHistoryShipper.isEmpty)
                              InkWell(
                                onTap: () {
                                  print(orderDetailController
                                      .orderResponse.value.partnerShipperId);
                                  SahaDialogApp.showDialogShipment(
                                      list: orderDetailController
                                          .listShipmentStore,
                                      shipmentCurrentId: orderDetailController
                                              .orderResponse
                                              .value
                                              .partnerShipperId ??
                                          -1,
                                      onTap: (Shipment itemFee) {
                                        orderDetailController.updateOrder(
                                            partnerShipperId: itemFee
                                                .shipperConfig?.partnerId!);
                                        // orderDetailController.updateOrder(
                                        //     totalShippingFee: itemFee.fee ?? 0);
                                        Get.back();
                                      });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 25,
                                        child: Icon(
                                          Icons.local_shipping_rounded,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Đơn vị vận chuyển: ${orderDetailController.orderResponse.value.shipperName ?? "Chưa chọn đơn vị vận chuyển"}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: orderDetailController
                                                              .orderResponse
                                                              .value
                                                              .partnerShipperId ==
                                                          null
                                                      ? Colors.red
                                                      : null),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                PopupKeyboard()
                                                    .showDialogInputKeyboard(
                                                  numberInput:
                                                      "${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.totalShippingFee ?? 0)}",
                                                  title: "Phí giao hàng",
                                                  confirm: (number) {
                                                    orderDetailController
                                                        .updateOrder(
                                                            totalShippingFee:
                                                                number);
                                                  },
                                                );
                                              },
                                              child: Text(
                                                "Phí giao hàng: ${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.totalShippingFee ?? 0)}₫",
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Icon(Icons.keyboard_arrow_down_rounded)
                                    ],
                                  ),
                                ),
                              ),
                            Divider(
                              height: 1,
                            ),
                            InkWell(
                              onTap: () {
                                expanded.value = !expanded.value;
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      "Cập nhật thông tin kiện hàng",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    )),
                                    Obx(() => Icon(!expanded.value
                                        ? Icons.navigate_next
                                        : Icons.keyboard_arrow_down_rounded))
                                  ],
                                ),
                              ),
                            ),
                            Obx(
                              () => expanded.value
                                  ? Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.all_inbox_rounded,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller:
                                                            orderDetailController
                                                                .weightEdit,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          ThousandsFormatter()
                                                        ],
                                                        decoration: InputDecoration(
                                                            isDense: true,
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Nhập cân nặng",
                                                            suffixText: "g"),
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                        minLines: 1,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.height,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller:
                                                            orderDetailController
                                                                .heightEdit,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          ThousandsFormatter()
                                                        ],
                                                        decoration: InputDecoration(
                                                            isDense: true,
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Nhập chiều cao",
                                                            suffixText: "cm"),
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                        minLines: 1,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    RotatedBox(
                                                      quarterTurns: 1,
                                                      child: Icon(
                                                        Icons.height,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller:
                                                            orderDetailController
                                                                .lengthEdit,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          ThousandsFormatter()
                                                        ],
                                                        decoration: InputDecoration(
                                                            isDense: true,
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Nhập chiều dài",
                                                            suffixText: "cm"),
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                        minLines: 1,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.width_wide_outlined,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller:
                                                            orderDetailController
                                                                .widthEdit,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          ThousandsFormatter()
                                                        ],
                                                        decoration: InputDecoration(
                                                            isDense: true,
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Nhập chiều rộng",
                                                            suffixText: "cm"),
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                        minLines: 1,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.money,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller:
                                                            orderDetailController
                                                                .cod,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        inputFormatters: [
                                                          ThousandsFormatter()
                                                        ],
                                                        decoration: InputDecoration(
                                                            isDense: true,
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                "Nhập tiền thu hộ",
                                                            suffixText: "đ"),
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                        minLines: 1,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            orderDetailController
                                                .updatePackage();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            margin: EdgeInsets.only(
                                                left: 30,
                                                right: 30,
                                                bottom: 10),
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.blue),
                                            child: Center(
                                              child: Text(
                                                'Cập nhật',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : Container(),
                            ),
                            Divider(
                              height: 1,
                            ),
                            if (orderDetailController
                                .listHistoryShipper.isEmpty)
                              orderDetailController
                                          .orderResponse.value.sentDelivery ==
                                      false
                                  ? InkWell(
                                      onTap: () {
                                        if (sahaDataController
                                                .badgeUser.value.isStaff ==
                                            true) {
                                          if (sahaDataController
                                                  .branchCurrent.value.id ==
                                              orderDetailController
                                                  .orderResponse
                                                  .value
                                                  .branch
                                                  ?.id) {
                                            if (orderDetailController
                                                    .orderResponse
                                                    .value
                                                    .shipperName ==
                                                null) {
                                              SahaAlert.showToastMiddle(
                                                  message:
                                                      "Chưa chọn đơn vị vận chuyển");
                                            } else {
                                              SahaDialogApp.showDialogYesNo(
                                                  mess:
                                                      "Đơn hàng sẽ được gửi tới đơn vị vận chuyển",
                                                  onOK: () {
                                                    orderDetailController
                                                        .sendOrderToShipper();
                                                  });
                                            }
                                          } else {
                                            SahaAlert.showToastMiddle(
                                                message:
                                                    "Bạn không có quyền của CN ${orderDetailController.orderResponse.value.branch?.name ?? ""}");
                                          }
                                        } else {
                                          if (orderDetailController
                                                  .orderResponse
                                                  .value
                                                  .shipperName ==
                                              null) {
                                            SahaAlert.showToastMiddle(
                                                message:
                                                    "Chưa chọn đơn vị vận chuyển");
                                          } else {
                                            SahaDialogApp.showDialogYesNo(
                                                mess:
                                                    "Đơn hàng sẽ được gửi tới đơn vị vận chuyển",
                                                onOK: () {
                                                  orderDetailController
                                                      .sendOrderToShipper();
                                                });
                                          }
                                        }
                                      },
                                      child: Container(
                                          padding: EdgeInsets.all(10),
                                          margin: EdgeInsets.only(
                                              top: 10, left: 10, right: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.green
                                                  .withOpacity(0.1)),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.send_rounded,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Đăng đơn hàng",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "chuyển đơn hàng sang đơn vị vận chuyển",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          )),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 9.0),
                                      child: Text(
                                        "Trạng thái giao vận",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  if (orderDetailController
                                      .listHistoryShipper.isNotEmpty)
                                    ...List.generate(
                                      orderDetailController
                                          .listHistoryShipper.length,
                                      (index) => Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: Get.width * 0.6,
                                                child: Text(
                                                  "${orderDetailController.listHistoryShipper[index].statusText}",
                                                  style: TextStyle(
                                                      color: Colors.grey[600]),
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                "${SahaDateUtils().getDDMMYY(orderDetailController.listHistoryShipper[index].time ?? DateTime.now())} ${SahaDateUtils().getHHMM(orderDetailController.listHistoryShipper[index].time ?? DateTime.now())}",
                                                style: TextStyle(
                                                    color: Colors.grey[600]),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  Divider(
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.all(6),
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F6F9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Địa chỉ nhận hàng của khách:",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Container(
                                width: Get.width * 0.7,
                                child: Text(
                                  "${orderDetailController.orderResponse.value.customerAddress?.name ?? "Chưa có tên"}  | ${orderDetailController.orderResponse.value.customerAddress?.phone ?? "Chưa có số điện thoại"}",
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.7,
                                child: Text(
                                  "${orderDetailController.orderResponse.value.customerAddress?.addressDetail ?? "Chưa có địa chỉ chi tiết"}",
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.7,
                                child: Text(
                                  "${orderDetailController.orderResponse.value.customerAddress?.wardsName ?? "Chưa có Phường/Xã"}, ${orderDetailController.orderResponse.value.customerAddress?.districtName ?? "Chưa có Quận/Huyện"}, ${orderDetailController.orderResponse.value.customerAddress?.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 13),
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 8,
                      color: Colors.grey[200],
                    ),
                    if (orderDetailController
                                .orderResponse.value.customerNote !=
                            null &&
                        orderDetailController
                                .orderResponse.value.orderCodeRefund ==
                            null)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Lời nhắn: ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Text(
                                  "${orderDetailController.orderResponse.value.customerNote ?? ""}"),
                            )
                          ],
                        ),
                      ),
                    if (orderDetailController
                            .orderResponse.value.customerNote !=
                        null)
                      Divider(
                        height: 1,
                      ),
                    Column(
                      children: [
                        ...List.generate(
                          (orderDetailController
                                      .orderResponse.value.lineItemsAtTime ??
                                  [])
                              .length,
                          (index) => Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey[200]!)),
                                        child: CachedNetworkImage(
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                          imageUrl: (orderDetailController
                                                              .inputOrder
                                                              ?.lineItemsAtTime ??
                                                          [])
                                                      .length ==
                                                  0
                                              ? ""
                                              : "${orderDetailController.orderResponse.value.lineItemsAtTime![index].imageUrl}",
                                          errorWidget: (context, url, error) =>
                                              SahaEmptyImage(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${orderDetailController.orderResponse.value.lineItemsAtTime![index].name}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          if (orderDetailController
                                                      .orderResponse
                                                      .value
                                                      .lineItemsAtTime![index]
                                                      .distributesSelected !=
                                                  null &&
                                              orderDetailController
                                                  .orderResponse
                                                  .value
                                                  .lineItemsAtTime![index]
                                                  .distributesSelected!
                                                  .isNotEmpty)
                                            Text(
                                              'Phân loại: ${orderDetailController.orderResponse.value.lineItemsAtTime![index].distributesSelected![0].value ?? ""} ${orderDetailController.orderResponse.value.lineItemsAtTime![index].distributesSelected![0].subElement ?? ""}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12),
                                            ),
                                          if (((orderDetailController
                                                                  .orderResponse
                                                                  .value
                                                                  .lineItemsAtTime ??
                                                              [])[index]
                                                          .totalRefund ??
                                                      0) >
                                                  0 &&
                                              orderDetailController
                                                      .orderResponse
                                                      .value
                                                      .orderStatusCode !=
                                                  CUSTOMER_HAS_RETURNS)
                                            Text(
                                              ",  ",
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12),
                                            ),
                                          if (((orderDetailController
                                                                  .orderResponse
                                                                  .value
                                                                  .lineItemsAtTime ??
                                                              [])[index]
                                                          .totalRefund ??
                                                      0) >
                                                  0 &&
                                              orderDetailController
                                                      .orderResponse
                                                      .value
                                                      .orderStatusCode !=
                                                  CUSTOMER_HAS_RETURNS)
                                            Text(
                                              "Đã hoàn tiền SL: ${((orderDetailController.orderResponse.value.lineItemsAtTime ?? [])[index].totalRefund ?? 0)}",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12),
                                            ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Spacer(),
                                                  Text(
                                                    " x ${(orderDetailController.orderResponse.value.lineItemsAtTime ?? [])[index].quantity}",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Colors.grey[600]),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Spacer(),
                                                  if (orderDetailController
                                                          .orderResponse
                                                          .value
                                                          .lineItemsAtTime![
                                                              index]
                                                          .beforePrice !=
                                                      orderDetailController
                                                          .orderResponse
                                                          .value
                                                          .lineItemsAtTime![
                                                              index]
                                                          .itemPrice)
                                                    Text(
                                                      "đ${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.lineItemsAtTime![index].beforePrice ?? 0)}",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color:
                                                              Colors.grey[600]),
                                                    ),
                                                  SizedBox(width: 15),
                                                  Text(
                                                    orderDetailController
                                                                .orderResponse
                                                                .value
                                                                .lineItemsAtTime![
                                                                    index]
                                                                .isBonus ==
                                                            true
                                                        ? 'Hàng tặng'
                                                        : "đ${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.lineItemsAtTime![index].itemPrice ?? 0)}",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Tổng tiền hàng: ",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Spacer(),
                              Text(
                                "₫${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.totalBeforeDiscount ?? 0)}",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "Phí vận chuyển: ",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Spacer(),
                              Text(
                                "+ đ${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.totalShippingFee ?? 0)}",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "VAT: ",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Spacer(),
                                  Text(
                                    "+ đ${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.vat ?? 0)}",
                                    style: TextStyle(color: Colors.grey[600]),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                          if ((orderDetailController
                                      .orderResponse.value.shipDiscountAmount ??
                                  0) >
                              0)
                            Row(
                              children: [
                                Text(
                                  "Miễn phí vận chuyển: ",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Spacer(),
                                Text(
                                  "- đ${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.shipDiscountAmount ?? 0)}",
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              ],
                            ),
                          if (orderDetailController
                                  .orderResponse.value.productDiscountAmount !=
                              0)
                            SizedBox(
                              height: 5,
                            ),
                          if (orderDetailController
                                  .orderResponse.value.productDiscountAmount !=
                              0)
                            Row(
                              children: [
                                Text(
                                  "Giảm giá sản phẩm: ",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Spacer(),
                                Text(
                                  "- đ${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.productDiscountAmount ?? 0)}",
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              ],
                            ),
                          if (orderDetailController
                                  .orderResponse.value.comboDiscountAmount !=
                              0)
                            SizedBox(
                              height: 5,
                            ),
                          if (orderDetailController
                                  .orderResponse.value.comboDiscountAmount !=
                              0)
                            Row(
                              children: [
                                Text(
                                  "Giảm giá Combo: ",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Spacer(),
                                Text(
                                  "- đ${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.comboDiscountAmount ?? 0)}",
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              ],
                            ),
                          if (orderDetailController
                                  .orderResponse.value.voucherDiscountAmount !=
                              0)
                            SizedBox(
                              height: 5,
                            ),
                          if (orderDetailController
                                  .orderResponse.value.voucherDiscountAmount !=
                              0)
                            Row(
                              children: [
                                Text(
                                  "Giảm giá Voucher:",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Spacer(),
                                Text(
                                  "- đ${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.voucherDiscountAmount ?? 0)}",
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              ],
                            ),
                          if (!(orderDetailController.orderResponse.value
                                      .bonusPointsAmountUsed ==
                                  0 ||
                              orderDetailController.orderResponse.value
                                      .bonusPointsAmountUsed ==
                                  null))
                            SizedBox(
                              height: 5,
                            ),
                          if (!(orderDetailController.orderResponse.value
                                      .bonusPointsAmountUsed ==
                                  0 ||
                              orderDetailController.orderResponse.value
                                      .bonusPointsAmountUsed ==
                                  null))
                            Row(
                              children: [
                                Text(
                                  "Giảm giá Xu:",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Spacer(),
                                Text(
                                  "- đ${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.bonusPointsAmountUsed)}",
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              ],
                            ),
                          if (!(orderDetailController.orderResponse.value
                                      .balanceCollaboratorUsed ==
                                  0 ||
                              orderDetailController.orderResponse.value
                                      .balanceCollaboratorUsed ==
                                  null))
                            SizedBox(
                              height: 5,
                            ),
                          if (!(orderDetailController.orderResponse.value
                                      .balanceCollaboratorUsed ==
                                  0 ||
                              orderDetailController.orderResponse.value
                                      .balanceCollaboratorUsed ==
                                  null))
                            Row(
                              children: [
                                Text(
                                  "Giảm giá Ví CTV:",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Spacer(),
                                Text(
                                  "- ₫${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.balanceCollaboratorUsed)}",
                                  style: TextStyle(color: Colors.grey[600]),
                                )
                              ],
                            ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text("Thành tiền: "),
                              Spacer(),
                              Text(
                                  "₫${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.totalFinal ?? 0)}")
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text("Đã thanh toán: "),
                              Spacer(),
                              Text(
                                  "₫${SahaStringUtils().convertToMoney((orderDetailController.orderResponse.value.totalFinal ?? 0) - (orderDetailController.orderResponse.value.remainingAmount ?? 0))}")
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text("Còn lại: "),
                              Spacer(),
                              Text(
                                  "₫${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.remainingAmount ?? 0)}")
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          // if ((orderDetailController
                          //             .orderResponse.value.shareAgency ??
                          //         0) >
                          //     0 && orderDetailController.orderResponse.value.isHandledBalanceAgency == true)
                          //   Row(
                          //     children: [
                          //       Text("Hoa hồng đại lý: "),
                          //       Spacer(),
                          //       Text(
                          //           "₫${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.shareAgency ?? 0)}")
                          //     ],
                          //   ),
                          // if ((orderDetailController
                          //             .orderResponse.value.shareAgency ??
                          //         0) >
                          //     0 && orderDetailController.orderResponse.value.isHandledBalanceAgency == true)
                          //   SizedBox(
                          //     height: 5,
                          //   ),
                          // if ((orderDetailController
                          //     .orderResponse.value.shareCollaborator ??
                          //     0) >
                          //     0 && orderDetailController.orderResponse.value.isHandledBalanceCollaborator == true)
                          //   Row(
                          //     children: [
                          //       Text("Hoa hồng cộng tác viên: "),
                          //       Spacer(),
                          //       Text(
                          //           "₫${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.shareCollaborator ?? 0)}")
                          //     ],
                          //   ),
                          // if ((orderDetailController
                          //     .orderResponse.value.shareCollaborator ??
                          //     0) >
                          //     0 && orderDetailController.orderResponse.value.isHandledBalanceCollaborator == true)
                          //   SizedBox(
                          //     height: 5,
                          //   ),
                        ],
                      ),
                    ),
                    if (orderDetailController
                            .orderResponse.value.bonusAgencyHistory !=
                        null)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: CachedNetworkImage(
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                      imageUrl: orderDetailController
                                              .orderResponse
                                              .value
                                              .bonusAgencyHistory
                                              ?.rewardImageUrl ??
                                          "",
                                      placeholder: (context, url) =>
                                          new SahaLoadingWidget(
                                        size: 20,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SahaEmptyImage(),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Quà tặng: ${orderDetailController.orderResponse.value.bonusAgencyHistory?.rewardName ?? " "}",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text("Đạt mức: "),
                                            Spacer(),
                                            Text(
                                                "₫${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.bonusAgencyHistory?.threshold ?? 0)}"),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text("Thưởng: "),
                                            Spacer(),
                                            Text(
                                                "₫${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.bonusAgencyHistory?.rewardValue ?? 0)}"),
                                            SizedBox(
                                              width: 10,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (orderDetailController.orderResponse.value
                                    .bonusAgencyHistory?.rewardDescription !=
                                null)
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, bottom: 10),
                                child: Text(
                                  orderDetailController
                                          .orderResponse
                                          .value
                                          .bonusAgencyHistory
                                          ?.rewardDescription ??
                                      "",
                                  maxLines: 4,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                          ],
                        ),
                      ),
                    Container(
                      height: 8,
                      color: Colors.grey[200],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F6F9),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              "assets/icons/money.svg",
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Phương thức thanh toán: "),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                  "${orderDetailController.orderResponse.value.orderFrom == ORDER_FROM_WEB || orderDetailController.orderResponse.value.orderFrom == ORDER_FROM_APP ? (orderDetailController.orderResponse.value.paymentPartnerName ?? "") : (orderDetailController.orderResponse.value.paymentMethodName ?? "")}")
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 8,
                      color: Colors.grey[200],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                Text("Mã đơn hàng"),
                                Spacer(),
                                Text(
                                    "${orderDetailController.orderResponse.value.orderCode}"),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  orderDetailController.orderResponse.value
                                              .orderCodeRefund ==
                                          null
                                      ? "Thời gian đặt hàng"
                                      : "Thời gian trả hàng",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Spacer(),
                                Text(
                                  "${SahaDateUtils().getDDMMYY(orderDetailController.orderResponse.value.createdAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(orderDetailController.orderResponse.value.createdAt ?? DateTime.now())}",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ...List.generate(
                              orderDetailController.listStateOrder.length,
                              (index) => Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.6,
                                        child: Text(
                                          "${orderDetailController.listStateOrder[index].note}",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${SahaDateUtils().getDDMMYY(orderDetailController.listStateOrder[index].createdAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(orderDetailController.listStateOrder[index].createdAt ?? DateTime.now())}",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    DecentralizationWidget(
                      decent: sahaDataController
                              .badgeUser.value.decentralization?.chatList ??
                          false,
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ChatUserScreen(
                                    boxChatCustomerInput: BoxChatCustomer(
                                      customerId: orderDetailController
                                          .orderResponse.value.customerId,
                                      customer: orderDetailController
                                          .orderResponse.value.infoCustomer,
                                    ),
                                  ))!
                              .then((value) => {});
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[500]!)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(4),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5F6F9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.chat,
                                      color: Theme.of(context).primaryColor,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Liên hệ khách hàng")
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 8,
                      color: Colors.grey[200],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Tổng tiền: ",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Obx(
                    () => orderDetailController.isLoadingOrder.value
                        ? Container()
                        : Text(
                            "đ${SahaStringUtils().convertToMoney(orderDetailController.orderResponse.value.totalFinal ?? 0)}",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor),
                          ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Mã đơn hàng",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Obx(
                    () => orderDetailController.isLoadingOrder.value
                        ? Container()
                        : Text(
                            "${orderDetailController.orderResponse.value.orderCode ?? ""}"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String namePayment(int paymentMethod) {
    if (PAYMENT_TYPE_SWIPE == paymentMethod) {
      return "QUẸT THẺ";
    }
    if (PAYMENT_TYPE_CASH == paymentMethod) {
      return "TIỀN MẶT";
    }
    if (PAYMENT_TYPE_COD == paymentMethod) {
      return "COD";
    }
    if (PAYMENT_TYPE_TRANSFER == paymentMethod) {
      return "CHUYỂN KHOẢN";
    }
    return "";
  }
}
