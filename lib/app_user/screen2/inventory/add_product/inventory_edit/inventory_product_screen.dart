import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/inventory_request.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../../../../components/saha_user/dialog/dialog.dart';
import 'inventory_product_controller.dart';

class InventoryEditScreen extends StatefulWidget {
  Product productInput;
  bool? isNew;
  InventoryEditScreen({required this.productInput, this.isNew});

  @override
  _InventoryEditScreenState createState() => _InventoryEditScreenState();
}

class _InventoryEditScreenState extends State<InventoryEditScreen> {
  late InventoryEditController inventoryProductController;
  var timeInputSearch = DateTime.now();
  @override
  void initState() {
    inventoryProductController =
        InventoryEditController(productInput: widget.productInput);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading:
              inventoryProductController.isLongPress.value == true
                  ? false
                  : true,
          title: Text("Chỉnh Kho"),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Sản phẩm",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Text(
                    " Tồn kho hiện tại",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => itemProduct(inventoryProductController.product.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 65,
          color: Colors.white,
          child: Column(
            children: [
              SahaButtonFullParent(
                text: "Xong",
                onPressed: () {
                  if (widget.isNew == true) {
                    Get.back(result: "reload");
                  } else {
                    Get.back();
                    Get.back(
                        result: inventoryProductController.product.value.id);
                  }
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemProduct(Product product) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              if (!(product.inventory?.distributes != null &&
                  product.inventory!.distributes!.isNotEmpty)) {
                PopupInput().showDialogInputInfoInventory(
                    stockInput: product.inventory!.mainStock,
                    priceInput: product.inventory!.mainCostOfCapital,
                    confirm: (v) {
                      inventoryProductController
                          .updateInventoryProduct(InventoryRequest(
                        productId: product.id,
                        distributeName: null,
                        elementDistributeName: null,
                        stock: v["stock"],
                        costOfCapital: v["price_capital"],
                        subElementDistributeName: null,
                      ));
                    });
              }
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    imageUrl:
                        product.images != null && product.images!.isNotEmpty
                            ? (product.images![0].imageUrl ?? "")
                            : "",
                    placeholder: (context, url) => new SahaLoadingWidget(
                      size: 20,
                    ),
                    errorWidget: (context, url, error) => new Icon(
                      Ionicons.image_outline,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product.name ?? ""}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                if (product.inventory?.distributes == null ||
                    product.inventory!.distributes!.isEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Text(
                          "Vốn: ${SahaStringUtils().convertToMoney(!(product.inventory?.distributes != null && product.inventory!.distributes!.isNotEmpty) ? "${product.inventory?.mainCostOfCapital ?? 0}" : 0)}",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Text(
                          "Kho: ${!(product.inventory?.distributes != null && product.inventory!.distributes!.isNotEmpty) ? "${product.inventory?.mainStock ?? 0}" : ""}",
                          style: TextStyle(
                              color: Colors.blue,
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
          SizedBox(
            height: 5,
          ),
          if (product.inventory?.distributes != null &&
              product.inventory!.distributes!.isNotEmpty)
            ...product.inventory!.distributes![0].elementDistributes!
                .map((e) => itemDistribute(e, product))
                .toList(),
        ],
      ),
    );
  }

  Widget itemDistribute(
      ElementDistributes elementDistributes, Product product) {
    return Column(
      children: [
        if (elementDistributes.subElementDistribute == null ||
            elementDistributes.subElementDistribute!.isEmpty)
          InkWell(
            onTap: () {
              PopupInput().showDialogInputInfoInventory(
                  stockInput: elementDistributes.stock,
                  priceInput: elementDistributes.priceCapital,
                  confirm: (v) {
                    inventoryProductController
                        .updateInventoryProduct(InventoryRequest(
                      productId: product.id,
                      distributeName: (product.distributes != null &&
                              product.distributes!.isNotEmpty)
                          ? product.distributes![0].name
                          : null,
                      elementDistributeName: elementDistributes.name,
                      stock: v["stock"],
                      costOfCapital: v["price_capital"],
                      subElementDistributeName: null,
                    ));
                  });
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                    imageUrl: elementDistributes.imageUrl != null
                        ? (elementDistributes.imageUrl ?? "")
                        : "",
                    placeholder: (context, url) => new SahaLoadingWidget(
                      size: 20,
                    ),
                    errorWidget: (context, url, error) => new Icon(
                      Ionicons.image_outline,
                      color: Colors.grey,
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
                        "${elementDistributes.name}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        "Vốn: ${SahaStringUtils().convertToMoney(elementDistributes.priceCapital ?? 0)}",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        maxLines: 1,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        "Kho: ${elementDistributes.stock ?? 0}",
                        style: TextStyle(
                            color: Colors.blue,
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
        ...elementDistributes.subElementDistribute!
            .map(
              (e) => Column(
                children: [
                  InkWell(
                    onTap: () {
                      PopupInput().showDialogInputInfoInventory(
                          stockInput: e.stock,
                          priceInput: e.priceCapital,
                          confirm: (v) {
                            inventoryProductController
                                .updateInventoryProduct(InventoryRequest(
                              productId: product.id,
                              distributeName: (product.distributes != null &&
                                      product.distributes!.isNotEmpty)
                                  ? product.distributes![0].name
                                  : null,
                              elementDistributeName: elementDistributes.name,
                              subElementDistributeName: e.name,
                              stock: v["stock"],
                              costOfCapital: v["price_capital"],
                            ));
                          });
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                            height: 45,
                            width: 45,
                            fit: BoxFit.cover,
                            imageUrl: elementDistributes.imageUrl != null
                                ? (elementDistributes.imageUrl ?? "")
                                : "",
                            placeholder: (context, url) =>
                                new SahaLoadingWidget(
                              size: 20,
                            ),
                            errorWidget: (context, url, error) => new Icon(
                              Ionicons.image_outline,
                              color: Colors.grey,
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
                                "Phân loại: ${!(elementDistributes.subElementDistribute == null || elementDistributes.subElementDistribute!.isEmpty) ? "${elementDistributes.name}," : ""} ${e.name}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text(
                                "Vốn: ${SahaStringUtils().convertToMoney(e.priceCapital ?? 0)}",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text(
                                "Kho: ${e.stock ?? 0}",
                                style: TextStyle(
                                    color: Colors.blue,
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
                  Divider(
                    height: 1,
                  )
                ],
              ),
            )
            .toList(),
        Divider(
          height: 1,
        )
      ],
    );
  }
}
