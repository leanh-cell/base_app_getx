import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/tally_sheet_request.dart';
import 'package:com.ikitech.store/app_user/model/tally_sheet.dart';
import 'package:com.ikitech.store/app_user/screen2/inventory/check_inventory/add_check_inventory/add_check_inventory_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';

import '../../../../components/saha_user/loading/loading_full_screen.dart';
import 'tally_sheet_controller.dart';

class TallySheetScreen extends StatelessWidget {
  int tallySheetInputId;

  TallySheetScreen({required this.tallySheetInputId}) {
    tallySheetController =
        TallySheetController(tallySheetInputId: tallySheetInputId);
  }

  late TallySheetController tallySheetController;

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
                  if (tallySheetController.isBalance == true) {
                    Get.back(result: "reload");
                  } else {
                    Get.back();
                  }
                },
                child: Icon(Icons.arrow_back_ios)),
            SizedBox(
              width: 30,
            ),
            Obx(() =>
                Text("${tallySheetController.tallySheet.value.code ?? ""}")),
          ],
        ),
      ),
      body: Obx(
        () => tallySheetController.isLoading.value
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
                              "Tạo ngày ${SahaDateUtils().getDDMMYY(tallySheetController.tallySheet.value.createdAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(tallySheetController.tallySheet.value.createdAt ?? DateTime.now())}"),
                          SizedBox(
                            height: 8,
                          ),
                          if (tallySheetController
                                  .tallySheet.value.profileUser?.name !=
                              null)
                            Text(
                                "Tạo bởi ${tallySheetController.tallySheet.value.profileUser?.name ?? ""}"),
                          if (tallySheetController
                                  .tallySheet.value.staff?.name !=
                              null)
                            Text(
                                "Tạo bởi nhân viên ${tallySheetController.tallySheet.value.staff?.name ?? ""}"),
                          if (tallySheetController.tallySheet.value.status != 0)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    "Cân bằng kho ngày ${SahaDateUtils().getDDMMYY(tallySheetController.tallySheet.value.updatedAt ?? DateTime.now())} ${SahaDateUtils().getHHMM(tallySheetController.tallySheet.value.updatedAt ?? DateTime.now())}"),
                                Text(
                                  "${tallySheetController.tallySheet.value.deviant ?? 0}",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              "Chinh nhánh ${tallySheetController.tallySheet.value.branch?.name ?? "Trống"}"),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                  "Trạng thái: ${tallySheetController.tallySheet.value.status == 0 ? "Đã kiểm kho" : "Đã cân bằng"} "),
                              InkWell(
                                onTap: () {
                                  SahaDialogApp.showDialogSuggestion(
                                      title: 'Tồn kho',
                                      contentWidget: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "1. Đã kiểm kho\n",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                              '- Là trạng thái đã tạo đơn kiểm kho, có số lượng chênh lệch giữa tồn kho thực tế và tồn kho trên hệ thống.\n'),
                                          Text(
                                            "2. Đã cân bằng\n",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                              '- Là trạng thái đã đồng bộ số lượng tồn thực tế và số lượng tồn trên hệ thống.')
                                        ],
                                      ));
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Colors.blue,
                                      size: 20,
                                    ),
                                    Text(
                                      'i',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (tallySheetController
                            .tallySheet.value.listTallySheetItem !=
                        null)
                      ...tallySheetController
                          .tallySheet.value.listTallySheetItem!
                          .map((e) => tallySheetItem(e))
                          .toList(),
                    SizedBox(
                      height: 15,
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
                              Text("SL tồn thực tế"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("SL tồn chi nhánh"),
                              SizedBox(
                                height: 8,
                              ),
                              Text("SL chênh lệch")
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: [
                              Text(
                                  "${tallySheetController.tallySheet.value.realityExist ?? 0}"),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                  "${tallySheetController.tallySheet.value.existingBranch ?? 0}"),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "${tallySheetController.tallySheet.value.deviant ?? 0}",
                                style: TextStyle(
                                  color: (tallySheetController
                                                  .tallySheet.value.deviant ??
                                              0) <
                                          0
                                      ? Colors.red
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    if (tallySheetController.tallySheet.value.note == null ||
                        tallySheetController.tallySheet.value.note == "")
                      InkWell(
                        onTap: () {
                          PopupInput().showDialogInputNote(
                              confirm: (v) {
                                tallySheetController.tallySheet.value.note = v;
                                tallySheetController.updateTallySheet();
                              },
                              title: "Ghi chú",
                              textInput:
                                  "${tallySheetController.tallySheet.value.note ?? ""}");
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
                    if (tallySheetController.tallySheet.value.note != null &&
                        tallySheetController.tallySheet.value.note != "")
                      InkWell(
                        onTap: () {
                          PopupInput().showDialogInputNote(
                              confirm: (v) {
                                tallySheetController.tallySheet.value.note = v;
                                tallySheetController.updateTallySheet();
                              },
                              title: "Ghi chú",
                              textInput:
                                  "${tallySheetController.tallySheet.value.note ?? ""}");
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
                                  "${tallySheetController.tallySheet.value.note}")
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Obx(
        () => tallySheetController.tallySheet.value.status == 0
            ? Container(
                height: 65,
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SahaButtonFullParent(
                            text: "Cân bằng kho",
                            onPressed: () {
                              tallySheetController.balanceTallySheet();
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
                                        leading: Icon(Icons.edit),
                                        title: Text('Sửa phiếu kiểm hàng'),
                                        onTap: () {
                                          Get.back();
                                          Get.to(() => AddCheckInventoryScreen(
                                                    tallySheetInput:
                                                        tallySheetController
                                                            .tallySheet.value,
                                                  ))!
                                              .then((value) => {
                                                    if (value == "reload")
                                                      {
                                                        tallySheetController
                                                            .getTallySheet(),
                                                      }
                                                  });
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.delete),
                                        title: Text('Xoá phiếu kiểm hàng'),
                                        onTap: () {
                                          Get.back();
                                          SahaDialogApp.showDialogYesNo(
                                              mess:
                                                  "Bạn có chắc muốn xoá phiếu kiểm hàng này chứ?",
                                              onOK: () {
                                                tallySheetController
                                                    .deleteTallySheet();
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

  Widget tallySheetItem(TallySheetItem tallySheetItem) {
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
                        fit: BoxFit.fill,
                        imageUrl: tallySheetItem.product?.images != null &&
                                tallySheetItem.product!.images!.isNotEmpty
                            ? tallySheetItem.product!.images![0].imageUrl!
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
                          "${tallySheetItem.realityExist ?? 0}",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${tallySheetItem.product?.name ?? ""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (tallySheetItem.elementDistributeName != null)
                      Text(
                          "Phân loại: ${tallySheetItem.elementDistributeName ?? ""}${tallySheetItem.subElementDistributeName == null ? "" : ","} ${tallySheetItem.subElementDistributeName == null ? "" : tallySheetItem.subElementDistributeName}"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Tồn chi nhánh: ",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "${tallySheetItem.existingBranch ?? 0}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                            )
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              "Chênh lệch: ",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "${tallySheetItem.deviant ?? 0}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: (tallySheetItem.deviant ?? 0) < 0
                                    ? Colors.red
                                    : null,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                      ],
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
