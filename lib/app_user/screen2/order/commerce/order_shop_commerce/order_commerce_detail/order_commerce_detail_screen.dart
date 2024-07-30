import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/model/order_commerce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../../components/saha_user/empty/saha_empty_image.dart';
import '../../../../../components/saha_user/loading/loading_full_screen.dart';
import '../../../../../utils/string_utils.dart';
import 'order_commerce_detail_controller.dart';

class OrderCommmerceDetailScreen extends StatelessWidget {
  OrderCommmerceDetailScreen({Key? key, required this.orderCommerce}) {
    orderCommerceDetailController =
        OrderCommerceDetailController(orderCommerce: orderCommerce);
  }
  late OrderCommerceDetailController orderCommerceDetailController;
  OrderCommerce orderCommerce;
  var expanded = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết đơn hàng"),
      ),
      body: Obx(() => orderCommerceDetailController.loadInit.value
          ? SahaLoadingFullScreen()
          : SingleChildScrollView(
              child: Column(
              children: [
                // Container(
                //   margin: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.15),
                //           spreadRadius: 2,
                //           blurRadius: 2,
                //           offset: Offset(0, 3),
                //         ),
                //       ]),
                //   padding: const EdgeInsets.all(8),
                //   child: Column(
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           expanded.value = !expanded.value;
                //         },
                //         child: Container(
                //           padding: EdgeInsets.all(10),
                //           child: Row(
                //             children: [
                //               Expanded(
                //                   child: Text(
                //                 "Cập nhật thông tin kiện hàng",
                //                 style: TextStyle(fontWeight: FontWeight.w500),
                //               )),
                //               Obx(() => Icon(!expanded.value
                //                   ? Icons.navigate_next
                //                   : Icons.keyboard_arrow_down_rounded))
                //             ],
                //           ),
                //         ),
                //       ),
                //       Obx(
                //         () => expanded.value
                //             ? Column(
                //                 children: [
                //                   Row(
                //                     children: [
                //                       Expanded(
                //                         child: Padding(
                //                           padding: const EdgeInsets.all(8.0),
                //                           child: Row(
                //                             children: [
                //                               Icon(
                //                                 Icons.all_inbox_rounded,
                //                                 color: Theme.of(context)
                //                                     .primaryColor,
                //                               ),
                //                               SizedBox(
                //                                 width: 10,
                //                               ),
                //                               Expanded(
                //                                 child: TextFormField(
                //                                   controller:
                //                                       orderCommerceDetailController
                //                                           .weightEdit,
                //                                   keyboardType:
                //                                       TextInputType.number,
                //                                   inputFormatters: [
                //                                     ThousandsFormatter()
                //                                   ],
                //                                   decoration: InputDecoration(
                //                                       isDense: true,
                //                                       border: InputBorder.none,
                //                                       hintText: "Nhập cân nặng",
                //                                       suffixText: "g"),
                //                                   style:
                //                                       TextStyle(fontSize: 14),
                //                                   minLines: 1,
                //                                   maxLines: 1,
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                       Expanded(
                //                         child: Padding(
                //                           padding: const EdgeInsets.all(8.0),
                //                           child: Row(
                //                             children: [
                //                               Icon(
                //                                 Icons.height,
                //                                 color: Theme.of(context)
                //                                     .primaryColor,
                //                               ),
                //                               SizedBox(
                //                                 width: 10,
                //                               ),
                //                               Expanded(
                //                                 child: TextFormField(
                //                                   controller:
                //                                       orderCommerceDetailController
                //                                           .heightEdit,
                //                                   keyboardType:
                //                                       TextInputType.number,
                //                                   inputFormatters: [
                //                                     ThousandsFormatter()
                //                                   ],
                //                                   decoration: InputDecoration(
                //                                       isDense: true,
                //                                       border: InputBorder.none,
                //                                       hintText:
                //                                           "Nhập chiều cao",
                //                                       suffixText: "cm"),
                //                                   style:
                //                                       TextStyle(fontSize: 14),
                //                                   minLines: 1,
                //                                   maxLines: 1,
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                   Row(
                //                     children: [
                //                       Expanded(
                //                         child: Padding(
                //                           padding: const EdgeInsets.all(8.0),
                //                           child: Row(
                //                             children: [
                //                               RotatedBox(
                //                                 quarterTurns: 1,
                //                                 child: Icon(
                //                                   Icons.height,
                //                                   color: Theme.of(context)
                //                                       .primaryColor,
                //                                 ),
                //                               ),
                //                               SizedBox(
                //                                 width: 10,
                //                               ),
                //                               Expanded(
                //                                 child: TextFormField(
                //                                   controller:
                //                                       orderCommerceDetailController
                //                                           .lengthEdit,
                //                                   keyboardType:
                //                                       TextInputType.number,
                //                                   inputFormatters: [
                //                                     ThousandsFormatter()
                //                                   ],
                //                                   decoration: InputDecoration(
                //                                       isDense: true,
                //                                       border: InputBorder.none,
                //                                       hintText:
                //                                           "Nhập chiều dài",
                //                                       suffixText: "cm"),
                //                                   style:
                //                                       TextStyle(fontSize: 14),
                //                                   minLines: 1,
                //                                   maxLines: 1,
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                       Expanded(
                //                         child: Padding(
                //                           padding: const EdgeInsets.all(8.0),
                //                           child: Row(
                //                             children: [
                //                               Icon(
                //                                 Icons.width_wide_outlined,
                //                                 color: Theme.of(context)
                //                                     .primaryColor,
                //                               ),
                //                               SizedBox(
                //                                 width: 10,
                //                               ),
                //                               Expanded(
                //                                 child: TextFormField(
                //                                   controller:
                //                                       orderCommerceDetailController
                //                                           .widthEdit,
                //                                   keyboardType:
                //                                       TextInputType.number,
                //                                   inputFormatters: [
                //                                     ThousandsFormatter()
                //                                   ],
                //                                   decoration: InputDecoration(
                //                                       isDense: true,
                //                                       border: InputBorder.none,
                //                                       hintText:
                //                                           "Nhập chiều rộng",
                //                                       suffixText: "cm"),
                //                                   style:
                //                                       TextStyle(fontSize: 14),
                //                                   minLines: 1,
                //                                   maxLines: 1,
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ],
                //               )
                //             : SizedBox(),
                //       ),
                //     ],
                //   ),
                // ),
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
                              "${orderCommerceDetailController.orderCommerceReq.value.customerName ?? "Chưa có tên"}  | ${orderCommerceDetailController.orderCommerceReq.value.customerPhone ?? "Chưa có số điện thoại"}",
                              maxLines: 2,
                            ),
                          ),
                          Container(
                            width: Get.width * 0.7,
                            child: Text(
                              "${orderCommerceDetailController.orderCommerceReq.value.customerAddressDetail ?? "Chưa có địa chỉ chi tiết"}",
                              maxLines: 2,
                            ),
                          ),
                          Container(
                            width: Get.width * 0.7,
                            child: Text(
                              "${orderCommerceDetailController.orderCommerceReq.value.customerWardsName ?? "Chưa có Phường/Xã"}, ${orderCommerceDetailController.orderCommerceReq.value.customerDistrictName ?? "Chưa có Quận/Huyện"}, ${orderCommerceDetailController.orderCommerceReq.value.customerDistrictName ?? "Chưa có Tỉnh/Thành phố"}",
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
                Column(
                  children: [
                    ...List.generate(
                      (orderCommerceDetailController
                                  .orderCommerceReq.value.lineTimes ??
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
                                      imageUrl: (orderCommerceDetailController
                                                          .orderCommerceReq
                                                          .value
                                                          .lineTimes ??
                                                      [])
                                                  .length ==
                                              0
                                          ? ""
                                          : "${orderCommerceDetailController.orderCommerceReq.value.lineTimes![index].thumbnail ?? ''}",
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
                                        "${orderCommerceDetailController.orderCommerceReq.value.lineTimes![index].name ?? 'Chưa có thông tin'}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                " x ${(orderCommerceDetailController.orderCommerceReq.value.lineTimes ?? [])[index].quantity}",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey[600]),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Spacer(),
                                              Text(
                                                "đ${SahaStringUtils().convertToMoney(orderCommerceDetailController.orderCommerceReq.value.lineTimes![index].beforeDiscountPrice ?? 0)}",
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.grey[600]),
                                              ),
                                              SizedBox(width: 15),
                                              Text(
                                                "đ${SahaStringUtils().convertToMoney(orderCommerceDetailController.orderCommerceReq.value.lineTimes![index].itemPrice ?? 0)}",
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
                Container(
                  height: 8,
                  color: Colors.grey[200],
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
                            "₫${SahaStringUtils().convertToMoney(orderCommerceDetailController.orderCommerceReq.value.totalBeforeDiscount ?? 0)}",
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
                            "+ đ${SahaStringUtils().convertToMoney(orderCommerceDetailController.orderCommerceReq.value.totalShippingFee ?? 0)}",
                            style: TextStyle(color: Colors.grey[600]),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if ((orderCommerceDetailController
                                  .orderCommerceReq.value.shipDiscountAmount ??
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
                              "- đ${SahaStringUtils().convertToMoney(orderCommerceDetailController.orderCommerceReq.value.shipDiscountAmount ?? 0)}",
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
                              "₫${SahaStringUtils().convertToMoney(orderCommerceDetailController.orderCommerceReq.value.totalFinal ?? 0)}")
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
                              "₫${SahaStringUtils().convertToMoney((orderCommerceDetailController.orderCommerceReq.value.totalFinal ?? 0) - (orderCommerceDetailController.orderCommerceReq.value.remainingAmount ?? 0))}")
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
                              "₫${SahaStringUtils().convertToMoney(orderCommerceDetailController.orderCommerceReq.value.remainingAmount ?? 0)}")
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
                Container(
                  height: 8,
                  color: Colors.grey[200],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("Mã đơn hàng"),
                      Spacer(),
                      Text(
                          "${orderCommerceDetailController.orderCommerceReq.value.orderCode}"),
                    ],
                  ),
                ),
              ],
            ))),
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
                    () => orderCommerceDetailController.loadInit.value
                        ? Container()
                        : Text(
                            "đ${SahaStringUtils().convertToMoney(orderCommerceDetailController.orderCommerceReq.value.totalFinal ?? 0)}",
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
                    () => orderCommerceDetailController.loadInit.value
                        ? Container()
                        : Text(
                            "${orderCommerceDetailController.orderCommerceReq.value.orderCode ?? ""}"),
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
