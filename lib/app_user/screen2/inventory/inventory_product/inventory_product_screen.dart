import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/dialog/dialog.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/popup/popup_input.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/inventory_request.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';

import '../product/filter/filter_screen.dart';
import 'history_inventory/history_inventory_screen.dart';
import 'inventory_product_controller.dart';

class InventoryProductScreen extends StatefulWidget {
  bool? isNearOutOfStock;
  InventoryProductScreen({this.isNearOutOfStock});
  @override
  _InventoryProductScreenState createState() => _InventoryProductScreenState();
}

class _InventoryProductScreenState extends State<InventoryProductScreen> {
  late InventoryProductController inventoryProductController;
  var timeInputSearch = DateTime.now();
  ScrollController _scrollController = ScrollController();

  TextEditingController searchEditingController = TextEditingController();
  RefreshController refreshController = RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();
    inventoryProductController =
        InventoryProductController(isNearOutOfStock: widget.isNearOutOfStock);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          inventoryProductController.loading.value == false) {
        inventoryProductController.getAllProduct();
      }
    });
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
          title: Obx(
            () => inventoryProductController.isLongPress.value == true
                ? Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            inventoryProductController.isLongPress.value =
                                false;
                          },
                          icon: Icon(Icons.clear)),
                      Text(
                          "${inventoryProductController.productsSelected.length}"),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            inventoryProductController.isLongPress.value =
                                false;
                            inventoryProductController.productsSelected([]);
                          },
                          child: Text(
                            "Bỏ chọn",
                            style: TextStyle(color: Colors.white),
                          )),
                      IconButton(
                          onPressed: () {
                            SahaDialogApp.showDialogYesNo(
                                mess:
                                    "Bạn có chắc chắn xoá ${inventoryProductController.productsSelected.length} sản phẩm đã chọn chứ ?",
                                onOK: () {
                                  inventoryProductController.deleteManyProduct(
                                      inventoryProductController
                                          .productsSelected
                                          .toList());
                                  inventoryProductController.isLongPress.value =
                                      false;
                                });
                          },
                          icon: Icon(Icons.delete))
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        child:
                            Obx(() => inventoryProductController.isSearch.value
                                ? Container(
                                    padding: EdgeInsets.only(left: 10),
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5)),
                                    child: TextFormField(
                                      controller: searchEditingController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.only(
                                            right: 15, top: 15, bottom: 10),
                                        border: InputBorder.none,
                                        hintText: "Tìm kiếm",
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            searchEditingController.clear();
                                            inventoryProductController
                                                .isSearch.value = false;
                                            inventoryProductController
                                                .searchText = "";
                                            inventoryProductController
                                                .getAllProduct(isRefresh: true);
                                          },
                                          icon: Icon(
                                            Icons.clear,
                                          ),
                                        ),
                                      ),
                                      onChanged: (v) async {
                                        inventoryProductController.searchText =
                                            v;
                                        inventoryProductController
                                            .getAllProduct(isRefresh: true);
                                      },
                                      minLines: 1,
                                      maxLines: 1,
                                    ),
                                  )
                                : Text('Kho')),
                      ),
                    ],
                  ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  scanBarcodeNormal();
                },
                icon: Icon(
                  Ionicons.barcode_outline,
                )),
            IconButton(
                onPressed: () {
                  inventoryProductController.isSearch.value = true;
                },
                icon: Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  Get.to(() => FilterScreen(
                        categoryInput:
                            inventoryProductController.categoryChooses,
                        categoryChildInput:
                            inventoryProductController.categoryChildChoose,
                            isNearOutOfStock: inventoryProductController.isNearOutOfStock,
                        onFilter: (List<Category>? categoryChooses,
                            List<Category>? categoryChildChooses,bool? isNearOutOfStock) {
                          print(categoryChooses);
                          print(categoryChildChooses);
                          inventoryProductController.categoryChooses =
                              categoryChooses;
                          inventoryProductController.categoryChildChoose =
                              categoryChildChooses;
                          inventoryProductController.isNearOutOfStock = isNearOutOfStock;
                          inventoryProductController.getAllProduct(
                              isRefresh: true);
                          Get.back();
                        },
                      ));
                },
                icon: Icon(((inventoryProductController.categoryChooses ?? [])
                            .isNotEmpty ||
                        (inventoryProductController.categoryChildChoose ?? [])
                            .isNotEmpty)
                    ? Icons.filter_alt_rounded
                    : Icons.filter_alt_outlined))
          ],
        ),
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: MaterialClassicHeader(),
          footer: CustomFooter(
            builder: (
              BuildContext context,
              LoadStatus? mode,
            ) {
              Widget body = Container();
              if (mode == LoadStatus.idle) {
                body = Obx(() => inventoryProductController.loading.value
                    ? CupertinoActivityIndicator()
                    : Container());
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              }
              return Container(
                height: 100,
                child: Center(child: body),
              );
            },
          ),
          controller: refreshController,
          onRefresh: () async {
            await inventoryProductController.getAllProduct(isRefresh: true);
            refreshController.refreshCompleted();
          },
          onLoading: () async {
            await inventoryProductController.getAllProduct();
            refreshController.loadComplete();
          },
          child: Column(
            children: [
              if (widget.isNearOutOfStock != true)
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        "Ẩn Sp không quan tâm số lượng",
                        maxLines: 1,
                      )),
                      CupertinoSwitch(
                        value: inventoryProductController.checkInventory.value,
                        onChanged: (bool value) {
                          inventoryProductController.checkInventory.value =
                              !inventoryProductController.checkInventory.value;
                          inventoryProductController.getAllProduct(
                              isRefresh: true);
                        },
                      ),
                    ],
                  ),
                ),
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
                      "Tồn kho hiện tại",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: inventoryProductController.listProduct.length,
                      itemBuilder: (BuildContext context, int index) {
                        return itemProduct(
                            inventoryProductController.listProduct[index]);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemProduct(Product product) {
    return Stack(
      children: [
        Container(
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
                          size: 30,
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
                            "${product.name}",
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
                    if (product.checkInventory == true)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 5.0),
                            child: Text(
                              "${!(product.inventory?.distributes != null && product.inventory!.distributes!.isNotEmpty) ? "SL: ${product.inventory?.mainStock ?? 0}" : ""}",
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
                    if (!(product.inventory?.distributes != null &&
                        product.inventory!.distributes!.isNotEmpty))
                      IconButton(
                          onPressed: () {
                            Get.to(() => HistoryInventoryScreen(
                                  idProduct: product.id ?? 0,
                                  distributeName:
                                      (product.distributes != null &&
                                              product.distributes!.isNotEmpty)
                                          ? product.distributes![0].name
                                          : null,
                                ));
                          },
                          icon: Icon(
                            Icons.history,
                            color: Colors.blue,
                          )),
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
              if (product.checkInventory == false)
                Container(
                  margin: EdgeInsets.all(5),
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.5)),
                  child: Center(
                    child: Text(
                      "Sản phẩm này không quan tâm đến số lượng",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ),
        // if (product.checkInventory == false)
        //   Positioned.fill(
        //     child: Container(
        //       margin: EdgeInsets.all(5),
        //       decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
        //       child: Center(
        //         child: Text(
        //           "Sản phẩm này không quan tâm đến số lượng",
        //           style:
        //               TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //     ),
        //   )
      ],
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      if (barcodeScanRes != "-1") {
        inventoryProductController.scanProduct(barcodeScanRes);
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
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
                      size: 30,
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
                        "Phân loại: ${elementDistributes.name}",
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
                if (product.checkInventory == true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Text(
                          "SL: ${elementDistributes.stock ?? 0}",
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
                IconButton(
                    onPressed: () {
                      Get.to(() => HistoryInventoryScreen(
                            idProduct: product.id ?? 0,
                            elm: elementDistributes.name,
                            distributeName: (product.distributes != null &&
                                    product.distributes!.isNotEmpty)
                                ? product.distributes![0].name
                                : null,
                          ));
                    },
                    icon: Icon(
                      Icons.history,
                      color: Colors.blue,
                    )),
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
                              size: 30,
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
                        if (product.checkInventory == true)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Text(
                                  "SL: ${e.stock ?? 0}",
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
                        IconButton(
                            onPressed: () {
                              Get.to(() => HistoryInventoryScreen(
                                    idProduct: product.id ?? 0,
                                    elm: elementDistributes.name,
                                    sub: e.name,
                                    distributeName:
                                        (product.distributes != null &&
                                                product.distributes!.isNotEmpty)
                                            ? product.distributes![0].name
                                            : null,
                                  ));
                            },
                            icon: Icon(
                              Icons.history,
                              color: Colors.blue,
                            )),
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
