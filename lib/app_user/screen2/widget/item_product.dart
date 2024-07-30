import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';

import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import '../../../saha_data_controller.dart';
import '../../components/saha_user/empty/saha_empty_image.dart';
import '../../components/text_field/rice_text_field.dart';
import 'modal_bottom_option_buy_product.dart';

class ItemProductInCartWidget extends StatelessWidget {
  final LineItem lineItem;
  final int? quantity;
  final Function? onDismissed;
  final Function? onDecreaseItem;
  final Function? onIncreaseItem;
  final Function? onNote;
  final SahaDataController sahaDataController = Get.find();
  final Function(int quantity, List<DistributesSelected> distributesSelected)?
      onUpdateProduct;

  ItemProductInCartWidget(
      {Key? key,
      required this.lineItem,
      this.onDismissed,
      this.onDecreaseItem,
      this.onIncreaseItem,
      this.quantity,
      this.onUpdateProduct,
      this.onNote})
      : super(key: key);

  bool canDecrease = true;
  bool canIncrease = true;
  TextEditingController note = TextEditingController();

  int? checkQuantityItem() {
    if (lineItem.distributesSelected != null) {
      if (lineItem.product!.distributes!.isEmpty) {
        return null;
      }
      if (lineItem.distributesSelected!.isEmpty) {
        return null;
      }
      var distribute = lineItem.product!.inventory!.distributes![0];
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

    var max = checkQuantityItem() ??
        (product.inventory?.mainStock == null ||
                product.inventory!.mainStock! < 0
            ? -1
            : product.inventory?.mainStock ?? -1);

    if (quantity == 1)
      canDecrease = false;
    else
      canDecrease = true;

    if (product.checkInventory == false) {
      canIncrease = true;
    } else {
      if (sahaDataController.badgeUser.value.allowSemiNegative == true) {
        canIncrease = true;
      } else {
        if (quantity! + 1 > max && max != -1)
          canIncrease = false;
        else
          canIncrease = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var product = lineItem.product!;
    note.text = lineItem.note ?? '';

    checkCanCrease();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          onDismissed!();
        },
        background: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Color(0xFFFFE6E6),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Spacer(),
              Icon(
                Icons.delete,
                color: Colors.red,
              )
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                          errorWidget: (context, url, error) =>
                              SahaEmptyImage(),
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
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            product.name ?? "Không tên",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            maxLines: 2,
                          ),
                        ),
                        if (lineItem.isBonus == true)
                          Text(
                            "x $quantity",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                      ],
                    ),
                    lineItem.distributesSelected == null ||
                            lineItem.distributesSelected!.length == 0
                        ? Container()
                        : InkWell(
                            onTap: () {
                              if (lineItem.isBonus != true) {
                                if (onUpdateProduct != null) {
                                  ModalBottomOptionBuyProductUser
                                      .showModelOption(
                                          product: lineItem.product!,
                                          lineItemId: lineItem.id,
                                          distributesSelectedParam:
                                              lineItem.distributesSelected,
                                          quantity: lineItem.quantity,
                                          onSubmit: (int quantity,
                                              Product product,
                                              List<DistributesSelected>
                                                  distributesSelected) {
                                            onUpdateProduct!(
                                                quantity, distributesSelected);
                                            Get.back();
                                          });
                                }
                              } else {
                                if (lineItem.allowsChooseDistribute == true) {
                                  if (onUpdateProduct != null) {
                                    ModalBottomOptionBuyProductUser
                                        .showModelOption(
                                            product: lineItem.product!,
                                            lineItemId: lineItem.id,
                                            distributesSelectedParam:
                                                lineItem.distributesSelected,
                                            quantity: lineItem.quantity,
                                            onSubmit: (int quantity,
                                                Product product,
                                                List<DistributesSelected>
                                                    distributesSelected) {
                                              onUpdateProduct!(quantity,
                                                  distributesSelected);
                                              Get.back();
                                            });
                                  }
                                }
                              }
                            },
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
                                  if (lineItem.isBonus != true)
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
                            text: lineItem.isBonus == true
                                ? 'Hàng tặng'
                                : "đ${SahaStringUtils().convertToMoney(lineItem.itemPrice ?? 0)}",
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
                    if (lineItem.isBonus != true)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (lineItem.isBonus != true)
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
                                  color:
                                      canDecrease ? Colors.black : Colors.grey,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[200]!),
                                ),
                              ),
                            ),
                          InkWell(
                            onTap: () {
                              ModalBottomOptionBuyProductUser.showModelOption(
                                  product: lineItem.product!,
                                  lineItemId: lineItem.id,
                                  isLoadingProduct: true,
                                  distributesSelectedParam:
                                      lineItem.distributesSelected,
                                  quantity: lineItem.quantity,
                                  onSubmit: (int quantity,
                                      Product product,
                                      List<DistributesSelected>
                                          distributesSelected) {
                                    onUpdateProduct!(
                                        quantity, distributesSelected);
                                    Get.back();
                                  });
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
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        SahaDialogApp.showDialogInput(
                            title: "Ghi chú",
                            hintText: "Nhập ghi chú",
                            textInput: note.text,
                            onInput: (String? v) {
                              note.text = v ?? '';
                              Get.back();
                              onNote!(lineItem.id,note.text);
                            });
                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: RiceTextField(
                              enabled: false,
                              controller: note,
                              hintText: "Nhập ghi chú",
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      "${lineItem.bonusProductName ?? ""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
          ],
        ),

        // Row(
        //   children: [
        //     Stack(
        //       children: [
        //         SizedBox(
        //           width: 88,
        //           child: Padding(
        //             padding: const EdgeInsets.all(2.0),
        //             child: AspectRatio(
        //               aspectRatio: 1,
        //               child: ClipRRect(
        //                 borderRadius: BorderRadius.circular(2),
        //                 child: CachedNetworkImage(
        //                   fit: BoxFit.cover,
        //                   imageUrl: imageItem() ??
        //                       (product.images!.length == 0
        //                           ? ""
        //                           : product.images![0].imageUrl!),
        //                   errorWidget: (context, url, error) => Icon(
        //                     Icons.image,
        //                     size: 40,
        //                     color: Colors.grey,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //         product.productDiscount == null
        //             ? Container()
        //             : Positioned(
        //           top: -12,
        //           left: 2,
        //           child: Stack(
        //             clipBehavior: Clip.none,
        //             children: [
        //               Container(
        //                 height: 45,
        //                 width: 45,
        //                 child: SvgPicture.asset(
        //                   "packages/sahashop_customer/assets/icons/ribbon.svg",
        //                   color: Color(0xfffdd100),
        //                 ),
        //               ),
        //               Positioned(
        //                 top: 15,
        //                 left: 5,
        //                 child: Text(
        //                   "-${SahaStringUtils().convertToMoney(product.productDiscount!.value)} %",
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(
        //                       fontSize: 10,
        //                       fontWeight: FontWeight.bold,
        //                       color: Color(0xfffd5800)),
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //     SizedBox(width: 20),
        //     Container(
        //       width: Get.width * 0.6,
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             product.name ?? "Không tên",
        //             style: TextStyle(color: Colors.black, fontSize: 14),
        //             maxLines: 2,
        //           ),
        //           lineItem.distributesSelected == null ||
        //               lineItem.distributesSelected!.length == 0
        //               ? Container()
        //               : InkWell(
        //             onTap: () {
        //               if (onUpdateProduct != null) {
        //                 ModalBottomOptionBuyProductUser.showModelOption(
        //                     product: lineItem.product!,
        //                     lineItemId: lineItem.id,
        //                     distributesSelectedParam:
        //                     lineItem.distributesSelected,
        //                     quantity: lineItem.quantity,
        //                     onSubmit: (int quantity,
        //                         Product product,
        //                         List<DistributesSelected>
        //                         distributesSelected) {
        //                       onUpdateProduct!(
        //                           quantity, distributesSelected);
        //                       Get.back();
        //                     });
        //               }
        //             },
        //             child: Container(
        //               margin: EdgeInsets.only(top: 10),
        //               padding: EdgeInsets.only(
        //                   left: 5, right: 5, top: 5, bottom: 5),
        //               color: Colors.grey[200],
        //               child: Row(
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   ConstrainedBox(
        //                     constraints: new BoxConstraints(
        //                       minWidth: 10,
        //                       maxWidth: Get.width * 0.5,
        //                     ),
        //                     child: Text(
        //                       'Phân loại: ${lineItem.distributesSelected![0].value ?? ""} ${lineItem.distributesSelected![0].subElement ?? ""}',
        //                       overflow: TextOverflow.ellipsis,
        //                       style: TextStyle(
        //                           color: Colors.grey[600], fontSize: 12),
        //                     ),
        //                   ),
        //                   Icon(
        //                     Icons.keyboard_arrow_down_rounded,
        //                     color: Colors.grey[600],
        //                     size: 12,
        //                   )
        //                 ],
        //               ),
        //             ),
        //           ),
        //           SizedBox(height: 10),
        //           Row(
        //             children: [
        //               Text.rich(
        //                 TextSpan(
        //                   text:
        //                   "đ${SahaStringUtils().convertToMoney(lineItem.itemPrice ?? 0)}",
        //                   style: TextStyle(
        //                       fontWeight: FontWeight.w600,
        //                       color: Theme.of(context).primaryColor),
        //                 ),
        //               ),
        //               SizedBox(
        //                 width: 10,
        //               ),
        //               Text(
        //                 product.productDiscount == null
        //                     ? ""
        //                     : "đ${SahaStringUtils().convertToMoney(((100 * lineItem.itemPrice!) / (100 - product.productDiscount!.value!)))}",
        //                 style: TextStyle(
        //                     decoration: TextDecoration.lineThrough,
        //                     color: Colors.grey[400],
        //                     fontWeight: FontWeight.w500,
        //                     fontSize: 12),
        //                 maxLines: 1,
        //               ),
        //             ],
        //           ),
        //           SizedBox(height: 10),
        //           Row(
        //             children: [
        //               InkWell(
        //                 onTap: !canDecrease
        //                     ? null
        //                     : () {
        //                   onDecreaseItem!();
        //                 },
        //                 child: Container(
        //                   height: 25,
        //                   width: 30,
        //                   child: Icon(
        //                     Icons.remove,
        //                     size: 13,
        //                     color: canDecrease ? Colors.black : Colors.grey,
        //                   ),
        //                   decoration: BoxDecoration(
        //                     border: Border.all(color: Colors.grey[200]!),
        //                   ),
        //                 ),
        //               ),
        //               InkWell(
        //                 onTap: () {
        //                   ModalBottomOptionBuyProductUser.showModelOption(
        //                       product: lineItem.product!,
        //                       lineItemId: lineItem.id,
        //                       isLoadingProduct: true,
        //                       distributesSelectedParam:
        //                       lineItem.distributesSelected,
        //                       quantity: lineItem.quantity,
        //                       onSubmit: (int quantity,
        //                           Product product,
        //                           List<DistributesSelected>
        //                           distributesSelected) {
        //                         onUpdateProduct!(quantity, distributesSelected);
        //                         Get.back();
        //                       });
        //                 },
        //                 child: Container(
        //                   height: 25,
        //                   padding: EdgeInsets.only(left: 5, right: 5),
        //                   child: Center(
        //                     child: Text(
        //                       '$quantity',
        //                       style: TextStyle(fontSize: 14),
        //                     ),
        //                   ),
        //                   decoration: BoxDecoration(
        //                     border: Border.all(color: Colors.grey[200]!),
        //                   ),
        //                 ),
        //               ),
        //               InkWell(
        //                 onTap: !canIncrease
        //                     ? null
        //                     : () {
        //                   onIncreaseItem!();
        //                 },
        //                 child: Container(
        //                   height: 25,
        //                   width: 30,
        //                   child: Icon(
        //                     Icons.add,
        //                     size: 13,
        //                     color: canIncrease ? Colors.black : Colors.grey,
        //                   ),
        //                   decoration: BoxDecoration(
        //                     border: Border.all(color: Colors.grey[200]!),
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           )
        //         ],
        //       ),
        //     )
        //   ],
        // ),
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
