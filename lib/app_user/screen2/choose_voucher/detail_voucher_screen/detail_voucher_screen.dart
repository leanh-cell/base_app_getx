import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sahashop_customer/app_customer/components/empty/saha_empty_image.dart';
import 'package:sahashop_customer/app_customer/components/loading/loading_container.dart';
import 'package:sahashop_customer/app_customer/components/modal/modal_bottom_option_buy_product.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'package:sahashop_customer/app_customer/screen_can_edit/product_screen/product_screen.dart';
import 'package:sahashop_customer/app_customer/screen_default/cart_screen/cart_controller.dart';
import 'package:sahashop_customer/app_customer/screen_default/data_app_controller.dart';
import 'package:sahashop_customer/app_customer/utils/color_utils.dart';
import 'package:sahashop_customer/app_customer/utils/date_utils.dart';
import 'package:sahashop_customer/app_customer/utils/string_utils.dart';

import '../../../model/voucher.dart';

class DetailVoucherScreen extends StatelessWidget {
  final Voucher? voucher;
  DetailVoucherScreen({this.voucher});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết mã giảm giá"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(13.0),
                decoration:
                BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(color: Colors.grey[500]!),
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 80,
                              child: voucher!.discountFor == 1
                                  ? Text(
                                "Miễn phí vận chuyển",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6!
                                      .color,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 4,
                              )
                                  : voucher!.voucherType == 1
                                  ? voucher!.discountType == 1
                                  ? Text(
                                "Mã: ${voucher!.code} giảm ${voucher!.valueDiscount} %",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6!
                                      .color,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 4,
                              )
                                  : Text(
                                "Mã: ${voucher!.code} giảm ${SahaStringUtils().convertToMoney(voucher!.valueDiscount)}đ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6!
                                      .color,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 4,
                              )
                                  : voucher!.discountType == 1
                                  ? Text(
                                "Mã: ${voucher!.code} giảm ${voucher!.valueDiscount} %",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6!
                                      .color,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 4,
                              )
                                  : Text(
                                "Mã: ${voucher!.code} giảm ${SahaStringUtils().convertToMoney(voucher!.valueDiscount)}đ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .headline6!
                                      .color,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 4,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          height: 8,
                          width: 8,
                          top: 5,
                          left: -4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          height: 8,
                          width: 8,
                          top: 20,
                          left: -4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          height: 8,
                          width: 8,
                          top: 35,
                          left: -4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          height: 8,
                          width: 8,
                          top: 50,
                          left: -4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          height: 8,
                          width: 8,
                          top: 65,
                          left: -4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          height: 8,
                          width: 8,
                          top: 80,
                          left: -4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${voucher!.name}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 2,
                                    ),
                                    voucher!.voucherType == 1
                                        ? Text(
                                      "Giảm giá cho các sản phẩm sau:",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                    )
                                        : Text(
                                      "Giảm giá cho toàn bộ các sản phẩm",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                    ),
                                    voucher!.voucherType == 1
                                        ? Text(
                                      "${voucher!.products![0].name}, vv...",
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                      maxLines: 1,
                                    )
                                        : Container(),
                                    Text(
                                      "HSD: ${SahaDateUtils().getDDMMYY(voucher!.endTime!)}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Ưu đãi",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (voucher!.discountFor != 1)
                      voucher!.voucherType == 1
                          ? voucher!.discountType == 1
                          ? Text(
                        "Giảm ${voucher!.valueDiscount} % cho các sản phẩm sau:",
                        textAlign: TextAlign.center,
                        maxLines: 4,
                      )
                          : Text(
                        "Giảm ${SahaStringUtils().convertToMoney(voucher!.valueDiscount)}đ cho các sản phẩm sau:",
                        textAlign: TextAlign.center,
                        maxLines: 4,
                      )
                          : voucher!.discountType == 1
                          ? Text(
                        "Giảm ${voucher!.valueDiscount} % cho toàn bộ các sản phẩm",
                        textAlign: TextAlign.center,
                        maxLines: 4,
                      )
                          : Text(
                        "Giảm ${SahaStringUtils().convertToMoney(voucher!.valueDiscount)}đ cho toàn bộ các sản phẩm",
                        textAlign: TextAlign.center,
                        maxLines: 4,
                      ),
                    if (voucher!.discountFor != 1)
                      voucher!.voucherType == 1
                          ? Text(
                        "${voucher!.products![0].name}, vv...",
                        style: TextStyle(
                          fontSize: 13,
                        ),
                        maxLines: 1,
                      )
                          : Container(),
                    (voucher!.discountFor == 1)
                        ? (voucher!.shipDiscountValue ?? 0) == 0
                        ? Text(
                        "Miễn phí vận chuyển")
                        : Text(
                        "Giới hạn giảm ${SahaStringUtils().convertToMoney(voucher!.shipDiscountValue)}đ.")
                        : voucher!.setLimitValueDiscount == true
                        ? Text(
                        "Giới hạn giảm ${SahaStringUtils().convertToMoney(voucher!.maxValueDiscount)}đ.")
                        : Container(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Có hiệu lực:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${SahaDateUtils().getDDMMYY(voucher!.startTime!)} ${SahaDateUtils().getHHMM(voucher!.startTime!)} - ${SahaDateUtils().getDDMMYY(voucher!.endTime!)} ${SahaDateUtils().getHHMM(voucher!.endTime!)}",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Thanh toán:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Mọi hình thức thanh toán."),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Điều kiện sử dụng:",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    voucher!.setLimitAmount == true
                        ? Text("Số lượng giới hạn: ${voucher!.amount}.")
                        : Container(),
                    voucher!.voucherType == 1
                        ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Chỉ áp dụng cho các sản phẩm sau: "),
                          ...List.generate(
                              voucher!.products!.length,
                                  (index) => Text(
                                  "${voucher!.products![index].name}."))
                        ],
                      ),
                    )
                        : Container(),
                    voucher!.setLimitTotal == true
                        ? Text(
                        "Giá trị tổng đơn hàng tối thiểu: ${SahaStringUtils().convertToMoney(voucher!.valueLimitTotal)}đ.")
                        : Container(),
                    Text(
                      "HSD: ${SahaDateUtils().getDDMMYY(voucher!.startTime!)} ${SahaDateUtils().getHHMM(voucher!.startTime!)} - ${SahaDateUtils().getDDMMYY(voucher!.endTime!)} ${SahaDateUtils().getHHMM(voucher!.endTime!)}.",
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Text('Các sản phẩm có thể áp dụng voucher',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 18,
                    )),
              ),
              Container(
                  child: Wrap(
                    children: [
                      ...voucher!.products!
                          .map((e) => promotionalProducts(product: e))
                          .toList(),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget promotionalProducts({required Product product}) {
    return SizedBox(
      width: Get.width / 2,
      child: InkWell(
        onTap: () {
          Get.to(ProductScreen(
            product: product,
          ));
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                height: 180,
                width: Get.width,
                fit: BoxFit.cover,
                imageUrl: product.images == null
                    ? ""
                    : product.images![0].imageUrl ?? "",
                placeholder: (context, url) => SahaLoadingContainer(),
                errorWidget: (context, url, error) => SahaEmptyImage(),
              ),
              Container(
                padding: EdgeInsets.all(5),
                height: 50,
                child: Text(
                  product.name != null ? product.name ?? "" : "",
                  maxLines: 2,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            product.minPrice == 0
                                ? "${product.price == 0 ? "Giảm" : "${SahaStringUtils().convertToMoney(product.price)}₫"} - ${SahaStringUtils().convertToMoney(product.productDiscount?.value ?? 0)}%"
                                : "${SahaStringUtils().convertToMoney(product.minPrice)}₫ - ${SahaStringUtils().convertToMoney(product.productDiscount?.value ?? 0)}%",
                            style: TextStyle(
                                decoration: product.price == 0
                                    ? null
                                    : TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                        Container(
                          child: Text(
                            textMoney(product)!,
                            style: TextStyle(
                                color: SahaColorUtils()
                                    .colorPrimaryTextWithWhiteBackground(),
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            maxLines: 1,
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? textMoney(Product product) {
    if (product.minPrice == 0) {
      if (product.productDiscount == null) {
        return "${product.price == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(product.price)}₫"}";
      } else {
        return "${product.productDiscount!.discountPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(product.productDiscount!.discountPrice)}₫"}";
      }
    } else {
      if (product.productDiscount == null) {
        return "${product.minPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(product.minPrice)}₫"}";
      } else {
        return "${product.minPrice == 0 ? "Liên hệ" : "${SahaStringUtils().convertToMoney(product.minPrice! - ((product.minPrice! * product.productDiscount!.value!) / 100))}₫"}";
      }
    }
  }

  double? checkMinMaxPrice(double? price, Product product) {
    return product.productDiscount == null
        ? (price ?? 0)
        : ((price ?? 0) -
        ((price ?? 0) * (product.productDiscount!.value! / 100)));
  }
}
