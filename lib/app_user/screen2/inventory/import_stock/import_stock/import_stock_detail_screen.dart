import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_keyboard.dart';
import 'package:com.ikitech.store/app_user/const/const_revenue_expenditure.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/import_stock/add_import_stock/add_import_stock_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/import_stock/pay_import_stock/pay_import_stock_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/import_stock/return_import_stock/return_import_stock_screen.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/suppliers/suppliers_profile/suppliers_profile_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';

import 'import_stock_detail_controller.dart';

class ImportStockDetailScreen extends StatelessWidget {
  int importStockInputId;

  ImportStockDetailScreen({required this.importStockInputId}) {
    importStockDetailController =
        ImportStockDetailController(importStockInputId: importStockInputId);
  }

  late ImportStockDetailController importStockDetailController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            "${importStockDetailController.importStock.value.code ?? ""}")),
      ),
      body: Obx(
        () => importStockDetailController.isLoading.value
            ? SahaLoadingFullScreen()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    importStockDetailController.importStock.value.status !=
                            STATUS_IMPORT_STOCK_REFUND
                        ? processStatus()
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () {
                                if (importStockDetailController.importStock
                                        .value.importStockIdRefund !=
                                    null) {
                                  importStockDetailController
                                          .importStockInputId =
                                      importStockDetailController.importStock
                                          .value.importStockIdRefund!;
                                  importStockDetailController.getImportStock();
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Đơn hoàn trả NCC",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red),
                                  ),
                                  if (importStockDetailController.importStock
                                          .value.importStockCodeRefund !=
                                      null)
                                    Text(
                                      "Từ đơn #${importStockDetailController.importStock.value.importStockCodeRefund ?? ""}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red),
                                    ),
                                ],
                              ),
                            ),
                          ),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      width: Get.width,
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${SahaStringUtils().convertToMoney(importStockDetailController.importStock.value.totalFinal ?? 0)}",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Tạo bởi ${importStockDetailController.importStock.value.staff?.name ?? ""}"),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Chi nhánh: ${importStockDetailController.importStock.value.branch?.name ?? ""}"),
                          SizedBox(
                            height: 10,
                          ),
                          if (importStockDetailController
                                  .importStock.value.status !=
                              STATUS_IMPORT_STOCK_REFUND)
                            Text(
                              "- ${importStockDetailController.checkPaymentStatus(importStockDetailController.importStock.value.paymentStatus ?? 0)}",
                              style: TextStyle(
                                color: (importStockDetailController.importStock
                                                .value.paymentStatus ??
                                            0) ==
                                        0
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            )
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    if (importStockDetailController
                            .importStock.value.supplier?.id !=
                        null)
                      InkWell(
                        onTap: () {
                          Get.to(() => SuppliersProfileScreen(
                              supplier: importStockDetailController
                                  .importStock.value.supplier!));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.store,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${importStockDetailController.importStock.value.supplier?.name ?? ""}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  if (importStockDetailController
                                          .importStock.value.supplier?.phone !=
                                      null)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (importStockDetailController
                                          .importStock.value.supplier?.phone !=
                                      null)
                                    Text(
                                      "${importStockDetailController.importStock.value.supplier?.phone ?? ""}",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  if (importStockDetailController.importStock
                                          .value.supplier?.addressDetail !=
                                      null)
                                    Text(
                                      "${importStockDetailController.importStock.value.supplier?.addressDetail ?? ""}",
                                    ),
                                  if (importStockDetailController.importStock
                                          .value.supplier?.wardsName !=
                                      null)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (importStockDetailController.importStock
                                          .value.supplier?.wardsName !=
                                      null)
                                    Text(
                                      "${importStockDetailController.importStock.value.supplier?.wardsName ?? ""} ${importStockDetailController.importStock.value.supplier?.districtName ?? ""} ${importStockDetailController.importStock.value.supplier?.provinceName ?? ""}",
                                    )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    Divider(
                      height: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 1,
                    ),
                    if (importStockDetailController
                            .importStock.value.importStockItems !=
                        null)
                      ...importStockDetailController
                          .importStock.value.importStockItems!
                          .map((e) => importStockItem(e))
                          .toList(),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 1,
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tiền hàng"),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Chiết khấu",
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Chi phí nhập hàng",
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "VAT",
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                              Text(
                                "Tổng tiền",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Thanh toán",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  "${SahaStringUtils().convertToMoney(importStockDetailController.importStock.value.totalAmount ?? 0)}"),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "${SahaStringUtils().convertToMoney(importStockDetailController.importStock.value.discount ?? 0)}"),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                      "${SahaStringUtils().convertToMoney(importStockDetailController.importStock.value.cost ?? 0)}"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                      "${SahaStringUtils().convertToMoney(importStockDetailController.importStock.value.vat ?? 0)}"),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              Text(
                                  "${SahaStringUtils().convertToMoney(importStockDetailController.importStock.value.totalFinal ?? 0)}"),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "${SahaStringUtils().convertToMoney(importStockDetailController.importStock.value.totalPayment ?? 0)}"),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 1,
                    ),
                    if (importStockDetailController.importStock.value.status !=
                        STATUS_IMPORT_STOCK_REFUND)
                      Container(
                        padding: EdgeInsets.all(5),
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.payment,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      "${importStockDetailController.checkPaymentStatus(importStockDetailController.importStock.value.paymentStatus ?? 0)}")
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                            ),
                            if (importStockDetailController
                                    .importStock.value.historyPayImportStock !=
                                null)
                              ...importStockDetailController
                                  .importStock.value.historyPayImportStock!
                                  .map((e) => Container(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    "${e.paymentMethod == 0 ? "Tiền mặt" : "Chuyển khoản"}"),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${SahaDateUtils().getHHMM(e.createdAt ?? DateTime.now())}, ${SahaDateUtils().getDDMMYY(e.createdAt ?? DateTime.now())}",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                            Spacer(),
                                            Text(
                                                "${SahaStringUtils().convertToMoney(e.money ?? 0)}")
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            Divider(
                              height: 1,
                            ),
                            if (importStockDetailController
                                    .importStock.value.remainingAmount !=
                                0)
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Text("Chưa thanh toán"),
                                    Spacer(),
                                    Text(
                                      "${SahaStringUtils().convertToMoney(importStockDetailController.importStock.value.remainingAmount ?? 0)}",
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    if (importStockDetailController.importStock.value.note ==
                            null ||
                        importStockDetailController.importStock.value.note ==
                            "")
                      InkWell(
                        onTap: () {
                          PopupInput().showDialogInputNote(
                              confirm: (v) {
                                importStockDetailController
                                    .importStock.value.note = v;
                                importStockDetailController.updateImportStock();
                              },
                              title: "Ghi chú",
                              textInput:
                                  "${importStockDetailController.importStock.value.note ?? ""}");
                        },
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Thêm ghi chú",
                                style: TextStyle(color: Colors.blue),
                              ),
                              Icon(
                                Icons.assignment_outlined,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ),
                    if (importStockDetailController.importStock.value.note !=
                            null &&
                        importStockDetailController.importStock.value.note !=
                            "")
                      InkWell(
                        onTap: () {
                          PopupInput().showDialogInputNote(
                              confirm: (v) {
                                importStockDetailController
                                    .importStock.value.note = v;
                                importStockDetailController.updateImportStock();
                              },
                              title: "Ghi chú",
                              textInput:
                                  "${importStockDetailController.importStock.value.note ?? ""}");
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Ghi chú",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "${importStockDetailController.importStock.value.note}")
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Obx(() => Container(
            height: 65,
            color: Colors.white,
            child: Column(
              children: [
                if (importStockDetailController.importStock.value.status == 0)
                  Row(
                    children: [
                      Expanded(
                          child: SahaButtonFullParent(
                        text: "Hoàn thành",
                        onPressed: () {
                          importStockDetailController
                              .updateStatusImportStock(3);
                        },
                      )),
                      // Expanded(
                      //   child: SahaButtonFullParent(
                      //     text:
                      //         "${importStockDetailController.getStatus((importStockDetailController.importStock.value.status ?? 0) + 1)}",
                      //     onPressed: importStockDetailController.isReturnAllItem()
                      //         ? null
                      //         : () {
                      //             if (importStockDetailController
                      //                     .importStock.value.status ==
                      //                 2) {
                      //               Get.to(() => PayImportStockScreen(
                      //                         payMustInput:
                      //                             importStockDetailController
                      //                                     .importStock
                      //                                     .value
                      //                                     .remainingAmount ??
                      //                                 0,
                      //                         importStock:
                      //                             importStockDetailController
                      //                                 .importStock.value,
                      //                       ))!
                      //                   .then((value) => {
                      //                         if (value == "reload")
                      //                           {
                      //                             importStockDetailController
                      //                                 .getImportStock()
                      //                           }
                      //                       });
                      //             } else {
                      //               importStockDetailController
                      //                   .updateStatusImportStock(
                      //                       (importStockDetailController
                      //                                   .importStock
                      //                                   .value
                      //                                   .status ??
                      //                               0) +
                      //                           1);
                      //             }
                      //           },
                      //     color: Theme.of(context).primaryColor,
                      //   ),
                      // ),
                      // if (!importStockDetailController.isReturnAllItem())
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0)),
                              ),
                              builder: (context) {
                                return
                                    // (importStockDetailController
                                    //                 .importStock.value.status ??
                                    //             0) ==
                                    //         2
                                    //     ? Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.start,
                                    //         mainAxisSize: MainAxisSize.min,
                                    //         children: <Widget>[
                                    //           ListTile(
                                    //             leading: Icon(
                                    //                 Icons.settings_backup_restore),
                                    //             title: Text('Hoàn trả nhà cung cấp'),
                                    //             onTap: () {
                                    //               Get.back();
                                    //               Get.to(() =>
                                    //                       ReturnImportStockScreen(
                                    //                         importStockInput:
                                    //                             importStockDetailController
                                    //                                 .importStock
                                    //                                 .value,
                                    //                       ))!
                                    //                   .then((value) => {
                                    //                         importStockDetailController
                                    //                             .getImportStock()
                                    //                       });
                                    //             },
                                    //           ),
                                    //           ListTile(
                                    //             leading: Container(
                                    //                 decoration: BoxDecoration(
                                    //                   border: Border.all(
                                    //                       color: Colors.grey,
                                    //                       width: 2),
                                    //                   shape: BoxShape.circle,
                                    //                 ),
                                    //                 child: Icon(
                                    //                   Icons.stop,
                                    //                   size: 20,
                                    //                 )),
                                    //             title: Text('Kết thúc đơn nhập'),
                                    //             onTap: () {
                                    //               Get.back();
                                    //               SahaDialogApp.showDialogYesNo(
                                    //                   mess:
                                    //                       "Đơn nhập ở trạng thái kết thúc sẽ không thể nhập kho hoặc thanh toán. Bạn có chắc chắn muốn kết thúc đơn nhập hàng này không ?",
                                    //                   onOK: () {
                                    //                     importStockDetailController
                                    //                         .updateStatusImportStock(
                                    //                             5);
                                    //                   });
                                    //             },
                                    //           ),
                                    //           SizedBox(
                                    //             height: 20,
                                    //           ),
                                    //         ],
                                    //       )
                                    //     :
                                    Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.edit),
                                      title: Text('Sửa đơn nhập'),
                                      onTap: () {
                                        Get.back();
                                        Get.to(() => AddImportStockScreen(
                                                  importStockInput:
                                                      importStockDetailController
                                                          .importStock.value,
                                                ))!
                                            .then((value) => {
                                                  if (value == "reload")
                                                    {
                                                      importStockDetailController
                                                          .getImportStock(),
                                                    }
                                                });
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text('Huỷ đơn nhập'),
                                      onTap: () {
                                        Get.back();
                                        SahaDialogApp.showDialogYesNo(
                                            mess:
                                                "Bạn có chắc muốn huỷ đơn nhập này chứ?",
                                            onOK: () {
                                              importStockDetailController
                                                  .updateStatusImportStock(4);
                                            });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(Icons.more_vert_rounded),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                if (importStockDetailController.importStock.value.status == 3)
                  Row(
                    children: [
                      Expanded(
                          child: SahaButtonFullParent(
                        text: "Sửa đơn nhập",
                        onPressed: () {
                          Get.to(() => AddImportStockScreen(
                                    importStockInput:
                                        importStockDetailController
                                            .importStock.value,
                                  ))!
                              .then((value) => {
                                    if (value == "reload")
                                      {
                                        importStockDetailController
                                            .getImportStock(),
                                      }
                                  });
                        },
                      )),
                      Expanded(
                          child: SahaButtonFullParent(
                        text: "Huỷ đơn nhập",
                        onPressed: () {
                          Get.to(() => ReturnImportStockScreen(
                                    importStockInput:
                                        importStockDetailController
                                            .importStock.value,
                                  ))!
                              .then((value) => {
                                    importStockDetailController.getImportStock()
                                  });
                        },
                      )),
                    ],
                  )
              ],
            ),
          )),
    );
  }

  Widget importStockItem(ImportStockItem importStockItem) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: CachedNetworkImage(
                        height: 55,
                        width: 55,
                        fit: BoxFit.cover,
                        imageUrl: importStockItem.product?.images != null &&
                                importStockItem.product!.images!.isNotEmpty
                            ? importStockItem.product!.images![0].imageUrl!
                            : "",
                        placeholder: (context, url) => SahaLoadingWidget(),
                        errorWidget: (context, url, error) => Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: -3,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.blue, width: 1.5)),
                      child: Center(
                        child: Text(
                          "${importStockItem.quantity ?? 0}",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${importStockItem.product?.name ?? ""}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          if (importStockItem.elementDistributeName != null)
                            Text(
                                "Phân loại: ${importStockItem.elementDistributeName ?? ""}${importStockItem.subElementDistributeName == null ? "" : ","} ${importStockItem.subElementDistributeName == null ? "" : importStockItem.subElementDistributeName}"),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${SahaStringUtils().convertToMoney(importStockItem.importPrice ?? 0)}₫",
                            style: TextStyle(fontSize: 12),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          if (importStockDetailController
                                  .importStock.value.status !=
                              STATUS_IMPORT_STOCK_REFUND)
                            Text(
                              "Đã hoàn ${importStockItem.totalRefund == importStockItem.quantity ? "toàn bộ sp" : ": ${SahaStringUtils().convertToMoney(importStockItem.totalRefund ?? 0)} sp"}",
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Text(
                        "${SahaStringUtils().convertToMoney((importStockItem.importPrice ?? 0) * (importStockItem.quantity ?? 0))}₫")
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }

  Widget processStatus() {
    return Obx(
      () => Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Đặt hàng"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2.5,
                          color: Colors.transparent,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color:
                              importStockDetailController.checkStatus(0) != null
                                  ? Colors.blue
                                  : Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2.5,
                          color:
                              importStockDetailController.checkStatus(3) != null
                                  ? Colors.blue
                                  : Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${importStockDetailController.checkStatus(0) != null ? SahaDateUtils().getHHMM(importStockDetailController.checkStatus(0)?.timeHandle ?? DateTime.now()) : ""}",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "${importStockDetailController.checkStatus(0) != null ? SahaDateUtils().getDDMMYY(importStockDetailController.checkStatus(0)?.timeHandle ?? DateTime.now()) : ""}",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Text("Duyệt"),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Row(
            //         children: [
            //           Expanded(
            //             child: Container(
            //               height: 2.5,
            //               color:
            //                   importStockDetailController.checkStatus(1) != null
            //                       ? Colors.blue
            //                       : Colors.grey[300],
            //             ),
            //           ),
            //           Container(
            //             padding: EdgeInsets.all(1),
            //             decoration: BoxDecoration(
            //               color:
            //                   importStockDetailController.checkStatus(1) != null
            //                       ? Colors.blue
            //                       : Colors.grey[300],
            //               shape: BoxShape.circle,
            //             ),
            //             child: Icon(
            //               Icons.check,
            //               size: 12,
            //               color: Colors.white,
            //             ),
            //           ),
            //           Expanded(
            //             child: Container(
            //               height: 2.5,
            //               color:
            //                   importStockDetailController.checkStatus(2) != null
            //                       ? Colors.blue
            //                       : Colors.grey[300],
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Text(
            //         "${importStockDetailController.checkStatus(1) != null ? SahaDateUtils().getHHMM(importStockDetailController.checkStatus(1)?.timeHandle ?? DateTime.now()) : ""}",
            //         style: TextStyle(fontSize: 12),
            //       ),
            //       Text(
            //         "${importStockDetailController.checkStatus(1) != null ? SahaDateUtils().getDDMMYY(importStockDetailController.checkStatus(1)?.timeHandle ?? DateTime.now()) : ""}",
            //         style: TextStyle(fontSize: 12),
            //       ),
            //     ],
            //   ),
            // ),
            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Text("Nhập kho"),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Row(
            //         children: [
            //           Expanded(
            //             child: Container(
            //               height: 2.5,
            //               color:
            //                   importStockDetailController.checkStatus(2) != null
            //                       ? Colors.blue
            //                       : Colors.grey[300],
            //             ),
            //           ),
            //           Container(
            //             padding: EdgeInsets.all(1),
            //             decoration: BoxDecoration(
            //               color:
            //                   importStockDetailController.checkStatus(2) != null
            //                       ? Colors.blue
            //                       : Colors.grey[300],
            //               shape: BoxShape.circle,
            //             ),
            //             child: Icon(
            //               Icons.check,
            //               size: 12,
            //               color: Colors.white,
            //             ),
            //           ),
            //           Expanded(
            //             child: Container(
            //               height: 2.5,
            //               color: importStockDetailController.checkStatus(5) !=
            //                       null
            //                   ? Colors.grey[300]
            //                   : importStockDetailController.checkStatus(4) !=
            //                           null
            //                       ? Colors.grey[300]
            //                       : importStockDetailController
            //                                   .checkStatus(3) !=
            //                               null
            //                           ? Colors.blue
            //                           : Colors.grey[300],
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Text(
            //         "${importStockDetailController.checkStatus(2) != null ? SahaDateUtils().getHHMM(importStockDetailController.checkStatus(2)?.timeHandle ?? DateTime.now()) : ""}",
            //         style: TextStyle(fontSize: 12),
            //       ),
            //       Text(
            //         "${importStockDetailController.checkStatus(2) != null ? SahaDateUtils().getDDMMYY(importStockDetailController.checkStatus(2)?.timeHandle ?? DateTime.now()) : ""}",
            //         style: TextStyle(fontSize: 12),
            //       ),
            //     ],
            //   ),
            // ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "${importStockDetailController.checkStatus(5) != null ? "Kết thúc" : importStockDetailController.checkStatus(4) != null ? "Huỷ" : importStockDetailController.checkStatus(3) != null ? "Hoàn thành" : "Hoàn thành"}"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2.5,
                          color: importStockDetailController.checkStatus(5) !=
                                  null
                              ? Colors.grey[300]
                              : importStockDetailController.checkStatus(4) !=
                                      null
                                  ? Colors.grey[300]
                                  : importStockDetailController
                                              .checkStatus(3) !=
                                          null
                                      ? Colors.blue
                                      : Colors.grey[300],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: importStockDetailController.checkStatus(5) !=
                                  null
                              ? Colors.red
                              : importStockDetailController.checkStatus(4) !=
                                      null
                                  ? Colors.red
                                  : importStockDetailController
                                              .checkStatus(3) !=
                                          null
                                      ? Colors.blue
                                      : Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2.5,
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${importStockDetailController.checkStatus(5) != null ? SahaDateUtils().getHHMM(importStockDetailController.checkStatus(5)?.timeHandle ?? DateTime.now()) : importStockDetailController.checkStatus(4) != null ? SahaDateUtils().getHHMM(importStockDetailController.checkStatus(4)?.timeHandle ?? DateTime.now()) : importStockDetailController.checkStatus(3) != null ? SahaDateUtils().getHHMM(importStockDetailController.checkStatus(3)?.timeHandle ?? DateTime.now()) : ""}",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "${importStockDetailController.checkStatus(5) != null ? SahaDateUtils().getDDMMYY(importStockDetailController.checkStatus(5)?.timeHandle ?? DateTime.now()) : importStockDetailController.checkStatus(4) != null ? SahaDateUtils().getDDMMYY(importStockDetailController.checkStatus(4)?.timeHandle ?? DateTime.now()) : importStockDetailController.checkStatus(3) != null ? SahaDateUtils().getDDMMYY(importStockDetailController.checkStatus(3)?.timeHandle ?? DateTime.now()) : ""}",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
