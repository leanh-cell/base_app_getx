import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/chip/ticker.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/text/text_money.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/toast/saha_alert.dart';
import 'package:com.ikitech.store/app_user/data/repository/repository_manager.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:sahashop_customer/app_customer/model/order.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../saha_data_controller.dart';
import '../../utils/product_utils.dart';

class ModalBottomOptionBuyProductUser {
  static Future<void> showModelOption(
      {int? lineItemId,
      required Product product,
      bool? isLoadingProduct,
      String? textButton,
      List<DistributesSelected>? distributesSelectedParam,
      int? quantity,
      Function(int quantity, Product product,
              List<DistributesSelected> distributesSelected)?
          onSubmit}) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: Get.context!,
      builder: (BuildContext context) {
        return OptionBuyProduct(
          isLoadingProduct: isLoadingProduct,
          lineItemId: lineItemId,
          textButton: textButton,
          product: product,
          onSubmit: onSubmit,
          distributesSelectedParam: distributesSelectedParam,
          quantity: quantity,
        );
      },
    );
  }
}

class OptionBuyProduct extends StatefulWidget {
  Product product;
  final int? lineItemId;
  final bool? isLoadingProduct;
  final String? textButton;
  final List<DistributesSelected>? distributesSelectedParam;
  final int? quantity;
  final Function(int quantity, Product product,
      List<DistributesSelected> distributesSelected)? onSubmit;

  OptionBuyProduct(
      {Key? key,
      required this.product,
      this.onSubmit,
      this.isLoadingProduct,
      this.distributesSelectedParam,
      this.quantity,
      this.lineItemId,
      this.textButton})
      : super(key: key);

  @override
  _OptionBuyProductState createState() => _OptionBuyProductState();
}

class _OptionBuyProductState extends State<OptionBuyProduct> {
  int quantity = 1;
  String errorTextInBottomModel = "";

  List<DistributesSelected> distributesSelected = [];
  SahaDataController sahaDataController = Get.find();
  bool canDecrease = true;
  bool canIncrease = true;

  var quantityInStock;
  int? max = -1;

  Future<void> getOneProduct(int idProduct) async {
    try {
      var data =
          await RepositoryManager.productRepository.getOneProductV2(idProduct);
      widget.product = data!.data!;
      quantityInStock = quantityMain();
      checkCanCrease();
      setState(() {});
    } catch (err) {
      SahaAlert.showError(message: err.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.isLoadingProduct == true) {
      getOneProduct(widget.product.id!);
    }

    max = widget.product.inventory?.mainStock == null ||
            widget.product.inventory!.mainStock! < 0
        ? -1
        : widget.product.inventory!.mainStock;

    if (widget.distributesSelectedParam != null) {
      distributesSelected = widget.distributesSelectedParam!;
      checkItemPriceCurrent();
      checkItemQuantityCurrent();
    }
    if (widget.quantity != null) {
      quantity = widget.quantity!;
    }
    textEditingController = TextEditingController(text: "$quantity");

    quantityInStock = quantityMain();
    checkCanCrease();
  }

  int quantityMain() {
    return ProductUtils.getQuantityMainTotal(widget.product);
  }

  String? nameDistribute;
  String? valueDistribute;
  String? subElementDistribute;
  double? priceMin;
  double? priceMax;
  double? priceCurrent;
  String? imageUrlCurrent;
  int? quantityStockCurrent;

  void onCheckElementDistribute() {
    quantity = 1;
    textEditingController.text = "$quantity";
    distributesSelected = [
      DistributesSelected(
          name: nameDistribute,
          value: valueDistribute,
          subElement: subElementDistribute)
    ];
    setState(() {
      print(distributesSelected[0].toJson());
    });
  }

  bool isChecked(String nameDistribute, String nameElement) {
    if (distributesSelected.map((e) => e.name).contains(nameDistribute) &&
        distributesSelected.map((e) => e.value).contains(nameElement)) {
      return true;
    } else {
      return false;
    }
  }

  bool isCheckedSub(String nameSubElement) {
    if (distributesSelected.map((e) => e.subElement).contains(nameSubElement)) {
      return true;
    } else {
      return false;
    }
  }

  void onSubmitBuy({bool buyNow = false}) {
    if (sahaDataController.badgeUser.value.allowSemiNegative != true) {
      if (widget.product.checkInventory == true) {
        if (max == 0) {
          errorTextInBottomModel = "Hết hàng";
          setState(() {});
          return;
        }
      }
    }

    if (widget.product.inventory!.distributes!.isNotEmpty) {
      if (distributesSelected.isNotEmpty) {
        if (widget
                .product.inventory!.distributes![0].subElementDistributeName !=
            null) {
          if (distributesSelected[0].subElement != null &&
              distributesSelected[0].name != null &&
              distributesSelected[0].value != null) {
            widget.onSubmit!(quantity, widget.product, distributesSelected);
          } else {
            if (distributesSelected[0].name != null &&
                distributesSelected[0].value != null) {
              errorTextInBottomModel =
                  "Mời chọn ${widget.product.inventory!.distributes![0].subElementDistributeName}";
            } else {
              errorTextInBottomModel =
                  "Mời chọn ${widget.product.inventory!.distributes![0].name}";
            }

            setState(() {});
          }
        } else {
          if (distributesSelected[0].name != null &&
              distributesSelected[0].value != null) {
            widget.onSubmit!(quantity, widget.product, distributesSelected);
          } else {
            errorTextInBottomModel =
                "Mời chọn ${widget.product.inventory!.distributes![0].name}";
            setState(() {});
          }
        }
      } else {
        errorTextInBottomModel =
            "Mời chọn ${widget.product.distributes![0].name}";
        setState(() {});
        return;
      }
    } else {
      widget.onSubmit!(quantity, widget.product, distributesSelected);
    }
  }

  bool isDoneCheckElement() {
    max = quantityMain() != 0
        ? quantityMain()
        : (widget.product.inventory?.mainStock == null ||
                widget.product.inventory!.mainStock! < 0
            ? -1
            : widget.product.inventory!.mainStock);

    if (widget.product.checkInventory == true) {
      if (max == 0) {
        errorTextInBottomModel = "Hết hàng";
        return false;
      }
    }

    if (widget.product.inventory?.distributes != null) {
      if (widget.product.inventory!.distributes!.isNotEmpty) {
        if (distributesSelected.isNotEmpty) {
          if (widget.product.inventory!.distributes![0]
                  .subElementDistributeName !=
              null) {
            if (distributesSelected[0].subElement != null &&
                distributesSelected[0].name != null &&
                distributesSelected[0].value != null) {
              return true;
            } else {
              return false;
            }
          } else {
            if (distributesSelected[0].name != null &&
                distributesSelected[0].value != null) {
              return true;
            } else {
              return false;
            }
          }
        } else {
          return false;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  void checkCanCrease() {
    setState(() {
      var quantityInStockCheck = quantityStockCurrent ?? quantityInStock;
      max = quantityInStockCheck == null || quantityInStockCheck! < 0
          ? -1
          : quantityInStockCheck;

      if (quantity > 1)
        canDecrease = true;
      else
        canDecrease = false;

      if (sahaDataController.badgeUser.value.allowSemiNegative == true) {
        canIncrease = true;
      } else {
        if (quantity + 1 > max! && max != -1)
          canIncrease = false;
        else
          canIncrease = true;
      }
    });
  }

  void checkItemPriceCurrent() {
    errorTextInBottomModel = "";
    var priceMain = priceCurrent ??
        (widget.product.productDiscount == null
            ? widget.product.price
            : widget.product.productDiscount!.discountPrice);

    if (widget.product.distributes!.isNotEmpty) {
      var distribute = widget.product.distributes![0];
      var select = distributesSelected[0];
      if (select.subElement != null) {
        var indexElement = distribute.elementDistributes!
            .indexWhere((e) => e.name == select.value);
        if (indexElement != -1) {
          var indexSub = distribute
              .elementDistributes![indexElement].subElementDistribute!
              .indexWhere((e) => e.name == select.subElement);
          if (indexSub != -1) {
            priceCurrent = distribute.elementDistributes![indexElement]
                .subElementDistribute![indexSub].price;
            quantityStockCurrent = distribute.elementDistributes![indexElement]
                .subElementDistribute![indexSub].stock;
            if (widget.product.productDiscount != null) {
              if (priceCurrent != null) {
                priceCurrent = priceCurrent! -
                    ((priceCurrent! * widget.product.productDiscount!.value!) /
                        100);
              } else {
                priceCurrent = null;
              }
            }
          } else {
            quantityStockCurrent = quantityInStock;
            priceCurrent = priceMain;
          }
        } else {
          quantityStockCurrent = quantityInStock;
          priceCurrent = priceMain;
        }
      } else {
        print("-==========");
        var indexElement = distribute.elementDistributes!
            .indexWhere((e) => e.name == select.value);
        if (indexElement != -1) {
          print("-==========2");
          priceCurrent = distribute.elementDistributes![indexElement].price;
          quantityStockCurrent =
              distribute.elementDistributes![indexElement].stock;
          if (widget.product.productDiscount != null) {
            if (priceCurrent != null) {
              priceCurrent = priceCurrent! -
                  ((priceCurrent! * widget.product.productDiscount!.value!) /
                      100);
            } else {
              priceCurrent = null;
            }
          }
          print("${priceCurrent}2");
        } else {
          quantityStockCurrent = quantityInStock;
          priceCurrent = priceMain;
        }
      }
      var indexImage = distribute.elementDistributes!
          .indexWhere((e) => e.name == select.value);
      if (indexImage != -1) {
        imageUrlCurrent = distribute.elementDistributes![indexImage].imageUrl ??
            (widget.product.images!.length == 0
                ? ""
                : widget.product.images![0].imageUrl!);
      }

      checkCanCrease();
    }
  }

  void checkItemQuantityCurrent() {
    errorTextInBottomModel = "";

    if (widget.product.inventory?.distributes == null) return;

    if (widget.product.inventory!.distributes!.isNotEmpty) {
      var distribute = widget.product.inventory!.distributes![0];
      var select = distributesSelected[0];
      if (select.subElement != null) {
        var indexElement = distribute.elementDistributes!
            .indexWhere((e) => e.name == select.value);
        if (indexElement != -1) {
          var indexSub = distribute
              .elementDistributes![indexElement].subElementDistribute!
              .indexWhere((e) => e.name == select.subElement);
          if (indexSub != -1) {
            quantityStockCurrent = distribute.elementDistributes![indexElement]
                .subElementDistribute![indexSub].stock;
          } else {
            quantityStockCurrent = quantityInStock;
          }
        } else {
          quantityStockCurrent = quantityInStock;
        }
      } else {
        var indexElement = distribute.elementDistributes!
            .indexWhere((e) => e.name == select.value);
        if (indexElement != -1) {
          quantityStockCurrent =
              distribute.elementDistributes![indexElement].stock;
        } else {
          quantityStockCurrent = quantityInStock;
        }
      }
      var indexImage = distribute.elementDistributes!
          .indexWhere((e) => e.name == select.value);
      if (indexImage != -1) {
        imageUrlCurrent = distribute.elementDistributes![indexImage].imageUrl ??
            (widget.product.images!.length == 0
                ? ""
                : widget.product.images![0].imageUrl!);
      }

      checkCanCrease();
    }
  }

  double? checkMinMaxPrice(double? price) {
    return widget.product.productDiscount == null
        ? (price ?? 0)
        : ((price ?? 0) -
            ((price ?? 0) * (widget.product.productDiscount!.value! / 100)));
  }

  late TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 110,
                            height: 110,
                            child: CachedNetworkImage(
                                imageUrl: imageUrlCurrent ??
                                    (widget.product.images!.length == 0
                                        ? ""
                                        : widget.product.images![0].imageUrl!),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Icon(
                                      Icons.image,
                                      color: Colors.grey,
                                      size: 90,
                                    )),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${widget.product.name ?? ""}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              priceCurrent != null
                                  ? SahaMoneyText(
                                      price: priceCurrent ?? 0,
                                      color: SahaColorUtils()
                                          .colorPrimaryTextWithWhiteBackground(),
                                    )
                                  : Row(
                                      children: [
                                        widget.product.minPrice !=
                                                widget.product.maxPrice
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (widget.product
                                                          .productDiscount !=
                                                      null)
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "₫${SahaStringUtils().convertToMoney(widget.product.minPrice ?? 0)}",
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13),
                                                        ),
                                                        Text(
                                                          " - ",
                                                          style: TextStyle(
                                                            color: SahaColorUtils()
                                                                .colorPrimaryTextWithWhiteBackground(),
                                                          ),
                                                        ),
                                                        Text(
                                                          "₫${SahaStringUtils().convertToMoney(widget.product.maxPrice ?? 0)}",
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13),
                                                        ),
                                                      ],
                                                    ),
                                                  Row(
                                                    children: [
                                                      SahaMoneyText(
                                                        price: checkMinMaxPrice(
                                                            widget.product
                                                                .minPrice),
                                                        color: SahaColorUtils()
                                                            .colorPrimaryTextWithWhiteBackground(),
                                                      ),
                                                      Text(
                                                        " - ",
                                                        style: TextStyle(
                                                          color: SahaColorUtils()
                                                              .colorPrimaryTextWithWhiteBackground(),
                                                        ),
                                                      ),
                                                      SahaMoneyText(
                                                        price: checkMinMaxPrice(
                                                            widget.product
                                                                .maxPrice),
                                                        color: SahaColorUtils()
                                                            .colorPrimaryTextWithWhiteBackground(),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : widget.product.price == 0
                                                ? Text(
                                                    "₫${SahaStringUtils().convertToMoney(widget.product.minPrice ?? 0)}",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                                  .primaryColor
                                                                  .computeLuminance() >
                                                              0.5
                                                          ? Colors.black
                                                          : Theme.of(context)
                                                              .primaryColor,
                                                    ),
                                                  )
                                                : Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      if (widget.product
                                                              .productDiscount !=
                                                          null)
                                                        Text(
                                                          "₫${SahaStringUtils().convertToMoney(widget.product.price ?? 0)}",
                                                          style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 13),
                                                        ),
                                                      SahaMoneyText(
                                                        price: checkMinMaxPrice(
                                                            widget.product
                                                                .minPrice),
                                                        color: SahaColorUtils()
                                                            .colorPrimaryTextWithWhiteBackground(),
                                                      ),
                                                    ],
                                                  ),
                                      ],
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              if (widget.product.productDiscount != null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (priceCurrent != null)
                                      Row(
                                        children: [
                                          Text(
                                            "${SahaStringUtils().convertToMoney((priceCurrent! * 100) / (100 - widget.product.productDiscount!.value!))}đ",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 12),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    Text(
                                      "-${SahaStringUtils().convertToMoney(widget.product.productDiscount!.value)}%",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.red),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: 15,
                              ),
                              if (widget.product.checkInventory == true)
                                quantityStockCurrent != null &&
                                        isDoneCheckElement()
                                    ? Text(
                                        "Kho: ${quantityStockCurrent == 0 ? "hết hàng" : quantityStockCurrent}")
                                    : Text(
                                        "Kho: ${quantityInStock == 0 ? "hết hàng" : quantityInStock}"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    }),
              ),
            ],
          ),
          Divider(
            height: 1,
          ),
          SizedBox(
            height: 15,
          ),
          widget.product.inventory?.distributes == null ||
                  widget.product.inventory?.distributes?.length == 0
              ? Container()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: new BoxConstraints(
                        minHeight: 35.0,
                        maxHeight: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? Get.height * 0.5
                            : Get.height * 0.2,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: Get.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 8,
                                          bottom: 8),
                                      child: Text(
                                        widget.product.inventory!
                                            .distributes![0].name!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Wrap(
                                        children: widget.product.inventory!
                                            .distributes![0].elementDistributes!
                                            .map(
                                              (elementDistribute) =>
                                                  TickerStateLess(
                                                text: elementDistribute.name,
                                                ticked: isChecked(
                                                    widget.product.inventory!
                                                        .distributes![0].name!,
                                                    elementDistribute.name!),
                                                onChange: (va) {
                                                  nameDistribute = widget
                                                      .product
                                                      .inventory!
                                                      .distributes![0]
                                                      .name!;
                                                  valueDistribute =
                                                      elementDistribute.name!;
                                                  onCheckElementDistribute();
                                                  checkItemPriceCurrent();
                                                  checkItemQuantityCurrent();
                                                },
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              if (widget.product.inventory!.distributes![0]
                                      .subElementDistributeName !=
                                  null)
                                Container(
                                  width: Get.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            top: 8,
                                            bottom: 8),
                                        child: Text(
                                          widget
                                              .product
                                              .inventory!
                                              .distributes![0]
                                              .subElementDistributeName!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Wrap(
                                          children: widget
                                              .product
                                              .inventory!
                                              .distributes![0]
                                              .elementDistributes![0]
                                              .subElementDistribute!
                                              .map(
                                                (e) => TickerStateLess(
                                                  text: e.name,
                                                  ticked: isCheckedSub(e.name!),
                                                  onChange: (va) {
                                                    subElementDistribute =
                                                        e.name!;
                                                    onCheckElementDistribute();
                                                    checkItemPriceCurrent();
                                                    checkItemQuantityCurrent();
                                                  },
                                                ),
                                              )
                                              .toList(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            ]),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Số lượng",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (quantity == 1) return;
                          quantity--;
                          textEditingController.text = "$quantity";
                        });
                        errorTextInBottomModel = "";

                        checkCanCrease();
                      },
                      child: Container(
                        height: 25,
                        width: 30,
                        child: Icon(
                          Icons.remove,
                          color: canDecrease ? Colors.black : Colors.grey,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!)),
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 40,
                      child: Center(
                        child: TextField(
                          controller: textEditingController,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          onChanged: (v) {
                            if (sahaDataController
                                    .badgeUser.value.allowSemiNegative ==
                                true) {
                              quantity = int.parse(textEditingController.text);
                            } else {
                              if (widget.product.checkInventory == true) {
                                setState(() {
                                  var quantityInStockCheck =
                                      quantityStockCurrent ?? quantityInStock;
                                  if (quantityInStockCheck < 0) {
                                    quantity =
                                        int.parse(textEditingController.text);
                                  } else {
                                    if (v != "" && v != "0") {
                                      if (quantityInStockCheck != null &&
                                          quantityInStockCheck != 'Vô hạn') {
                                        if (int.parse(v) <
                                            quantityInStockCheck) {
                                          quantity = int.parse(
                                              textEditingController.text);
                                        } else {
                                          textEditingController.text =
                                              '$quantityInStockCheck';
                                          quantity = int.parse(
                                              textEditingController.text);
                                          FocusScope.of(context).unfocus();
                                        }
                                      } else {
                                        quantity = int.parse(
                                            textEditingController.text);
                                      }
                                    }
                                  }
                                  checkCanCrease();
                                });
                              } else {
                                quantity =
                                    int.parse(textEditingController.text);
                              }
                            }
                          },
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!)),
                    ),
                    InkWell(
                      onTap: () {
                        if (widget.product.checkInventory == true) {
                          setState(() {
                            if (canIncrease) {
                              quantity++;
                              textEditingController.text = "$quantity";
                            }
                          });
                          checkCanCrease();
                        } else {
                          setState(() {
                            quantity++;
                            textEditingController.text = "$quantity";
                          });
                        }
                      },
                      child: Container(
                        height: 25,
                        width: 30,
                        child: Icon(
                          Icons.add,
                          color: widget.product.checkInventory == false
                              ? Colors.black
                              : canIncrease
                                  ? Colors.black
                                  : Colors.grey,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          !isDoneCheckElement() && errorTextInBottomModel.length > 0
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$errorTextInBottomModel",
                    style: TextStyle(fontSize: 12, color: Colors.redAccent),
                  ),
                )
              : Container(),
          SahaButtonFullParent(
            text: widget.textButton ?? "Mua ngay",
            textColor: Colors.grey[200],
            color: Theme.of(context).primaryColor,
            onPressed: () {
              if (widget.product.checkInventory == true) {
                onSubmitBuy();
              } else {
                onSubmitBuy();
              }
            },
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
