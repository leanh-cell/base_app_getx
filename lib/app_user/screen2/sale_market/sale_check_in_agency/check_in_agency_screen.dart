import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/saha_user/empty/saha_empty_image.dart';

import '../../../components/saha_user/text_field/text_field_no_border.dart';
import '../../../components/widget/select_image/select_images.dart';
import '../../../model/image_assset.dart';
import '../../../utils/debounce.dart';
import 'check_in_agency_controller.dart';

class CheckInAgencyScreen extends StatefulWidget {
  final int agencyId;
  final bool? isCancel;
  final bool? isWatch;
  final bool? isInPayScreen;
  CheckInAgencyScreen(
      {required this.agencyId,
      this.isCancel,
      this.isInPayScreen,
      this.isWatch});

  @override
  State<CheckInAgencyScreen> createState() => _InfoCustomerScreenState();
}

class _InfoCustomerScreenState extends State<CheckInAgencyScreen> {
  late final CheckInAgencyController controller;

  @override
  void initState() {
    controller = CheckInAgencyController(agencyId: widget.agencyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thông tin"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => controller.loadInit.value
                ? SahaLoadingFullScreen()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          width: Get.width,
                          decoration: BoxDecoration(color: Colors.green[300]),
                          child: Text(
                            "Thời gian viếng thăm: ${controller.timeVisit.value.inHours}:${(controller.timeVisit.value.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.timeVisit.value.inSeconds % 60).toString().padLeft(2, '0')}",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  imageUrl: controller
                                          .infoCustomer.value.avatarImage ??
                                      "",
                                  errorWidget: (context, url, error) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SahaEmptyImage(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Họ và tên: ${controller.infoCustomer.value.name ?? "'Chưa đặt tên'"}"),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text("Cấp đại lý: "),
                                        Text(
                                          controller.agency.value.agencyType
                                                  ?.name ??
                                              "Chưa có cấp",
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Text(
                                "${controller.agency.value.customer?.addressDetail == null ? "" : "${controller.agency.value.customer?.addressDetail},"} ${controller.agency.value.customer?.wardsName == null ? "" : "${controller.agency.value.customer?.wardsName},"} ${controller.agency.value.customer?.districtName == null ? "" : "${controller.agency.value.customer?.districtName},"} ${controller.agency.value.customer?.provinceName == null ? "" : "${controller.agency.value.customer?.provinceName}"}",
                                style: TextStyle(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              controller.agency.value.customer?.phoneNumber ??
                                  "",
                              style: TextStyle(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Số dư: ${SahaStringUtils().convertToMoney(controller.agency.value.balance ?? 0)}₫",
                        //       style: TextStyle(
                        //           color: Colors.green,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //   ],
                        // ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Đại lý mở cửa ?",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            CupertinoSwitch(
                                value:
                                    controller.saleCheckIn.value.isAgencyOpen ??
                                        false,
                                onChanged: (v) {
                                  controller.saleCheckIn.value.isAgencyOpen = v;
                                  controller.checkOutAgency();
                                })
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Obx(
                            () => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectImages(
                                    type: '',
                                    title: 'Ảnh checkin',
                                    subTitle: 'Tối đa 10 hình',
                                    onUpload: () {},
                                    images: controller.listImages.toList(),
                                    doneUpload: (List<ImageData> listImages) {
                                      print(
                                          "done upload image ${listImages.length} images => ${listImages.toList().map((e) => e.linkImage).toList()}");

                                      controller.listImages(listImages);
                                      controller.saleCheckIn.value.images =
                                          (listImages.map(
                                                  (e) => e.linkImage ?? "x"))
                                              .toList();
                                      controller.checkOutAgency();
                                    },
                                    maxImage: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 6,
                                offset: const Offset(
                                    1, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: SahaTextFieldNoBorder(
                            enabled: true,
                            controller: controller.noteTextEditingController,
                            onChanged: (v) {
                              controller.saleCheckIn.value.note = v;
                              EasyDebounce.debounce(
                                  'note', const Duration(milliseconds: 500),
                                  () {
                                controller.checkOutAgency();
                              });
                            },
                            textInputType: TextInputType.multiline,
                            maxLine: 5,
                            labelText: "Ghi chú",
                            hintText: "Nhập ghi chú",
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        bottomNavigationBar: Obx(() =>
            controller.agency.value.staffSaleVisitAgency?.timeCheckout ==
                        null &&
                    controller.loadInit.value == false
                ? SizedBox(
                    height: 65,
                    child: Column(
                      children: [
                        SahaButtonFullParent(
                          text: "Check out",
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            SahaDialogApp.showDialogYesNo(
                                mess: "Bạn có muốn check out không?",
                                onOK: () async {
                                  await controller.initFind();
                                  controller.saleCheckIn.value.timeCheckout =
                                      DateTime.now();
                                  controller.checkOutAgency(isCheckOut: true);
                                });
                          },
                        ),
                      ],
                    ),
                  )
                : const SizedBox()),
      ),
    );
  }
}
