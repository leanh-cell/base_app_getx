import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/button/saha_button.dart';
import 'package:com.ikitech.store/app_user/components/saha_user/loading/loading_widget.dart';
import 'package:com.ikitech.store/app_user/data/remote/response-request/inventory/tally_sheet_request.dart';
import 'package:com.ikitech.store/app_user/model/import_stock.dart';
import 'package:com.ikitech.store/app_user/utils/color_utils.dart';
import 'package:com.ikitech.store/app_user/utils/string_utils.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sahashop_customer/app_customer/model/category.dart';
import 'package:sahashop_customer/app_customer/model/product.dart';
import 'search_product_controller.dart';

class SearchProductScreen extends StatefulWidget {
  bool? isSearch;
  bool? checkInventory;
  Function? onChoose;
  Function? onChooseImportStock;
  List<TallySheetItem>? listTallySheetItem;
  List<ImportStockItem>? listImportStockItem;

  SearchProductScreen(
      {this.isSearch,
      this.checkInventory,
      this.onChoose,
      this.onChooseImportStock,
      this.listImportStockItem,
      this.listTallySheetItem});

  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  late SearchProductController inventoryProductController;
  ScrollController _scrollController = ScrollController();

  TextEditingController searchEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    inventoryProductController = SearchProductController(
        checkInventory: widget.checkInventory,
        inputListImportStockItem: widget.listImportStockItem,
        inputListTallySheetItem: widget.listTallySheetItem);
    if (widget.isSearch != null) {
      inventoryProductController.isSearch.value = widget.isSearch!;
    }

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
      () => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
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
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => inventoryProductController.isSearch.value
                                ? Container(
                                    padding: EdgeInsets.only(left: 10),
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5)),
                                    child: TextFormField(
                                      controller: searchEditingController,
                                      autofocus: inventoryProductController
                                              .isSearch.value
                                          ? true
                                          : false,
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
                                            size: 15,
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
                                : Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    child: DropdownButton<Category>(
                                      underline: SizedBox(),
                                      value: inventoryProductController
                                          .categoryChoose,
                                      icon: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        color: Colors.white,
                                      ),
                                      hint: Text(
                                        "Tất cả sản phẩm",
                                        style: TextStyle(
                                            fontSize: 17, color: Colors.white),
                                      ),
                                      items: inventoryProductController
                                          .categories
                                          .map((Category cate) {
                                        return DropdownMenuItem<Category>(
                                          value: cate,
                                          child: Container(
                                            width: 150,
                                            child: Text(
                                              "${cate.name ?? ""}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (v) {
                                        inventoryProductController
                                            .categoryChoose = v;
                                        inventoryProductController.searchText =
                                            "";
                                        inventoryProductController.categories
                                            .refresh();
                                        inventoryProductController
                                            .getAllProduct(isRefresh: true);
                                      },
                                    ),
                                  ),
                          ),
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
                  icon: Icon(Icons.search))
            ],
          ),
          body: Obx(
            () => Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 55,
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        "Chọn nhiều (${widget.onChoose != null ? inventoryProductController.listTallySheetItem.length : inventoryProductController.listImportStockItem.length})",
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                      Obx(() => inventoryProductController.isChooseMany.value
                          ? TextButton(
                              onPressed: () {
                                inventoryProductController
                                    .listImportStockItem([]);
                                inventoryProductController
                                    .listTallySheetItem([]);
                              },
                              child: Text("Bỏ chọn"))
                          : Container()),
                      Obx(() => inventoryProductController.isChooseMany.value
                          ? TextButton(
                              onPressed: () {
                                inventoryProductController.addAll(
                                    isTallySheet:
                                        widget.onChoose != null ? true : false);
                              },
                              child: Text("Chọn tất cả"))
                          : Container()),
                      Obx(
                        () => CupertinoSwitch(
                          value: inventoryProductController.isChooseMany.value,
                          onChanged: (bool value) {
                            inventoryProductController.isChooseMany.value =
                                !inventoryProductController.isChooseMany.value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: inventoryProductController.listProduct.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Không có sản phẩm nào hoặc sản phẩm không theo dõi hàng trong kho",
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(8),
                          itemCount:
                              inventoryProductController.listProduct.length,
                          itemBuilder: (BuildContext context, int index) {
                            return itemProduct(
                                inventoryProductController.listProduct[index]);
                          }),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 65,
            color: Colors.white,
            child: Column(
              children: [
                SahaButtonFullParent(
                  text: "Xong",
                  onPressed: () {
                    if (widget.onChoose != null) {
                      widget.onChoose!(
                          inventoryProductController.listTallySheetItem
                              .toList(),
                          true);
                    }

                    if (widget.onChooseImportStock != null) {
                      widget.onChooseImportStock!(
                          inventoryProductController.listImportStockItem
                              .toList(),
                          true);
                    }
                  },
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
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
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              var checkChoose = inventoryProductController.checkChoose(
                isTallySheet: widget.onChoose != null ? true : false,
                productId: product.id,
                distributeName: null,
                elementDistributeName: null,
                subElementDistributeName: null,
              );

              if (checkChoose == false) {
                if (!(product.inventory?.distributes != null &&
                    product.inventory!.distributes!.isNotEmpty)) {
                  if (widget.onChoose != null) {
                    widget.onChoose!([
                      TallySheetItem(
                        stockOnline: product.inventory?.mainStock ?? 0,
                        imageProductUrl: (product.images != null &&
                                product.images!.isNotEmpty)
                            ? product.images![0].imageUrl
                            : "",
                        productId: product.id,
                        nameProduct: "${product.name}",
                        distributeName: null,
                        elementDistributeName: null,
                        subElementDistributeName: null,
                      )
                    ], false);
                  }
                  if (widget.onChooseImportStock != null) {
                    widget.onChooseImportStock!([
                      ImportStockItem(
                        productId: product.id,
                        distributeName: null,
                        quantity: 1,
                        elementDistributeName: null,
                        subElementDistributeName: null,
                        importPrice: product.priceImport,
                        product: product,
                      )
                    ], false);
                  }
                }
              } else {
                Get.back();
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
                      Icons.image,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Text(
                        "${!(product.inventory?.distributes != null && product.inventory!.distributes!.isNotEmpty) ? "Kho: ${product.inventory?.mainStock ?? 0}" : ""}",
                        style: TextStyle(
                            color: SahaColorUtils()
                                .colorPrimaryTextWithWhiteBackground(),
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
                        "${!(product.inventory?.distributes != null && product.inventory!.distributes!.isNotEmpty) ? "Nhập: ${SahaStringUtils().convertToMoney(product.priceImport ?? 0)}" : ""}",
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
                  Obx(
                    () => !inventoryProductController.isChooseMany.value
                        ? inventoryProductController.checkChoose(
                            isTallySheet:
                                widget.onChoose != null ? true : false,
                            productId: product.id,
                            distributeName: null,
                            elementDistributeName: null,
                            subElementDistributeName: null,
                          )
                            ? Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Container()
                        : Checkbox(
                            value: inventoryProductController.checkChoose(
                              isTallySheet:
                                  widget.onChoose != null ? true : false,
                              productId: product.id,
                              distributeName: null,
                              elementDistributeName: null,
                              subElementDistributeName: null,
                            ),
                            onChanged: (v) {
                              print("ssss");
                              inventoryProductController.addOrRemoveSelected(
                                isTallySheet:
                                    widget.onChoose != null ? true : false,
                                tallySheetItem: TallySheetItem(
                                  stockOnline:
                                      product.inventory?.mainStock ?? 0,
                                  imageProductUrl: (product.images != null &&
                                          product.images!.isNotEmpty)
                                      ? product.images![0].imageUrl
                                      : "",
                                  productId: product.id,
                                  nameProduct: "${product.name}",
                                  distributeName: null,
                                  elementDistributeName: null,
                                  subElementDistributeName: null,
                                ),
                                importStockItem: ImportStockItem(
                                  productId: product.id,
                                  distributeName: null,
                                  quantity: 1,
                                  elementDistributeName: null,
                                  subElementDistributeName: null,
                                  importPrice: product.priceImport,
                                  product: product,
                                ),
                              );
                              setState(() {});
                            }),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 1,
          ),
          if (product.inventory?.distributes != null &&
              product.inventory!.distributes!.isNotEmpty)
            ...product.inventory!.distributes![0].elementDistributes!
                .map((e) => itemDistribute(
                    e,
                    product.distributes![0].elementDistributes![product
                        .distributes![0].elementDistributes!
                        .indexWhere((e2) => e2.id == e.id)],
                    product))
                .toList(),
        ],
      ),
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

  Widget itemDistribute(ElementDistributes elementDistributes,
      ElementDistributes elementDistributes2, Product product) {
    return Column(
      children: [
        if (elementDistributes.subElementDistribute == null ||
            elementDistributes.subElementDistribute!.isEmpty)
          InkWell(
            onTap: () {
              if (widget.onChoose != null) {
                widget.onChoose!([
                  TallySheetItem(
                    stockOnline: elementDistributes.stock,
                    imageProductUrl:
                        (product.images != null && product.images!.isNotEmpty)
                            ? product.images![0].imageUrl
                            : "",
                    productId: product.id,
                    nameProduct: "${product.name}",
                    distributeName: (product.distributes != null &&
                            product.distributes!.isNotEmpty)
                        ? product.distributes![0].name
                        : null,
                    elementDistributeName: elementDistributes.name,
                    subElementDistributeName: null,
                  ),
                ], false);
              }

              if (widget.onChooseImportStock != null) {
                widget.onChooseImportStock!([
                  ImportStockItem(
                    productId: product.id,
                    distributeName: (product.distributes != null &&
                            product.distributes!.isNotEmpty)
                        ? product.distributes![0].name
                        : null,
                    quantity: 1,
                    elementDistributeName: elementDistributes.name,
                    subElementDistributeName: null,
                    importPrice: elementDistributes2.priceImport,
                    product: product,
                  )
                ], false);
              }
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.inventory,
                    size: 20,
                    color: Theme.of(context).primaryColor,
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
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: Text(
                          "Kho: ${elementDistributes.stock ?? 0}",
                          style: TextStyle(
                              color: SahaColorUtils()
                                  .colorPrimaryTextWithWhiteBackground(),
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
                          "Nhập: ${SahaStringUtils().convertToMoney(elementDistributes2.priceImport ?? 0)}",
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
                ),
                Obx(
                  () => !inventoryProductController.isChooseMany.value
                      ? inventoryProductController.checkChoose(
                          isTallySheet: widget.onChoose != null ? true : false,
                          productId: product.id,
                          distributeName: (product.distributes != null &&
                                  product.distributes!.isNotEmpty)
                              ? product.distributes![0].name
                              : null,
                          elementDistributeName: elementDistributes.name,
                          subElementDistributeName: null,
                        )
                          ? Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 12,
                              ),
                            )
                          : Container()
                      : Checkbox(
                          value: inventoryProductController.checkChoose(
                            isTallySheet:
                                widget.onChoose != null ? true : false,
                            productId: product.id,
                            distributeName: (product.distributes != null &&
                                    product.distributes!.isNotEmpty)
                                ? product.distributes![0].name
                                : null,
                            elementDistributeName: elementDistributes.name,
                            subElementDistributeName: null,
                          ),
                          onChanged: (v) {
                            print("ssss");
                            inventoryProductController.addOrRemoveSelected(
                              isTallySheet:
                                  widget.onChoose != null ? true : false,
                              tallySheetItem: TallySheetItem(
                                stockOnline: elementDistributes.stock,
                                imageProductUrl: (product.images != null &&
                                        product.images!.isNotEmpty)
                                    ? product.images![0].imageUrl
                                    : "",
                                productId: product.id,
                                nameProduct: "${product.name}",
                                distributeName: (product.distributes != null &&
                                        product.distributes!.isNotEmpty)
                                    ? product.distributes![0].name
                                    : null,
                                elementDistributeName: elementDistributes.name,
                                subElementDistributeName: null,
                              ),
                              importStockItem: ImportStockItem(
                                productId: product.id,
                                distributeName: (product.distributes != null &&
                                        product.distributes!.isNotEmpty)
                                    ? product.distributes![0].name
                                    : null,
                                quantity: 1,
                                elementDistributeName: elementDistributes.name,
                                subElementDistributeName: null,
                                importPrice: elementDistributes2.priceImport,
                                product: product,
                              ),
                            );
                            setState(() {});
                          }),
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
                      var checkChoose = inventoryProductController.checkChoose(
                        isTallySheet: widget.onChoose != null ? true : false,
                        productId: product.id,
                        distributeName: (product.distributes != null &&
                                product.distributes!.isNotEmpty)
                            ? product.distributes![0].name
                            : null,
                        elementDistributeName: elementDistributes.name,
                        subElementDistributeName: e.name,
                      );

                      if (checkChoose == false) {
                        if (widget.onChoose != null) {
                          widget.onChoose!([
                            TallySheetItem(
                              stockOnline: e.stock,
                              imageProductUrl: (product.images != null &&
                                      product.images!.isNotEmpty)
                                  ? product.images![0].imageUrl
                                  : "",
                              productId: product.id,
                              nameProduct: "${product.name}",
                              distributeName: (product.distributes != null &&
                                      product.distributes!.isNotEmpty)
                                  ? product.distributes![0].name
                                  : null,
                              elementDistributeName: elementDistributes.name,
                              subElementDistributeName: e.name,
                            )
                          ], false);
                        }
                        if (widget.onChooseImportStock != null) {
                          widget.onChooseImportStock!([
                            ImportStockItem(
                              productId: product.id,
                              distributeName: (product.distributes != null &&
                                      product.distributes!.isNotEmpty)
                                  ? product.distributes![0].name
                                  : null,
                              quantity: 1,
                              elementDistributeName: elementDistributes.name,
                              subElementDistributeName: e.name,
                              importPrice: elementDistributes2
                                  .subElementDistribute![(elementDistributes2
                                      .subElementDistribute!
                                      .indexWhere((sub) => sub.id == e.id))]
                                  .priceImport,
                              product: product,
                            )
                          ], false);
                        }
                      } else {
                        Get.back();
                      }
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.inventory,
                            size: 20,
                            color: Theme.of(context).primaryColor,
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
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Text(
                                  "Kho: ${e.stock ?? 0}",
                                  style: TextStyle(
                                      color: SahaColorUtils()
                                          .colorPrimaryTextWithWhiteBackground(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                child: Text(
                                  "Nhập: ${SahaStringUtils().convertToMoney(elementDistributes2.subElementDistribute![(elementDistributes2.subElementDistribute!.indexWhere((sub) => sub.id == e.id))].priceImport ?? 0)}",
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
                        ),
                        Obx(
                          () => !inventoryProductController.isChooseMany.value
                              ? inventoryProductController.checkChoose(
                                  isTallySheet:
                                      widget.onChoose != null ? true : false,
                                  productId: product.id,
                                  distributeName:
                                      (product.distributes != null &&
                                              product.distributes!.isNotEmpty)
                                          ? product.distributes![0].name
                                          : null,
                                  elementDistributeName:
                                      elementDistributes.name,
                                  subElementDistributeName: e.name,
                                )
                                  ? Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container()
                              : Checkbox(
                                  value: inventoryProductController.checkChoose(
                                    isTallySheet:
                                        widget.onChoose != null ? true : false,
                                    productId: product.id,
                                    distributeName:
                                        (product.distributes != null &&
                                                product.distributes!.isNotEmpty)
                                            ? product.distributes![0].name
                                            : null,
                                    elementDistributeName:
                                        elementDistributes.name,
                                    subElementDistributeName: e.name,
                                  ),
                                  onChanged: (v) {
                                    print("ssss");
                                    inventoryProductController
                                        .addOrRemoveSelected(
                                      isTallySheet: widget.onChoose != null
                                          ? true
                                          : false,
                                      tallySheetItem: TallySheetItem(
                                        stockOnline: e.stock,
                                        imageProductUrl:
                                            (product.images != null &&
                                                    product.images!.isNotEmpty)
                                                ? product.images![0].imageUrl
                                                : "",
                                        productId: product.id,
                                        nameProduct: "${product.name}",
                                        distributeName: (product.distributes !=
                                                    null &&
                                                product.distributes!.isNotEmpty)
                                            ? product.distributes![0].name
                                            : null,
                                        elementDistributeName:
                                            elementDistributes.name,
                                        subElementDistributeName: e.name,
                                      ),
                                      importStockItem: ImportStockItem(
                                        productId: product.id,
                                        distributeName: (product.distributes !=
                                                    null &&
                                                product.distributes!.isNotEmpty)
                                            ? product.distributes![0].name
                                            : null,
                                        quantity: 1,
                                        elementDistributeName:
                                            elementDistributes.name,
                                        subElementDistributeName: e.name,
                                        importPrice: elementDistributes2
                                            .subElementDistribute![
                                                (elementDistributes2
                                                    .subElementDistribute!
                                                    .indexWhere((sub) =>
                                                        sub.id == e.id))]
                                            .priceImport,
                                        product: product,
                                      ),
                                    );
                                    setState(() {});
                                  }),
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
