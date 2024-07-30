import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/empty/saha_empty_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

class ItemCartAnimation extends StatelessWidget {
  final GlobalKey imageGlobalKey = GlobalKey();
  final Function onTap;
  final Product product;
  final quantity;
  Function onDecreaseItem;
  Function onIncreaseItem;
  Function quantityInput;
  ItemCartAnimation({
    required this.quantity,
    required this.onTap,
    required this.product,
    required this.onDecreaseItem,
    required this.onIncreaseItem,
    required this.quantityInput,
  });

  @override
  Widget build(BuildContext context) {
    // Improvement/Suggestion 3.1: Container is mandatory. It can hold images or whatever you want
    Container mandatoryContainer = Container(
      key: imageGlobalKey,
      color: Colors.white,
      padding: EdgeInsets.only(left: 17, top: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          height: 50,
          width: 50,
          fit: BoxFit.cover,
          imageUrl: product.images != null && product.images!.isNotEmpty
              ? (product.images![0].imageUrl ?? "")
              : "",
          errorWidget: (context, url, error) => Container(),
        ),
      ),
    );

    return InkWell(
      onTap: () {
        onTap(imageGlobalKey);
      },
      child: Stack(
        children: [
          mandatoryContainer,
          itemProduct(product),
        ],
      ),
    );
  }

  Widget itemProduct(
    Product product,
  ) {
    String? textMoney() {
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

    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 13, right: 13),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    imageUrl:
                        product.images != null && product.images!.isNotEmpty
                            ? (product.images![0].imageUrl ?? "")
                            : "",
                    errorWidget: (context, url, error) => new SahaEmptyImage(),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${product.name ?? ""}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 0.0, right: 5.0),
                          child: Text(
                            textMoney()!,
                            style: TextStyle(
                                color: SahaColorUtils()
                                    .colorPrimaryTextWithWhiteBackground(),
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            maxLines: 1,
                          ),
                        ),
                        product.productDiscount == null
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Text(
                                  product.minPrice == 0
                                      ? "${product.price == 0 ? "Giảm" : "${SahaStringUtils().convertToMoney(product.price)}₫"}"
                                      : "${SahaStringUtils().convertToMoney(product.minPrice)}₫",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10),
                                ),
                              ),
                      ],
                    ),
                    if(product.checkInventory == true)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5,),
                        Text("Kho: ${product.inventory?.mainStock ?? 0}"),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      onDecreaseItem();
                    },
                    child: Container(
                      height: 25,
                      width: 30,
                      child: Icon(
                        Icons.remove,
                        size: 13,
                        color: quantity == 1 ? Colors.grey : Colors.black,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      quantityInput(imageGlobalKey);
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
                    onTap: () {
                      onIncreaseItem(imageGlobalKey);
                    },
                    child: Container(
                      height: 25,
                      width: 30,
                      child: Icon(
                        Icons.add,
                        size: 13,
                        color: Colors.black,
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
        Divider(
          height: 1,
        ),
      ],
    );
  }
}
