import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/screen_default/chat_customer_screen/chat_user_screen.dart';
import 'order_detail_history_controller.dart';

// ignore: must_be_immutable
class OrderHistoryDetailCtvScreen extends StatelessWidget {
  final Order? orderInput;

  var listStatusCode = [
    WAITING_FOR_PROGRESSING,
    PACKING,
    OUT_OF_STOCK,
    USER_CANCELLED,
    CUSTOMER_CANCELLED,
    SHIPPING,
    DELIVERY_ERROR,
    COMPLETED,
    CUSTOMER_RETURNING,
    CUSTOMER_HAS_RETURNS,
  ];

  OrderHistoryDetailCtvScreen({this.orderInput}) {
    orderHistoryDetailController =
        Get.put(OrderHistoryDetailCtvController(orderInput: orderInput));
  }

  late OrderHistoryDetailCtvController orderHistoryDetailController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin đơn hàng"),
      ),
      body: Obx(
        () => orderHistoryDetailController.isLoading.value == true
            ? SahaSimmer(
                isLoading: true,
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.black,
                ))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Color(0xff16a5a1),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Trạng thái đơn hàng: ${orderHistoryDetailController.order.value.orderStatusName}",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6!
                                          .color),
                                ),
                                Spacer(),
                                Container(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.asset(
                                      "packages/sahashop_customer/assets/icons/delivery_truck.svg",
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6!
                                          .color),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Trạng thái thanh toán: ${orderHistoryDetailController.order.value.paymentStatusName}",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6!
                                          .color),
                                ),
                                Spacer(),
                                Container(
                                  child: SvgPicture.asset(
                                      "packages/sahashop_customer/assets/icons/wallet.svg",
                                      width: 28,
                                      height: 28,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .headline6!
                                          .color),
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
                            width: 25,
                            height: 25,
                            child: SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/delivery_truck.svg",
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Đơn vị vận chuyển: ${orderHistoryDetailController.order.value.shipperName}"),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Kiểu : ${orderHistoryDetailController.order.value.shipperType == 0 ? "Giao nhanh" : "Siêu tốc"}"),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "Phí giao hàng: đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.totalShippingFee)}"),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
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
                            child: SvgPicture.asset(
                              "packages/sahashop_customer/assets/icons/location.svg",
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
                            ),
                          ),
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
                                  "${orderHistoryDetailController.order.value.customerAddress!.name ?? "Chưa có tên"}  | ${orderHistoryDetailController.order.value.customerAddress!.phone ?? "Chưa có số điện thoại"}",
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.7,
                                child: Text(
                                  "${orderHistoryDetailController.order.value.customerAddress!.addressDetail ?? "Chưa có địa chỉ chi tiết"}",
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.7,
                                child: Text(
                                  "${orderHistoryDetailController.order.value.customerAddress!.districtName ?? "Chưa có Quận/Huyện"}, ${orderHistoryDetailController.order.value.customerAddress!.wardsName ?? "Chưa có Phường/Xã"}, ${orderHistoryDetailController.order.value.customerAddress!.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
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
                          orderHistoryDetailController
                              .order.value.lineItemsAtTime!.length,
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
                                          imageUrl: orderHistoryDetailController
                                                      .order
                                                      .value
                                                      .lineItemsAtTime!
                                                      .length ==
                                                  0
                                              ? ""
                                              : "${orderHistoryDetailController.order.value.lineItemsAtTime![index].imageUrl}",
                                          errorWidget: (context, url, error) =>
                                              SahaEmptyImage(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 80,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${orderHistoryDetailController.order.value.lineItemsAtTime![index].name}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Spacer(),
                                                    Text(
                                                      " x ${orderHistoryDetailController.order.value.lineItemsAtTime![index].quantity}",
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
                                                    Text(
                                                      "đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.lineItemsAtTime![index].beforePrice)}",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color:
                                                              Colors.grey[600]),
                                                    ),
                                                    SizedBox(width: 15),
                                                    Text(
                                                      "đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.lineItemsAtTime![index].afterDiscount)}",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
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
                                "đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.totalBeforeDiscount)}",
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
                                "+ đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.totalAfterDiscount)}",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          orderHistoryDetailController
                                      .order.value.productDiscountAmount ==
                                  0
                              ? Container()
                              : Row(
                                  children: [
                                    Text(
                                      "Giảm giá sản phẩm: ",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Spacer(),
                                    Text(
                                      "- đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.productDiscountAmount)}",
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 5,
                          ),
                          orderHistoryDetailController
                                      .order.value.comboDiscountAmount ==
                                  0
                              ? Container()
                              : Row(
                                  children: [
                                    Text(
                                      "Giảm giá Combo: ",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Spacer(),
                                    Text(
                                      "- đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.comboDiscountAmount)}",
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                          SizedBox(
                            height: 5,
                          ),
                          orderHistoryDetailController
                                      .order.value.voucherDiscountAmount ==
                                  0
                              ? Container()
                              : Row(
                                  children: [
                                    Text(
                                      "Giảm giá Voucher:",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Spacer(),
                                    Text(
                                      "- đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.voucherDiscountAmount)}",
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
                                  "đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.totalAfterDiscount)}")
                            ],
                          ),
                          SizedBox(
                            height: 5,
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
                              "packages/sahashop_customer/assets/icons/money.svg",
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
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
                                  "${orderHistoryDetailController.order.value.paymentMethodName}")
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
                                    "${orderHistoryDetailController.order.value.orderCode}"),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Thời gian đặt hàng",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Spacer(),
                                Text(
                                  "${SahaDateUtils().getDDMMYY(orderHistoryDetailController.order.value.createdAt!)} ${SahaDateUtils().getHHMM(orderHistoryDetailController.order.value.createdAt!)}",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ...List.generate(
                              orderHistoryDetailController
                                  .listStateOrder.length,
                              (index) => Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.6,
                                        child: Text(
                                          "${orderHistoryDetailController.listStateOrder[index].note}",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${SahaDateUtils().getDDMMYY(orderHistoryDetailController.listStateOrder[index].createdAt!)} ${SahaDateUtils().getHHMM(orderHistoryDetailController.listStateOrder[index].createdAt!)}",
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
                    InkWell(
                      onTap: () {
                        Get.to(() => ChatCustomerScreen());
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
                                child: SvgPicture.asset(
                                  "packages/sahashop_customer/assets/icons/chat.svg",
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Liên hệ Shop")
                            ],
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
      bottomNavigationBar: Obx(
        () => Container(
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
                    Text(
                      "đ${SahaStringUtils().convertToMoney(orderHistoryDetailController.order.value.totalAfterDiscount ?? 0)}",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: SahaColorUtils()
                              .colorPrimaryTextWithWhiteBackground()),
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
                    Text("${orderHistoryDetailController.order.value.orderCode ?? ""}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
