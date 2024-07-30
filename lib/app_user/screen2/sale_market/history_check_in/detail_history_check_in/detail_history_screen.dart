import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_container.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_full_screen.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text_field/text_field_no_border.dart';
import 'package:com.ikitech.store/app_user/screen2/sale_market/history_check_in/detail_history_check_in/detail_history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sahashop_customer/app_customer/components/image/show_image.dart';

class DetailHistoryScreen extends StatelessWidget {
  DetailHistoryScreen({Key? key, required this.historyId}) : super(key: key) {
    controller = DetailHistoryController(historyId: historyId);
  }
  final int historyId;
  late final DetailHistoryController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết"),
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
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Ngày tháng"),
                              Text(
                                  "${DateFormat("dd-MM-yyyy").format(controller.history.value.createdAt ?? DateTime.now())}"),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Check in"),
                              Text(
                                  "${DateFormat("HH:mm").format(controller.history.value.timeCheckin ?? DateTime.now())}",style: TextStyle(color: Colors.green),),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Check out"),
                              Text(controller.history.value.timeCheckin == null
                                  ? "Chưa check out"
                                  : "${DateFormat("HH:mm").format(controller.history.value.timeCheckout ?? DateTime.now())}",style: TextStyle(color: Colors.red),),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          //  if (timeVisit != null)
                          // Column(
                          //   children: [

                          //     Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Text("Thời gian viếng thăm :"),
                          //         Text(
                          //             "${timeVisit.inHours}:${(timeVisit.inMinutes % 60).toString().padLeft(2, '0')}:${(timeVisit.inSeconds % 60).toString().padLeft(2, '0')}"),
                          //       ],
                          //     ),
                          //      const SizedBox(
                          //       height: 5,
                          //     ),
                          //   ],
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tên thiết bị"),
                              Text(controller.history.value.deviceName ??
                                  "Chưa có thông tin")
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Trạng thái"),
                              Text(
                                controller.history.value.isAgencyOpen == true
                                    ? "Mở cửa"
                                    : "Đóng cửa",
                                style: TextStyle(
                                    color:
                                        controller.history.value.isAgencyOpen ==
                                                true
                                            ? Colors.green
                                            : Colors.red),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Địa chỉ check in"),
                              const SizedBox(width: 30,),
                              Expanded(
                                child: Text(controller.history.value.addressCheckin ??
                                "Chưa có thông tin",textAlign: TextAlign.end,),
                              ),
                            ],
                          ),
                       
                         
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "  Ảnh",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if ((controller.history.value.images ?? [])
                              .isNotEmpty)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...(controller.history.value.images ?? [])
                                      .map((e) => images(e))
                                ],
                              ),
                            ),
                          if ((controller.history.value.images ?? []).isEmpty)
                            Text("  Chưa có ảnh check in")
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "  Ghi chú",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
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
                              readOnly: true,
                              controller: controller.note,
                              textInputType: TextInputType.multiline,
                              maxLine: 5,
                              labelText: "Ghi chú",
                              hintText: "Chưa có ghi chú",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget images(
    String imageUrl,
  ) {
    return Container(
      height: 100,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
        child: InkWell(
          onTap: () {
            ShowImage().seeImage(
                listImageUrl: (controller.history.value.images ?? []).toList(),
                index: (controller.history.value.images ?? [])
                    .toList()
                    .indexOf(imageUrl));
          },
          child: CachedNetworkImage(
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: imageUrl,
            placeholder: (context, url) => const SahaLoadingContainer(),
            errorWidget: (context, url, error) => const SahaEmptyImage(),
          ),
        ),
      ),
    );
  }
}
