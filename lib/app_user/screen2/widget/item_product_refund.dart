import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/order/refund_request.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';

class ItemProductInCartRefundWidget extends StatelessWidget {
  final LineItem lineItem;
  final int? quantity;
  final Function? onDismissed;
  final Function? onDecreaseItem;
  final Function? onIncreaseItem;
  final Function? onUpdateQuantity;
  final Function? onCheckBox;
  final bool? valueCheckBox;
  final Function(int quantity, List<DistributesSelected> distributesSelected)?
      onUpdateProduct;

  ItemProductInCartRefundWidget({
    Key? key,
    required this.lineItem,
    this.onDismissed,
    this.onDecreaseItem,
    this.onIncreaseItem,
    this.quantity,
    this.onUpdateQuantity,
    this.onUpdateProduct,
    this.valueCheckBox,
    this.onCheckBox,
  }) : super(key: key);

  bool canDecrease = true;
  bool canIncrease = true;

  int? checkQuantytiItem() {
    if (lineItem.distributesSelected != null) {
      if (lineItem.product!.distributes!.isEmpty) {
        return null;
      }
      if (lineItem.distributesSelected!.isEmpty) {
        return null;
      }
      var distribute = lineItem.product!.distributes![0];
      var select = lineItem.distributesSelected![0];
      if (select.subElement != null) {
        var indexElement = distribute.elementDistributes!
            .indexWhere((e) => e.name == select.value);
        if (indexElement != -1) {
          var indexSub = distribute
              .elementDistributes![indexElement].subElementDistribute!
              .indexWhere((e) => e.name == select.subElement);
          if (indexSub != -1) {
            return distribute.elementDistributes![indexElement]
                .subElementDistribute![indexSub].stock;
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        var indexElement = distribute.elementDistributes!
            .indexWhere((e) => e.name == select.value);
        if (indexElement != -1) {
          return distribute.elementDistributes![indexElement].stock;
        } else {
          return null;
        }
      }
    }
  }

  void checkCanCrease() {
    var product = lineItem.product!;

    var max = checkQuantytiItem() ??
        (product.mainStock == null || product.mainStock! < 0
            ? -1
            : product.mainStock);

    if (quantity == 1)
      canDecrease = false;
    else
      canDecrease = true;

    if (quantity! + 1 > max! && max != -1)
      canIncrease = false;
    else
      canIncrease = true;
  }

  @override
  Widget build(BuildContext context) {
    var product = lineItem.product!;

    checkCanCrease();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child:  Stack(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 88,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: imageItem() ??
                                (product.images!.length == 0
                                    ? ""
                                    : product.images![0].imageUrl!),
                            errorWidget: (context, url, error) => Icon(
                              Icons.image,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  product.productDiscount == null
                      ? Container()
                      : Positioned(
                    top: -12,
                    left: 2,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          child: SvgPicture.asset(
                            "packages/sahashop_customer/assets/icons/ribbon.svg",
                            color: Color(0xfffdd100),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          left: 5,
                          child: Text(
                            "-${SahaStringUtils().convertToMoney(product.productDiscount!.value)} %",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xfffd5800)),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? "Không tên",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                      maxLines: 2,
                    ),
                    lineItem.distributesSelected == null ||
                        lineItem.distributesSelected!.length == 0
                        ? Container()
                        : InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.only(
                            left: 5, right: 5, top: 5, bottom: 5),
                        color: Colors.grey[200],
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ConstrainedBox(
                              constraints: new BoxConstraints(
                                minWidth: 10,
                                maxWidth: Get.width * 0.5,
                              ),
                              child: Text(
                                'Phân loại: ${lineItem.distributesSelected![0].value ?? ""} ${lineItem.distributesSelected![0].subElement ?? ""}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12),
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.grey[600],
                              size: 12,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: lineItem.isBonus == true ? 'Hàng tặng' :
                            "đ${SahaStringUtils().convertToMoney(lineItem.itemPrice ?? 0)}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          product.productDiscount == null
                              ? ""
                              : "đ${SahaStringUtils().convertToMoney(((100 * lineItem.itemPrice!) / (100 - product.productDiscount!.value!)))}",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[400],
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    if(lineItem.isBonus != true)
                      Row(
                        children: [
                          InkWell(
                            onTap: !canDecrease
                                ? null
                                : () {
                              onDecreaseItem!();
                            },
                            child: Container(
                              height: 25,
                              width: 30,
                              child: Icon(
                                Icons.remove,
                                size: 13,
                                color: canDecrease ? Colors.black : Colors.grey,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: onUpdateQuantity == null
                                ? null
                                : () {
                              onUpdateQuantity!();
                            },
                            child: Container(
                              height: 25,
                              width: 40,
                              child: Center(
                                child: Text(
                                  '$quantity',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: !canIncrease
                                ? null
                                : () {
                              onIncreaseItem!();
                            },
                            child: Container(
                              height: 25,
                              width: 30,
                              child: Icon(
                                Icons.add,
                                size: 13,
                                color: canIncrease ? Colors.black : Colors.grey,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[200]!),
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
              if (lineItem.isBonus == true) SizedBox(width: 10),
              if (lineItem.isBonus == true)
                Column(
                  children: [
                    SvgPicture.asset(
                      "packages/sahashop_customer/assets/icons/presents.svg",
                      height: 40,
                      width: 40,
                    ),
                    SizedBox(height: 5,),
                    SizedBox(
                      width: 50,
                      child: Text(
                        "${lineItem.bonusProductName ?? ""}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          if(lineItem.isBonus != true)
            Positioned(
              right: 5,
              bottom: 20,
              child: Checkbox(
                value: valueCheckBox ?? false,
                onChanged: (v) {
                  if (onCheckBox != null) {
                    onCheckBox!();
                  }
                },
              ),
            ),
        ],
      ),
    );
  }

  String? imageItem() {
    if (lineItem.product!.distributes != null &&
        lineItem.distributesSelected != null) {
      if (lineItem.distributesSelected!.isEmpty) {
        return null;
      }
      if (lineItem.product!.distributes!.isNotEmpty) {
        var indexImage = lineItem.product!.distributes![0].elementDistributes!
            .indexWhere(
                (e) => e.name == lineItem.distributesSelected![0].value);
        if (indexImage != -1) {
          String imageUrlCurrent = lineItem.product!.distributes![0]
                  .elementDistributes![indexImage].imageUrl ??
              (lineItem.product!.images!.length == 0
                  ? ""
                  : lineItem.product!.images![0].imageUrl!);
          return imageUrlCurrent;
        }
      }
      return null;
    } else {
      return null;
    }
  }
}
