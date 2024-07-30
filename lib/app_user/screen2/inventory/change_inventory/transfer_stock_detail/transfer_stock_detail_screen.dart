import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';

import '../../../../model/transfer_stock_item.dart';
import '../add_transfer_stock/add_transfer_stock_screen.dart';
import 'transfer_stock_detail_controller.dart';

class TransferStockDetailScreen extends StatelessWidget {
  int transferStockId;
  bool isSender;

  TransferStockDetailScreen(
      {required this.transferStockId, required this.isSender}) {
    transferStockController =
        TransferStockDetailController(transferStockId: transferStockId);
  }

  late TransferStockDetailController transferStockController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
                onTap: () {
                  Get.back(result: "reload");
                },
                child: Icon(Icons.arrow_back_ios)),
            SizedBox(
              width: 30,
            ),
            Obx(() => Text(
                "${transferStockController.transferStock.value.code ?? ""}")),
          ],
        ),
      ),
      body: Obx(
        () => transferStockController.isLoading.value
            ? SahaLoadingFullScreen()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      width: Get.width,
                      padding: EdgeInsets.only(
                          top: 15, left: 10, right: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Tạo ngày ${SahaDateUtils().getDDMMYY(transferStockController.transferStock.value.createdAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(transferStockController.transferStock.value.createdAt ?? DateTime.now())}"),
                          SizedBox(
                            height: 8,
                          ),
                          if (transferStockController
                                  .transferStock.value.profileUser?.name !=
                              null)
                            Text(
                                "Tạo bởi ${transferStockController.transferStock.value.profileUser?.name ?? ""}"),
                          if (transferStockController
                                  .transferStock.value.staff?.name !=
                              null)
                            Text(
                                "Tạo bởi nhân viên ${transferStockController.transferStock.value.staff?.name ?? ""}"),
                          if (transferStockController
                                  .transferStock.value.status ==
                              2)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    "Đã nhận hàng ngày: ${SahaDateUtils().getDDMMYY(transferStockController.transferStock.value.updatedAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(transferStockController.transferStock.value.updatedAt ?? DateTime.now())}"),
                              ],
                            ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                "${transferStockController.transferStock.value.fromBranch?.name ?? ""}",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 12,
                                color: Colors.blue,
                              ),
                              Text(
                                "${transferStockController.transferStock.value.toBranch?.name ?? ""}",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              "Trạng thái: ${transferStockController.transferStock.value.status == 0 ? "Chờ nhận hàng" : transferStockController.transferStock.value.status == 1 ? "Đã huỷ" : "Đã nhận"}"),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (transferStockController
                            .transferStock.value.transferStockItems !=
                        null)
                      ...transferStockController
                          .transferStock.value.transferStockItems!
                          .map((e) => transferStockItem(e))
                          .toList(),
                    SizedBox(
                      height: 15,
                    ),
                    if (transferStockController.transferStock.value.note ==
                            null ||
                        transferStockController.transferStock.value.note == "")
                      InkWell(
                        onTap: () {
                          PopupInput().showDialogInputNote(
                              confirm: (v) {
                                transferStockController
                                    .transferStock.value.note = v;
                                transferStockController.updateTransferStock();
                              },
                              title: "Ghi chú",
                              textInput:
                                  "${transferStockController.transferStock.value.note ?? ""}");
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
                    if (transferStockController.transferStock.value.note !=
                            null &&
                        transferStockController.transferStock.value.note != "")
                      InkWell(
                        onTap: () {
                          PopupInput().showDialogInputNote(
                              confirm: (v) {
                                transferStockController
                                    .transferStock.value.note = v;
                                transferStockController.updateTransferStock();
                              },
                              title: "Ghi chú",
                              textInput:
                                  "${transferStockController.transferStock.value.note ?? ""}");
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
                                  "${transferStockController.transferStock.value.note}")
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Obx(
        () => transferStockController.transferStock.value.status == 0 &&
                isSender
            ? Container(
                height: 65,
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SahaButtonFullParent(
                            text: "Sửa phiếu chuyển kho",
                            onPressed: () {
                              Get.to(() => AddTransferStockScreen(
                                        transferStockInput:
                                            transferStockController
                                                .transferStock.value,
                                      ))!
                                  .then((value) => {
                                        transferStockController
                                            .getTransferStock()
                                      });
                            },
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
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
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.delete),
                                        title: Text('Huỷ phiếu chuyển kho'),
                                        onTap: () {
                                          Get.back();
                                          SahaDialogApp.showDialogYesNo(
                                              mess:
                                                  "Bạn có chắc muốn huỷ phiếu chuyển kho này chứ?",
                                              onOK: () {
                                                transferStockController
                                                    .changeStatusTransferStock(
                                                        1);
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
                  ],
                ),
              )
            : transferStockController.transferStock.value.status == 0 &&
                    isSender == false
                ? Container(
                    height: 65,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SahaButtonFullParent(
                                text: "Đã nhận hàng",
                                onPressed: () {
                                  transferStockController
                                      .changeStatusTransferStock(2);
                                },
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
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
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: Icon(Icons.delete),
                                            title: Text('Huỷ phiếu chuyển kho'),
                                            onTap: () {
                                              Get.back();
                                              SahaDialogApp.showDialogYesNo(
                                                  mess:
                                                      "Bạn có chắc muốn huỷ phiếu chuyển kho này chứ?",
                                                  onOK: () {
                                                    transferStockController
                                                        .changeStatusTransferStock(
                                                            1);
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
                      ],
                    ),
                  )
                : Container(
                    height: 1,
                    width: 1,
                  ),
      ),
    );
  }

  Widget transferStockItem(TransferStockItem transferStockItem) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: CachedNetworkImage(
                    height: 55,
                    width: 55,
                    fit: BoxFit.fill,
                    imageUrl: transferStockItem.product?.images != null &&
                            transferStockItem.product!.images!.isNotEmpty
                        ? transferStockItem.product!.images![0].imageUrl!
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
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${transferStockItem.product?.name ?? ""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (transferStockItem.elementDistributeName != null)
                      Text(
                          "Phân loại: ${transferStockItem.elementDistributeName ?? ""}${transferStockItem.subElementDistributeName == null ? "" : ","} ${transferStockItem.subElementDistributeName == null ? "" : transferStockItem.subElementDistributeName}"),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Số lượng: ${SahaStringUtils().convertToMoney(transferStockItem.quantity ?? "0")}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
}
