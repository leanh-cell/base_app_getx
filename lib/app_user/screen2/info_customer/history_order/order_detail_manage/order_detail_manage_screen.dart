import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_shimmer.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/screen2/config/print/printers_screen.dart';
import 'package:com.ikitech.store/app_user/utils/date_utils.dart';
import 'package:com.ikitech.store/app_user/utils/pdf_generate.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'order_detail_manage_controller.dart';
import 'pdf/pdf_invoice.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order? order;

  OrderDetailScreen({this.order}) {
    orderDetailController = OrderDetailController(inputOrder: order);
  }

  OrderDetailController? orderDetailController;

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin đơn hàng"),
        actions: [
          IconButton(
              onPressed: () async {
                final pdfFile = await PdfInvoiceApi.generate(
                    widget.orderDetailController!.orderResponse.value);

                PdfApi.openFile(pdfFile);
              },
              icon: Icon(Icons.picture_as_pdf)),
          IconButton(
              onPressed: () {
                Get.to(() => PrintScreen(isChoosePrint: true));
              },
              icon: Icon(Icons.print))
        ],
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => widget.orderDetailController!.isLoadingOrder.value
              ? SahaSimmer(
                  isLoading: true,
                  child: Container(
                    width: Get.width,
                    height: Get.height,
                    color: Colors.black,
                  ))
              : Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            color: Theme.of(context).primaryColor,
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
                                  "${widget.orderDetailController!.orderResponse.value.customerAddress!.name ?? "Chưa có tên"}  | ${widget.orderDetailController!.orderResponse.value.customerAddress!.phone ?? "Chưa có số điện thoại"}",
                                  maxLines: 2,
                                ),
                              ),
                              Container(
                                width: Get.width * 0.7,
                                child: Text(
                                  "${widget.orderDetailController!.orderResponse.value.customerAddress!.addressDetail ?? "Chưa có địa chỉ chi tiết"}${widget.orderDetailController!.orderResponse.value.customerAddress!.addressDetail == null ? "" : ","} ${widget.orderDetailController!.orderResponse.value.customerAddress!.wardsName ?? "Chưa có Phường/Xã"}, ${widget.orderDetailController!.orderResponse.value.customerAddress!.districtName ?? "Chưa có Quận/Huyện"}, ${widget.orderDetailController!.orderResponse.value.customerAddress!.provinceName ?? "Chưa có Tỉnh/Thành phố"}",
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
                          widget.orderDetailController!.orderResponse.value
                              .lineItemsAtTime!.length,
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
                                          imageUrl: widget
                                                      .orderDetailController!
                                                      .inputOrder!
                                                      .lineItemsAtTime!
                                                      .length ==
                                                  0
                                              ? ""
                                              : "${widget.orderDetailController!.orderResponse.value.lineItemsAtTime![index].imageUrl}",
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                            Icons.image,
                                            size: 40,
                                            color: Colors.grey,
                                          ),
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
                                            "${widget.orderDetailController!.orderResponse.value.lineItemsAtTime![index].name}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          if (widget
                                                      .orderDetailController!
                                                      .orderResponse
                                                      .value
                                                      .lineItemsAtTime![index]
                                                      .distributesSelected !=
                                                  null &&
                                              widget
                                                  .orderDetailController!
                                                  .orderResponse
                                                  .value
                                                  .lineItemsAtTime![index]
                                                  .distributesSelected!
                                                  .isNotEmpty)
                                            Text(
                                              'Phân loại: ${widget.orderDetailController!.orderResponse.value.lineItemsAtTime![index].distributesSelected![0].value ?? ""} ${widget.orderDetailController!.orderResponse.value.lineItemsAtTime![index].distributesSelected![0].subElement ?? ""}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 12),
                                            ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Spacer(),
                                                  Text(
                                                    " x ${widget.orderDetailController!.orderResponse.value.lineItemsAtTime![index].quantity}",
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
                                                  if (widget
                                                          .orderDetailController!
                                                          .orderResponse
                                                          .value
                                                          .lineItemsAtTime![
                                                              index]
                                                          .beforePrice !=
                                                      widget
                                                          .orderDetailController!
                                                          .orderResponse
                                                          .value
                                                          .lineItemsAtTime![
                                                              index]
                                                          .itemPrice)
                                                    Text(
                                                      "đ${SahaStringUtils().convertToMoney(widget.orderDetailController!.orderResponse.value.lineItemsAtTime![index].beforePrice ?? 0)}",
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color:
                                                              Colors.grey[600]),
                                                    ),
                                                  SizedBox(width: 15),
                                                  Text(
                                                    "đ${SahaStringUtils().convertToMoney(widget.orderDetailController!.orderResponse.value.lineItemsAtTime![index].itemPrice ?? 0)}",
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
                                "₫${SahaStringUtils().convertToMoney(widget.orderDetailController!.orderResponse.value.totalBeforeDiscount)}",
                                style: TextStyle(color: Colors.grey[600]),
                              )
                            ],
                          ),
                          widget.orderDetailController!.orderResponse.value
                                      .productDiscountAmount ==
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
                                      "- đ${SahaStringUtils().convertToMoney(widget.orderDetailController!.orderResponse.value.productDiscountAmount)}",
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                          widget.orderDetailController!.orderResponse.value
                                      .comboDiscountAmount ==
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
                                      "- đ${SahaStringUtils().convertToMoney(widget.orderDetailController!.orderResponse.value.comboDiscountAmount)}",
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                          widget.orderDetailController!.orderResponse.value
                                      .voucherDiscountAmount ==
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
                                      "- đ${SahaStringUtils().convertToMoney(widget.orderDetailController!.orderResponse.value.voucherDiscountAmount)}",
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                          widget.orderDetailController!.orderResponse.value
                                          .bonusPointsAmountUsed ==
                                      0 ||
                                  widget.orderDetailController!.orderResponse
                                          .value.bonusPointsAmountUsed ==
                                      null
                              ? Container()
                              : Row(
                                  children: [
                                    Text(
                                      "Giảm giá Xu:",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Spacer(),
                                    Text(
                                      "- đ${SahaStringUtils().convertToMoney(widget.orderDetailController!.orderResponse.value.bonusPointsAmountUsed)}",
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                          widget.orderDetailController!.orderResponse.value
                                          .balanceCollaboratorUsed ==
                                      0 ||
                                  widget.orderDetailController!.orderResponse
                                          .value.balanceCollaboratorUsed ==
                                      null
                              ? Container()
                              : Row(
                                  children: [
                                    Text(
                                      "Giảm giá Ví CTV:",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Spacer(),
                                    Text(
                                      "- ₫${SahaStringUtils().convertToMoney(widget.orderDetailController!.orderResponse.value.balanceCollaboratorUsed)}",
                                      style: TextStyle(color: Colors.grey[600]),
                                    )
                                  ],
                                ),
                          Row(
                            children: [
                              Text("Thành tiền: "),
                              Spacer(),
                              Text(
                                  "₫${SahaStringUtils().convertToMoney(widget.orderDetailController!.orderResponse.value.totalFinal)}")
                            ],
                          ),
                          Row(
                            children: [
                              Text("Đã thanh toán: "),
                              Spacer(),
                              Text(
                                  "₫${SahaStringUtils().convertToMoney((widget.orderDetailController!.orderResponse.value.totalFinal ?? 0) - (widget.orderDetailController!.orderResponse.value.remainingAmount ?? 0))}")
                            ],
                          ),
                          Row(
                            children: [
                              Text("Còn lại: "),
                              Spacer(),
                              Text(
                                  "₫${SahaStringUtils().convertToMoney(widget.orderDetailController!.orderResponse.value.remainingAmount ?? 0)}")
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (widget.orderDetailController?.orderResponse.value
                            .bonusAgencyHistory !=
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
                                      imageUrl: widget
                                              .orderDetailController!
                                              .orderResponse
                                              .value
                                              .bonusAgencyHistory!
                                              .rewardImageUrl ??
                                          "",
                                      placeholder: (context, url) =>
                                          new SahaLoadingWidget(
                                        size: 20,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                        size: 40,
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
                                          "Quà tặng: ${widget.orderDetailController!.orderResponse.value.bonusAgencyHistory!.rewardName ?? " "}",
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
                                                "₫${SahaStringUtils().convertToMoney(widget.orderDetailController!.orderResponse.value.bonusAgencyHistory!.threshold ?? "")}"),
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
                                                "₫${SahaStringUtils().convertToMoney(widget.orderDetailController!.orderResponse.value.bonusAgencyHistory!.rewardValue ?? "")}"),
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 16.0, bottom: 10),
                              child: Text(
                                widget
                                        .orderDetailController!
                                        .orderResponse
                                        .value
                                        .bonusAgencyHistory!
                                        .rewardDescription ??
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
                      child: Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                Text("Mã đơn hàng"),
                                Spacer(),
                                Text(
                                    "${widget.orderDetailController!.orderResponse.value.orderCode}"),
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
                                  "${SahaDateUtils().getDDMMYY(widget.orderDetailController!.orderResponse.value.createdAt!)} ${SahaDateUtils().getHHMM(widget.orderDetailController!.orderResponse.value.createdAt!)}",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ...List.generate(
                              widget
                                  .orderDetailController!.listStateOrder.length,
                              (index) => Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.6,
                                        child: Text(
                                          "${widget.orderDetailController!.listStateOrder[index].note}",
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "${SahaDateUtils().getDDMMYY(widget.orderDetailController!.listStateOrder[index].createdAt!)} ${SahaDateUtils().getHHMM(widget.orderDetailController!.listStateOrder[index].createdAt!)}",
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
    );
  }
}
